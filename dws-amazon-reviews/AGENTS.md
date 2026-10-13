# AGENTS.md — DWS de Reseñas de Amazon

Reglas del proyecto para OpenCode. La fuente de verdad es `memory/constitution.md` (v1.0.0): **léela completa antes de actuar**. Si algo de este archivo la contradice, gana la constitución.

## Qué es

Data Warehouse sobre reseñas de Amazon (SNAP, Stanford), construido desde cero con Spec-Driven Development. Kimball para el modelo de Oro, Medallion para las capas (`raw` → `silver` → `gold`, un esquema de PostgreSQL por capa), PostgreSQL local, costo $0.

## Mapa del repositorio

| Ruta | Qué vive ahí |
|---|---|
| `memory/` | Constitución y ADR globales (`memory/adr/`). Dice qué construir y por qué. |
| `specs/NN-nombre/` | `spec.md` (qué y por qué), `plan.md` (cómo), archivo de tareas y `adr/` de esa entrega. |
| `src/bronze`, `src/silver`, `src/gold` | SQL numerado (`01_`, `02_`…) de cada capa + `README.md` + `NN_export_parquet.sql`. |
| `src/exploration/` | SQL del EDA sobre `raw` y el catálogo de reglas (`R01`, `R02`…). |
| `tests/` | Único lugar donde vive Python (pytest). |
| `docs/gestion/` | `roles.md` y `tareas.md`. |
| `templates/` | Plantillas de spec, plan, tareas, ADR y README de capa. |
| `scripts/` | Utilidades de apoyo (sin Python). |
| `data/` | Datos locales. Ignorada por Git. |
| `.opencode/` | Agentes y comandos de este set-up. |

## Flujo (Principio XII)

`/specify` → `/plan` → `/tasks` → `/implement` → verificación humana → Pull Request. `/check` audita en cualquier momento (solo lectura).

Orden de especificaciones: `01-ingesta-bronce` → `02-exploracion-eda` → `03-etl-plata` → `04-modelo-oro` → `05-dashboards-bi`. Una no empieza hasta que la anterior pasa sus tests. Si algo cambia, se actualiza primero la spec y luego se regeneran plan y tareas.

Agentes (cambia entre ellos con Tab): `spec-writer`, `architect`, `task-breaker`, `implementer`.

## Reglas que no se rompen

- **SQL puro.** Ingesta, EDA y ETL en SQL sobre PostgreSQL. DuckDB solo exporta a Parquet. Python solo en `tests/`.
- **`raw` es inmutable.** Nunca `UPDATE`, `DELETE` ni `TRUNCATE` sobre `raw` una vez cargado y validado; se corrige en Plata.
- **Sin regla no hay transformación.** Toda transformación del ETL nace de una regla del EDA (código, acción: descarta / corrige / marca, conteo en la bitácora) y tiene su test.
- **Cuadre exacto.** Filas que entran = filas que salen + rechazadas + eliminadas. Sin tolerancia.
- **Datos y secretos fuera de Git.** Nada de `.gz`, `.parquet`, `.csv`, `.twbx` ni `.env`. La conexión sale de variables de entorno (`PGHOST`, `PGDATABASE`, `PGUSER`; la contraseña solo en el `.env` local). Ningún SQL con credenciales, tampoco el `ATTACH` de DuckDB.
- **Scripts numerados y portables.** Se corren en orden, sin rutas absolutas ni nada atado a una máquina.
- **Nombres:** un esquema por capa; tablas y campos en `snake_case`.
- **Fuera de alcance:** Airflow, Dagster, dbt, nube, Notion, revisión cruzada de PR y reutilizar nada del modelo anterior.

## Lo que un agente nunca hace

- Resolver por su cuenta una decisión pendiente (tabla de abajo). Se detiene y lo dice.
- Dar una especificación por cerrada. La cierra el responsable de la capa tras verificar con sus propias consultas (Principio XI).
- Enmendar `memory/constitution.md`. Las enmiendas entran por Pull Request.
- Hacer `git push` o `git merge`. Eso es de las personas.

## Compuerta de cierre de una especificación

1. Tests en verde. 2. Cuadre exacto. 3. Verificación humana con SQL. 4. README de la capa actualizado. 5. Pull Request integrado a `main`.

## Decisiones pendientes

| ADR | Pendiente | Resolver antes de |
|---|---|---|
| 0006 | Nombre del archivo de tareas: `task.md` o `tasks.md` | `01-ingesta-bronce` |
| 0007 | Ubicación de `memory/` y cómo la leen los agentes | `01-ingesta-bronce` |
| 0008 | Herramienta del paso `clave: valor` → archivo delimitado por `\|` (choca con el principio V) | `01-ingesta-bronce` |
| 0009 | Dónde vive la bitácora de calidad y el registro de incidencias | `03-etl-plata` |
| 0010 | Umbral de latencia de las consultas principales | `04-modelo-oro` |
| 0011 | Cómo llega Oro a Tableau Public | `05-dashboards-bi` |

Su estado real está en `memory/adr/`. Mientras uno diga «Pendiente», nadie lo da por resuelto.

## Idioma

Documentación, specs y respuestas en español. Identificadores SQL en `snake_case`.
