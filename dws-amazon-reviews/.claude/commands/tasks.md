---
description: Desglosa el plan.md de una especificación en task.md y refleja la lista en specs/README.md y docs/gestion/tareas.md. Corre aislado en el agente task-breaker. Uso /tasks 00-preguntas-negocio [borrador]
argument-hint: "[NN-nombre] [borrador]"
context: fork
agent: task-breaker
---

Genera o actualiza las tareas de una especificación siguiendo la skill `skill-tasks`.

Argumentos del usuario (el primero es la carpeta de la especificación; `borrador` autoriza seguir aunque haya ADR sin firma; el resto es contexto): $ARGUMENTS

## Variables (sección 0 de la skill)

```text
SPECS=specs
SPEC=$SPECS/<primer argumento>
```

- Si el argumento viene como ruta (`specs/NN-nombre`), quédate solo con `NN-nombre`.
- Si no hay argumentos, haz la única pregunta de la sección 0 de la skill y termina.
- Muestra primero el bloque de variables y la tabla de rutas con `existe` / `no existe` / `se crea`, comprobado listando el directorio.

## Cómo seguir

1. La skill `skill-tasks` viene precargada en tu agente. Si no la ves, lee `.claude/skills/skill-tasks/SKILL.md` completo.
2. Síguela paso a paso.

## Reglas de este comando

- Lee `memory/constitution.md` completa antes que cualquier otro documento.
- Las tareas salen de `specs/<NN-nombre>/plan.md`. Si no existe, detente: «Corre `/plan <NN-nombre>` primero».
- Solo escribes `specs/<NN-nombre>/task.md`, tus bloques de `specs/README.md` y la fila de la spec en `docs/gestion/tareas.md`.
- No puedes preguntar a mitad de la tarea. Si un ADR que bloquea sigue sin firma y los argumentos no traen `borrador`, no escribas nada: devuelve la pregunta y di que se responde con `/tasks <NN-nombre> borrador`.
