---
description: Lleva una especificación por todo el flujo SDD (/spec → /clarify → /plan → /analyze → /tasks → /implement → /check) desde un solo comando, deteniéndose en cada compuerta a pedir tu confirmación. Retoma donde quedó. Uso /flujo 01-ingesta-bronce [desde plan] [descripción]
agent: spec-writer
subtask: false
---

Orquesta el flujo Spec-Driven completo de la especificación `$1`. **No sustituye a los comandos**: ejecuta el mismo procedimiento de cada uno, en orden, y se detiene en cada compuerta hasta que el usuario diga «continuar». Corre con el agente principal `spec-writer` porque `/spec` y `/clarify` hacen preguntas; los demás pasos los delega a subagentes.

Argumentos completos del usuario: $ARGUMENTS

## Variables

```text
SPECS=specs
SPEC=$SPECS/$1                          # NN-nombre
SPEC_FILE=$SPEC/spec.md
PLAN_FILE=$SPEC/plan.md
TASK_FILE=$SPEC/task.md                 # o tasks.md (ADR-0006): usa el que exista
CONSTITUCION=memory/constitution.md
DESDE=<paso tras la palabra «desde», si viene>   # spec | clarify | plan | analyze | tasks | implement | check
DESCRIPCION=<el resto de los argumentos>
```

- Si `$1` viene como ruta (`specs/NN-nombre` o `specs/NN-nombre/spec.md`), quédate con `NN-nombre`.
- Si `$1` viene vacío, pregunta «¿Qué especificación llevo por el flujo? Por ejemplo `01-ingesta-bronce`» y detente.

## Los pasos y quién los ejecuta

| N.º | Paso | Dónde corre | Procedimiento |
|---|---|---|---|
| 1 | `/spec` | Aquí (pregunta) | Lee `.opencode/commands/spec.md`, la skill `.opencode/skills/spec.md` y `templates/spec-template.md` completas, y síguelas. Pasa `DESCRIPCION`. |
| 2 | `/clarify` | Aquí (pregunta, una por turno) | Lee `.opencode/commands/clarify.md` y la skill `.opencode/skills/clarity.md` completas, y síguelas. |
| 3 | `/plan` | Subagente `architect` | Comando `.opencode/commands/plan.md` + skill `.opencode/skills/plan.md`. |
| 4 | `/analyze` | Subagente `architect`, solo lectura | Comando `.opencode/commands/analyze.md` + skill `.opencode/skills/analyze.md`. |
| 5 | `/tasks` | Subagente `task-breaker` | Comando `.opencode/commands/tasks.md` + skill `.opencode/skills/tasks.md`. Añade `borrador` solo si el usuario lo autorizó en la compuerta. |
| 6 | `/implement` | Subagente `implementer` | Comando `.opencode/commands/implement.md`. Una fase por vez. |
| 7 | `/check` | Subagente `general`, solo lectura | Comando `.opencode/commands/check.md`. |

Para los pasos 3 a 7 usa la herramienta de subagentes (task) con el agente de la tabla y este encargo:

```text
Ejecuta el comando /<paso> para la especificación <NN-nombre> [argumentos extra].
1. Lee .opencode/commands/<paso>.md completo, sin su cabecera ---. Donde diga $1 usa <NN-nombre>; donde diga $ARGUMENTS usa «<NN-nombre> [argumentos extra]».
2. Si el comando incluye una línea @<ruta> (skill o plantilla), lee ese archivo completo: es parte del procedimiento.
3. Síguelo paso a paso con tus propias reglas de agente. No puedes preguntar: si te falta una decisión, detente y devuélvela como pregunta.
[Solo /analyze y /check: no edites ni crees ningún archivo.]
Devuelve el informe final que pide el comando.
```

Si un subagente devuelve una pregunta o un bloqueo, muéstralo tal cual y trátalo como compuerta no superada. Si la herramienta de subagentes no está disponible, no simules el paso: di qué comando correr a mano (por ejemplo `/plan $1`) y detente.

## Paso 0 — Leer el estado (siempre, antes de hacer nada)

1. Lee `memory/constitution.md` completa ANTES que cualquier otro documento. Después `AGENTS.md`, `specs/README.md`, `docs/gestion/tareas.md` y `memory/adr/README.md`.
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

Al terminar cada paso, entrega su informe resumido y la compuerta que le sigue. **Nunca avances al siguiente paso sin un «continuar» explícito del usuario en esta conversación.** Ofrece: «Continuar con <paso siguiente>», «Repetir <paso>», «Parar aquí». Un «sí» vale solo para el paso siguiente, no para los demás.

| Después de | Compuerta: se puede seguir si… | Si no se cumple |
|---|---|---|
| 1 `/spec` | La spec existe, sigue la plantilla y el usuario la revisó. | Repetir `/spec` o editarla a mano. |
| 2 `/clarify` | No quedan huecos de impacto alto; lo restante está diferido o escalado a ADR. | Repetir `/clarify`. |
| 3 `/plan` | Cada requisito tiene componente y el Constitution Check no tiene incumplimientos. | Repetir `/plan`, o volver a `/spec` si el problema está en la spec. |
| 4 `/analyze` | El veredicto es LISTO, sin hallazgos CRITICAL. | CRITICAL → vuelve al paso que lo causa (spec o plan). «NO LISTO» solo por firmas de ADR → para, o sigue a `/tasks` con `borrador` si el usuario lo autoriza expresamente. |
| 5 `/tasks` | `task.md` existe, cada RF tiene tarea y está la tarea final de legibilidad. Antes de seguir, la rama actual DEBE ser `NN-nombre`. | Repetir `/tasks`; cambiar de rama lo hace el usuario. |
| 6 `/implement` | La fase terminó con su «Hecho cuando» cumplido y tests en verde. | Revisar la bitácora del `task.md`; repetir `/implement` con la tarea concreta. |
| 7 `/check` | — | Fin del flujo del agente: la verificación con SQL, la lectura en frío y el Pull Request son del responsable (Principio XI). |

`/implement` se repite por fases: después de cada fase vuelve a su compuerta y ofrece «Siguiente fase», «Ir a /check» o «Parar». Si `/analyze` hay que repetirlo tras cambios, vuelve al paso 4.

## Reglas de este comando

- Cada paso respeta las reglas de su propio comando, su agente y su skill; lo que dicen ellos manda sobre este archivo, y sobre todos, la Constitución.
- Tú (`spec-writer`) solo editas `specs/$1/spec.md` en los pasos 1 y 2. Lo demás lo escriben los subagentes en sus rutas (`plan.md`; `task.md` y sus índices; `src/` y `tests/`).
- No resuelvas ADR pendientes, no marques nada como «Aprobada» y no cierres la especificación.
- Si la conversación se corta, `/flujo $1` retoma desde el paso 0 leyendo los archivos.
- Conversa en español.

Al parar (por compuerta o por petición del usuario) termina con: pasos hechos, paso siguiente y el comando exacto para retomar, por ejemplo `/flujo $1` o `/flujo $1 desde tasks`.
