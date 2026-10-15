---
name: skill-implement
description: "Ejecuta, una por una y en orden de dependencias, las tareas pendientes del task.md de una especificación del DWS de reseñas de Amazon (SQL en src/, pruebas en tests/, README de la capa), verificando cada una con su «Hecho cuando» y dejando evidencia y bitácora. Úsala cuando el usuario pida /implement, implementar, ejecutar o avanzar las tareas de una spec, «sigue con la siguiente tarea», retomar la implementación o atacar una tarea o fase concreta (T-NN-MM), aunque no diga la palabra skill. Necesita el nombre de la spec (NN-nombre); si falta, lo pide y se detiene. Nunca cierra la especificación."
argument-hint: "[NN-nombre] [T-NN-MM | fase N | contexto]"
user-invocable: false
---

# Skill `/implement`: de las tareas al código

Convierte las tareas de `specs/NN-nombre/task.md` en artefactos que funcionan: scripts SQL en `src/`, pruebas en `tests/` y el `README.md` de la capa. Trabaja **una tarea a la vez**, en el orden que fijan sus dependencias, y no da una tarea por hecha hasta que su «Hecho cuando» se cumple de verdad.

El flujo es `/spec` → `/clarify` → `/plan` → `/analyze` → `/tasks` → **`/implement`**. Esta skill solo cubre la implementación. La cadena de autoridad es **Constitución → spec → plan → tareas → código**: el código obedece a la tarea, y si la tarea choca con algo de más arriba, gana lo de arriba.

Por qué existe: la implementación es donde un detalle sin decidir se convierte en una decisión silenciosa dentro de un script. Aquí cada ambigüedad se detiene y se devuelve al artefacto que debe resolverla, y cada tarea cerrada deja una evidencia que otra persona puede comprobar.

**Qué NO hace:** no cambia `spec.md`, `plan.md` ni la Constitución; no crea, borra ni renumera tareas; no resuelve ADR pendientes; no ejecuta tareas humanas (firmar, verificar con SQL, leer en frío, integrar el Pull Request); no cierra la especificación (Principio XI).

## 0. Variables y ubicación del contexto

Se invoca como `/implement <NN-nombre> [selector]`. El selector es opcional: una tarea (`T-03-07`), una fase (`fase 2`) o una instrucción («solo pruebas»).

- **Sin nombre de spec:** pregunta «¿Qué especificación implemento? Por ejemplo `01-ingesta-bronce`» y detente. No la deduzcas de la rama ni de un número: implementar la spec equivocada produce código que parece correcto.

Antes de leer nada, muestra este bloque y una línea por ruta con `existe` / `no existe` (compruébalo listando el directorio):

```text
SPECS=specs
SPEC=$SPECS/<NN-nombre>
```

| Variable | Ruta | Uso |
|---|---|---|
| `CONSTITUCION` | `memory/constitution.md` | Se lee primero (lo exige su preámbulo a todo agente). Gana sobre todo |
| `ADR_INDEX` | `memory/adr/README.md` | Estado y «Resolver antes de» de cada ADR del proyecto |
| `AGENTS` | `AGENTS.md` | Comandos de ejecución, pruebas y orden de scripts |
| `SPEC_FILE` | `$SPEC/spec.md` | Qué y por qué. Solo lectura |
| `PLAN_FILE` | `$SPEC/plan.md` | Cómo. Solo lectura. Fuente de nombres, reglas `Rnn`, umbrales y consultas `V-NN-MM` |
| `TASK_FILE` | `$SPEC/task.md` | Las tareas. Se actualiza estado, evidencia y bitácora |
| `README_TAREAS` | `$SPECS/README.md` | Solo los bloques `<!-- tareas… -->` de esta spec |
| `GESTION` | `docs/gestion/tareas.md` | Solo la fila de esta spec |
| `ROLES` | `docs/gestion/roles.md` | Quién hace las tareas humanas |
| `LAYER_README` | `templates/layer-readme.md` | Plantilla del README de cada capa |
| `ADR_GLOBAL` · `SPEC_ADR` | `memory/adr/` · `$SPEC/adr/` | Decisiones que pueden bloquear |
| `GLOSARIO` | `docs/glosario.md` | Solo si existe |

