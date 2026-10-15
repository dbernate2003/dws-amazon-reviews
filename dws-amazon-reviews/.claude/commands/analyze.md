---
description: Audita la coherencia Constitución ↔ spec ↔ plan ↔ tareas de una especificación. Solo lectura, informa y no corrige. Corre aislado en el agente architect, sin herramientas de escritura. Uso /analyze 01-ingesta-bronce
argument-hint: "[NN-nombre]"
context: fork
agent: architect
disallowed-tools: Edit, Write
---

Audita una especificación siguiendo la skill `skill-analyze`. Corres con contexto limpio: eres un revisor distinto del autor y todo lo que afirmes sale de los archivos.

Argumentos del usuario (el primero es la carpeta de la especificación; el resto es contexto adicional): $ARGUMENTS

## Variables

```text
SPECS=specs
SPEC=$SPECS/<primer argumento>
CONSTITUCION=memory/constitution.md
SPEC_FILE=$SPEC/spec.md
PLAN_FILE=$SPEC/plan.md
TASK_FILE=$SPEC/task.md
```

- Si el argumento viene como ruta (`specs/NN-nombre` o `specs/NN-nombre/spec.md`), quédate solo con la carpeta.
- Si no hay argumentos, responde solo con la pregunta de la sección 1 de la skill y termina.
- El modo (previo a tareas o completo) depende de si existe `TASK_FILE`. Compruébalo listando el directorio.

## Cómo seguir

1. La skill `skill-analyze` viene precargada en tu agente. Si no la ves, lee `.claude/skills/skill-analyze/SKILL.md` completo.
2. Síguela paso a paso.

## Reglas de este comando

- **Solo lectura.** No edites ni crees ningún archivo. No ejecutes nada que cambie algo.
- Lee `memory/constitution.md` completa antes que cualquier otro documento.
- Entrega el informe con la estructura de la sección 6 de la skill.
