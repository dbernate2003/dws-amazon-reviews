# Tareas del proyecto

Resumen general (Principio X). Cada tarea tiene responsable, estado y evidencia: el archivo o commit que la cierra. El detalle de cada especificación vive en su propio archivo de tareas, en `specs/NN-nombre/`.

**Estados:** pendiente · en curso · hecha

## Proyecto

| ID | Tarea | Responsable | Estado | Evidencia |
|---|---|---|---|---|
| G-01 | Ratificar la constitución v1.0.0 | por asignar | hecha | `memory/constitution.md` (ratificada 2026-10-12) |
| G-02 | Set-up de OpenCode: agentes, comandos, `opencode.json`, `AGENTS.md` | por asignar | en curso | pendiente de commit |
| G-03 | Resolver ADR-0006, ADR-0007 y ADR-0008 | por asignar | pendiente | `memory/adr/` |
| G-04 | Completar `docs/gestion/roles.md` y `.github/CODEOWNERS` con los responsables reales | por asignar | pendiente | |

## Especificaciones

Cada una empieza cuando la anterior pasa sus tests (Principio XII).

| ID | Especificación | Bloqueada por | Responsable | Estado | Evidencia |
|---|---|---|---|---|---|
| S-01 | `01-ingesta-bronce` | ADR-0006, 0007, 0008 | por asignar | pendiente | |
| S-02 | `02-exploracion-eda` | S-01 | por asignar | pendiente | |
| S-03 | `03-etl-plata` | S-02, ADR-0009 | por asignar | pendiente | |
| S-04 | `04-modelo-oro` | S-03, ADR-0010 | por asignar | pendiente | |
| S-05 | `05-dashboards-bi` | S-04, ADR-0011 | por asignar | pendiente | |
