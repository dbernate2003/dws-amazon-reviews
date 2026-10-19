---
description: Lleva una especificación por todo el flujo SDD (/spec → /clarify → /plan → /analyze → /tasks → /implement → /check) desde un solo comando, deteniéndose en cada compuerta a pedir tu confirmación. Retoma donde quedó. Uso /flujo 01-ingesta-bronce [desde plan] [descripción]
argument-hint: "[NN-nombre] [desde <paso>] [descripción]"
---

Orquesta el flujo Spec-Driven completo de una especificación. **No sustituye a los comandos**: ejecuta el mismo procedimiento de cada uno, en orden, y se detiene en cada compuerta hasta que digas «continuar». Corre en la sesión principal porque `/spec` y `/clarify` te hacen preguntas. Ábrela con `claude --agent spec-writer` (o una sesión normal con `claude`).

Argumentos del usuario: $ARGUMENTS

## Variables

```text
SPECS=specs
SPEC=$SPECS/<primer argumento>          # NN-nombre
SPEC_FILE=$SPEC/spec.md
PLAN_FILE=$SPEC/plan.md
TASK_FILE=$SPEC/task.md                 # o tasks.md (ADR-0006): usa el que exista
CONSTITUCION=memory/constitution.md
DESDE=<paso tras la palabra «desde», si viene>   # spec | clarify | plan | analyze | tasks | implement | check
DESCRIPCION=<el resto de los argumentos>
```

- Si el argumento viene como ruta (`specs/NN-nombre` o `specs/NN-nombre/spec.md`), quédate con `NN-nombre`.
- Si no hay argumentos, pregunta «¿Qué especificación llevo por el flujo? Por ejemplo `01-ingesta-bronce`» y detente.

## Los pasos y quién los ejecuta

| N.º | Paso | Dónde corre | Cómo lo ejecutas |
|---|---|---|---|
| 1 | `/spec` | Aquí (pregunta) | Carga la skill `skill-spec` y síguela con `templates/spec-template.md`. Pasa `DESCRIPCION`. |
| 2 | `/clarify` | Aquí (pregunta, una por turno) | Carga la skill `skill-clarify` y síguela. |
| 3 | `/plan` | Subagente `architect` | Herramienta Agent con el cuerpo de `.claude/commands/plan.md`. |
| 4 | `/analyze` | Subagente `architect`, solo lectura | Herramienta Agent con el cuerpo de `.claude/commands/analyze.md`; dile explícitamente que no edite ni cree archivos. |
| 5 | `/tasks` | Subagente `task-breaker` | Herramienta Agent con el cuerpo de `.claude/commands/tasks.md`. Añade `borrador` solo si tú lo autorizaste en la compuerta. |
| 6 | `/implement` | Subagente `implementer` | Herramienta Agent con el cuerpo de `.claude/commands/implement.md`. Una fase por vez. |
| 7 | `/check` | Subagente `Explore`, solo lectura | Herramienta Agent con el cuerpo de `.claude/commands/check.md`. |

Para los pasos 3 a 7: lee el archivo del comando, quita su bloque `---` de cabecera, reemplaza `$ARGUMENTS` por `NN-nombre` (más `borrador`, la tarea o la fase cuando correspondan) y pásalo como `prompt` con el `subagent_type` de la tabla. Los subagentes no pueden preguntarte: si su respuesta trae una pregunta o un bloqueo, muéstralo tal cual y trátalo como compuerta no superada.

Si la herramienta Agent no está disponible en esta sesión, no simules el paso: di qué comando correr a mano (por ejemplo `/plan 01-ingesta-bronce`) y detente.

## Paso 0 — Leer el estado (siempre, antes de hacer nada)

1. Lee `memory/constitution.md` completa. Después `AGENTS.md`, `specs/README.md`, `docs/gestion/tareas.md` y `memory/adr/README.md`.
2. Valida el nombre: cumple `^[0-9]{2}-[a-z0-9]+(-[a-z0-9]+)*$` y está en la lista del Principio XII.
3. Comprueba la rama con `git branch --show-current` y si la spec anterior pasó su compuerta de cierre en `docs/gestion/tareas.md`. Si no la pasó, avísalo (Principio XII) y pregunta si sigues de todos modos.
4. Determina el paso siguiente. Si viene `DESDE`, empieza ahí. Si no, el primero que se cumpla:

