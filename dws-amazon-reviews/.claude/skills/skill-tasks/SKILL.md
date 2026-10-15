---
name: skill-tasks
description: "Genera o actualiza task.md, la lista de tareas de una especificación del DWS de reseñas de Amazon, a partir de su spec.md, su plan.md y la Constitución, y deja esa lista reflejada en specs/README.md. Úsala cuando el usuario pida /tasks, tareas, task.md, desglosar el plan o «qué tareas siguen» de una spec, aunque no diga la palabra skill. Antes de hacer nada declara las rutas del contexto. Necesita el nombre de la spec (NN-nombre); si falta, lo pide y se detiene."
argument-hint: "[NN-nombre]"
user-invocable: false
---

# Skill `/tasks`: del plan a las tareas

Convierte el `plan.md` de una especificación en `task.md`: una lista de tareas pequeñas, ordenadas por dependencia, cada una con un criterio de «hecho» que otra persona pueda comprobar. La fórmula del proyecto es **SPEC (qué) + PLAN (cómo) + Constitución (principios) ⇒ task.md**.

El flujo es `/specify` → `/clarify` → `/plan` → `/analyze` → **`/tasks`** → `/implement`. Esta skill solo cubre el paso de las tareas.

Por qué existe: una tarea vaga («implementar el ETL») se descubre vaga en plena implementación, cuando rehacerla cuesta mucho más. Aquí cada tarea tiene que ser accionable, verificable y acotada en el tiempo antes de que alguien escriba código.

**Qué NO hace:** no escribe código; no modifica `spec.md`, `plan.md` ni la Constitución; no resuelve ADR pendientes; no marca ninguna tarea como hecha (la cierra quien la hace, con su evidencia). Solo escribe tres archivos: `specs/NN-nombre/task.md`, `specs/README.md` y `docs/gestion/tareas.md`.

## 0. Primero: variables y ubicación del contexto

Se invoca como `/tasks <NN-nombre>` (por ejemplo, `/tasks 00-preguntas-negocio`). El argumento es la carpeta de la especificación y es la única que se trabaja.

- **Sin argumento:** haz una sola pregunta («¿Para qué spec genero las tareas? Por ejemplo `00-preguntas-negocio`») y detente. No busques ni deduzcas la spec por un número o un tema: unas tareas de la spec equivocada parecen correctas y no lo son.

**Antes de leer ningún documento**, declara las variables y muéstralas. Este bloque es lo primero que aparece en tu respuesta, para que cualquiera sepa de dónde sale cada dato:

```text
SPECS=specs
SPEC=$SPECS/<NN-nombre>
```

| Variable | Ruta | Uso |
|---|---|---|
| `CONSTITUCION` | `memory/constitution.md` | Se lee primero. Gana sobre cualquier otro documento |
| `AGENTS` | `AGENTS.md` | Comandos y convenciones |
| `SPEC_FILE` | `$SPEC/spec.md` | Qué y por qué. Solo lectura |
| `PLAN_FILE` | `$SPEC/plan.md` | Cómo. Solo lectura. Es la fuente de las tareas |
| `TASK_FILE` | `$SPEC/task.md` | Se crea o se actualiza. El nombre lo fija el ADR-0006 |
| `PLANTILLA` | `templates/task-list-template.md` | Única fuente de la estructura |
| `README_TAREAS` | `$SPECS/README.md` | Se actualiza en cada uso (sección 6) |
| `ROLES` | `docs/gestion/roles.md` | Responsables por capa |
| `GESTION` | `docs/gestion/tareas.md` | Resumen general del proyecto |
| `ADR_GLOBAL` · `SPEC_ADR` | `memory/adr/` · `$SPEC/adr/` | Decisiones pendientes que pueden bloquear |
| `GLOSARIO` | `docs/glosario.md` | Solo si existe |

Escribe una línea por archivo: ruta · `existe` / `no existe` / `se crea` (compruébalo listando el directorio, no de memoria). Las rutas son relativas a la raíz del repositorio; si algo se mueve, se cambia solo este bloque. Después sigue.

## 1. Condiciones de entrada

