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
Un test de Python por regla del EDA (una función de prueba identificada por su código `Rnn`, agrupada en el archivo de su dominio según el Principio XIII.3), más un cuadre de filas entre capas: filas que entran = filas que salen + rechazadas + eliminadas. El cuadre DEBE dar exacto, sin tolerancia.
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
`spec.md` dice qué y por qué, sin tecnología. `plan.md` dice cómo. Las tareas salen del plan y el código sale de las tareas. Si algo cambia, se actualiza primero la especificación y luego se regeneran plan y tareas. El orden es `00-preguntas-negocio` → `01-ingesta-bronce` → `02-exploracion-eda` → `03-etl-plata` → `04-modelo-oro` → `05-dashboards-bi` → `06-reproducibilidad-integracion`, y una no empieza hasta que la anterior pasa sus tests.

### XIII. Legibilidad y trazabilidad para perfiles junior (principio transversal)
Todo artefacto producido en este proyecto —scripts SQL, definiciones de esquema (DDL), pruebas de Python con reglas del EDA, documentos y cualquier componente del DWS— DEBE ser comprensible, ejecutable y modificable por una persona ingeniera de datos junior sin contexto previo del repositorio. La legibilidad no es un estilo opcional: es un requisito de aceptación. Un artefacto que funciona pero que una persona junior no puede entender sin ayuda NO está terminado.

Es un principio transversal: aplica a las siete especificaciones (`00` a `06`). Se referencia en `spec.md` (requisitos y criterio de éxito de legibilidad), se verifica en `plan.md` (filas del Constitution Check y sección «Verificación de legibilidad») y en `/analyze` (puntos de control de la tabla XIII-C), y se comprueba al cerrar cada especificación.

**Por qué existe.** Los proyectos de datos acumulan deuda técnica silenciosa: SQL que solo entiende quien lo escribió, esquemas sin documentación, tests del EDA que nadie sabe qué validan. Cuando esa persona se va, el equipo queda bloqueado. Este principio lo previene desde el primer commit.

**Definiciones.**
- *Perfil junior:* persona que conoce SQL básico (`SELECT`, `JOIN`, `GROUP BY`) y Python básico (funciones y pytest), pero no el repositorio ni el dataset.
- *Sin ayuda:* usando solo el propio artefacto, el `README.md` de su capa y el glosario del proyecto.
- *Artefacto:* script, tabla, vista, columna, prueba o documento.

#### XIII.1 SQL
Todo script SQL DEBE:
1. descomponer la lógica en CTEs (`WITH`) con nombre descriptivo, una unidad lógica por CTE, sin subconsultas anidadas en `FROM` ni en `JOIN`;
2. llevar sobre cada CTE un comentario de una línea que diga QUÉ representa y POR QUÉ existe;
3. usar nombres y alias descriptivos y completos (`resenas_validas`, no `t1`, `a` ni `x`);
4. listar las columnas explícitamente, sin `SELECT *`;
5. comentar la regla de negocio de cada columna calculada, con el código `Rnn` cuando provenga del EDA;
6. escribir una cláusula por línea (`SELECT`, `FROM`, `WHERE`, `GROUP BY`…), con indentación consistente y palabras clave en mayúsculas.

#### XIII.2 Esquemas (DDL)
Todo DDL DEBE:
1. comentar cada tabla con su propósito en el DWS (hecho, dimensión, bitácora, etc.) y cada columna con lo que representa y su unidad o dominio, en lenguaje llano y sin repetir el nombre;
2. declarar de forma explícita las llaves primarias, foráneas, `NOT NULL` y `UNIQUE`, sin asumirlas;
3. justificar en un comentario el tipo de dato cuando exista una alternativa razonable (p. ej. `VARCHAR(n)` frente a `TEXT`);
4. usar `snake_case` completo, en español y sin tildes; en Oro, el tipo de tabla se indica con prefijo (`dim_`, `fact_`, `agg_`); la capa se indica con el esquema (`raw`, `silver`, `gold`), nunca con prefijo, y no se usa `stg_`.