## 1. Condiciones de entrada

Comprueba todo antes de escribir una línea de código. Si una falla, dilo y detente salvo que se indique otra cosa.

1. **Nombre válido.** Cumple `^[0-9]{2}-[a-z0-9]+(-[a-z0-9]+)*$` y está en la lista del Principio XII.
2. **`SPEC_FILE`, `PLAN_FILE` y `TASK_FILE` existen.** Si falta `task.md`: «Corre `/tasks <NN-nombre>` primero». El código sale de las tareas, nunca directamente del plan.
3. **Rama.** `git branch --show-current` devuelve `NN-nombre`. Si no, detente y propone `git checkout NN-nombre`; no cambies de rama sin permiso.
4. **Spec anterior cerrada.** Según `GESTION` y `README_TAREAS`, la spec anterior pasó su compuerta (Principio XII). Si no, avísalo y pregunta si sigues.
5. **Tareas al día.** Si `plan.md` o `spec.md` se modificaron después que `task.md`, las tareas pueden estar viejas: avísalo y recomienda `/tasks` y `/analyze` antes de seguir.
6. **Spec sin código.** En `00`, `02` y `05` no hay ETL que construir (ver «Compuerta de cierre» en `README_TAREAS`). Solo ejecutas las tareas documentales o de prueba que produzcan un archivo concreto; las demás son humanas (sección 4).
7. **Entorno.** Las tareas que ejecutan SQL necesitan PostgreSQL y las variables de `.env` (ver `AGENTS`). Si el entorno no responde, puedes escribir el código, pero la tarea queda sin cerrar (sección 5).
8. **ADR que bloquean.** Cruza la tabla «Decisiones pendientes» de la Constitución con `ADR_INDEX` y `SPEC_ADR`. Todo ADR cuyo «Resolver antes de» alcanza a esta spec y siga «Pendiente» o «Decidido · falta firma» se anuncia antes de empezar, y las tareas que dependen de él quedan bloqueadas. Ejemplos al escribir esta skill: para `01-ingesta-bronce`, ADR-0008 (conversión a delimitado) y ADR-0012 (linter y lectura en frío) siguen pendientes, y ADR-0003 (Parquet con DuckDB) falta firma. Si la Constitución y `ADR_INDEX` no coinciden (hoy ADR-0012 no figura en el índice), gana la Constitución y lo avisas. Nunca firmas ni das por resuelto un ADR.

Cita solo los principios que define la Constitución vigente (I a XIII en la v1.1.0). Si otro documento cita un principio que no existe, avísalo y no lo repitas.

## 2. Qué leer, en este orden

Lee cada documento completo y por su ruta. Una implementación que solo leyó parte del plan inventa el resto.

1. `CONSTITUCION`: versión, principios, «Decisiones pendientes», «Flujo de desarrollo y compuertas» y «Fuera de alcance».
1b. `ADR_INDEX` y `SPEC_ADR`: estado y firma de cada ADR.
2. `AGENTS`: comandos, orden de ejecución por capa y convenciones.
3. `TASK_FILE`: tareas, dependencias, «Hecho cuando», puntos de verificación y la sección `## Bitácora de implementación` si existe (es tu memoria entre sesiones).
4. `PLAN_FILE`: §7.2 (scripts y orden), §7.4 (reglas `Rnn`), §7.5 (cuadre y linaje), §8 (componentes `C-NN-MM`), §9 (legibilidad), §10 (pruebas y `V-NN-MM`), §15 (umbrales con nombre).
5. `SPEC_FILE`: los requisitos que cita la tarea que vas a ejecutar.
6. El código que ya existe en `src/<capa>/` y `tests/`, y el `README.md` de la capa.
7. `ROLES`, `GLOSARIO` y los ADR que la tarea cita.

