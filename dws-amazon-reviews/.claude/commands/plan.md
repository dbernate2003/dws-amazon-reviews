---
description: Genera el plan técnico (plan.md) de una especificación desde su spec.md y la Constitución, sin escribir código. Corre aislado en el agente architect. Uso /plan 01-ingesta-bronce
argument-hint: "[NN-nombre]"
context: fork
agent: architect
---

Genera el plan técnico de una especificación siguiendo la skill `skill-plan`.

Argumentos del usuario (el primero es la carpeta de la especificación; el resto es contexto adicional): $ARGUMENTS

## Variables

```text
SPECS=specs
SPEC=$SPECS/<primer argumento>
SPEC_FILE=$SPEC/spec.md
PLAN_FILE=$SPEC/plan.md
PLANTILLA_PLAN=templates/plan-template.md
CONSTITUCION=memory/constitution.md
```

- Si el argumento viene como ruta (`specs/NN-nombre` o `specs/NN-nombre/spec.md`), quédate solo con la carpeta.
- Si no hay argumentos, responde solo con la pregunta de la sección 1 de la skill y termina.

## Cómo seguir

1. La skill `skill-plan` viene precargada en tu agente. Si no la ves, lee `.claude/skills/skill-plan/SKILL.md` completo.
2. Síguela paso a paso.

## Reglas de este comando

- Lee `memory/constitution.md` completa antes que cualquier otro documento.
- Solo escribes `specs/<NN-nombre>/plan.md`. Si ya existe, léelo antes y conserva lo firmado.
- Sin código: nada de SQL, DDL, Python ni comandos en el plan.
- No puedes preguntar a mitad de la tarea: si te falta algo que solo la persona puede decidir, detente y devuélvelo como pregunta.