1. **Nombre válido.** Cumple `^[0-9]{2}-[a-z0-9]+(-[a-z0-9]+)*$` y figura en la lista del Principio XII (léela en la Constitución, no la des por sabida).
2. **`SPEC_FILE` existe.** Si no, detente: lo produce `/specify`.
3. **`PLAN_FILE` existe.** Si no, detente y di: «Las tareas salen del plan (Principio XII) y falta `plan.md`. Corre `/plan` primero». Nunca generes tareas solo desde la spec: inventarías el cómo.
4. **Plan desactualizado.** Si `spec.md` se modificó después que `plan.md`, avisa que el plan puede no reflejar la spec y pregunta si sigues. Si sigue, deja la advertencia en el encabezado de `task.md`.
5. **ADR que bloquean.** Revisa `ADR_GLOBAL`, `SPEC_ADR` y la tabla «Decisiones pendientes» de la Constitución. En cada ADR lee los campos **Estado** y **Resolver antes de**. Si un ADR cuyo «Resolver antes de» alcanza a `/tasks` de esta spec está pendiente o decidido sin firma (al escribir esta skill: ADR-0006 y ADR-0007 para `/tasks` de la `00`), dilo **antes de crear nada** y pregunta si continúas como borrador. Si el usuario dice que sí: usa el nombre decidido (`task.md`), deja el estado en `borrador` y registra el bloqueo (columna «Bloqueos» del README y tu respuesta). Nunca firmes un ADR ni lo des por resuelto.
6. **`/analyze`.** Si el usuario no lo corrió, recomiéndalo en una frase; no bloquees.

## 2. Qué leer, en este orden

Lee cada documento completo y por su ruta. Una afirmación de cobertura exige haber visto el documento entero.

1. `CONSTITUCION`: anota la versión. Si algo la contradice, gana ella.
2. `AGENTS`.
3. `SPEC_FILE`: requisitos (`RF`, `RNF`, `CE`, `PNnn`), criterios de finalización, preguntas abiertas.
4. `PLAN_FILE`: §5 (ADR y supuestos), §7.2 (scripts y orden), §7.4 (catálogo de reglas `Rnn`), §7.5 (cuadre y linaje), §8 (componentes `C-NN-MM`), §9 (legibilidad), §10 (pruebas y verificación humana `V-NN-MM`), §11 (trazabilidad), §14 (compuerta de cierre), §15 (umbrales).
5. `PLANTILLA`. Si no existe, detente y pídela; no la reconstruyas de memoria, porque cada copia improvisada deriva de la oficial.
6. `ROLES` y `GESTION`.
7. `README_TAREAS`: su estado actual y si ya tiene bloques de tareas.
8. Si existen: un `TASK_FILE` previo, `GLOSARIO` y el `task.md` de la spec anterior (sus tareas abiertas pueden bloquear esta).

## 3. Cómo es una buena tarea

Aplica estas seis cualidades a cada fila. Son la parte que más pesa de esta skill.

| Cualidad | Regla | Se comprueba con |
|---|---|---|
| **Accionable** | Una sola operación. Empieza con un verbo en infinitivo y nombra el artefacto y su archivo («Escribir la CTE … en `src/silver/02_etl.sql`», no «Hacer el ETL»). Si une dos operaciones con «y», son dos tareas | Primera palabra = verbo; columna `Archivo` llena |
| **Verificable** | `Hecho cuando` es una condición que otra persona comprueba sin preguntar al autor: un comando que termina sin error, una cifra o un archivo con contenido definido. Prohibido: «funciona», «queda bien», «revisado», «completo» | Cada fila tiene su `Hecho cuando` con comando, cifra o archivo |
| **Con límite de tiempo** | `Min` solo puede ser 30, 45 o 60. Si pide más de 60, divídela por artefacto (un script o una regla por tarea). Si pide menos de 30, únela con la tarea contigua sobre el mismo archivo | Ninguna fila fuera de 30–60 |
| **Independiente** | Declara `Depende de` con IDs o «ninguna». Una tarea no espera trabajo que no le concierne | Ninguna dependencia hacia una tarea posterior |
| **Trazable** | `Cubre` cita los IDs tal como los escriben la spec y el plan (`RF`, `RNF`, `CE`, `Rnn`, `C-NN-MM`) y el principio (`Const. n`). Si la tarea crea una transformación, cita su `Rnn` (Principio IV): sin regla no hay tarea | Cada tarea cita al menos un requisito o regla |
| **Legible** | Encabezados y comentarios del artefacto se crean con la tarea que lo crea, no después. Cita `Const. XIII.n` cuando el artefacto sea SQL, DDL, prueba o documento | `Cubre` incluye XIII.n donde corresponde |

## 4. Cómo se arma `task.md`