## 3. Elegir la siguiente tarea: divide y vencerás

Las tareas forman un grafo de dependencias. Recórrelo así:

1. **Disponibles:** tareas `[ ]` cuyas dependencias están todas en `[x]` (o `—` si no aplican).
2. **Selector del usuario.** Si nombró una tarea o fase, esa manda, pero solo si está disponible. Si depende de algo abierto, dilo y ofrece primero la dependencia; nunca la ejecutes saltándote el orden.
3. **Sin selector:** la primera disponible según el orden del archivo. Respeta las olas y el orden por capa de `AGENTS` (DDL → carga o ETL → pruebas → índices, solo Oro → exportación a Parquet → README de la capa).
4. **Tareas `[P]`.** Sigues haciendo una a la vez; `[P]` solo indica que dos personas podrían repartírselas.
5. **Cambio de prioridades.** Si el usuario cambia el orden a mitad de camino, termina o deja en un estado limpio la tarea actual, registra el cambio en la bitácora y sigue con la nueva prioridad dentro de lo que permiten las dependencias.
6. **Tarea demasiado grande.** Si ves que una tarea no cabe en 60 minutos o mezcla dos operaciones, no la partas tú: hazla si es posible, y registra en la bitácora que `/tasks` debe dividirla.

Antes de empezar, anuncia en una línea: tarea, archivo, qué cubre y su «Hecho cuando».

## 4. Tareas que no ejecutas

Algunas tareas son de una persona por diseño. Para ellas preparas el material, no el resultado:

| Tarea | Qué haces tú |
|---|---|
| Firmar un ADR o una decisión `D-NN-xx` | Nada. La reportas como bloqueo si otras dependen de ella |
| Verificación humana `V-NN-MM` (Principio XI) | Entregas en tu respuesta las consultas SQL listas para que el responsable las ejecute. Si el plan nombra un archivo para ellas, las escribes ahí |
| Lectura en frío y checklist de legibilidad (XIII.7) | Nada. Debe hacerla una persona distinta del autor |
| Integrar el Pull Request | Nada. Puedes dejar preparado el resumen del Pull Request |

Nunca marques `[x]` una tarea humana.

## 5. Ejecutar una tarea

1. **Escribe el artefacto.** Un solo archivo o bloque, el que nombra la tarea. Encabezado (propósito, autor `skill implement`, fecha, dependencias, IDs `RF`/`RNF`/`Rnn` que atiende) y comentarios se escriben junto con el código, no después (XIII.4, XIII.5).
2. **Cumple las reglas de cada tipo:**
   - **SQL** (XIII.1): CTEs con nombre y comentario de una línea; sin subconsultas anidadas en `FROM` ni `JOIN`; columnas explícitas, sin `SELECT *`; una cláusula por línea y palabras clave en mayúsculas; cada columna calculada comenta su regla `Rnn`.
   - **DDL** (XIII.2): comentario en cada tabla y columna; llaves, `NOT NULL` y `UNIQUE` explícitos; `snake_case` en español; en Oro prefijos `dim_`, `fact_`, `agg_`.
   - **Pruebas** (XIII.3): docstring con regla, motivo de negocio y consecuencia; nombre descriptivo; `assert` con mensaje «se esperaba X, se encontró Y»; umbrales como constantes con nombre; un archivo por dominio.
   - **Scripts** (IX): numerados `NN_nombre.sql`, re-ejecutables sin duplicar datos, conexión por variables de entorno, sin rutas absolutas.
   - **Glosario** (XIII.6): todo término de dominio, sigla o estado de capa nuevo se agrega a `docs/glosario.md` en la misma tarea, con un solo nombre por concepto. Ningún artefacto usa una sigla sin definir.
