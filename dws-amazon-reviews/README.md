# DWS de Reseñas de Amazon

Data Warehouse sobre reseñas de Amazon, construido desde cero con Spec-Driven Development para el curso de Bases de Datos Avanzadas. Modelo analítico con Kimball, capas con Medallion (`raw` → `silver` → `gold`), PostgreSQL local, todo gratis.

Las reglas del proyecto están en [`memory/constitution.md`](memory/constitution.md). Si algo de este README la contradice, gana la constitución.

## Fuente de datos

Reseñas de Amazon del proyecto SNAP de Stanford: <https://snap.stanford.edu/data/web-Amazon.html>. Dataset público de investigación, de uso académico.

> J. McAuley y J. Leskovec. *Hidden factors and hidden topics: understanding rating dimensions with review text.* RecSys, 2013.

El archivo completo (`all.txt.gz`, ≈ 11 GB, 34.686.770 reseñas, 1995–2013) no se carga. Se trabaja con `all_3y.txt.gz`, un recorte de 3 años (2010-03-04 a 2013-03-04, 9.707.634 reseñas) que se descarga de Google Drive a `data/raw/`. La especificación `01-ingesta-bronce` documenta cómo se generó.

## Estructura

```
dws-amazon-reviews/
├── .github/CODEOWNERS         Responsables por carpeta
├── .opencode/
│   ├── agents/                spec-writer, architect, task-breaker, implementer
│   └── commands/              /specify, /plan, /tasks, /implement, /check
├── data/                      Datos locales (ignorada por Git)
├── docs/gestion/              roles.md y tareas.md
├── memory/
│   ├── constitution.md        Principios no negociables
│   └── adr/                   Decisiones que afectan a todo el proyecto
├── scripts/                   Utilidades de apoyo (sin Python)
├── specs/                     01-ingesta-bronce … 05-dashboards-bi
├── src/
│   ├── bronze/                Capa raw
│   ├── exploration/           EDA y catálogo de reglas
│   ├── silver/                Capa silver
│   └── gold/                  Capa gold
├── templates/                 Plantillas de spec, plan, tareas, ADR y README de capa
├── tests/                     Único lugar con Python (pytest)
├── AGENTS.md                  Reglas del proyecto para OpenCode
├── opencode.json              Configuración de OpenCode
└── .env.example               Variables de conexión, sin contraseña
```

## Flujo de trabajo

Cada especificación sigue el mismo camino, con el agente y el comando de OpenCode que le corresponden:

| Paso | Comando | Agente | Resultado |
|---|---|---|---|
| Qué y por qué | `/specify 01-ingesta-bronce` | `spec-writer` | `specs/01-ingesta-bronce/spec.md` |
| Cómo | `/plan 01-ingesta-bronce` | `architect` | `plan.md` con su Constitution Check |
| Tareas | `/tasks 01-ingesta-bronce` | `task-breaker` | Archivo de tareas de la especificación |
| Código | `/implement 01-ingesta-bronce` | `implementer` | SQL en `src/`, tests en `tests/`, README de la capa |
| Auditoría | `/check 01-ingesta-bronce` | `plan` (solo lectura) | Informe contra la constitución |

Orden obligatorio: `01-ingesta-bronce` → `02-exploracion-eda` → `03-etl-plata` → `04-modelo-oro` → `05-dashboards-bi`. Una no empieza hasta que la anterior pasa sus tests.

Una especificación se cierra con la compuerta de la constitución: tests en verde, cuadre exacto, verificación humana con SQL, README de la capa actualizado y Pull Request integrado a `main`. Los agentes no la cierran.

## Puesta en marcha

1. Instala PostgreSQL, pgAdmin y DuckDB (todo local y gratis), y OpenCode.
2. Copia `.env.example` a `.env` y completa `PGHOST`, `PGDATABASE` y `PGUSER`. La contraseña vive solo en tu `.env` local, que Git ignora.
3. Abre el repositorio con `opencode`. Cambia de agente con Tab y lanza los comandos con `/`.
4. Descarga `all_3y.txt.gz` a `data/raw/`.
5. Ejecuta los scripts de cada capa en orden numérico (`01_`, `02_`…).

## Decisiones pendientes

Se cierran con un ADR en [`memory/adr/`](memory/adr/) y la firma del responsable, antes de la especificación indicada.

| ADR | Pendiente | Antes de |
|---|---|---|
| 0006 | Nombre del archivo de tareas: `task.md` o `tasks.md` | `01-ingesta-bronce` |
| 0007 | Ubicación de `memory/` y cómo la leen los agentes | `01-ingesta-bronce` |
| 0008 | Herramienta del paso `clave: valor` → archivo delimitado por `\|` | `01-ingesta-bronce` |
| 0009 | Bitácora de calidad y registro de incidencias | `03-etl-plata` |
| 0010 | Umbral de latencia de las consultas principales | `04-modelo-oro` |
| 0011 | Cómo llega Oro a Tableau Public | `05-dashboards-bi` |