#### XIII.3 Pruebas de Python con reglas del EDA
Toda prueba DEBE:
1. llevar un docstring que responda qué regla del EDA (`Rnn`) valida, por qué importa para el negocio y qué ocurre si falla;
2. tener un nombre descriptivo que diga lo que se afirma (`test_r07_puntaje_dentro_del_rango_valido`, no `test_1`);
3. incluir en cada `assert` un mensaje que diga qué se esperaba y qué se encontró;
4. agruparse por dominio en un archivo por área (calidad, completitud, unicidad, consistencia, distribución), con una función de prueba por regla `Rnn`;
5. declarar constantes y umbrales con nombre, al inicio del archivo o en un archivo de configuración; ninguna cifra literal en medio de la lógica.

#### XIII.4 General (aplica a todo artefacto)
Todo artefacto DEBE:
1. preferir nombres completos a abreviaturas (`cantidad`, no `qty`);
2. comentar el POR QUÉ, no el qué: el código ya dice qué hace;
3. priorizar la claridad sobre la brevedad: nada de expresiones densas en una sola línea;
4. documentarse en español, sin mezclar idiomas;
5. abrir con un encabezado que indique propósito, autor, fecha y dependencias.

#### XIII.5 Trazabilidad
Todo script, tabla, prueba y documento DEBE citar, en su encabezado o comentario, el ID del requisito (`RF-NN-MM`, `RNF-NN-MM`) y el código de regla (`Rnn`) que atiende. Todo ID citado DEBE existir en la `spec.md` o en el catálogo de reglas del EDA.

#### XIII.6 Glosario
Los términos de dominio, las siglas y los estados de capa DEBEN definirse en el glosario único del proyecto (`docs/glosario.md`), con un solo nombre por concepto. Ningún artefacto DEBE usar una sigla sin definirla.

#### XIII.7 Lectura en frío
Antes de cerrar una especificación, una persona distinta del autor y de perfil junior (en un equipo de dos, la otra persona) DEBE leer en frío una muestra de los artefactos nuevos —como mínimo uno por tipo (SQL, DDL, prueba, documento) y por capa tocada— y responder correctamente, sin consultar al autor, las cinco preguntas estándar: (1) ¿qué hace?, (2) ¿qué entra y qué sale?, (3) ¿qué regla o requisito atiende?, (4) ¿por qué existe cada filtro o transformación?, (5) ¿cómo se ejecuta y se verifica? Un artefacto que no supera la lectura se corrige antes de cerrar. Los umbrales de tiempo y de aciertos se calibran en el ADR-0012.

**Prohibido frente a esperado** (ilustrativo; los nombres reales los define la spec de cada capa):

| Artefacto | Prohibido | Esperado |
|---|---|---|
| SQL | `SELECT t1.id, t1.n, SUM(t2.v) FROM t1 JOIN t2 ON t1.id=t2.id GROUP BY 1,2;` | CTEs con nombre y comentario de una línea (ver abajo) |
| DDL | Tabla sin comentario con columnas `c1` y `fch`, y el tipo elegido sin explicación | Comentario de tabla con su propósito; comentario por columna con unidad o dominio; llaves y `NOT NULL` declaradas |
| Prueba | `test_1` sin docstring, con `assert x >= 0` y el número escrito en medio de la lógica | Nombre que dice la regla; docstring con regla, motivo de negocio y consecuencia; `assert` con mensaje «se esperaban 0, se encontraron N»; umbral como constante nombrada |
| Nombres | `qty`, `tmp`, `data`, `x` | `cantidad`, `resenas_validas`, `resenas_por_producto` (identificadores en español, sin tildes) |

