# ADR-0006 — Nombre del archivo de tareas

- **Estado:** Aceptado · firmado por el responsable el 2026-10-19
- **Fecha:** 2026-10-12
- **Resolver antes de:** `/tasks` de `00-preguntas-negocio`
- **Responsable (firma):** Dario Andres Bernate Canas — 2026-10-19

## Contexto

Cada especificación mantiene su propio archivo de tareas en `specs/NN-nombre/` (Principio X). La constitución dejaba abierto cómo se llama.

## Opciones consideradas

| Opción | A favor | En contra |
|---|---|---|
| `task.md` | Singular, como `spec.md` y `plan.md` | Spec Kit usa `tasks.md` |
| `tasks.md` | Es el nombre de GitHub Spec Kit | Plural, distinto de `spec.md` y `plan.md` |

## Decisión

`task.md`, en singular, en `specs/NN-nombre/task.md`.

## Consecuencias

Actualizar con ese nombre (lo último que se hace, cuando todo lo demás esté ajustado): `templates/task-list-template.md`, `.opencode/agents/task-breaker.md`, `.opencode/agents/implementer.md`, `.opencode/commands/tasks.md`, `specs/README.md`, la constitución y el `README.md` raíz.
