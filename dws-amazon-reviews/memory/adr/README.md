# Registro de decisiones (ADR)

Decisiones que afectan a todo el proyecto. Las de una sola entrega van en `specs/NN-nombre/adr/`. Plantilla: `templates/adr-template.md`.

Ningún agente resuelve una decisión pendiente por su cuenta: se cierra con un ADR y la firma del responsable antes de la especificación indicada.

| ADR | Título | Estado | Resolver antes de | Archivo |
|---|---|---|---|---|
| 0003 | Parquet exportado con DuckDB | Aceptado (citado por la constitución) · falta firma | — | [0003](0003-parquet-con-duckdb.md) |
| 0006 | Nombre del archivo de tareas: `task.md` | Decidido · falta firma | `/tasks` de `00-preguntas-negocio` | [0006](0006-nombre-del-archivo-de-tareas.md) |
| 0007 | Ubicación de `memory/` e `instructions` (opción B) | Decidido · falta firma | `/tasks` de `00-preguntas-negocio` | [0007](0007-ubicacion-de-memory-y-lectura-por-agentes.md) |
| 0008 | Herramienta del paso `clave: valor` → archivo delimitado | Pendiente | `01-ingesta-bronce` | [0008](0008-herramienta-de-conversion-a-delimitado.md) |
| 0009 | Bitácora de calidad y registro de incidencias | Pendiente | `03-etl-plata` | [0009](0009-bitacora-de-calidad-e-incidencias.md) |
| 0010 | Umbral de latencia de las consultas principales | Pendiente | `04-modelo-oro` | [0010](0010-umbral-de-latencia.md) |
| 0011 | Cómo llega Oro a Tableau Public | Pendiente | `05-dashboards-bi` | [0011](0011-oro-hacia-tableau-public.md) |

Los números 0001, 0002, 0004 y 0005 no aparecen en la constitución v1.0.0. Se crean aquí cuando existan, sin reutilizar el número.