```sql
-- Ilustrativo. Promedio de puntaje por producto sobre reseñas con puntaje válido.
WITH resenas_con_puntaje_valido AS (
    -- Reseñas con puntaje entre 1 y 5; existe para que el promedio no se contamine (regla R07).
    SELECT
        producto_id,
        puntaje
    FROM silver.resena
    WHERE puntaje BETWEEN 1 AND 5
),
promedio_puntaje_por_producto AS (
    -- Un renglón por producto con su puntaje promedio; es la medida que consumirá el tablero.
    SELECT
        producto_id,
        AVG(puntaje) AS puntaje_promedio  -- Regla de negocio: promedio simple, sin ponderar por utilidad.
    FROM resenas_con_puntaje_valido
    GROUP BY producto_id
)
SELECT
    producto_id,
    puntaje_promedio
FROM promedio_puntaje_por_producto;
```

**Tabla XIII-C. Puntos de control del principio por fase.**

| Fase | Qué DEBE contener | Quién lo comprueba |
|---|---|---|
| `/specify` → `spec.md` | Requisitos no funcionales de legibilidad que citan `(Const. XIII.n)` y un criterio de éxito de legibilidad, ambos sin tecnología; el principio listado en «Principios transversales aplicables» (sección Supuestos) | Lista de calidad de `/specify` y `/analyze` |
| `/clarify` | Definiciones de «perfil junior», «sin ayuda» y «artefacto» aplicadas a la spec; términos nuevos en el glosario | Registro de aclaraciones de la spec |
| `/plan` → `plan.md` | Una fila XIII.1–XIII.7 en el Constitution Check; sección «Verificación de legibilidad» (regla → método → artefacto → umbral → responsable) | Compuerta del plan, antes y después del diseño |
| `/analyze` | Comprueba que: (a) todo requisito o criterio que cita XIII.n tiene fila en el plan; (b) toda fila de verificación tiene al menos una tarea; (c) existe la tarea final de revisión de legibilidad; (d) no hay deriva terminológica ni siglas fuera del glosario | Un faltante o un conflicto con un DEBE es CRITICAL y bloquea el avance |
| `task.md` (tareas) | Tareas con referencia explícita `(RF-…, Const. XIII.n)`; los comentarios, encabezados y descripciones se crean junto con el artefacto, no después; una tarea final «Revisión de legibilidad por una persona junior» | `/analyze` (cobertura) |
| Cierre de la especificación | Checklist de legibilidad firmado por quien hizo la lectura en frío (condición 5 de la compuerta) | Verificación humana (Principio XI) |

**Verificación:** (1) `plan.md` contiene la fila XIII.1–XIII.7 en el Constitution Check y la sección «Verificación de legibilidad»; (2) la consulta al catálogo de PostgreSQL devuelve 0 tablas y 0 columnas sin comentario; (3) una prueba en `tests/` confirma que todo archivo `.sql` y `.py` abre con encabezado y que todo ID citado existe; (4) el checklist de lectura en frío, firmado, está en `specs/NN-nombre/checklists/legibilidad.md`.

## Estándares tecnológicos

- **Motor:** PostgreSQL local. Es el único motor del DW.
- **Fuente:** `all_3y.txt.gz` se descarga de Google Drive a `data/raw/`. Es un recorte de `all.txt.gz` (≈ 11 GB, 34.686.770 reseñas, 1995–2013), contado hacia atrás desde la última fecha del dataset (2013-03-04, epoch `1362355200`), no desde hoy. El corte es el epoch `1267660800`. La especificación `01-ingesta-bronce` documenta cómo se generó el recorte y valida conteo y rango de fechas.
- **Formatos:** `.gz` de texto plano `clave: valor` → archivo delimitado por `|` → tablas PostgreSQL (carga con `\copy`) → `.parquet` por capa.
- **Parquet:** exportado con DuckDB desde `src/<capa>/NN_export_parquet.sql` hacia `data/parquet/{bronze,silver,gold}/` (ADR-0003).
- **Exploración:** solo SQL sobre `raw`. El archivo completo NO se carga en PostgreSQL; sus cifras son referencia de la fuente.
- **Pruebas:** Python (pytest) en `tests/`, con la conexión leída de variables de entorno.
- **Visualización:** Tableau, con acceso de lectura solo a Oro. Se versionan los `.twb`; los `.twbx` no, porque incluyen datos.
- **Nombres:** un esquema por capa; tablas y campos en `snake_case`. En Oro, prefijo por tipo de tabla (`dim_`, `fact_`, `agg_`); la capa se indica con el esquema, no con prefijo (Principio XIII.2).

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
- **Glosario:** `docs/glosario.md`, con términos de dominio, siglas y estados de capa, un solo nombre por concepto (Principio XIII.6).