| Condición encontrada | Paso siguiente |
|---|---|
| `SPEC_FILE` no existe o tiene `[CORCHETES]` de la plantilla sin llenar | 1 `/spec` |
| La spec tiene `[NECESITA ACLARACIÓN]` o filas `Pendiente` en sus preguntas que no estén escaladas ni diferidas | 2 `/clarify` |
| `PLAN_FILE` no existe, o la «Última actualización» de la spec es posterior a la del plan | 3 `/plan` |
| No hay `/analyze` en esta sesión posterior al último cambio del plan o de las tareas | 4 `/analyze` |
| `TASK_FILE` no existe o es anterior al plan | 5 `/tasks` |
| `TASK_FILE` tiene tareas de agente sin `[x]` | 6 `/implement` |
| Todo lo anterior está hecho | 7 `/check` |

5. Muestra un tablero corto y espera confirmación antes del primer paso:

```text
## /flujo — <NN-nombre>   (Constitución vX.Y.Z · rama <rama>)
| Paso | Estado | Evidencia |
|---|---|---|
| 1 spec | hecho / pendiente / desactualizado | specs/<NN-nombre>/spec.md (Borrador, 2026-10-15) |
| … | | |
Siguiente: <paso>. ¿Continúo?
```

## Compuertas (pausa obligatoria después de cada paso)

Al terminar cada paso, entrega su informe resumido y la compuerta que le sigue. **Nunca avances al siguiente paso sin un «continuar» explícito tuyo en esta conversación.** Usa AskUserQuestion con estas opciones: «Continuar con <paso siguiente>», «Repetir <paso>», «Parar aquí». Un «sí» vale solo para el paso siguiente, no para los demás.

| Después de | Compuerta: se puede seguir si… | Si no se cumple |
|---|---|---|
| 1 `/spec` | La spec existe, sigue la plantilla y tú la revisaste. | Repetir `/spec` o editarla a mano. |
| 2 `/clarify` | No quedan huecos de impacto alto; lo restante está diferido o escalado a ADR. | Repetir `/clarify`. |
| 3 `/plan` | Cada requisito tiene componente y el Constitution Check no tiene incumplimientos. | Repetir `/plan`, o volver a `/spec` si el problema está en la spec. |
| 4 `/analyze` | El veredicto es LISTO, sin hallazgos CRITICAL. | CRITICAL → vuelve al paso que lo causa (spec o plan). «NO LISTO» solo por firmas de ADR → para, o sigue a `/tasks` con `borrador` si tú lo autorizas expresamente. |
| 5 `/tasks` | `task.md` existe, cada RF tiene tarea y está la tarea final de legibilidad. Antes de seguir, la rama actual DEBE ser `NN-nombre`. | Repetir `/tasks`; cambiar de rama lo haces tú. |
| 6 `/implement` | La fase terminó con su «Hecho cuando» cumplido y tests en verde. | Revisar la bitácora del `task.md`; repetir `/implement` con la tarea concreta. |
| 7 `/check` | — | Fin del flujo del agente: la verificación con SQL, la lectura en frío y el Pull Request son tuyos (Principio XI). |

`/implement` se repite por fases: después de cada fase vuelve a su compuerta y ofrece «Siguiente fase», «Ir a /check» o «Parar». Si `/analyze` hay que repetirlo tras cambios, vuelve al paso 4.

## Reglas de este comando

- Cada paso respeta las reglas de su propio comando, su agente y su skill; lo que dicen ellos manda sobre este archivo, y sobre todos, la Constitución.
- Este comando no edita archivos por su cuenta: solo escriben los pasos, cada uno en sus rutas (`spec.md` en 1–2, `plan.md` en 3, `task.md` y sus índices en 5, `src/` y `tests/` en 6).
- No resuelvas ADR pendientes, no marques nada como «Aprobada» y no cierres la especificación.
- No corras `git checkout`, `git commit`, `psql` ni `duckdb` sin tu confirmación (están en «ask» de `.claude/settings.json`).
- Si la conversación se corta, `/flujo <NN-nombre>` retoma desde el paso 0 leyendo los archivos.
- Conversa en español.

Al parar (por compuerta o por petición tuya) termina con: pasos hechos, paso siguiente y el comando exacto para retomar, por ejemplo `/flujo 01-ingesta-bronce` o `/flujo 01-ingesta-bronce desde tasks`.
