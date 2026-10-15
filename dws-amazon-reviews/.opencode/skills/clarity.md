---
name: clarify
description: Finds gaps and voids in a spec.md before /plan with up to 5 questions, and records the answers in the spec. Use with /clarify or when asked to clarify a spec or review gaps and ambiguities.
---

# `/clarify` skill

This is the *Clarify* step of **GitHub Spec Kit** (`/specify → /clarify → /plan → /tasks → /implement`). What a spec leaves unsaid gets discovered in the plan, the tasks or the code, and redoing work there costs far more. Here it is discovered earlier, with short questions, and each answer is written into the spec.

It is adapted to this repository: the constitution rules, and the only file you edit is `spec.md`.

## 0. Variables (declared BEFORE using this skill)

The command `.opencode/commands/clarify.md` sets them first and then points to this file. If they are not defined, set them yourself with these values and say so.

```text
SPECS=specs
SPEC=$SPECS/<NN-name>        # the command argument, e.g. specs/00-preguntas-negocio
```

Everything else derives from those two, so you can find every element of the repository without hand-written paths:

| Variable | Value | Purpose |
|---|---|---|
| `SPEC_FILE` | `$SPEC/spec.md` | The only file you edit. |
| `PLAN_FILE` | `$SPEC/plan.md` | Read only. If it exists, every change makes it obsolete (principle XII). |
| `TASKS_FILE` | `$SPEC/task.md` or `$SPEC/tasks.md` | Read only. ADR-0006 decides the name; use whichever exists. |
| `SPEC_ADR` | `$SPEC/adr/` | ADRs of this specification. |
| `SPECS_INDEX` | `$SPECS/README.md` | List and order of the specifications. |
| `CONSTITUCION` | `memory/constitution.md` | Read first (XIV). |
| `ADR_GLOBAL` | `memory/adr/` | ADRs that affect the whole project. |
| `GESTION` | `docs/gestion/` | `tareas.md` and `roles.md`: real status and owners. |
| `PLANTILLA_SPEC` | `templates/spec-template.md` | The structure a spec is expected to have. |

## 1. When to use it and what it does NOT do

- Use it on a spec in **Borrador** (Draft) or **En revisión** (In review), before `/plan`.
- It does not write the spec from scratch (that is `/specify`), does not design (that is `/plan`) and does not approve: approval and closing belong to the owner (principle XI).
- If the spec is **Aprobada** (Approved), warn and stop: clarifying it requires the owner to reopen it, because any change forces plan and tasks to be regenerated.

## 2. Flow

### Step 1 — Resolve and validate

1. Set `SPEC`, and with it the other variables.
2. The name matches `^[0-9]{2}-[a-z0-9]+(-[a-z0-9]+)*$` (XIII) and is in the list of principle XII. Read the list from the constitution; do not assume you know it.
3. `SPEC_FILE` exists. If it does not, do not create it: point to `/specify` or `bash scripts/new-spec.sh <name>`.

### Step 2 — Load the context, in this order (XIV)

1. `CONSTITUCION` in full. Note its current version.
2. `AGENTS.md` and the root `README.md`.
3. `SPEC_FILE` in full, and `PLANTILLA_SPEC` to know what structure it was meant to have.
4. `SPECS_INDEX` and `GESTION/tareas.md`: order, status and blockers.
5. `ADR_GLOBAL` and `SPEC_ADR`: what is "Pendiente" (pending) and what blocks this spec.
6. The neighbouring specs: the previous one (it must have passed its gate) and the following ones, above all the part about what they inherit. A gap is often in what this spec must hand over to another.
7. `PLAN_FILE` and `TASKS_FILE`, only to know whether they exist.

### Step 3 — Scan for gaps

Mark each category **Clear**, **Partial** or **Missing**. The sections are those of `PLANTILLA_SPEC`.

| Category | Where to look | It is a gap if… |
|---|---|---|
| Scope and goal | §1, §6 | You cannot say in one sentence what it delivers and what it leaves out; the `SC-xx` results have no figure, file or command. |
| Use cases and acceptance | §2 | A P1/P2/P3 priority is missing, or a criterion cannot be checked ("fast", "adequate"). |
| Functional requirements | §3 | An RF is not in EARS, does not link to a use case or does not say how it is verified. |
| Data and domain | §3 entities | An entity, its grain, its keys or its relationships are not defined; a field does not match the source. |
| Non-functional | §4 | A category has no metric (value and unit) nor "No aplica: reason"; cost other than $0 without an ADR (VIII). |
| Edge cases and data quality | §5 | Errors, limits, invalid data, concurrency or **re-running the same step** (IX) are missing. |
| Dependencies and ADRs | header, §7 | "Depende de" (depends on) has not passed its gate, or a pending ADR blocks it. |
| Traceability (XV) | §2, §3, §8 | Some RF, rule or criterion cannot be followed to its verification or evidence. |
| Constitution | whole spec | Technology appears (V, XII), versioned data (VII), or something from the constitution's "Fuera de alcance" (out of scope). |
| Terminology and markers | whole spec | Two names for the same thing; more than 3 `[NECESITA ACLARACIÓN]`; markers without a row in the questions section; `[BRACKETS]` left unreplaced. |
| Closing and size | §8 | The closing list does not mirror the gate; the spec is outside 160–180 lines (if over 300, warn: splitting it requires amending the constitution). |