## Gobernanza y cumplimiento

- **Licencia y uso:** dataset público de investigación (McAuley y Leskovec, 2013), de uso académico. El `README.md` raíz cita la fuente.
- **Retención:** Bronce no se modifica nunca y sirve de respaldo para reprocesar.
- **Residencia:** computadores del equipo, Google Drive (datos) y GitHub (código y documentación).
- **Accesibilidad:** repositorio con ramas, Pull Requests y responsables por carpeta (`.github/CODEOWNERS`).
- **Auditoría:** commits por fase, bitácora de calidad y registro de incidencias.

## Flujo de desarrollo y compuertas

- **Estructura:** lo que dice qué construir y por qué va en `memory/` y `specs/`; lo que se ejecuta va en `src/` y `tests/`; lo que gestiona el equipo va en `docs/`.
- **Ramas:** una rama por especificación (`00-preguntas-negocio`, `01-ingesta-bronce`, `02-exploracion-eda`…), integrada a `main` por Pull Request, con commits por fase.
- **Requisitos:** se redactan con la convención de las plantillas de `spec.md` y `plan.md` (adaptación del proyecto inspirada en EARS): una oración, un patrón, sujeto con nombre, `DEBE` como único modal y un ID (`RF-NN-MM`, `RNF-NN-MM`, `CE-NN-MM`). `spec.md` los escribe sin tecnología; `plan.md` los repite con el mismo ID y el artefacto concreto.
- **Constitution Check:** todo `plan.md` incluye una sección que lista cada principio aplicable y cómo el diseño lo cumple, con una fila por cada regla XIII.1–XIII.7, y una sección «Verificación de legibilidad» (Principio XIII).
- **Tareas:** el archivo de tareas de cada especificación incluye una tarea final de revisión de legibilidad por una persona junior (Principio XIII.7).
- **Decisiones:** las que afectan a todo el proyecto van en `memory/adr/`; las de una sola entrega, en `specs/NN-nombre/adr/`.
- **Compuerta de cierre de una especificación:** (1) tests en verde, (2) cuadre exacto, (3) verificación humana con SQL, (4) README de la capa actualizado, (5) checklist de legibilidad firmado tras la lectura en frío, (6) Pull Request integrado a `main`.

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
| 0012 | Herramienta y umbrales de la verificación de legibilidad: linter de SQL y de Python (toda herramienta de Python fuera de `tests/` choca con el principio V) y tiempo y aciertos de la lectura en frío | `01-ingesta-bronce` |

## Gobernanza de la constitución

- Es un documento vivo que cambia con poca frecuencia. Toda enmienda entra por Pull Request, en una rama propia, con su motivo.
- Versionado: MAJOR si se quita o redefine un principio; MINOR si se agrega un principio o una sección; PATCH si solo cambia la redacción.
- Un incumplimiento detectado al revisar una especificación, un plan o las tareas bloquea el avance. Una excepción exige un ADR que la justifique y una fecha de revisión.

### Historial de enmiendas

| Versión | Fecha | Tipo | Cambio |
|---|---|---|---|
| 1.0.0 | 2026-10-12 | — | Ratificación inicial. |
| 1.1.0 | 2026-10-14 | MINOR | Agrega el Principio XIII (legibilidad y trazabilidad para perfiles junior, transversal) con su tabla de puntos de control y la sección «Glosario»; agrega `00-preguntas-negocio` y `06-reproducibilidad-integracion` al orden del Principio XII; precisa el Principio VI (un test por regla, agrupado por dominio); agrega la convención de requisitos, la tarea de revisión y la condición 5 de la compuerta de cierre; agrega el pendiente ADR-0012. |

**Versión**: 1.1.0 | **Ratificada**: 2026-10-12 | **Última enmienda**: 2026-10-14
