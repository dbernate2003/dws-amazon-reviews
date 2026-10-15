---
description: Encuentra huecos de la spec.md antes de /plan con hasta 5 preguntas, una por turno, y registra cada respuesta en la spec. Uso /clarify 00-preguntas-negocio
agent: spec-writer
subtask: false
---

Aclara la especificación `$1` siguiendo la skill `clarify` que aparece abajo.

Argumentos completos del usuario (el primero es la carpeta de la especificación; el resto es contexto adicional): $ARGUMENTS

## Variables (sección 0 de la skill)

```text
SPECS=specs
SPEC=$SPECS/$1
```

Si `$1` ya viene como ruta (`specs/NN-nombre` o `specs/NN-nombre/spec.md`), quédate solo con la carpeta. Si viene vacío, pregunta «¿Qué spec aclaro? Por ejemplo `00-preguntas-negocio`» y detente.

Las demás variables (`SPEC_FILE`, `PLAN_FILE`, `TASKS_FILE`, `CONSTITUCION`…) se derivan de estas dos según la tabla de la skill.

## Reglas de este comando

- Lee `memory/constitution.md` completa ANTES que cualquier otro documento (Principio XIV).
- Haz una sola pregunta por turno y espera la respuesta. Guarda en `spec.md` después de cada respuesta.
- Solo editas `specs/$1/spec.md`.
- Conversa en español. Lo que escribes en la spec sigue en español, con sus encabezados literales.

## Skill

@.opencode/skills/clarity.md
