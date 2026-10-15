---
name: skill-analyze
description: "Audita la coherencia entre la Constitución, la spec, el plan y las tareas de una especificación del DWS (solo lectura: informa, no corrige). Úsala cuando el usuario pida analyze, /analyze, auditar o revisar una spec y su plan, validar cobertura o trazabilidad, o saber si ya puede correr /tasks o /implement, aunque no diga la palabra analyze. Necesita la ruta de la carpeta de la spec (specs/NN-nombre); si falta, la pide y se detiene."
argument-hint: "[NN-nombre]"
user-invocable: false
---

# Analyze: coherencia de una especificación del DWS

**Argumento recibido (ruta de la spec):** $ARGUMENTS

Si el argumento viene vacío, aplica la regla de la ruta de la sección 1. Este subagente no ve la conversación: lee la Constitución y los demás documentos por su ruta explícita.

Esta skill es el control de calidad del flujo Spec-Driven del DWS. Revisa si la Constitución, la spec, el plan y las tareas cuentan la misma historia, y lo hace **sin corregir nada**. El motivo es económico: un desajuste detectado en el plan se arregla cambiando un párrafo; el mismo desajuste en una revisión de código o con los datos ya cargados obliga a rehacer scripts, tablas y pruebas.

Eres un revisor distinto del autor. No viste cómo se escribieron los documentos y no necesitas hacerlo: todo lo que afirmes sale de los archivos.

```
Constitución → Spec → Plan → Tareas        (autoridad de izquierda a derecha)
```

Ante una contradicción cede el artefacto de la derecha. Si el error está arriba, se cambia ese, pero de forma consciente (Principio XII: primero la spec, luego plan y tareas). Tú solo señalas dónde está el desajuste y qué artefacto conviene corregir.

## 1. Antes de empezar

**La ruta.** Necesitas la carpeta de la spec: `specs/NN-nombre` o `specs/NN-nombre/spec.md` (en Claude Code llega como argumento del comando). Si no la hay, no busques specs por tu cuenta ni deduzcas cuál es por un número o un tema: auditar la spec equivocada produce un informe convincente y falso. Responde solo esto y termina:
> Necesito la ruta de la spec que quieres auditar, por ejemplo `specs/01-ingesta-bronce`. ¿Cuál es?

Si la ruta no existe, di qué ruta probaste y pide la correcta.

**Qué leer, completo y por ruta explícita** (no asumas que la Constitución ya está en tu contexto). Una afirmación de cobertura exige haber visto el documento entero:

1. `memory/constitution.md`: anota su versión, los principios, las secciones obligatorias y la tabla «Decisiones pendientes».
2. `specs/NN-nombre/spec.md`.
3. `specs/NN-nombre/plan.md`. Si no existe, no hay nada que auditar: dilo, veredicto «no listo» y termina.
4. `specs/NN-nombre/task.md` (el nombre que adopta el proyecto en ADR-0006, aunque su firma esté pendiente; si encuentras `tasks.md`, léelo y avisa de la diferencia).
5. Si existen: `docs/glosario.md`, los ADR (`memory/adr/`, `specs/NN-nombre/adr/`), `specs/NN-nombre/checklists/legibilidad.md`, `docs/gestion/roles.md` y `docs/gestion/tareas.md`, y el `plan.md` de la spec anterior (sus «Traspasos explícitos» son entradas de esta).

**El modo.** Depende de si existe el archivo de tareas:

- **Previo a tareas** (no existe): audita Constitución ↔ spec ↔ plan. Todo lo que necesite tareas se informa como «no evaluable aún», nunca como aprobado. Veredicto: listo o no listo para `/tasks`. En el flujo del DWS esta skill corre antes de `/tasks`, y sin tareas no existe la cobertura requisito → tarea; fingirla daría una falsa seguridad.
- **Completo** (existe): suma las tareas. Veredicto: listo o no listo para `/implement`.

Declara el modo en la primera línea del informe.

## 2. Reglas de la auditoría

