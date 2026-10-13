# Constitución del DWS de Reseñas de Amazon

Principios no negociables del proyecto. Todo agente (`spec-writer`, `architect`, `task-breaker`, `implementer`) y toda persona que trabaje en este repositorio DEBE leerla antes de actuar y comprobar que su trabajo la cumple. Si una especificación, un plan o una tarea la contradice, gana la constitución.

## Propósito

Data Warehouse sobre reseñas de Amazon (SNAP, Stanford) construido desde cero con Spec-Driven Development: Kimball para el modelo analítico, Medallion para las capas, PostgreSQL como motor, todo local y gratis.

## Principios fundamentales

### I. Kimball para el modelo analítico
El modelo de Oro se diseña desde cero con Kimball. Toda tabla de hechos DEBE declarar su grano en una frase, usar claves subrogadas, tener una fila especial para datos faltantes y clasificar cada medida como aditiva, semiaditiva o no aditiva.
**Verificación:** el `README.md` de `src/gold/` contiene grano, claves, fila especial y clasificación de medidas.

### II. Medallion: un esquema de PostgreSQL por capa
Bronce (`raw`), Plata (`silver`) y Oro (`gold`) son tres esquemas de PostgreSQL. Cada capa DEBE exportarse a `.parquet` con DuckDB y documentarse con su DDL (esquema, tablas, campos, tipos y restricciones) en su `README.md`.
**Verificación:** `src/bronze/`, `src/silver/` y `src/gold/` tienen `README.md` y un script `NN_export_parquet.sql`.

### III. Bronce no se modifica nunca
`raw` contiene el histórico de 3 años (2010-03-04 a 2013-03-04, 9.707.634 reseñas) y es el respaldo para reprocesar. Una vez cargado y validado, NINGÚN script ejecuta `UPDATE`, `DELETE` ni `TRUNCATE` sobre `raw`; las correcciones se hacen en Plata.
**Verificación:** `tests/test_bronze.py` valida el conteo (9.707.634) y el rango de fechas.

### IV. Toda transformación nace de una regla del EDA
Cada hallazgo del EDA se convierte en una regla con código (`R01`, `R02`…), una acción (descarta, corrige o marca) y su conteo en la bitácora de calidad. NO DEBE existir en el ETL ninguna transformación sin regla.
**Verificación:** cada regla listada en `src/exploration/README.md` tiene su fila en la bitácora y su test.

### V. SQL puro; Python solo para pruebas
Ingesta, exploración y ETL se escriben en SQL sobre PostgreSQL. DuckDB (SQL) solo exporta a Parquet. Python solo vive en `tests/`. Toda excepción requiere un ADR aprobado (ver pendiente ADR-0008).
**Verificación:** no hay archivos `.py` fuera de `tests/`, salvo los autorizados por ADR.

### VI. Cada regla tiene un test y el cuadre es exacto
Un script de Python por regla del EDA, más un cuadre de filas entre capas: filas que entran = filas que salen + rechazadas + eliminadas. El cuadre DEBE dar exacto, sin tolerancia.
**Verificación:** `tests/` pasa en verde; el cuadre de cada capa queda en su README.

### VII. Los datos nunca se versionan
Git guarda solo código y documentación. Los datos viven en `data/` (ignorada) y se respaldan en Google Drive.
**Verificación:** `git ls-files` no lista ningún `.gz`, `.parquet`, `.csv`, `.twbx` ni `.env`.

### VIII. Costo $0 en el estado actual
Todo corre gratis y en local (PostgreSQL, pgAdmin, DuckDB, Tableau Public). Ninguna especificación ni plan puede introducir un servicio de pago. La nube y la comparación de costos son trabajo futuro.

### IX. Orquestación manual y reproducible
La ejecución es manual, con scripts numerados (`01_`, `02_`…) que se corren en orden, sin rutas ni configuraciones atadas a una sola máquina, pensada para migrar a Databricks en el siguiente corte.
**Verificación:** partiendo de `all_3y.txt.gz` y siguiendo el orden numerado, otra persona obtiene las mismas tablas y conteos.

