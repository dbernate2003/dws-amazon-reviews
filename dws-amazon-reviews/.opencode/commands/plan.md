---
description: Genera el plan técnico (plan.md) de una especificación desde su spec.md y la Constitución, sin escribir código. Uso /plan 01-ingesta-bronce
agent: architect
subtask: false
---

Genera el plan técnico de la especificación `$1` siguiendo la skill `plan-tecnico-dws` que aparece abajo.

Argumentos completos del usuario (el primero es la carpeta de la especificación; el resto es contexto adicional): $ARGUMENTS

## Variables

```text
SPECS=specs
SPEC=$SPECS/$1
SPEC_FILE=$SPEC/spec.md
PLAN_FILE=$SPEC/plan.md
PLANTILLA_PLAN=templates/plan-template.md
CONSTITUCION=memory/constitution.md
```

- Si `$1` ya viene como ruta (`specs/NN-nombre` o `specs/NN-nombre/spec.md`), quédate solo con la carpeta.
- Si viene vacío, responde solo con la pregunta de la sección 1 de la skill y detente.
- **Plantilla:** la skill dice `templates/plan.md`, pero en este repositorio el archivo es `templates/plan-template.md`. Usa `PLANTILLA_PLAN` y avísalo en tu respuesta.

## Reglas de este comando

- Lee `memory/constitution.md` completa ANTES que cualquier otro documento (Principio XIV).
- Solo escribes `specs/$1/plan.md`. Si ya existe, léelo antes y conserva lo firmado.
- Sin código: nada de SQL, DDL, Python ni comandos en el plan.

## Skill

@.opencode/skills/plan.md