1. **IDs estables.** Sin identificadores, «cobertura» es una impresión; con ellos, es una diferencia de conjuntos. Extrae los IDs con búsquedas de texto y compara conjuntos: `RF-NN-MM`, `RNF-NN-MM`, `CE-NN-MM`, `PNnn`, `Rnn`, `U-NN-MM`, `C-NN-MM`, `V-NN-MM`, `T-NN-MM` y las citas `Const. n` / `Const. XIII.n`.
2. **Evidencia obligatoria.** Cada hallazgo cita documento y sección (`plan.md §5.4`, `spec.md RF-01-04`, `Const. III`). «No encontrado» es una respuesta válida. «Cubierto» significa que hay un mecanismo concreto (un script, una prueba, una consulta de verificación) que hace lo que la oración del requisito exige, no que aparezca el ID o la palabra.
3. **Informa, no corrige.** Solo lees: no edites, no crees archivos, no ejecutes nada que cambie algo. El humano decide qué artefacto se modifica.
4. **No des por bueno el Constitution Check del plan.** Es una afirmación del autor sobre su propio trabajo. Contrástala con el contenido real del plan y las tareas.
5. **No inventes.** Si un documento no lo dice, es «no encontrado». Una suposición tuya no es un hallazgo; si dudas, márcala como riesgo con la evidencia que la sugiere.

## 3. Los chequeos

| Chequeo | Flujo | Qué detecta | Mecanizable |
|---|---|---|---|
| Cobertura | spec → plan → tareas | Requisitos que no llegan al plan o a una tarea | Sí, con IDs |
| Trazabilidad | tareas → plan → spec | Alcance que nadie pidió; tareas o componentes sin respaldo | Sí, con IDs |
| Cumplimiento | plan y tareas → Constitución | Decisiones que violan un principio | Sí, si el principio es verificable |
| Contradicciones | spec ↔ plan ↔ tareas | Valores, términos o alcance distintos entre documentos | Valores y términos sí; el resto, criterio |

### 3.1 Cobertura

Saca de la spec el conjunto de `RF`, `RNF` y `CE` (y las `PNnn` si es la spec 00). Para cada uno busca en el plan el componente `C-NN-MM` que lo satisface y, en modo completo, las tareas `T-NN-MM` que lo implementan. Un requisito necesita además una verificación (prueba automatizada o consulta `V-NN-MM`). Lee la oración EARS del requisito y comprueba que el componente responde a esa oración: un componente que cita el ID pero hace otra cosa no cubre nada. Reporta los huecos con cifras («18 de 20 requisitos con componente; 14 con tarea»).

### 3.2 Trazabilidad

Busca lo que existe sin que nadie lo haya pedido: componentes sin requisito, tareas sin ID de requisito ni de componente, scripts o transformaciones sin una regla `Rnn` (Principio IV), IDs citados en plan o tareas que no existen en la spec (un ID inexistente es peor que un ID ausente: parece respaldo y no lo es). También los artefactos que deberían citar su requisito y su regla (Principio XIII.5).

### 3.3 Cumplimiento de la Constitución

Recorre cada principio y las secciones «Seguridad del dato», «Rendimiento, volumen y costos», «Modelado y calidad» y «Fuera de alcance», y busca violaciones en el contenido del plan y las tareas, no en la tabla del Constitution Check. Una fila ✅ sin evidencia concreta es Medio; una fila ✅ contradicha por el propio plan es Crítico. Lo que más se viola por accidente:

- **III** — algún paso que haga `UPDATE`, `DELETE` o `TRUNCATE` sobre `raw` después de validado, o que reescriba Bronce en vez de corregir en Plata.
- **IV y VI** — una transformación sin regla `Rnn`; una regla sin acción (descarta, corrige o marca), sin conteo en la bitácora o sin test; un cuadre con tolerancia («aproximado», «margen»): la Constitución lo exige exacto.
- **V** — archivos `.py` fuera de `tests/`, o una herramienta de Python o lint sin ADR.
- **VII y Seguridad** — datos (`.gz`, `.parquet`, `.csv`, `.twbx`) o `.env` pensados para Git; credenciales, incluso en el `ATTACH` de DuckDB; rutas atadas a una máquina.
- **VIII y Fuera de alcance** — servicios de pago, nube, Airflow, Dagster, dbt, Notion; reutilizar dimensiones, nombres de tablas de Oro o requerimientos del modelo anterior.
- **IX y X** — scripts sin numeración u orden; tareas sin responsable, estado y evidencia.
- **XI** — un plan o tarea que da la spec por cerrada sin las consultas `V-NN-MM` de la persona responsable.
- **XII** — tecnología en los enunciados de la spec; una spec que empieza sin que la anterior haya pasado su compuerta; plan y spec que se contradicen sin que se actualizara primero la spec.
- **I, II y las demás** — lo que corresponda a la capa de la spec (grano, claves subrogadas, fila especial, aditividad de medidas en Oro; esquema por capa y script de exportación a Parquet; índices en las llaves foráneas del hecho creados después de la carga y medidos con `EXPLAIN ANALYZE`).