### X. Gestión dentro del repositorio
Roles y tareas viven en `docs/gestion/`: `roles.md` (responsable por capa y entregable) y `tareas.md` (resumen general del proyecto; cada tarea con responsable, estado y evidencia: el archivo o commit que la cierra). Cada especificación mantiene además su propio archivo de tareas en `specs/NN-nombre/`. Sin Notion.

### XI. Verificación humana antes de cerrar
Los agentes generan y ejecutan el SQL, pero el responsable de la capa DEBE verificar con sus propias consultas (conteos, cuadres y muestras) antes de cerrar una especificación. Un agente NO da una especificación por cerrada.

### XII. Especificación primero y en orden
`spec.md` dice qué y por qué, sin tecnología. `plan.md` dice cómo. Las tareas salen del plan y el código sale de las tareas. Si algo cambia, se actualiza primero la especificación y luego se regeneran plan y tareas. El orden es `01-ingesta-bronce` → `02-exploracion-eda` → `03-etl-plata` → `04-modelo-oro` → `05-dashboards-bi`, y una no empieza hasta que la anterior pasa sus tests.

## Estándares tecnológicos

- **Motor:** PostgreSQL local. Es el único motor del DW.
- **Fuente:** `all_3y.txt.gz` se descarga de Google Drive a `data/raw/`. Es un recorte de `all.txt.gz` (≈ 11 GB, 34.686.770 reseñas, 1995–2013), contado hacia atrás desde la última fecha del dataset (2013-03-04, epoch `1362355200`), no desde hoy. El corte es el epoch `1267660800`. La especificación `01-ingesta-bronce` documenta cómo se generó el recorte y valida conteo y rango de fechas.
- **Formatos:** `.gz` de texto plano `clave: valor` → archivo delimitado por `|` → tablas PostgreSQL (carga con `\copy`) → `.parquet` por capa.
- **Parquet:** exportado con DuckDB desde `src/<capa>/NN_export_parquet.sql` hacia `data/parquet/{bronze,silver,gold}/` (ADR-0003).
- **Exploración:** solo SQL sobre `raw`. El archivo completo NO se carga en PostgreSQL; sus cifras son referencia de la fuente.
- **Pruebas:** Python (pytest) en `tests/`, con la conexión leída de variables de entorno.
- **Visualización:** Tableau, con acceso de lectura solo a Oro. Se versionan los `.twb`; los `.twbx` no, porque incluyen datos.
- **Nombres:** un esquema por capa; tablas y campos en `snake_case`.

## Seguridad del dato

- **PII:** los únicos datos personales son `userId` y `profileName` (seudónimos públicos de Amazon). No hay correos, teléfonos ni pagos. Las reseñas anónimas se tratan con una regla del EDA explícita, con acción y conteo en la bitácora.
- **Cruce de fuentes:** el dataset NO se cruza con otras fuentes para identificar personas.
- **Cifrado:** no aplica, porque la base es local y el dataset es público. Se reevalúa si algún día se migra a la nube.
- **Acceso por rol:** un esquema por capa. Tableau se conecta con un rol de solo lectura que tiene permisos únicamente sobre `gold`.
- **Secretos:** la contraseña de PostgreSQL nunca se sube al repositorio. Scripts y pruebas leen la conexión de variables de entorno; `.env.example` lista `PGHOST`, `PGDATABASE` y `PGUSER` sin contraseña, y la contraseña real vive solo en el `.env` local (ignorado). Ningún SQL versionado, incluido el `ATTACH` de DuckDB, contiene credenciales.
- **Auditoría:** fecha de carga en Oro, bitácora de calidad por regla y linaje de cada fila de Oro hasta su fila en Bronce.

## Rendimiento, volumen y costos

- **Volumen:** filas y MB por capa, documentados en el README de cada capa.
- **Latencia de consultas:** un índice B-tree en cada llave foránea de la tabla de hechos (PostgreSQL no los crea solo), creados DESPUÉS de cargar el hecho en `src/gold/03_indexes.sql`. Las consultas principales se miden con `EXPLAIN ANALYZE` antes y después, y los tiempos quedan en el README de `gold`. Un índice compuesto solo se agrega si una consulta frecuente filtra por dos claves a la vez.
- **Frescura:** dataset cerrado (último dato 2013-03-04) y carga histórica única; no hay cargas incrementales.
- **Concurrencia:** 2 usuarios, cada uno con su copia local.
- **Costo:** $0 mensual. A futuro, calcular SLAs y costos para montar las tres capas en la nube y compararlos con el entorno local.

