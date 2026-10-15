---
description: Encuentra huecos de la spec.md antes de /plan con hasta 5 preguntas, una por turno, y registra cada respuesta en la spec. Uso /clarify 00-preguntas-negocio
argument-hint: "[NN-nombre]"
---

Aclara una especificación con la skill `skill-clarify`. Corre en la sesión principal porque hace una pregunta por turno y un subagente no puede preguntar. Para aplicar las reglas del agente, abre la sesión con `claude --agent spec-writer`.

Argumentos del usuario (el primero es la carpeta de la especificación; el resto es contexto adicional): $ARGUMENTS

## Variables (sección 0 de la skill)

```text
SPECS=specs
SPEC=$SPECS/<primer argumento>
```

- Si el argumento viene como ruta (`specs/NN-nombre` o `specs/NN-nombre/spec.md`), quédate solo con la carpeta.
- Si no hay argumentos, pregunta «¿Qué spec aclaro? Por ejemplo `00-preguntas-negocio`» y detente.
- Las demás variables (`SPEC_FILE`, `PLAN_FILE`, `TASKS_FILE`, `CONSTITUCION`…) se derivan de estas dos según la tabla de la skill.

## Cómo seguir

1. Carga la skill `skill-clarify` con la herramienta Skill. Si no está disponible, lee `.claude/skills/skill-clarify/SKILL.md` completo.
2. Síguela paso a paso.

## Reglas de este comando

- Lee `memory/constitution.md` completa antes que cualquier otro documento.
- Haz una sola pregunta por turno y espera la respuesta. Guarda en `spec.md` después de cada respuesta.
- Solo editas `specs/<NN-nombre>/spec.md`.
- Conversa en español. Lo que escribes en la spec sigue en español, con sus encabezados literales.