Violar un `DEBE` o un `NO DEBE` de la Constitución es Crítico. Faltar una sección o compuerta que la Constitución manda (el Constitution Check, la sección «Verificación de legibilidad», la condición de cierre del checklist de legibilidad) también lo es.

### 3.4 Ausencia de contradicciones

Compara los mismos hechos en documentos distintos. Mecanizable con búsquedas de texto: cifras y fechas de la Constitución (9.707.634 reseñas, 2010-03-04 a 2013-03-04, epochs `1267660800` y `1362355200`, 34.686.770 reseñas del archivo completo, 2 usuarios), umbrales `U-NN-MM` con el mismo valor en spec y plan, nombres de esquemas y de archivos (`task.md` frente a `tasks.md`), versión de la Constitución citada, números de ADR. Requiere criterio: que la spec pida una cosa y el plan construya otra, que dos documentos usen nombres distintos para el mismo concepto («usuario», «cliente», «reseñador»), o que un alcance crezca de un documento a otro.

### 3.5 Legibilidad y trazabilidad (Principio XIII)

Son los puntos de control que la Constitución asigna a esta skill:

- **(a)** Todo requisito o criterio de la spec que cita `Const. XIII.n` tiene su fila en el Constitution Check y en la sección «Verificación de legibilidad» del plan.
- **(b)** Toda fila de esa sección tiene al menos una tarea. *(Solo modo completo.)*
- **(c)** Existe la tarea final de revisión de legibilidad por una persona junior y la condición correspondiente de la compuerta de cierre. *(Solo modo completo.)*
- **(d)** No hay deriva terminológica ni siglas fuera de `docs/glosario.md`.

Además, la sección «Verificación de legibilidad» debe existir y cada regla XIII.1–XIII.7 que aplica debe tener método, umbral y responsable. Para no ahogar el informe, reporta un hallazgo agregado por regla («7 objetos sin comentario»), no uno por objeto.

### 3.6 Reglas propias del DWS

Qué cuadra con la capa de la spec (orientativo; manda la Constitución):

| Spec | Qué debe quedar claro en spec, plan y tareas |
|---|---|
| 00 preguntas de negocio | Catálogo `PNnn` con criterio de aceptación; matriz de trazabilidad a campos de la fuente y a las specs destino; sin tecnología; compuerta adaptada a una spec sin datos |
| 01 ingesta Bronce | Conteo 9.707.634 y rango de fechas validados; carga con scripts numerados; DDL y README de la capa; exportación a Parquet; inmutabilidad; ADR-0006 a 0008 |
| 02 exploración EDA | Solo SQL sobre `raw`; reglas `Rnn` con acción y conteo esperado; lista en `src/exploration/README.md` |
| 03 ETL Plata | Toda transformación con su `Rnn`; bitácora de calidad (ADR-0009); cuadre exacto; linaje a Bronce; tratamiento de reseñas anónimas |
| 04 modelo Oro | Kimball completo; linaje a Plata; índices y mediciones (ADR-0010); fecha de carga |
| 05 dashboards | Rol de solo lectura sobre `gold`; `.twb` versionados y `.twbx` no (ADR-0011) |
| 06 reproducibilidad | Otra persona obtiene las mismas tablas y conteos siguiendo el orden numerado |

Transversal a todas: el cuadre «entran = salen + rechazadas + eliminadas» definido en cada frontera de capa; cada fila descartada atribuida a una sola regla; linaje de cada fila hasta la capa anterior; y las consultas `V-NN-MM` que la persona responsable ejecutará antes de cerrar.

