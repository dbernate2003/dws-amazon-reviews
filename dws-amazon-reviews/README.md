# DWS de Reseñas de Amazon

> **ALTO: lee primero [`memory/constitution.md`](memory/constitution.md).** Este README y `AGENTS.md` se leen DESPUÉS de la constitución (principio XIV). Si algo de aquí la contradice, gana la constitución.

Data Warehouse sobre reseñas de Amazon, construido desde cero con Spec-Driven Development ([GitHub Spec Kit](https://github.com/github/spec-kit)) para el curso de Bases de Datos Avanzadas. Modelo analítico con Kimball, capas con Medallion (`raw` → `silver` → `gold`), PostgreSQL local y costo $0.

## Fuente de datos

Reseñas de Amazon del proyecto SNAP de Stanford: <https://snap.stanford.edu/data/web-Amazon.html>. Dataset público de investigación, de uso académico.

> J. McAuley y J. Leskovec. *Hidden factors and hidden topics: understanding rating dimensions with review text.* RecSys, 2013.

El archivo completo (`all.txt.gz`, ≈ 11 GB, 34.686.770 reseñas, 1995–2013) no se carga. Se trabaja con `all_3y.txt.gz`, un recorte de 3 años (2010-03-04 a 2013-03-04, 9.707.634 reseñas) que se descarga de Google Drive a `data/raw/`. La especificación `01-ingesta-bronce` documenta cómo se generó.

## Arquitectura del repositorio

Es la misma estructura que fija la constitución. Los archivos de `src/` y `tests/` los crea la especificación de cada capa.

```text
dws-amazon-reviews/
├── AGENTS.md                              # Contexto corto para agentes; se lee después de la constitución
├── CLAUDE.md                              # Importa la constitución y AGENTS.md (Claude Code)
├── README.md                              # Entrada del repositorio; cita la fuente de datos
├── opencode.json                          # Permisos de OpenCode e instructions (carga la constitución)
├── .env.example                           # PGHOST, PGDATABASE y PGUSER, sin contraseña
├── .gitignore                             # Ignora data/, .env, .gz, .parquet, .csv y .twbx
├── .gitattributes                         # Finales de línea LF en los scripts .sh
├── .github/
│   └── CODEOWNERS                         # Responsables por carpeta
├── .claude/
│   └── skills/
│       └── clarify/SKILL.md               # /clarify: detecta brechas en spec.md (Claude Code y OpenCode la leen)
├── .opencode/
│   ├── agents/                            # task-breaker, implementer (OpenCode: tareas e implementación)
│   └── commands/                          # tasks, implement, check (OpenCode)
├── data/                                  # Ignorada por Git; respaldo en Google Drive
│   ├── raw/                               # all_3y.txt.gz
│   └── parquet/
│       ├── bronze/
│       ├── silver/
│       └── gold/
├── docs/
│   └── gestion/
│       ├── roles.md                       # Responsable por capa y entregable
│       └── tareas.md                      # Resumen general: responsable, estado y evidencia
├── memory/                                # Ubicación sujeta al ADR-0007
│   ├── constitution.md                    # Primer documento que se lee
│   ├── adr/                               # Decisiones que afectan a todo el proyecto
│   │   ├── README.md                      # Índice de ADR
│   │   ├── 0003-parquet-con-duckdb.md
│   │   └── 0006 … 0011                    # Un ADR por decisión pendiente
├── scripts/
│   ├── README.md
│   └── new-spec.sh                        # Crea la rama y la carpeta NN-nombre; rechaza nombres inválidos
├── specs/
│   ├── README.md                          # Índice, orden y compuerta de cierre
│   ├── 00-preguntas-negocio/              # Cada carpeta NN-nombre/ contiene lo mismo:
│   │   ├── spec.md                        # Qué y por qué, sin tecnología
│   │   ├── plan.md                        # Cómo, con su Constitution Check
│   │   ├── task.md                        # Tareas (nombre fijado por el ADR-0006)
│   │   └── adr/                           # Decisiones de esa sola entrega
│   ├── 01-ingesta-bronce/
│   ├── 02-exploracion-eda/
│   ├── 03-etl-plata/
│   ├── 04-modelo-oro/
│   ├── 05-dashboards-bi/
│   └── 06-reproducibilidad-integracion/
├── src/
│   ├── bronze/                            # Esquema raw (spec 01)
│   │   ├── README.md                      # Plantilla templates/layer-readme.md
│   │   ├── 01_ddl.sql
│   │   ├── 02_load.sql                    # Carga con \copy
│   │   └── 03_export_parquet.sql          # DuckDB → data/parquet/bronze/
│   ├── exploration/                       # EDA solo sobre raw (spec 02)
│   │   ├── README.md                      # Catálogo de reglas R01, R02…
│   │   └── NN_tema.sql
│   ├── silver/                            # Esquema silver (spec 03)
│   │   ├── README.md
│   │   ├── 01_ddl.sql
│   │   ├── 02_etl.sql
│   │   └── 03_export_parquet.sql          # DuckDB → data/parquet/silver/
│   └── gold/                              # Esquema gold (spec 04)
│       ├── README.md                      # Grano, claves, fila especial y medidas
│       ├── 01_ddl.sql
│       ├── 02_etl.sql
│       ├── 03_indexes.sql                 # Índices B-tree, tras cargar el hecho
│       └── 04_export_parquet.sql          # DuckDB → data/parquet/gold/
├── templates/
│   ├── adr-template.md
│   ├── constitution-template.md
│   ├── default-template.md                # Plantilla de AGENTS.md
│   ├── layer-readme.md
│   ├── plan-template.md
│   ├── spec-template.md
│   └── task-list-template.md
└── tests/                                 # Único lugar con Python (pytest)
    ├── README.md
    ├── test_bronze.py                     # Conteo 9.707.634 y rango de fechas
    └── test_*.py                          # Un test por regla del EDA y los cuadres
```

## Especificaciones (en este orden)

Nombre estándar `NN-nombre` (principio XIII). Una no empieza hasta que la anterior pasa su compuerta de cierre. El detalle está en [`specs/README.md`](specs/README.md).

| N.º | Carpeta | Entrega |
|---|---|---|
| 00 | `00-preguntas-negocio` | Preguntas de negocio validadas (insumo del grano y de los tableros) |
| 01 | `01-ingesta-bronce` | Bronce (`raw`) y su Parquet |
| 02 | `02-exploracion-eda` | Catálogo de reglas `R01`… sobre `raw` |
| 03 | `03-etl-plata` | Plata (`silver`) y su Parquet |
| 04 | `04-modelo-oro` | Oro (`gold`), rol de solo lectura y su Parquet |
| 05 | `05-dashboards-bi` | Tableau sobre Oro |
| 06 | `06-reproducibilidad-integracion` | Flujo completo reproducible desde `all_3y.txt.gz` |

## Flujo de trabajo (GitHub Spec Kit)

La especificación manda y el código sale de ella. En Spec Kit los pasos se llaman `/speckit-<paso>`; aquí son comandos de OpenCode con el nombre corto del paso. Cada especificación sigue el mismo camino, en este orden:

| N.º | Comando | Cómo se ejecuta | En Spec Kit | Resultado |
|---|---|---|---|---|
| 1 | `/specify` | A mano, con la plantilla `templates/spec-template.md` (la carpeta nace con `scripts/new-spec.sh`) | `/speckit-specify` | `spec.md` |
| 2 | `/clarify 00-preguntas-negocio` | Skill de Claude (`.claude/skills/clarify/`) | `/speckit-clarify` | Preguntas sobre las brechas; las respuestas ajustan la spec indicada |
| 3 | `/plan 00-preguntas-negocio` | Skill de Claude *(por crear)* | `/speckit-plan` | `plan.md`: arquitectura, herramientas y metodología, con su Constitution Check |
| 4 | `/analyze 00-preguntas-negocio` | *(Por crear, después de la skill de plan)* | `/speckit-analyze` | Informe de solo lectura contra la constitución |
| 5 | `/tasks 00-preguntas-negocio` | Comando de OpenCode (`task-breaker`) | `/speckit-tasks` | Archivo `task.md` (ADR-0006) |
| 6 | `/implement 01-ingesta-bronce` | Comando de OpenCode (`implementer`) | `/speckit-implement` | SQL en `src/`, tests en `tests/`, README de la capa |

OpenCode solo desglosa tareas, implementa y ayuda a verificar: `/check 01-ingesta-bronce` (solo lectura) revisa una especificación contra la constitución y no sustituye la verificación humana. Los pasos 2 y 3 trabajan solo con la especificación que se les indica: `/clarify 00-preguntas-negocio` ajusta únicamente la spec de `specs/00-preguntas-negocio/`.

La constitución (`/speckit-constitution`) se redactó una vez con `templates/constitution-template.md` y cambia solo por Pull Request. En Spec Kit `analyze` corre después de `tasks`; aquí va antes. `/speckit-checklist` y `/speckit-converge` no tienen comando propio: la «Revisión final» de `templates/spec-template.md` hace de lista de calidad, y la verificación humana con SQL cierra cada especificación. Las demás diferencias con Spec Kit están en [`specs/README.md`](specs/README.md).

Los agentes no dan una especificación por cerrada: la cierra el responsable de la capa tras verificar con sus propias consultas SQL (principio XI).

## Puesta en marcha

1. Instala PostgreSQL, pgAdmin, DuckDB, Python (pytest) y OpenCode. Todo local y gratis.
2. Copia `.env.example` a `.env` y completa `PGHOST`, `PGDATABASE` y `PGUSER`. La contraseña vive solo en tu `.env` local, que Git ignora.
3. Carga el entorno (Git Bash): `set -a; source .env; set +a`.
4. Descarga `all_3y.txt.gz` a `data/raw/`.
5. Ejecuta los scripts de cada capa en orden numérico: `psql -f src/<capa>/NN_nombre.sql`. El Parquet sale con `duckdb < src/<capa>/NN_export_parquet.sql`.
6. Valida con `pytest tests/`.
7. Para empezar una especificación nueva: `bash scripts/new-spec.sh NN-nombre`, y sigue el flujo de trabajo de arriba.

## Decisiones pendientes

Se cierran con un ADR en [`memory/adr/`](memory/adr/) y la firma del responsable, antes de la especificación indicada.

| ADR | Pendiente | Antes de |
|---|---|---|
| 0006 | Nombre del archivo de tareas: decidido `task.md`, falta firma | `/tasks` de `00-preguntas-negocio` |
| 0007 | Ubicación de `memory/` y cómo la leen los agentes: decidido opción B (`instructions`), falta firma | `/tasks` de `00-preguntas-negocio` |
| 0008 | Herramienta del paso `clave: valor` → archivo delimitado por `\|` | `01-ingesta-bronce` |
| 0009 | Dónde vive la bitácora de calidad y el registro de incidencias | `03-etl-plata` |
| 0010 | Umbral de latencia de las consultas principales | `04-modelo-oro` |
| 0011 | Cómo llega Oro a Tableau Public | `05-dashboards-bi` |