3. **Punto de compilación.** Ejecuta lo que pide el «Hecho cuando»: el `psql -f`, el `pytest` o la consulta indicada. Corre los scripts de carga dos veces seguidas cuando la tarea pida repetibilidad. Reporta la salida real, con cifras.
4. **Si falla**, corrige y vuelve a ejecutar. Tras tres intentos sin éxito, detente: deja el código en un estado claro, registra el error en la bitácora y pregunta.
5. **Cierra la tarea** solo si el «Hecho cuando» se cumplió con la salida que acabas de ver:
   - En `task.md`: cambia `[ ]` por `[x]` y llena «Evidencia» con el archivo y, si ya existe, el commit.
   - Si escribiste el código pero no pudiste ejecutarlo (sin base de datos, sin datos), la tarea **sigue `[ ]`**. Registra en la bitácora «escrita, sin verificar» y qué comando falta correr.
6. **Contexto para la siguiente tarea.** Añade una entrada a la bitácora (sección 7) antes de pasar a otra.

## 6. Ambigüedad y bloqueos: detenerse, no inventar

Una decisión tomada en silencio dentro del código no la revisa nadie. Cuando aparezca una, detente y clasifícala:

| Encuentras | Pertenece a | Haces |
|---|---|---|
| Un requisito ambiguo, contradictorio o sin criterio | `spec.md` | Detente. Recomienda `/clarify NN-nombre` |
| Un nombre de tabla, un umbral, un campo o una regla que el plan no fija | `plan.md` | Detente. Recomienda `/plan NN-nombre` |
| Una tarea vaga, sin «Hecho cuando» comprobable o con dependencias erróneas | `task.md` | Detente. Recomienda `/tasks NN-nombre` |
| Un ADR pendiente o sin firma que la tarea necesita | `memory/adr/` | Tarea bloqueada. No lo resuelves |
| Una dependencia abierta, una entrada que falta, el entorno caído | — | Tarea bloqueada |
| Algo que contradice la Constitución | Constitución | Detente siempre. Nada se implementa contra ella |

Una tarea bloqueada sigue `[ ]`: registra el bloqueo en la bitácora y en la columna «Bloqueos» del resumen de `README_TAREAS`, y pasa a la siguiente tarea disponible que no dependa de ella. Si no queda ninguna disponible, detente y explica qué destraba el avance.

No uses marcadores nuevos en la columna de estado: `/tasks` y `README_TAREAS` solo cuentan `[ ]` y `[x]`.

## 7. Bitácora de implementación (memoria entre tareas)

Al final de `task.md` mantén una sección `## Bitácora de implementación`. Créala si no existe, debajo de todo lo demás. Es solo de añadir: nunca borres entradas.

Ejemplo ilustrativo (las fechas y los IDs son de muestra):

```markdown
## Bitácora de implementación

| Fecha | Tarea | Resultado | Detalle | Siguiente |
|---|---|---|---|---|
| 2026-10-20 | T-01-04 | hecha | `psql -f src/bronze/02_load.sql` cargó 9.707.634 filas en dos corridas | T-01-05 |
| 2026-10-20 | T-01-05 | bloqueada | ADR-0008 sin firma: falta la herramienta de conversión | firmar ADR-0008 |
```

`Resultado` es uno de: `hecha`, `escrita, sin verificar`, `bloqueada`, `ambigüedad`, `cambio de prioridad`, `falló`. Así una sesión nueva sabe en qué quedó la anterior sin depender de la conversación.

## 8. Puntos de verificación de fase y commits

Cuando todas las tareas de una fase están `[x]`:

1. Recorre el «Punto de verificación» de la fase en `task.md` y comprueba cada casilla con un comando o una cifra. Marca solo las que comprobaste.
2. Corre `pytest tests/` si ya hay pruebas, y reporta el resultado real.
3. Si la fase creó tablas, comprueba la verificación del Principio XIII: la consulta al catálogo de PostgreSQL devuelve 0 tablas y 0 columnas sin comentario, y todo archivo `.sql` y `.py` nuevo abre con encabezado y cita IDs que existen.
4. Propón un commit por fase (Constitución, «Ramas»): mensaje en español con la spec, la fase y los IDs de tarea. Antes de proponerlo, revisa con `git status` que no entren datos (`.gz`, `.parquet`, `.csv`, `.twbx`) ni `.env` (Principio VII).