1. **Parte de la plantilla completa.** Conserva columnas y títulos; borra las instrucciones entre `>`. La fase que no aplique queda como `No aplica: <motivo>`, no se borra en silencio.
2. **De dónde salen las tareas.** Del plan, no de la imaginación: cada fila de §7.2 (scripts) es una o más tareas; cada componente `C-NN-MM` de §8 tiene al menos una; cada prueba de §10.1, una tarea de prueba; cada `V-NN-MM` de §10.2, una de verificación humana; las filas de §9, la lectura en frío; las reglas de §7.4, una tarea que las construye en su script y otra con su prueba; el cuadre de §7.5, una tarea de cuadre; los pendientes de §5.1 y los cambios de §5.4, tareas de preparación o bloqueos.
3. **Organiza por fases.** Cada fase tiene objetivo, entregable y un **punto de verificación**: una lista manual de 2 a 4 casillas comprobables. En specs con código el orden es DDL → carga o ETL → pruebas → índices (solo Oro) → exportación a Parquet → README de la capa. En specs sin código (por ejemplo `00`, `02`, `05`) las tareas son documentales y de validación: nombra el artefacto real, no inventes scripts.
4. **Decide secuencia o paralelo, par por par.** Si una tarea produce lo que otra lee, es secuencial y se declara en `Depende de`. Marca `[P]` solo si la tarea no depende de ninguna tarea abierta y no comparte archivo con otra de su ola. En un equipo de dos, dos tareas `[P]` son dos personas trabajando a la vez. Dos tareas sobre el mismo script nunca son `[P]`.
5. **Responsables.** Toma los nombres de `ROLES` por capa y entregable; no inventes ninguno. La verificación humana va al responsable de la capa. La lectura en frío va a la otra persona del equipo, nunca al autor (Principio XIII.7). Si según `ROLES` esa persona resulta ser la misma que escribió el artefacto, no la asignes: deja `[POR DEFINIR: roles]` y avísalo.
6. **Fase de cierre.** Sale de la compuerta de la spec (§14 del plan) contrastada con la compuerta de la Constitución («Flujo de desarrollo y compuertas», seis condiciones). Si difieren, gana la Constitución y lo avisas. Conserva las seis filas: las que no apliquen a esta spec quedan con «No aplica: motivo» (`specs/README.md`, «Compuerta de cierre», lista las variantes por spec). El cuadre es exacto, diferencia 0 y sin tolerancia (Principio VI). La fila 5 se redacta como «Revisión de legibilidad por una persona junior distinta del autor» (así la pide la Constitución en «Flujo de desarrollo y compuertas») y su evidencia es `$SPEC/checklists/legibilidad.md` firmado (XIII.7).
7. **Seguimiento calculado, no estimado.** Cuenta tareas, hechas, `% hecho`, `% falta` y minutos por fase y en total. Porcentajes enteros que suman 100.
8. **Cobertura.** Arma la tabla requisito → tareas. Todo `RF`, `RNF` y `CE` tiene al menos una tarea; toda regla `Rnn`, una tarea de construcción y una de prueba. Un requisito sin tarea o una tarea sin requisito es un error del desglose: informa el hueco con cifras («14 de 15 requisitos con tarea»). Usa los mismos IDs `T-NN-MM` que cita la tabla de trazabilidad del plan (§11); si allí aún no figuran, tu tabla es la que se le entrega a `/plan` (esta skill no edita `plan.md`).
9. **Nada inventado.** Cifras, campos, nombres y tecnología salen de la spec, el plan o la Constitución. Lo que falte queda como `[POR DEFINIR: ADR-nnnn]` o `[PLAN: qué falta]` y lo listas en tu respuesta.
10. **Restricciones que ninguna tarea puede romper.** Nada de `UPDATE`, `DELETE` ni `TRUNCATE` sobre `raw` una vez validado; SQL puro y Python solo en `tests/`; sin Airflow, Dagster, dbt, nube ni Notion; datos y credenciales fuera del repositorio; scripts numerados y reproducibles; no reutilizar dimensiones, nombres de tablas de Oro ni requerimientos del modelo anterior.
11. **Encabezado.** Llena propósito, autor (`skill tasks`), fecha de hoy, estado `borrador` y la línea `Basada en: spec.md (fecha y estado) · plan.md (fecha y estado)`. Así las tareas declaran qué versión de la spec usaron y se nota cuándo quedaron viejas. Cita los IDs de la spec y del plan sin renumerarlos; si la spec y el plan usan formas distintas para el mismo ID, cita la del plan y avísalo.
12. **IDs de tarea.** `T-NN-MM`: NN es el número de la spec y MM un consecutivo desde 01 en todo el archivo (las fases no reinician la cuenta). No se reutilizan ni se renumeran. Es el formato del plan (§2.3); si otro documento o agente usa `T001`, avísalo y usa el del plan.

## 5. Si `task.md` ya existe

Léelo antes y no lo sobrescribas a ciegas. Es lo que hace segura la ejecución repetida.

