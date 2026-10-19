# ADR-0007 — Ubicación de `memory/` y cómo la leen los agentes

- **Estado:** Aceptado · firmado por el responsable el 2026-10-19
- **Fecha:** 2026-10-12
- **Resolver antes de:** `/tasks` de `00-preguntas-negocio`
- **Responsable (firma):** Dario Andres Bernate Canas — 2026-10-19

## Contexto

La constitución obliga a todo agente a leerla antes de actuar. Faltaba fijar dónde vive `memory/` y con qué mecanismo la leen los agentes. Estado previo: `memory/` en la raíz y cada agente con la instrucción en su prompt.

## Opciones consideradas

| Opción | A favor | En contra |
|---|---|---|
| A. `memory/` en la raíz; cada prompt de agente repite la orden de leerla | Sin configuración | Depende de que el modelo obedezca y de no olvidar un agente nuevo |
| B. A más `instructions` en `opencode.json` (y `@` en `CLAUDE.md` para Claude Code) | La herramienta carga la constitución en cada sesión | Gasta tokens en cada petición; una ruta mal escrita se omite sin error |
| C. Mover todo a `.specify/memory/` | Convención de Spec Kit | Cambia todas las rutas y la constitución |

## Decisión

**B.** `memory/constitution.md` sigue en la raíz. `opencode.json` declara `"instructions": ["memory/constitution.md"]` y `CLAUDE.md` importa `@memory/constitution.md` antes de `@AGENTS.md`. Una vez comprobado que carga, la orden repetida en cada prompt de agente sobra.

## Consecuencias

- Comprobar en OpenCode (agente principal, un comando y un subagente) que cita una regla de la constitución. La documentación no confirma que los subagentes reciban `instructions`. **Comprobado el 2026-10-19:** un subagente de OpenCode citó la constitución; en Claude Code la sesión la recibe cargada por `CLAUDE.md`.
- Mantener la constitución corta: viaja completa en cada petición.
- Revisar `AGENTS.md`, los prompts de `.opencode/agents/` y las rutas citadas en `templates/` y `specs/`.
