---
description: Redacta o completa la spec.md de una especificación con la skill skill-spec y templates/spec-template.md (qué y por qué, sin tecnología). Uso /spec 01-ingesta-bronce [descripción de la entrega]
argument-hint: "[NN-nombre] [descripción]"
---

Redacta o completa una especificación con la skill `skill-spec` y la plantilla oficial. Corre en la sesión principal porque puede necesitar preguntarte cosas. Para aplicar las reglas del agente, abre la sesión con `claude --agent spec-writer`.

Argumentos del usuario (el primero es la carpeta de la especificación; el resto es contexto o la descripción de la entrega): $ARGUMENTS

## Variables (sección 0 de la skill)

```text
SPECS=specs
SPEC=$SPECS/<primer argumento>
```

- Si el argumento viene como ruta (`specs/NN-nombre` o `specs/NN-nombre/spec.md`), quédate solo con la carpeta.
- Si no hay argumentos, pregunta «¿Qué especificación redacto? Por ejemplo `01-ingesta-bronce`» y detente.
- Las demás variables (`SPEC_FILE`, `PLAN_FILE`, `TASKS_FILE`, `CONSTITUCION`, `PLANTILLA_SPEC`…) se derivan de estas dos según la tabla de la skill.

## Cómo seguir

1. Carga la skill `skill-spec` con la herramienta Skill. Si no está disponible, lee `.claude/skills/skill-spec/SKILL.md` completo.
2. Lee `templates/spec-template.md` completa: es la estructura obligatoria de la spec.
3. Sigue la skill paso a paso.

## Reglas de este comando

- Lee `memory/constitution.md` completa antes que cualquier otro documento.
- Si `specs/<NN-nombre>/spec.md` no existe, propone `bash scripts/new-spec.sh <NN-nombre>` y espera la confirmación; no crees la carpeta a mano.
- Pregunta una sola cosa por turno (máximo 3) y solo lo imprescindible; lo demás queda como `[NECESITA ACLARACIÓN]` para `/clarify`.
- Solo editas `specs/<NN-nombre>/spec.md`. Nunca la marques como «Aprobada».
- Conversa en español. La spec va en español, con los encabezados y marcadores literales de la plantilla.
- Termina con el informe de la skill y el siguiente paso `/clarify <NN-nombre>`.
