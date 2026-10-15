---
description: Desglosa el plan.md de una especificación en task.md y refleja la lista en specs/README.md y docs/gestion/tareas.md. Uso /tasks 00-preguntas-negocio
agent: task-breaker
subtask: false
---

Genera o actualiza las tareas de la especificación `$1` siguiendo la skill `tasks` que aparece abajo.

Argumentos completos del usuario (el primero es la carpeta de la especificación; el resto es contexto adicional): $ARGUMENTS

## Variables (sección 0 de la skill)

```text
SPECS=specs
SPEC=$SPECS/$1
```

- Si `$1` viene como ruta (`specs/NN-nombre`), quédate solo con `NN-nombre`.
- Si viene vacío, haz la única pregunta de la sección 0 de la skill y detente.
- Muestra primero el bloque de variables y la tabla de rutas con `existe` / `no existe` / `se crea`, comprobado listando el directorio.

## Reglas de este comando

- Lee `memory/constitution.md` completa ANTES que cualquier otro documento (Principio XIV).
- Las tareas salen de `specs/$1/plan.md`. Si no existe, detente: «Corre `/plan $1` primero».
- Solo escribes `specs/$1/task.md`, tus bloques de `specs/README.md` y la fila de la spec en `docs/gestion/tareas.md`.
- Si ADR-0006 o ADR-0007 siguen sin firma, dilo antes de crear nada y pregunta si sigues como borrador.

## Skill

@.opencode/skills/tasks.md