## Modelado y calidad

- **Reglas del EDA:** código, acción y conteo. `descarta` cubre las filas rechazadas y las eliminadas; `corrige` y `marca` no cambian el número de filas.
- **Bitácora de calidad:** tabla que la carga llena automáticamente, con una fila por regla: regla, descripción, filas, acción y fecha de registro. Sirve de evidencia (la regla se aplicó y cuánto afectó), de cuadre (no se perdió ninguna fila) y de fuente de los indicadores de calidad (por ejemplo, % de reseñas anónimas), que los tests comparan contra lo esperado.
- **Linaje:** de cada fila de Oro se puede llegar a su fila de Plata y de Bronce.
- **Documentación:** un `README.md` por capa, con la plantilla `templates/layer-readme.md`: DDL, reglas aplicadas y volumetría.

## Gobernanza y cumplimiento

- **Licencia y uso:** dataset público de investigación (McAuley y Leskovec, 2013), de uso académico. El `README.md` raíz cita la fuente.
- **Retención:** Bronce no se modifica nunca y sirve de respaldo para reprocesar.
- **Residencia:** computadores del equipo, Google Drive (datos) y GitHub (código y documentación).
- **Accesibilidad:** repositorio con ramas, Pull Requests y responsables por carpeta (`.github/CODEOWNERS`).
- **Auditoría:** commits por fase, bitácora de calidad y registro de incidencias.

## Flujo de desarrollo y compuertas

- **Estructura:** lo que dice qué construir y por qué va en `memory/` y `specs/`; lo que se ejecuta va en `src/` y `tests/`; lo que gestiona el equipo va en `docs/`.
- **Ramas:** una rama por especificación (`01-ingesta-bronce`, `02-exploracion-eda`…), integrada a `main` por Pull Request, con commits por fase.
- **Constitution Check:** todo `plan.md` incluye una sección que lista cada principio aplicable y cómo el diseño lo cumple.
- **Decisiones:** las que afectan a todo el proyecto van en `memory/adr/`; las de una sola entrega, en `specs/NN-nombre/adr/`.
- **Compuerta de cierre de una especificación:** (1) tests en verde, (2) cuadre exacto, (3) verificación humana con SQL, (4) README de la capa actualizado, (5) Pull Request integrado a `main`.

## Fuera de alcance

NO DEBE proponerse ni implementarse: Airflow, Dagster o dbt; despliegue en la nube; Notion o revisión cruzada de Pull Requests; ni reutilizar dimensiones, nombres de tablas de Oro o requerimientos del modelo anterior (la topología se rediseña desde cero con Kimball).

## Decisiones pendientes

Ningún agente resuelve estos puntos por su cuenta: cada uno se cierra con un ADR y la firma del responsable antes de la especificación indicada.

| ADR | Pendiente | Resolver antes de |
|---|---|---|
| 0006 | Nombre del archivo de tareas: `task.md` o `tasks.md` | `01-ingesta-bronce` |
| 0007 | Ubicación de `memory/` y cómo la leen los agentes | `01-ingesta-bronce` |
| 0008 | Herramienta del paso que convierte `clave: valor` en archivo delimitado por `\|` (choca con el principio V) | `01-ingesta-bronce` |
| 0009 | Dónde vive la bitácora de calidad y el registro de incidencias | `03-etl-plata` |
| 0010 | Umbral de latencia de las consultas principales | `04-modelo-oro` |
| 0011 | Cómo llega Oro a Tableau Public | `05-dashboards-bi` |

## Gobernanza de la constitución

- Es un documento vivo que cambia con poca frecuencia. Toda enmienda entra por Pull Request, en una rama propia, con su motivo.
- Versionado: MAJOR si se quita o redefine un principio; MINOR si se agrega un principio o una sección; PATCH si solo cambia la redacción.
- Un incumplimiento detectado al revisar una especificación, un plan o las tareas bloquea el avance. Una excepción exige un ADR que la justifique y una fecha de revisión.

**Versión**: 1.0.0 | **Ratificada**: 2026-10-12 | **Última enmienda**: 2026-10-12