## 9. Actualizar la gestión

Cada vez que una tarea cambia de estado:

- **`README_TAREAS`:** en el bloque `<!-- tareas:NN-nombre:inicio -->`, copia el estado y la evidencia de la fila; en `<!-- tareas-resumen:… -->`, recalcula las cifras de la spec **leyendo `task.md`** y actualiza «Bloqueos». No toques nada fuera de los marcadores. Si falta un marcador de cierre, avisa en lugar de adivinar.
- **`GESTION`:** solo la fila de la spec. Estado `en curso` desde la primera `[x]`. Nunca `hecha`: eso lo pone el responsable tras su verificación (Principio XI).

## 10. Restricciones que ningún código puede romper

- Bronce no se modifica después de validado: ningún `UPDATE`, `DELETE` ni `TRUNCATE` sobre `raw` (III).
- Toda transformación nace de una regla `Rnn` con acción y conteo en la bitácora de calidad (IV). Sin regla, no hay código.
- SQL puro sobre PostgreSQL; DuckDB solo para exportar a Parquet; Python solo en `tests/` (V).
- Cuadre exacto: entran = salen + rechazadas + eliminadas, diferencia 0 (VI).
- Datos y credenciales fuera de Git, incluido el `ATTACH` de DuckDB (VII y «Seguridad del dato»).
- Sin servicios de pago, nube, Airflow, Dagster, dbt ni Notion (VIII, «Fuera de alcance»).
- Sin reutilizar dimensiones, nombres de tablas de Oro ni requerimientos del modelo anterior.
- Linaje: de cada fila de Oro se llega a su fila de Plata y de Bronce («Modelado y calidad»).
- Bitácora de calidad: la carga la llena con una fila por regla (regla, descripción, filas, acción, fecha). Dónde vive lo decide ADR-0009.
- Oro (I y «Rendimiento»): grano en una frase, claves subrogadas, fila especial para faltantes y medidas clasificadas; índice B-tree en cada llave foránea del hecho, creado después de la carga en `src/gold/03_indexes.sql`, con `EXPLAIN ANALYZE` antes y después en el README de `gold`; fecha de carga en Oro («Auditoría»).
- Acceso: Tableau usa un rol de solo lectura con permisos únicamente sobre `gold` («Seguridad del dato»).
- Datos personales: solo `userId` y `profileName`; las reseñas anónimas se tratan con una regla del EDA explícita y no se cruzan con otras fuentes.
- Lint o formato: no hay herramienta fijada; no añadas ninguna sin ADR (ADR-0012).

## 11. Respuesta al usuario

Máximo doce líneas, sin pegar el código entero:

- Tareas ejecutadas en esta corrida, con su resultado y su evidencia.
- Salida real de los puntos de compilación (`psql`, `pytest`) con cifras.
- Tareas bloqueadas y ambigüedades, con el comando que las destraba (`/clarify`, `/plan`, `/tasks` o la firma de un ADR).
- Avance de la spec: «n de m tareas hechas».
- Para las tareas humanas listas: las consultas `V-NN-MM` que debe correr el responsable y el estado de las seis condiciones de la compuerta de cierre de la Constitución: (1) tests en verde, (2) cuadre exacto, (3) verificación humana con SQL, (4) README de la capa actualizado, (5) checklist de legibilidad firmado tras la lectura en frío, (6) Pull Request integrado a `main`. Para las variantes de (1) y (2) por spec usa `README_TAREAS`; si allí la compuerta tiene cinco puntos, gana la Constitución y lo avisas.
- Siguiente paso: la próxima tarea disponible, o `/check NN-nombre` si solo quedan tareas humanas.

Di con claridad qué no verificaste.