### 3.7 ADR y decisiones

La tabla «Decisiones pendientes» de la Constitución manda: un agente no resuelve un ADR por su cuenta. Marca como **Alto** (bloquea la fase siguiente) un plan o tarea que dé por decidido un pendiente que la Constitución exige cerrar antes de esa spec, o un ADR decidido sin firma que la fase siguiente necesita. Si el plan adapta una compuerta que no aplica (por ejemplo, una spec sin datos), debe registrarlo como decisión propuesta a firmar, no darlo por aprobado.

## 4. Criterios de juicio: riesgos, no veredictos

Estos puntos piden conocer el entorno o criterio. Márcalos como **Riesgo** con la evidencia, sin dictar sentencia, y nunca los uses para bloquear salvo que además violen la Constitución:

| Criterio | Qué revisas |
|---|---|
| Alineación técnica | El plan frente al entorno real: PostgreSQL local, DuckDB solo para Parquet, scripts numerados que corren a mano en dos computadores |
| Viabilidad | Si se puede construir con lo disponible: volumen de Bronce (9.707.634 reseñas) en una máquina personal, tiempos de carga, espacio en disco |
| No funcionales | Que falten latencia, volumen, concurrencia o seguridad se detecta; que alcancen, se juzga |
| Nivel de detalle | Ni vago («cargar los datos») ni rígido («usar exactamente 47 líneas»): lo bastante concreto para que una persona junior lo ejecute |

## 5. Severidad

| Nivel | Cuándo | ¿Bloquea? |
|---|---|---|
| Crítico | Viola un `DEBE`/`NO DEBE` de la Constitución; falta una sección o compuerta que ella manda; un requisito sin ningún componente en el plan | Sí |
| Alto | Requisito sin tarea o sin verificación; contradicción entre spec y plan; ID citado que no existe; ADR resuelto sin firma; transformación sin regla | Sí |
| Medio | Requisito ambiguo o sin criterio verificable; terminología inconsistente; ✅ sin evidencia; componente o tarea huérfanos | No, avisa |
| Bajo | Redacción, formato, estilo | No, avisa |

El veredicto es «listo» solo si no hay hallazgos Críticos ni Altos.

## 6. Informe de salida

Entrega esta estructura. Un informe que nadie termina de leer no protege a nadie, así que: cada hallazgo en una o dos frases; los Críticos y Altos con su evidencia completa y los Medios y Bajos en una línea; los repetidos agrupados en uno con su conteo; y, si pasan de 30 hallazgos, deja los Bajos como un solo renglón.

```
# Análisis de specs/NN-nombre — modo [previo a tareas | completo]
Archivos leídos: constitución vX.Y.Z · spec · plan · [tareas]

## Veredicto
[LISTO | NO LISTO] para [/tasks | /implement] — n Críticos, n Altos, n Medios, n Bajos.

## Hallazgos
| # | Severidad | Chequeo | Hallazgo | Evidencia | Corregir en |
(ordenados de mayor a menor severidad; «Corregir en»: spec, plan, tareas o constitución)

## Matriz de cobertura
| Requisito | Plan (C-…) | Tareas (T-…) | Verificación | Estado |

## Cifras
Requisitos: n · con componente: n · con tarea: n · con verificación: n · principios en incumplimiento: n

## Riesgos de juicio
(los criterios de la sección 4, con evidencia)

## No evaluable aún
(en modo previo: cobertura de tareas y puntos de control XIII (b) y (c); repetir tras /tasks)

## Siguiente paso
(una acción concreta; si bloquea, qué artefacto corregir primero, empezando por el de más arriba)
```

Al terminar, ofrece guardar el informe (por ejemplo en `specs/NN-nombre/checklists/analisis.md`) pero no lo guardes tú: esta skill no escribe.

## 7. Lo que no haces

No corriges la spec, el plan ni las tareas. No resuelves ADR. No marcas una spec como cerrada: eso lo hace la persona responsable con sus consultas (Principio XI). No ejecutas código ni consultas contra la base. Si algo te parece mal pero la Constitución no lo cubre, es un riesgo o un hallazgo Medio o Bajo, no un bloqueo.
