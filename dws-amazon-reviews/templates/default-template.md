# plantilla.md — dws-amazon-reviews

<!-- Contexto corto para los agentes (spec-writer, architect, task-breaker, implementer). Guárdalo como AGENTS.md en la raíz del repositorio. Lo que va entre <...> es un dato que la constitución todavía no fija: complétalo o ciérralo con un ADR. -->

## Proyecto
Data Warehouse sobre reseñas de Amazon (SNAP, Stanford; McAuley y Leskovec, 2013), construido desde cero con Spec-Driven Development. El modelo analítico usa Kimball y las capas son esquemas Medallion de PostgreSQL local: `raw` (Bronce), `silver` (Plata) y `gold` (Oro), cada una exportada a `.parquet` con DuckDB. La fuente es `all_3y.txt.gz` (9.707.634 reseñas, 2010-03-04 a 2013-03-04) y Tableau lee solo `gold`. Todo corre en local y con costo $0.

## Comandos
- Cargar el entorno (Git Bash): `set -a; source .env; set +a` (`.env` define `PGHOST`, `PGDATABASE`, `PGUSER` y tu contraseña local; no se versiona).
- Ejecutar un script: `psql -f src/<capa>/NN_nombre.sql`. La carga usa `\copy` dentro de `02_load.sql`.
- Orden de ejecución por capa:
  - `src/bronze/`: `01_ddl` → `02_load` → `03_export_parquet`
  - `src/silver/`: `01_ddl` → `02_etl` → `03_export_parquet`
  - `src/gold/`: `01_ddl` → `02_etl` → `03_indexes` → `04_export_parquet`
- Exploración: `psql -f src/exploration/<archivo>.sql` (solo sobre `raw`).
- Exportar a Parquet: `duckdb < src/<capa>/NN_export_parquet.sql` (sale a `data/parquet/<capa>/`).
- Tests: `pytest tests/`
- Lint/formato: <no definido en la constitución; no añadir herramienta sin ADR>
- Nueva especificación: `bash scripts/new-spec.sh NN-nombre` (crea la rama y copia las plantillas a `specs/NN-nombre/`).

## Estilo y convenciones
- Lenguajes: SQL (PostgreSQL) para ingesta, exploración y ETL; DuckDB solo para exportar a Parquet; Python solo en `tests/` (pytest).
- Nombres: un esquema por capa; tablas y campos en `snake_case`; scripts numerados `NN_nombre.sql`.
- Idioma: documentación y mensajes en español; identificadores en español sin tildes (p. ej. `silver.resena`).
- Reglas del EDA: código `R01`, `R02`…, con acción `descarta`, `corrige` o `marca` y su conteo en la bitácora de calidad.
- Kimball: grano en una frase, claves subrogadas, fila especial para datos faltantes, medidas clasificadas como aditivas, semiaditivas o no aditivas.
- Cada capa lleva un `README.md` hecho con `templates/layer-readme.md` (DDL, reglas aplicadas y volumetría).

## Reglas
- Lee `memory/constitution.md` y la spec activa (`specs/NN-nombre/`) antes de tocar código. Si algo las contradice, gana la constitución.
- Dónde va cada cosa: lo que se ejecuta, en `src/` y `tests/`; qué y por qué, en `memory/` y `specs/`; gestión, en `docs/gestion/`.
- `spec.md` dice qué y por qué, sin tecnología; `plan.md` dice cómo e incluye su Constitution Check. Una spec no empieza hasta que la anterior pasa sus tests.
- No toques `raw`: después de cargado y validado, ningún `UPDATE`, `DELETE` ni `TRUNCATE`. Las correcciones van en Plata.
- No versiones datos (`.gz`, `.parquet`, `.csv`, `.twbx`, `.env`) ni pongas credenciales en ningún archivo, incluido el `ATTACH` de DuckDB.
- No añadas sin preguntar: Airflow, Dagster o dbt, nube, Notion, servicios de pago, Python fuera de `tests/`, ni transformaciones que no nazcan de una regla del EDA.
- No reutilices dimensiones, nombres de tablas de Oro ni requerimientos del modelo anterior.
- No resuelvas por tu cuenta los pendientes ADR 0006–0011 de la constitución: propón el ADR y espera al responsable.
- Trabaja en la rama de la especificación activa y deja commits por fase.

## Al terminar cualquier tarea
- Corre `pytest tests/` y confirma que el cuadre de filas da exacto: entran = salen + rechazadas + eliminadas.
- Actualiza el `README.md` de la capa (DDL, reglas, volumetría) y la bitácora de calidad.
- Registra la tarea en `docs/gestion/tareas.md` con su evidencia (archivo o commit).
- No des la especificación por cerrada: entrega al responsable las consultas SQL para que verifique conteos, cuadres y muestras.
