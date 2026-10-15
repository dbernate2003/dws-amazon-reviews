---
description: Redacta o completa la spec.md de una especificación con la skill spec y templates/spec-template.md (qué y por qué, sin tecnología). Uso /spec 01-ingesta-bronce [descripción de la entrega]
agent: spec-writer
subtask: false
---

Redacta o completa la especificación `$1` siguiendo la skill `spec` que aparece abajo, con la plantilla oficial.

Argumentos completos del usuario (el primero es la carpeta de la especificación; el resto es contexto o la descripción de la entrega): $ARGUMENTS

## Variables (sección 0 de la skill)

```text
SPECS=specs
SPEC=$SPECS/$1
```

Si `$1` ya viene como ruta (`specs/NN-nombre` o `specs/NN-nombre/spec.md`), quédate solo con la carpeta. Si viene vacío, pregunta «¿Qué especificación redacto? Por ejemplo `01-ingesta-bronce`» y detente.

Las demás variables (`SPEC_FILE`, `PLAN_FILE`, `TASKS_FILE`, `CONSTITUCION`, `PLANTILLA_SPEC`…) se derivan de estas dos según la tabla de la skill.

## Reglas de este comando

- Lee `memory/constitution.md` completa ANTES que cualquier otro documento.
- Si `specs/$1/spec.md` no existe, propone `bash scripts/new-spec.sh $1` y espera la confirmación; no crees la carpeta a mano.
- Pregunta una sola cosa por turno (máximo 3) y solo lo imprescindible; lo demás queda como `[NECESITA ACLARACIÓN]` para `/clarify`.
- Solo editas `specs/$1/spec.md`. Nunca la marques como «Aprobada».
- Conversa en español. La spec va en español, con los encabezados y marcadores literales de la plantilla.
- Termina con el informe de la skill y el siguiente paso `/clarify $1`.

## Skill

@.opencode/skills/spec.md

## Plantilla oficial

@templates/spec-template.md