- Conserva las filas con `[x]`, su evidencia y todos los IDs. No renumeres ni reutilices IDs; una tarea que ya no aplica se marca `retirada` con su motivo, no se borra.
- Agrega o ajusta solo las tareas pendientes según los cambios de la spec o del plan. Recalcula seguimiento y cobertura.
- Actualiza la fecha del encabezado y registra el cambio (fecha, qué y por qué) en una sección `## Historial de cambios` al final; créala si no existe.

## 6. Actualizar `specs/README.md` (en cada uso)

Cada vez que esta skill escribe o cambia un `task.md`, el README de `specs/` refleja la lista. Si te detienes antes de escribir `task.md`, no lo toques.

1. Trabaja en una sección `## Tareas por especificación`, al final del README. Si no existe, créala. **No toques nada fuera de tus bloques.**
2. Cada bloque va entre marcadores, para reemplazarlo sin tocar lo demás. Si encuentras un marcador de apertura sin su cierre, detente y avisa en lugar de adivinar.
3. Dentro de la sección hay una tabla de resumen (una fila por spec que tiene `task.md`) y, debajo, un subtítulo por spec con sus filas, en el orden de las specs (00 a 06):

```markdown
## Tareas por especificación

<!-- tareas-resumen:inicio -->
| Spec | Archivo | Tareas | Hechas | % hecho | % falta | Min estimados | Bloqueos |
|---|---|---|---|---|---|---|---|
| `NN-nombre` | [task.md](NN-nombre/task.md) | 13 | 0 | 0 % | 100 % | 540 | ninguno |
<!-- tareas-resumen:fin -->

### NN-nombre

<!-- tareas:NN-nombre:inicio -->
| ID | Estado | Tarea | Responsable | Depende de | Evidencia |
|---|---|---|---|---|---|
| T-NN-01 | [ ] [P] | … | … | ninguna | |
<!-- tareas:NN-nombre:fin -->
```

4. Las filas del bloque son las de `task.md` con las mismas palabras (ID, estado, tarea, responsable, dependencia y evidencia). `Archivo`, `Min`, `Cubre` y `Hecho cuando` se quedan en `task.md`, que el README enlaza.
5. Las cifras del resumen se **recalculan leyendo `task.md`** (casillas `[x]` y `[ ]` de las filas), nunca a partir del README anterior. Esto corrige también las diferencias que se hayan colado por marcar tareas a mano.
6. «Bloqueos» lista lo que impide avanzar (ADR sin firma, plan desactualizado, marcadores `[POR DEFINIR]`) o `ninguno`.
7. No crees una tarea para actualizar el README: es parte de esta skill.

## 7. Resumen de gestión (`docs/gestion/tareas.md`)

Actualiza la fila de la spec en la tabla «Especificaciones» (columnas `ID | Especificación | Bloqueada por | Responsable | Estado | Evidencia`) y no toques otras filas. Si no tiene fila (hoy faltan la `00` y la `06`), agrégala con el ID `S-<NN>`, siguiendo el patrón de la tabla y con «Bloqueada por» tomado de tu lista de bloqueos, y avísalo. Estado: `pendiente` hasta que alguna tarea esté en `[x]`, `en curso` después; `hecha` solo la pone la persona responsable tras su verificación humana (Principio XI), nunca esta skill. Evidencia: `specs/NN-nombre/task.md`.

## 8. Verifica antes de entregar

Recorre la «Lista de revisión» al final de la plantilla y comprueba además:

- Ninguna fila tiene `Min` fuera de 30, 45 o 60, un `Hecho cuando` vago o sin `Cubre`.
- No quedan `[corchetes]` de la plantilla ni textos de ejemplo. Las únicas casillas `[ ]` son las de estado y las de los puntos de verificación.
- Las tareas `[P]` de una misma ola no comparten archivo.
- La tabla de cobertura coincide con tu conteo de IDs en la spec y el plan.
- El bloque del README tiene las mismas filas y las mismas cifras que `task.md`.
- Las seis filas de cierre existen (con «No aplica: motivo» donde corresponde) y la lectura en frío está asignada a una persona distinta del autor.
- Ninguna tarea está marcada como hecha ni trae evidencia inventada.

Corrige lo que falle antes de responder.

## 9. Respuesta al usuario

Máximo diez líneas, sin repetir el contenido de las tareas:

- Las variables del contexto (ya mostradas al inicio) y la ruta de `task.md`.
- Tareas, fases y minutos totales; cuántas son `[P]`.
- Cobertura («n de m» requisitos) y huecos.
- Bloqueos: ADR sin firma, plan desactualizado, marcadores abiertos.
- Qué bloque de `specs/README.md` y qué fila de `docs/gestion/tareas.md` actualizaste.
- Siguiente paso: volver a correr `/analyze` en modo completo, ahora con las tareas, y después `/implement` (no aplica en specs sin código).

Di con claridad qué dejaste sin decidir.
