---
description: Audita la coherencia Constitución ↔ spec ↔ plan ↔ tareas de una especificación. Solo lectura, informa y no corrige. Uso /analyze 01-ingesta-bronce
agent: architect
subtask: true
---

Audita la especificación `$1` siguiendo la skill `analyze` que aparece abajo. Corres como subtarea con contexto limpio: eres un revisor distinto del autor y todo lo que afirmes sale de los archivos.

Argumentos completos del usuario (el primero es la carpeta de la especificación; el resto es contexto adicional): $ARGUMENTS

## Variables

```text
SPECS=specs
SPEC=$SPECS/$1
CONSTITUCION=memory/constitution.md
SPEC_FILE=$SPEC/spec.md
PLAN_FILE=$SPEC/plan.md
TASK_FILE=$SPEC/task.md
```

- Si `$1` ya viene como ruta (`specs/NN-nombre` o `specs/NN-nombre/spec.md`), quédate solo con la carpeta.
- Si viene vacío, responde solo con la pregunta de la sección 1 de la skill y detente.
- Donde la skill escribe `$ARGUMENTS`, entiende la ruta `specs/$1`.
- El modo (previo a tareas o completo) depende de si existe `TASK_FILE`. Compruébalo listando el directorio.

## Reglas de este comando

- **Solo lectura.** No edites ni crees ningún archivo, aunque tu permiso permita editar `plan.md`. No ejecutes nada que cambie algo.
- Lee `memory/constitution.md` completa ANTES que cualquier otro documento (Principio XIV).
- Entrega el informe con la estructura de la sección 6 de la skill.

## Skill

@.opencode/skills/analyze.md