**Repository gaps.** They are **reported, not asked about or edited**, because they do not live in the spec:

- The constitution version in the header is not the current one.
- The previous spec has no closed gate in `GESTION/tareas.md`.
- There are "Pendiente" ADRs that had to be resolved before this spec.
- The spec is not in `SPECS_INDEX` or has no entry in `GESTION/tareas.md`.
- The spec does not follow `PLANTILLA_SPEC` (different sections, or no questions table). Reporting it is enough: restructuring it is the owner's decision.
- `PLAN_FILE` or `TASKS_FILE` already exist and will become obsolete.

### Step 4 — Build the question queue (at most 5)

Rank the gaps by **impact × uncertainty**. A question gets in only if its answer changes the plan, the tests, the data model or an acceptance criterion. These stay out:

- **Technology** (engine, tool, library): it belongs to `plan.md` or an ADR.
- Anything the constitution already decided.
- **Pending ADRs that affect the whole project** (0006 to 0011): they are not asked here; mark them "Escalada a ADR" (escalated to ADR) and report the blocker.
- Anything the spec itself **defers to another spec** with a reason. Example: in `00-preguntas-negocio`, the volume threshold for the rankings is set with data in `02-exploracion-eda`, and the real fields are confirmed in `01-ingesta-bronce`. They are noted as "Diferida" (deferred) in the report, not asked.
- Style or wording that does not change the meaning.

Each question is **multiple choice** (2 to 5 mutually exclusive options) or **short answer** (5 words or fewer).

### Step 5 — Ask one at a time

Ask a single question per turn and wait for the answer. Do not reveal the next ones. Format:

```text
Question 2 of 4 · Data and domain · Impact: high
<the question>

Recommended: B — <reason in one sentence>

| Option | What it implies |
|---|---|
| A | … |
| B | … |

Reply with the letter, with "yes" (accept the recommended one) or with your own answer.
```

- If the answer is ambiguous, ask a quick follow-up on the same point; it does not count as a new question.
- Stop when the queue is empty, when 5 have been asked, or when the person says "done" or "stop".
- Base the recommendation on the constitution, the neighbouring specs or the data source. If there is no basis to recommend, say so; do not invent one.

### Step 6 — Record each answer immediately

Save after **every** answer, not at the end: if the session is cut off, nothing is lost.

1. In the open-questions section (`§7 DISCOVERY QUESTIONS`; "Puntos abiertos" in a spec that predates the template), move the row to **Resuelta** (resolved) with the decision, or to **Escalada a ADR** with its number. If the question had no row, create it.
2. Add to "Decisiones tomadas" (decisions made): `Decisión · Motivo · Consecuencia` (decision · reason · consequence), with the date `YYYY-MM-DD`.
3. Apply the answer where it belongs (RF, CA, CL, non-functional requirement, entity). Replace the vague sentence; do not leave both versions.
4. If a new requirement emerges, give it the next `RF-xx`, link it to its use case and say how it is verified (XV).
5. Remove the `[NECESITA ACLARACIÓN]` that no longer applies and update "Última actualización" (last updated).

### Step 7 — Validate after each write

- No marker is left without a row, and there are no more than 3 in the text.
- Terms are the same across the whole spec.
- The answer contradicts neither an earlier one nor the constitution.
- No technology slipped in.

### Step 8 — Final report

```text
## /clarify report — <NN-name>
Questions: n of 5 · Sections touched: …

| Category | Before | After | Note |
|---|---|---|---|

Gaps still open (highest to lowest impact): …
Deferred to another spec: …
Repository gaps (not edited): …
Plan or tasks obsolete? yes / no (if yes: regenerate them, principle XII)

Next step: /plan <name>   (or /clarify again if something of high impact remains)
```

If there is no ambiguity that matters, say so ("no gaps of significant impact") and suggest `/plan`. Do not invent questions to reach five.

## 3. Rules, and why

- **You edit only `SPEC_FILE`.** Everything else is reported; that way `/clarify` cannot undo decisions made elsewhere.
- **Do not invent figures or fields.** Use those of the constitution or the source; if they are not there, ask or leave it "Pendiente". An invented figure becomes a test that passes for the wrong reason.
- **Do not resolve pending ADRs or treat them as resolved.** Resolving them requires an ADR signed by the owner.
- **Clarifying is not redesigning.** If an answer changes the scope or the list of specs, stop: that is amending the constitution.
- **Never mark the spec "Aprobada" (Approved).** The owner approves it (XI).
- **Language.** Talk to the person in English. What you write into the spec stays in the spec's own language (Spanish in this repository), reusing its literal headings and markers (`[NECESITA ACLARACIÓN]`, "Decisiones tomadas", "Puntos abiertos", "Última actualización").
