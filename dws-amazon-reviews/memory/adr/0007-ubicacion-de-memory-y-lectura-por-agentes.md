# ADR-0007 — Ubicación de `memory/` y cómo la leen los agentes

- **Estado:** Pendiente
- **Fecha:** 2026-10-12
- **Resolver antes de:** `01-ingesta-bronce`
- **Responsable (firma):** pendiente

## Contexto

La constitución obliga a todo agente a leerla antes de actuar, y dice que lo que define qué construir y por qué va en `memory/` y `specs/`. Falta fijar dónde vive `memory/` y con qué mecanismo la leen los agentes.

Estado provisional del set-up de OpenCode: `memory/` está en la raíz del repositorio y cada agente tiene en su prompt la instrucción de leer `memory/constitution.md`. `opencode.json` no usa el campo `instructions`.

## Opciones consideradas

| Opción | A favor | En contra |
|---|---|---|
| | | |

## Decisión

Pendiente.

## Consecuencias

Al decidir: revisar `AGENTS.md`, `opencode.json` y los prompts de `.opencode/agents/`, y las rutas citadas en `templates/` y `specs/`.
