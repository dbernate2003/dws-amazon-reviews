# AGENTS.md — dws-amazon-reviews

> **ALTO: lee primero `memory/constitution.md`.** Este archivo y el `README.md` se leen DESPUÉS de la constitución (preámbulo de la constitución). Si algo de aquí la contradice, gana la constitución.

<!-- Contexto corto para los agentes de OpenCode (task-breaker, implementer) y para Claude Code. Lo que va entre <...> es un dato que la constitución todavía no fija: complétalo o ciérralo con un ADR. -->

## Orden de lectura
1. `memory/constitution.md` (v1.1.0)
2. `AGENTS.md` (este archivo) y `README.md`
3. `spec.md`, `plan.md` y tareas de la especificación activa en `specs/NN-nombre/`

## Ponytail: siempre activo (ahorro de tokens)
Toda sesión y todo subagente (`spec-writer`, `architect`, `task-breaker`, `implementer`, `explore`…) trabaja en modo **Ponytail**, el «senior perezoso» de <https://github.com/dietrichgebert/ponytail>: escribe el cambio más pequeño que resuelve el problema completo, sin funciones, opciones ni código «para después» que nadie pidió. La pereza es sobre la solución, nunca sobre la lectura: primero se lee el código que el cambio toca y después se recorta.

- **Instalación (una sola vez por persona).** OpenCode: `opencode plugin add @dietrichgebert/ponytail` (global); alternativa por proyecto: `"plugins": ["@dietrichgebert/ponytail"]` en `opencode.json`. Claude Code: `/plugin marketplace add DietrichGebert/ponytail` y `/plugin install ponytail@ponytail`, en dos prompts separados. El detalle está en «Ahorro de tokens (Ponytail)» del `README.md`.
- **Nivel.** `full` por defecto; se ajusta con `/ponytail lite|full|ultra`. En este repositorio no se apaga: `off` solo con autorización del responsable.
- **La constitución gana (principio XIII).** Ponytail recorta alcance, no calidad: no autoriza a omitir los CTEs con su comentario (XIII.1), los comentarios de DDL (XIII.2), las pruebas con docstring (XIII.3), los encabezados, la trazabilidad (XIII.5), el README de capa, la bitácora ni el español (XIII.4). Un atajo deliberado se marca con un comentario `shortcut:` que dice su límite y cuándo revisarlo.
- **Nunca se poda:** validación en las fronteras de confianza, manejo de errores, seguridad, cuadre de filas ni la verificación humana del responsable (principio XI).
- **Cierre de respuesta.** Una o dos líneas finales con lo que se omitió o no se verificó y su riesgo; sin eso, la tarea no está terminada.

## Proyecto
Data Warehouse sobre reseñas de Amazon (SNAP, Stanford; McAuley y Leskovec, 2013), construido desde cero con Spec-Driven Development. El modelo analítico usa Kimball y las capas son esquemas Medallion de PostgreSQL local: `raw` (Bronce), `silver` (Plata) y `gold` (Oro), cada una exportada a `.parquet` con DuckDB. La fuente es `all_3y.txt.gz` (9.707.634 reseñas, 2010-03-04 a 2013-03-04) y Tableau lee solo `gold`. Todo corre en local y con costo $0.

## Especificaciones (en este orden)
| N.º | Nombre | Qué entrega |
|---|---|---|
| 00 | `00-preguntas-negocio` | Preguntas de negocio validadas (insumo del grano y de los tableros) |
| 01 | `01-ingesta-bronce` | Carga de la fuente en `raw` |
| 02 | `02-exploracion-eda` | Hallazgos y reglas `R01`, `R02`… |
| 03 | `03-etl-plata` | Capa `silver` |
| 04 | `04-modelo-oro` | Modelo Kimball en `gold` |
| 05 | `05-dashboards-bi` | Tableros de Tableau |
| 06 | `06-reproducibilidad-integracion` | Reproducibilidad de punta a punta |

Nombre estándar: `NN-nombre` en minúsculas, sin tildes, con guiones y dos dígitos desde `00` (principio XIII).

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
- Nueva especificación: `bash scripts/new-spec.sh NN-nombre` (crea la rama y copia las plantillas a `specs/NN-nombre/`). El script rechaza nombres que no cumplan `^[0-9]{2}-[a-z0-9]+(-[a-z0-9]+)*$`.

## Estilo y convenciones
- Lenguajes: SQL (PostgreSQL) para ingesta, exploración y ETL; DuckDB solo para exportar a Parquet; Python solo en `tests/` (pytest).
- Nombres: un esquema por capa; tablas y campos en `snake_case`; scripts numerados `NN_nombre.sql`; especificaciones `NN-nombre`.
- Idioma: documentación y mensajes en español; identificadores en español sin tildes (p. ej. `silver.resena`).
- Reglas del EDA: código `R01`, `R02`…, con acción `descarta`, `corrige` o `marca` y su conteo en la bitácora de calidad.
- Kimball: grano en una frase, claves subrogadas, fila especial para datos faltantes, medidas clasificadas como aditivas, semiaditivas o no aditivas.
- Cada capa lleva un `README.md` hecho con `templates/layer-readme.md` (DDL, reglas aplicadas y volumetría).
- Cada `spec.md` y `plan.md` declara en su encabezado la versión de la constitución con la que se escribió.

## Reglas
- Lee `memory/constitution.md` ANTES que este archivo, el `README.md` y la spec activa (`specs/NN-nombre/`). Si algo las contradice, gana la constitución.
- Dónde va cada cosa: lo que se ejecuta, en `src/` y `tests/`; qué y por qué, en `memory/` y `specs/`; gestión, en `docs/gestion/`.
- `spec.md` dice qué y por qué, sin tecnología; `plan.md` dice cómo e incluye su Constitution Check. Una spec no empieza hasta que la anterior pasa su compuerta de cierre.
- No toques `raw`: después de cargado y validado, ningún `UPDATE`, `DELETE` ni `TRUNCATE`. Las correcciones van en Plata.
- No versiones datos (`.gz`, `.parquet`, `.csv`, `.twbx`, `.env`) ni pongas credenciales en ningún archivo, incluido el `ATTACH` de DuckDB.
- No añadas sin preguntar: Airflow, Dagster o dbt, nube, Notion, servicios de pago, Python fuera de `tests/`, ni transformaciones que no nazcan de una regla del EDA.
- No reutilices dimensiones, nombres de tablas de Oro ni requerimientos del modelo anterior.
- No resuelvas por tu cuenta los pendientes ADR 0008–0011 de la constitución (el ADR-0012 ya está firmado): propón el ADR y espera al responsable.
- No crees ni renombres especificaciones fuera de la lista del principio XII: eso exige enmendar la constitución.
- Trabaja en la rama de la especificación activa y deja commits por fase.

## Al terminar cualquier tarea
- Corre `pytest tests/` y confirma que el cuadre de filas da exacto: entran = salen + rechazadas + eliminadas. (En `00-preguntas-negocio` no hay código: aplica su lista de validación.)
- Actualiza el `README.md` de la capa (DDL, reglas, volumetría) y la bitácora de calidad.
- Registra la tarea en `docs/gestion/tareas.md` con su evidencia (archivo o commit).
- No des la especificación por cerrada: entrega al responsable las consultas SQL para que verifique conteos, cuadres y muestras.
