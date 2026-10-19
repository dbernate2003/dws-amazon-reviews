# Tareas del proyecto

Resumen general (Principio X). Cada tarea tiene responsable, estado y evidencia: el archivo o commit que la cierra. El detalle de cada especificación vive en su propio archivo de tareas, en `specs/NN-nombre/`.

**Estados:** pendiente · en curso · hecha

## Proyecto

| ID | Tarea | Responsable | Estado | Evidencia |
|---|---|---|---|---|
| G-01 | Ratificar la constitución v1.0.0 | por asignar | hecha | `memory/constitution.md` (ratificada 2026-10-12) |
| G-02 | Set-up de OpenCode: agentes, comandos, `opencode.json`, `AGENTS.md` | por asignar | en curso | pendiente de commit |
| G-03 | Resolver ADR-0006, ADR-0007 y ADR-0008 | por asignar | en curso | `memory/adr/`: 0006 y 0007 firmados el 2026-10-19; falta 0008 |
| G-04 | Completar `docs/gestion/roles.md` y `.github/CODEOWNERS` con los responsables reales | por asignar | pendiente | |
| G-05 | Adoptar Ponytail en los agentes (ahorro de tokens) | por asignar | en curso | `memory/adr/0013-ponytail-ahorro-de-tokens.md` y sección «Ahorro de tokens» del `README.md`; ADR firmado el 2026-10-19; falta confirmar la instalación del plugin en los dos equipos |

## Especificaciones

Cada una empieza cuando la anterior pasa sus tests (Principio XII).

| ID | Especificación | Bloqueada por | Responsable | Estado | Evidencia |
|---|---|---|---|---|---|
| S-00 | `00-preguntas-negocio` | U-00-09 `[POR DEFINIR: ADR-0012]` | Dario Andres Bernate Canas | en curso | `specs/00-preguntas-negocio/task.md`; `research.md` (T-00-11, 2026-10-19) |
| S-01 | `01-ingesta-bronce` | S-00 (pausada hasta que cierre), ADR-0008, ADR-0012 | Dario Andres Bernate Canas | pendiente | `specs/01-ingesta-bronce/spec.md` (borrador pausado) |
| S-02 | `02-exploracion-eda` | S-01 | por asignar | pendiente | |
| S-03 | `03-etl-plata` | S-02, ADR-0009 | por asignar | pendiente | |
| S-04 | `04-modelo-oro` | S-03, ADR-0010 | por asignar | pendiente | |
| S-05 | `05-dashboards-bi` | S-04, ADR-0011 | por asignar | pendiente | |
