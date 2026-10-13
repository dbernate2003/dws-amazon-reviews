# Tareas NN — <nombre>

> Salen del `plan.md`, no de la imaginación (Principio XII). El nombre final de este archivo (`task.md` o `tasks.md`) lo fija el ADR-0006. Borra las instrucciones entre `>`.

**Plan:** `specs/NN-nombre/plan.md` · **Rama:** `NN-nombre`

> `[P]` = se puede hacer en paralelo (no comparte archivos con otra tarea). Estado: `[ ]` pendiente · `[x]` hecha.

## Fase 1 — <nombre>

| ID | Estado | Tarea | Archivo | Responsable | Depende de | Evidencia |
|---|---|---|---|---|---|---|
| T001 | [ ] | | `src/…` | | | |
| T002 | [ ] [P] | | `tests/…` | | T001 | |

## Fase N — Cierre (compuerta de la constitución)

| ID | Estado | Tarea | Responsable | Evidencia |
|---|---|---|---|---|
| T0xx | [ ] | Tests en verde | | |
| T0xx | [ ] | Cuadre exacto | | |
| T0xx | [ ] | Verificación humana con SQL (conteos, cuadres y muestras) | responsable de la capa | |
| T0xx | [ ] | README de la capa actualizado | | |
| T0xx | [ ] | Pull Request integrado a `main` | | |
