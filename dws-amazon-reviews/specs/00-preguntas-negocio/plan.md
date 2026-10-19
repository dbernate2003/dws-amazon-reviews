# Plan técnico — 00-preguntas-negocio

**Rama**: `00-preguntas-negocio-cierre` | **Fecha**: 2026-10-19 | **Spec**: `specs/00-preguntas-negocio/spec.md` | **Constitución**: v1.1.0
**Basada en**: `spec.md` última actualización 2026-10-19, que es también la fecha del último cambio de PN, requisitos o spec §6–§7 (DQ-32 acota RF-00-10 y DQ-33 acota la verificación de RF-00-06; estado «Revisada» por el responsable el 2026-10-19, ADR-0006, ADR-0007 y D-00-01 firmados; aclaraciones DQ-01 a DQ-36; DQ-34 cambia CE-00-04 y quién lee en frío, DQ-35 fija los cortes de PN07 y DQ-36 la ventana de datos)
**Estado**: en cierre (41 de 42; falta el merge del PR #2) | **Responsable**: Dario Andres Bernate Canas | **Segundo validador**: Dario Andres Bernate Canas (spec DQ-10; `docs/gestion/roles.md`)
**Generado por**: skill `/plan` (`skill-plan`, agente `architect`)

---

## 1. Resumen (siempre)

La especificación 00 fija y valida las doce preguntas de negocio (PN01 a PN12) que el DWS de reseñas de Amazon debe poder responder, y deja tres insumos: el nivel de detalle mínimo (insumo del grano de `04-modelo-oro`), las medidas y cortes (spec §6) y la asignación de preguntas a tableros (spec §7, insumo de `05-dashboards-bi`).

No toca ninguna capa ni esquema: no carga datos, no crea tablas, no ejecuta SQL y no tiene pruebas de Python (spec DQ-31: se rechazó D-00-03).

El plan define cómo se **comprueba** el catálogo de preguntas contra los requisitos de la spec y cómo se **traza** cada pregunta hacia los campos de la fuente (spec §3) y hacia las especificaciones que la atienden. Para eso produce documentos: una matriz de trazabilidad (`matriz-trazabilidad.md`), una lista de validación firmada (`checklists/validacion.md`), la investigación de viabilidad (`research.md`), una guía para repetir la revisión (`quickstart.md`), el checklist de lectura en frío (`checklists/legibilidad.md`) y el glosario único del proyecto (`docs/glosario.md`). La validación de cada pregunta queda en la tabla de la spec §11.

Fuera de este plan: diseñar hechos, dimensiones o claves (spec 04); definir reglas del EDA, umbrales con datos, la definición de «palabra», los rangos de longitud o el corte del grupo más activo (spec 02); tocar `raw`; escribir cualquier script o prueba.

**Requisitos que cubre este plan** (IDs tal como existen en la spec, sin renumerar): RF-00-01 a RF-00-11, RNF-00-01 a RNF-00-04, CE-00-01 a CE-00-05 (20 requisitos). Preguntas de negocio: PN01 a PN12. Decisiones de la spec que el plan respeta: DQ-01 a DQ-36 (spec §12; el número DQ-09 no existe en la spec y no se reutiliza).

---

## 2. Convención de requisitos (siempre)

> Adaptación del proyecto inspirada en EARS (*Easy Approach to Requirements Syntax*, Mavin et al., 2009).
> EARS no tiene versión oficial en español: las palabras clave en español son una adaptación de este proyecto.
> EARS **no** es Gherkin: EARS escribe la obligación en una oración; los escenarios Dado/Cuando/Entonces solo se
> usan para ejemplos con datos concretos y citan el ID del requisito que verifican.

### 2.1 Palabras clave (siempre en MAYÚSCULAS)

| Patrón | Palabra clave | Plantilla | Se usa para |
|---|---|---|---|
| Ubicuo (siempre activo) | (ninguna) | `El <sujeto> DEBE <respuesta>.` | Invariantes: grano, claves, nombres, linaje |
| Dirigido por evento | `CUANDO` | `CUANDO <evento>, el <sujeto> DEBE <respuesta>.` | Un hecho puntual: termina una carga, se aplica una regla, se cierra una capa |
| Dirigido por estado | `MIENTRAS` | `MIENTRAS <estado>, el <sujeto> DEBE <respuesta>.` | Algo que vale todo el tiempo que dure un estado de capa |
| Opcional | `DONDE` | `DONDE <característica incluida>, el <sujeto> DEBE <respuesta>.` | Una variante que puede existir o no |
| Comportamiento no deseado | `SI … ENTONCES` | `SI <situación no deseada>, ENTONCES el <sujeto> DEBE <respuesta>.` | Dato inválido, descuadre, linaje roto, fallo |
| Complejo | combinación | `[DONDE …,] [MIENTRAS …,] [CUANDO … \| SI …, ENTONCES] el <sujeto> DEBE <respuesta>.` | Estado más evento, o estado más situación no deseada |

### 2.2 Reglas de redacción

1. **Un patrón y una respuesta por requisito.** Si dos respuestas se comprueban con pruebas distintas, son dos requisitos.
2. **Sujeto con nombre, nunca «el sistema».** En `spec.md`: «el DWS», «la capa Bronce», «el ETL de Plata», «la bitácora de calidad». En `plan.md`: el artefacto concreto (un documento, un rol, una prueba).
3. **`DEBE` es el único modal** (`DEBEN` si el sujeto es plural). `NO DEBE` solo para prohibiciones heredadas de la constitución o bloqueos de estado. No se usa «debería» ni «puede»: lo no obligatorio va en Supuestos.
4. **Modo verbal:** `CUANDO` y `MIENTRAS` con subjuntivo; `SI` con indicativo.
5. **Máximo dos palabras clave por requisito** (`DONDE` no cuenta).
6. **Todo número es un umbral con nombre (`U-NN-MM`) o `[POR DEFINIR: ADR-nnnn]`.** Prohibidos los adjetivos vagos.
7. **Los cuantificadores universales («cada», «toda») llevan población cerrada** y criterio de cero excepciones o 100 %.
8. **`spec.md` dice qué y por qué**, sin productos, lenguajes, objetos físicos ni rutas.
9. **`plan.md` dice cómo.** Reutiliza el ID del requisito de la spec y agrega componentes `C-NN-MM`.
10. **Todo `CUANDO` que describe un flujo tiene su `SI … ENTONCES` de error.**

### 2.3 IDs

| Tipo | Formato de la constitución | Cómo aparece en esta spec | Nota |
|---|---|---|---|
| Requisito funcional | `RF-NN-MM` | `RF-00-01` … `RF-00-11` | RF-00-09, RF-00-10 y RF-00-11 nacen de partir RF-00-03, RF-00-06 y RF-00-08 (spec DQ-30) |
| Requisito no funcional | `RNF-NN-MM` | `RNF-00-01` … `RNF-00-04` | Coincide (DQ-21) |
| Criterio de éxito | `CE-NN-MM` | `CE-00-01` … `CE-00-05` | CE-00-01 incluye RF-00-09 desde DQ-30 |
| Pregunta de negocio | `PNnn` | `PN01` … `PN12` | Coincide |
| Decisión de la spec | — | `DQ-01` … `DQ-36` (sin DQ-09) | Propio de la spec (spec §12) |
| Regla de calidad del EDA | `Rnn` | — | No nacen en esta spec |
| Umbral | `U-NN-MM` | `U-00-01` … `U-00-18` | §15.2 |
| Componente del plan | `C-NN-MM` | `C-00-01` … `C-00-30` | §8 |
| Verificación humana | `V-NN-MM` | `V-00-01` … `V-00-10` | §10.2 |
| Tarea | `T-NN-MM` | `T-00-01` … `T-00-56` | `task.md` regenerado el 2026-10-19; T-00-55 es la segunda parte de la lectura en frío y T-00-56 la regeneración por DQ-32 |
| Supuesto del plan | `S-NN-nn` | `S-00-01` … `S-00-05` | §5.3 |
| Decisión propuesta del plan | `D-NN-xx` | `D-00-01` … `D-00-08` | §5.2 |

Los IDs no se reutilizan; un componente retirado se marca «retirado» y no se renumera.

### 2.4 Formato de línea

```text
RF-NN-MM  · <enunciado EARS> · Origen: <Const. n | PNnn | Rnn> · Verificación: <prueba automatizada | consulta de verificación humana | inspección>
C-NN-MM   · <enunciado EARS con sujeto concreto> · Satisface: RF-NN-MM · Verificación: <…>
```

---

## 3. Contexto técnico (siempre)

| Campo | Valor |
|---|---|
| Capas y esquemas | Ninguna. Esta especificación no crea esquemas ni tablas |
| Entradas | `spec.md` (2026-10-19): catálogo PN01–PN12 (§5), campos de la fuente (§3), insumo del modelo (§6), tableros (§7), requisitos (§9), criterios (§10), validación (§11), decisiones (§12); Constitución v1.1.0; D-00-01 firmada (`specs/00-preguntas-negocio/adr/D-00-01-compuerta-de-cierre-sin-datos.md`); `templates/plan-template.md`; `docs/gestion/roles.md` |
| Salidas | `research.md`, `matriz-trazabilidad.md`, `quickstart.md`, `checklists/validacion.md`, `checklists/legibilidad.md`, `checklists/analisis.md` (informe de `/analyze`, T-00-10), `docs/glosario.md` (nuevo), tabla de la spec §11 completa y firmada por las personas, `task.md` (lo genera `/tasks`) |
| Motor | No se usa en esta especificación |
| Lenguajes | Markdown. Sin Python: no hay validador del catálogo (spec DQ-31, D-00-03 rechazada) |
| Herramientas | Editor de texto y Git. Sin herramientas nuevas |
| Volumen esperado | 12 preguntas de negocio (U-00-01), 3 tableros, 10 campos de la fuente. Referencia de la fuente: 9.707.634 reseñas entre 2010-03-04 y 2013-03-04 (Constitución, Principio III) |
| Rendimiento | No aplica: no hay consultas |
| Frescura | Dataset cerrado; último dato 2013-03-04 |
| Concurrencia | 2 usuarios, cada uno con su copia local |
| Restricciones | Costo $0; los documentos contienen nombres de campos, nunca datos; sin credenciales |
| Ejecución | Manual, en el orden de los pasos de la sección 7.2. `/implement` no aplica en la 00 (`specs/README.md`): las personas producen los documentos siguiendo `task.md` |

**Campos de la fuente**: se usan los diez nombres de la spec §3 (`productId`, `title`, `price`, `userId`, `profileName`, `helpfulness`, `score`, `time`, `summary`, `text`). La spec 01 confirma contra los datos su nombre exacto en el archivo y cómo aparecen las reseñas anónimas (spec DQ-12). Por DQ-13, `title` y `price` no entran en el análisis; `title` solo se muestra como etiqueta legible del producto en T2.

**Orden de las especificaciones**: la spec 01 queda en pausa hasta que la 00 pase su compuerta de cierre (Principio XII).

---

## 4. Constitution Check (siempre; compuerta)

Estados: ✅ cumple · ⚠️ cumple con riesgo (explicado) · ❌ incumple · — no aplica (explicado).

| Principio | Qué exige (resumen) | ¿Aplica? | Cómo lo cumple el diseño | Evidencia o verificación | Estado |
|---|---|---|---|---|---|
| I. Kimball | Grano, claves subrogadas, fila especial, medidas clasificadas | No directamente | La spec solo entrega insumos (§6.1 nivel de detalle mínimo = una reseña; §6.4 advertencias de aditividad). El plan los traspasa a la spec 04 sin diseñar el modelo y sin reutilizar nada del modelo anterior | Tabla «Traspasos explícitos» (§7.4–7.9); firma del responsable de la 00 (C-00-21, DQ-34) | — |
| II. Medallion | Un esquema por capa; Parquet; README con DDL | No | No existen capas en esta spec | — | — |
| III. Bronce inmutable | Sin `UPDATE`/`DELETE`/`TRUNCATE` sobre `raw` | No | No se toca ningún dato | — | — |
| IV. Transformación con regla | Toda transformación nace de una regla `Rnn` | No | No hay ETL. Las decisiones que exigen regla (anónimas DQ-04 y DQ-15, cero votos totales, meses parciales, palabra de PN08) se traspasan a la spec 02 | Tabla «Traspasos explícitos» | — |
| V. SQL puro | Python solo en `tests/` | Sí | Solo Markdown. No hay ningún archivo Python: D-00-03 se rechazó (spec DQ-31) | Ningún `.py` nuevo; C-00-10 retirado | ✅ |
| VI. Test por regla y cuadre | Un test por `Rnn`; cuadre exacto | No | No hay reglas ni filas. La condición de cuadre de la compuerta no aplica (D-00-01, firmada) | D-00-01 | — |
| VII. Datos sin versionar | Ningún dato en Git | Sí | Los documentos contienen nombres de campos y definiciones, no datos | Ningún `.gz`, `.parquet`, `.csv`, `.twbx` ni `.env` en Git | ✅ |
| VIII. Costo $0 | Nada de pago ni de nube | Sí | Solo documentos, editor y Git | §3, fila «Herramientas» | ✅ |
| IX. Orquestación manual | Pasos numerados y reproducibles | Sí | Pasos 01–09 de §7.2; `quickstart.md` (T-00-22) permite que otra persona repita la revisión | §7.2; `quickstart.md` (9 de 9 pasos, 2026-10-19) | ✅ |
| X. Gestión en el repositorio | Tareas con responsable, estado y evidencia | Sí | ADR-0006 (`task.md`) y ADR-0007 firmados el 2026-10-19. `task.md` se regenera desde este plan el 2026-10-19 y la fila S-00 entra en `docs/gestion/tareas.md` | `memory/adr/README.md`; `task.md` | ✅ |
| XI. Verificación humana | La persona responsable verifica con sus consultas | Sí, adaptado | No hay tablas para consultar con SQL. Se sustituye por las verificaciones `V-00-01` a `V-00-10` sobre los documentos y por la firma de la spec §11, según D-00-01 (firmada el 2026-10-19) | D-00-01; §10.2 | ✅ |
| XII. Spec primero y en orden | Spec antes que plan; orden 00 → 06 | Sí | El plan usa la spec con última actualización 2026-10-19 (DQ-01 a DQ-36): primero cambió la spec (DQ-32 acota RF-00-10; DQ-34 a DQ-36 cierran firmas, cortes y ventana) y después se regeneran plan y tareas (T-00-56). Los cambios 4, 6, 9, 11 y 12 de §5.4 ya están en la spec y `specs/README.md` cita D-00-01 (cambio 5); los cambios 5 y 11, confirmados por el responsable el 2026-10-19 (T-00-41, T-00-44). La spec 01 sigue en borrador pausado hasta cerrar la 00 | §5.4; `spec.md` (encabezado, §9 y §12); `specs/README.md` («Compuerta de cierre»); «Basada en» de este plan | ✅ |
| XIII. Legibilidad y trazabilidad | Siete reglas XIII.1–XIII.7 | Sí | Ver filas siguientes y §9; XIII.4 a XIII.6 tienen evidencia (documentos y glosario) y XIII.7 se cerró con la lectura en frío firmada (T-00-38 y T-00-55) | §9 | ✅ |
| ↳ XIII.1 SQL | CTEs, sin `SELECT *`, comentarios | No | Esta spec no tiene SQL | — | — |
| ↳ XIII.2 DDL | Comentarios de tabla y columna; llaves explícitas | No | Esta spec no tiene DDL | — | — |
| ↳ XIII.3 Pruebas | Docstring, nombres, mensajes, constantes | No | Esta spec no tiene pruebas de Python (spec DQ-31) | — | — |
| ↳ XIII.4 General | Nombres completos, porqué, español, encabezado | Sí | Todo documento nuevo abre con encabezado (propósito, autor, fecha, dependencias) y usa nombres completos (C-00-08, C-00-23) | `research.md`, `quickstart.md`, `matriz-trazabilidad.md`, `checklists/validacion.md` y `docs/glosario.md` (encabezados del 2026-10-19); `V-00-10` los comprueba | ✅ |
| ↳ XIII.5 Trazabilidad | Todo artefacto cita IDs `RF-NN-MM`/`RNF-NN-MM` que existen | Sí | La spec usa `RF-00-MM`, `RNF-00-MM` y `CE-00-MM`; el plan, `task.md` y los documentos nuevos citan esos mismos IDs, incluidos RF-00-09 a RF-00-11 | C-00-08, C-00-28; documentos del 2026-10-19; `V-00-02`, `V-00-04` y `V-00-10` (IDs citados en este plan y en `task.md` existen) | ✅ |
| ↳ XIII.6 Glosario | Términos y siglas definidos, un nombre por concepto | Sí | `docs/glosario.md` creado con los 39 términos de §15.1 más las siglas y los términos de `spec.md` y `plan.md` (49 entradas en total); la spec fija «usuario» como término único (DQ-20) | C-00-07; `docs/glosario.md` (2026-10-19); `V-00-10` | ✅ |
| ↳ XIII.7 Lectura en frío | Persona junior distinta del autor responde cinco preguntas | Sí | Un agente sin historial ni acceso al resto del repositorio (anexo 2 de D-00-01, spec DQ-34) leyó en frío las 12 PN, la matriz y el glosario (§9) y registró las respuestas; 2 de 2 bloques con 5 de 5 (10 de 10), sin tropiezos que impidieran responder (C-00-11, C-00-24). U-00-08 = 5 de 5, fijado para la 00 en el anexo de D-00-01 y extendido a todas las especificaciones por el ADR-0012; U-00-09 = 45 minutos por bloque (ADR-0012 firmado el 2026-10-19). Evidencia: `checklists/legibilidad.md` firmado por el responsable el 2026-10-19 | C-00-11, C-00-24; U-00-08 (anexo de D-00-01), U-00-09 (ADR-0012) | ✅ |

**Resultado de la compuerta antes de la Fase 0**: pasa con advertencias en IX y XIII (XIII.4, XIII.5, XIII.6 y XIII.7). Ninguna fila en ❌. X y XI están en ✅ por la firma de ADR-0006, ADR-0007 y D-00-01; XII, por la confirmación de los cambios 5 y 11 y por el orden spec → plan de DQ-32. Ninguna advertencia bloquea `/analyze` ni `/tasks`.
**Resultado de la compuerta después de la Fase 1**: pasa con las mismas advertencias. El diseño (§7 y §8) cubre los 20 requisitos de la spec, no introduce código ni herramientas, no toca capas y deja cada advertencia con su salida: `quickstart.md` (T-00-22), C-00-07 (glosario) y la evidencia que producen las tareas y la lectura en frío.
**Resultado histórico tras producir los documentos (2026-10-19; superado por los párrafos siguientes)**: IX, XIII.4, XIII.5 y XIII.6 pasan a ✅ con su evidencia (`quickstart.md` y `docs/glosario.md`, T-00-22 y T-00-12); XIII.7 sigue en ⚠️ hasta la lectura en frío (T-00-38 y T-00-55). Ninguna fila queda en ❌, y la compuerta de cierre sigue abierta por las condiciones 1, 3, 4, 5 y 6 (firmas humanas, verificación final y Pull Request).

**Resultado histórico tras los documentos del cierre (2026-10-19; superado por el párrafo siguiente)**: la spec §11 queda firmada por el responsable (7 PN D en «Validada», DQ-10), `checklists/legibilidad.md` está creado (falta la lectura en frío de T-00-38 y T-00-55) y el ADR-0012 queda propuesto (U-00-09 = 45 minutos por bloque). La compuerta de cierre sigue abierta por las condiciones 1 (falta la firma de Oro), 3, 4 y 5; la condición 6 se cumplió fuera de orden con el Pull Request #1 (`567ad89`). Ninguna fila queda en ❌.

**Resultado tras la firma del ADR-0012 y la lectura en frío (2026-10-19)**: el ADR-0012 queda firmado (opción A; U-00-09 = 45 minutos por bloque), CE-00-04 queda firmada por el responsable de la 00 (DQ-34), `checklists/legibilidad.md` queda lleno y firmado (2 de 2 bloques, 5 de 5 cada uno) y la compuerta cierra las condiciones 1, 3, 4 y 5; la condición 6 queda a la espera de integrar el PR de cierre #2. XIII.7 pasa a ✅.

---

## 5. Decisiones, ADR y supuestos (siempre)

### 5.1 Pendientes de la constitución que afectan a esta especificación

| ADR | Pendiente | ¿Bloquea esta spec? | Cómo la trata este plan |
|---|---|---|---|
| 0006 | Nombre del archivo de tareas | No: firmado el 2026-10-19 | `task.md` |
| 0007 | Ubicación de `memory/` y cómo la leen los agentes | No: firmado el 2026-10-19 | `memory/` en la raíz más `instructions` en `opencode.json` |
| 0008 | Herramienta de `clave: valor` a archivo delimitado | No | Es de la spec 01 |
| 0009 | Dónde vive la bitácora de calidad | No | Es de la spec 03. La matriz solo anota qué PN dependerán de reglas con conteo en bitácora (anónimas, cero votos) |
| 0010 | Umbral de latencia | No | Es de la spec 04 |
| 0011 | Cómo llega Oro a Tableau Public | No | Es de la spec 05 |
| 0012 | Herramienta y umbrales de legibilidad | No para esta spec | Firmado el 2026-10-19 (opción A): 5 de 5 aciertos y 45 minutos por bloque; fija U-00-09. U-00-08 sigue como anexo de D-00-01 |
| 0013 | Ponytail como modo de trabajo de los agentes | No: firmado el 2026-10-19 | No cambia el diseño; no autoriza a omitir nada del Principio XIII |

### 5.2 Decisiones nuevas que propone este plan

| ID | Decisión propuesta | Alternativas descartadas | Motivo | Estado |
|---|---|---|---|---|
| D-00-01 | Compuerta de cierre de la spec 00: condición 1 sustituida por CE-00-01 a CE-00-04 cumplidos y spec §11 firmada, sin `pytest`; condición 2 «no aplica»; condición 3 cumplida con `V-00-01` a `V-00-10`; condición 4 con el glosario y los documentos de la spec al día; condiciones 5 y 6 sin cambio | Enmendar la constitución; exigir SQL sin tablas; saltarse la compuerta | La constitución v1.1.0 no contiene variantes de compuerta | **Firmada** el 2026-10-19: `specs/00-preguntas-negocio/adr/D-00-01-compuerta-de-cierre-sin-datos.md`. Anexo firmado: U-00-08 = 5 de 5 para la 00; el ADR-0012 extiende el 5 de 5 a todas las especificaciones. Fecha de revisión: al hacer el `/plan` de `02-exploracion-eda` o de `05-dashboards-bi`, lo que ocurra primero |
| D-00-02 | `/analyze` corre **dos veces**: una antes de `/tasks` (coherencia constitución ↔ spec ↔ plan) y otra después, en modo completo, para los puntos (b) toda verificación tiene tarea y (c) existe la tarea final de legibilidad de la tabla XIII-C. Si una pasada da un hallazgo crítico o alto, se repite una vez corregido (decisión del responsable del 2026-10-19; tercera pasada de la `00`) | Una sola pasada antes de `/tasks` con (b) y (c) a mano (aceptada y revertida el mismo día); una sola pasada después | (b) y (c) necesitan `task.md`; el responsable comprobó que la segunda pasada hace falta | **Aceptada** por el responsable el 2026-10-19 (dos pasadas) |
| D-00-03 | Validador del catálogo en `tests/` | — | — | **Rechazada** el 2026-10-19 (spec DQ-31): basta la verificación humana `V-00-01`; C-00-10 retirado |
| D-00-04 | El glosario vive en `docs/glosario.md` y se siembra en esta spec | Glosario por spec; glosario en el README raíz | XIII.6 pide un glosario único y la spec 00 es la primera que define términos | **Aceptada** por el responsable el 2026-10-19 |
| D-00-05 | La trazabilidad PN → campos → tablero → especificaciones destino vive en `matriz-trazabilidad.md`. La matriz no copia las medidas ni los cortes de la spec §6.2 (la spec manda); solo los cita por ID | Usar `data-model.md`; copiar §6.2 dentro de la matriz | Esta spec no tiene modelo de datos; copiar §6.2 crearía dos fuentes de verdad | **Aceptada** por el responsable el 2026-10-19 |
| D-00-06 | La evidencia de CE-00-01 a CE-00-04 (revisión por lista, conteo por tablero, estado de las PN D y firma del responsable de la 00 sobre §6.1 y §6.2, DQ-34) vive en `checklists/validacion.md` | Firmar dentro de `spec.md`; usar el Pull Request como evidencia | La spec no dice dónde queda la firma de CE-00-04; dónde se guarda una evidencia es parte del cómo | **Aceptada** por el responsable el 2026-10-19 |
| D-00-07 | Formato de los IDs de la spec `RF-00-MM`, `RNF-00-MM` y `CE-00-MM`, con `DEBE` como único modal | Mantener `RF-01` con un ADR de excepción | La constitución («Flujo de desarrollo», XIII.5) fija `RF-NN-MM` | **Decidida** el 2026-10-15 (spec DQ-21) y aplicada |
| D-00-08 | En `task.md`, citan `Const. XIII.n` solo las tareas que crean o editan un documento (XIII.4 encabezado y nombres, XIII.5 IDs citados); las que solo ejecutan una verificación V-00-MM no la citan | Todas las tareas citan XIII.n; ninguna | La cita sirve a quien escribe el documento; en una tarea de comprobar no aporta (hallazgo 7 de `/analyze` T-00-10) | **Aceptada** por el responsable el 2026-10-19 |

### 5.3 Supuestos

- **S-00-01**: la spec 00 no carga datos, no ejecuta SQL y no tiene pruebas de Python. Verificado contra la spec §2, §12 (DQ-31) y §13 (2026-10-19).
- **S-00-02**: los diez campos de la spec §3 son la única fuente de datos de las preguntas. Se confirma en la spec 01 (spec DQ-12).
- **S-00-03**: las preguntas se redactan en español y sin tecnología. Verificado contra la spec §5 y §9 (2026-10-19): ningún enunciado de requisito nombra productos, lenguajes, objetos físicos ni rutas.
- **S-00-04**: Jose Julio Gomez Palmera no firma ni verifica las especificaciones `00` a `03` (spec DQ-34); la lectura en frío de la `00` la hace un agente en contexto limpio y el responsable firma su resultado (anexo 2 de D-00-01).
- **S-00-05**: el trabajo de la 00 se integra a `main` por la rama `00-preguntas-negocio-cierre` (PR #2); `specs/01-ingesta-bronce/` queda fuera del commit de cierre (ver §12).

### 5.4 Cambios que este plan exige a `spec.md`

Principio XII: estos cambios se aplican primero en la spec y después se regeneran plan y tareas (RF-00-10). Este plan no los aplica.

| # | Cambio en la spec | Motivo | Estado |
|---|---|---|---|
| — | Agregar requisitos no funcionales de legibilidad, un criterio de éxito de legibilidad y la línea «Principios transversales aplicables: Const. XIII» | Tabla XIII-C de la constitución | **Hecho** el 2026-10-15 (spec DQ-16) |
| — | Revisar que ningún enunciado de requisito nombre productos, lenguajes, objetos físicos ni rutas | Principio XII | **Hecho**: revisado de nuevo el 2026-10-19, cero menciones (S-00-03) |
| 1 | Formato de IDs `RF-NN-MM`, `RNF-NN-MM` y `CE-NN-MM` | Constitución, «Flujo de desarrollo» y XIII.5 | **Hecho** el 2026-10-15 (DQ-21; D-00-07) |
| 2 | Modal `DEBE` en lugar de «deberá» | §2.2 regla 3 | **Hecho** el 2026-10-15 (DQ-21) |
| 3 | Sujeto con nombre en RF-00-08 en lugar de «el sistema» | §2.2 regla 2 | **Hecho** el 2026-10-15 (DQ-21) |
| 4 | Partir RF-00-03, RF-00-06 y RF-00-08, que tenían dos respuestas | §2.2 regla 1 | **Hecho** el 2026-10-19 (spec DQ-30): nacen RF-00-09, RF-00-10 y RF-00-11; CE-00-01 incluye RF-00-09 |
| 5 | Origen de la variante de compuerta de la 00 | Constitución, «Compuerta de cierre»; XIII.7 | **Hecho**: D-00-01 firmada el 2026-10-19 y `specs/README.md` (sección «Compuerta de cierre», seis condiciones) la cita como origen de la variante de la 00; confirmado por el responsable el 2026-10-19 (T-00-44) |
| 6 | RNF-00-03 sin lugar verificable para el nivel de detalle | RNF-00-03 sin criterio verificable completo | **Hecho**: la verificación de RNF-00-03 remite ahora a §6.1 (nivel de detalle) y §6.2 (medida y cortes) |
| 7 | CE-00-04 no decía dónde quedaba la firma del insumo | CE-00-04 sin evidencia definida | **Resuelto** el 2026-10-19: firma el responsable de la 00 (DQ-34) en `checklists/validacion.md`; Oro acepta en el `/clarify` de la 04. D-00-06 sigue siendo el lugar de la evidencia |
| 8 | Extender RF-00-08 a PN02 (DQ-15) | Decisión sin requisito | **Hecho** el 2026-10-15 (DQ-21) |
| 9 | Escribir «Prioridad» en lugar de «Prio.» | XIII.4 (nombres completos) | **Hecho**: la spec §5 usa «Prioridad» |
| 10 | Un solo nombre para quien escribe la reseña | XIII.6 | **Hecho** el 2026-10-15: «usuario» (DQ-20); el glosario debe registrarlo (C-00-07) |
| 11 | La línea «Estado» del encabezado de la spec dice «falta la firma de los ADR» y las filas DQ-06, DQ-07 y DQ-08 de §12 dicen «falta firma», pero ADR-0006 y ADR-0007 se firmaron el 2026-10-19 | XIII.5 (lo citado debe ser verdad); RF-00-07 legible | **Hecho** el 2026-10-19: la línea «Estado» cita las firmas y DQ-06, DQ-07 y DQ-08 figuran «Resuelta» con fecha de firma; confirmado por el responsable el 2026-10-19 (T-00-41) |
| 12 | RF-00-10 obligaba a regenerar plan y tareas ante cualquier cambio de la spec, incluidas las aprobaciones de §11 que hacen T-00-23 y T-00-25, y V-00-07 fallaría por diseño | Hallazgo 1 (alto) de `checklists/analisis.md` (T-00-10) | **Hecho** el 2026-10-19 (spec DQ-32): RF-00-10 se acota a cambios de PN, requisitos o spec §6–§7 |

---

## 6. Fase 0 — Investigación (`research.md`)

| Pregunta | Opciones evaluadas | Decisión | Justificación | Fuente |
|---|---|---|---|---|
| ¿Qué se necesita de la fuente para responder cada PN? | Revisar la documentación del dataset; revisar una muestra del archivo | Documentación del dataset y la columna «Disponible con los campos» de la spec §11; la muestra real se difiere a las specs 01 y 02 | Esta spec no carga datos (S-00-01); RF-00-02 | Spec §3 y §11; SNAP (McAuley y Leskovec, 2013) |
| ¿Qué hacer con una PN que la fuente no puede responder? | Eliminarla; reformularla; mantenerla marcada | Mantenerla marcada «no viable con esta fuente» y registrar la decisión de la persona responsable en la spec §12 antes del cierre | Eliminarla pierde trazabilidad; RF-00-06 obliga a cambiar primero la spec | C-00-04, C-00-25 |
| ¿Alguna PN identifica a una persona? | Revisión por pregunta | Revisar las doce (RF-00-03); PN09, PN10 y PN11 solo de forma agregada (RF-00-09) | Constitución, «Seguridad del dato»; spec DQ-30 | C-00-12, C-00-13, C-00-29 |
| ¿Cómo se tratan las reseñas anónimas al contar usuarios? | Incluirlas; excluirlas; tratarlas aparte | Decidido en la spec: se excluyen en PN02, PN09 y PN10 (RF-00-08) y el resultado informa cuántas se excluyeron (RF-00-11); la regla con acción y conteo nace en la spec 02 | DQ-04, DQ-15, DQ-30 | Spec §12 |
| ¿Cómo se tratan marzo de 2010 y marzo de 2013? | Incluirlos tal cual; excluirlos; marcarlos | Decidido en la spec: se muestran marcados «mes parcial» en PN01, PN02, PN03, PN04, PN07 y PN11 (DQ-03, DQ-19, RF-00-05) | Evita leer como caída un mes incompleto | Spec §12 |
| ¿Entran el título y el precio? | Analizarlos; excluirlos | Decidido en la spec: fuera del análisis; el título solo como etiqueta en T2 (DQ-13) | Ninguna PN los necesita | Spec §12 |
| ¿Con qué zona horaria se convierten las fechas? | UTC; hora local | Decidido en la spec: UTC siempre (DQ-14) | Regla única y reproducible | Spec §12 |
| ¿Qué es «calificación baja» en PN06? | Promedio ≤ 2,5; otro corte | Decidido en la spec: promedio ≤ 2,5 (DQ-18, U-00-10) | Debajo del punto medio de la escala 1–5 | Spec §12 |
| ¿Sobre qué total se mide el «% con al menos un voto útil» de PN07? | Sobre reseñas con votos; sobre todas | Decidido en la spec: reseñas con votos útiles ≥ 1 ÷ todas las reseñas del corte, incluidas las de cero votos totales (DQ-22, U-00-16) | Lectura literal; no depende de la regla de cero votos de la 02 | Spec §6.2, §6.4 |
| ¿Hace falta un mínimo de votos totales para leer la razón de utilidad? | Siempre; nunca; solo por producto | Decidido en la spec: PN08 usa suma ÷ suma por calificación y rango de longitud, sin mínimo (DQ-27); el mínimo solo aplica a una lectura futura por producto y su valor lo fija la 02 (DQ-23, U-00-17) | Suma ÷ suma ya evita que un 1 de 1 pese como 100 % | Spec §6.4 |
| ¿En qué unidad se mide la longitud de PN08? | Caracteres; palabras | Decidido en la spec: palabras; qué cuenta como palabra y los rangos los fija la 02 (DQ-24, U-00-18) | Es la lectura que entiende un analista | Spec §6.2 |
| ¿Cuántos productos muestra PN05 y cómo se desempata? | Top 10; Top 20; por umbral | Decidido en la spec: Top 10; empate por mayor calificación promedio y después por `productId` en orden alfabético (DQ-25, DQ-29, U-00-14) | T2 muestra siempre 10 filas con criterio reproducible | Spec §6.2 |
| ¿Dónde aplica el umbral de volumen de DQ-11? | PN05 y PN06; solo PN06 | Decidido en la spec: solo PN06 (DQ-28, U-00-11) | El Top 10 de PN05 ya elige los de mayor volumen | Spec §12 |
| ¿Cómo se clasifica a un usuario en PN10? | Por año; en la ventana completa | Decidido en la spec: ventana completa; «una sola vez» = exactamente 1 reseña; «recurrente» = 2 o más (DQ-26, U-00-15) | La fidelidad se ve en el tiempo largo | Spec §6.2 |
| ¿Se crea un validador automático del catálogo? | Sí, en `tests/`; no | Decidido en la spec: no (DQ-31; D-00-03 rechazada) | 12 preguntas que cambian poco; `V-00-01` las revisa en minutos | Spec §12 |
| ¿Registrar aprobaciones, firmas o fechas en la spec §11 obliga a regenerar plan y tareas? | Sí, ante todo cambio de la spec; solo ante cambios de PN, requisitos o spec §6–§7 | Decidido en la spec: solo esos cambios (DQ-32, RF-00-10) | Una firma no cambia lo que se construye; sin el acote, V-00-07 fallaría tras T-00-23 y T-00-25 | Spec §9 y §12 |
| ¿Qué falta y se difiere? | — | Umbral de volumen de PN06 (DQ-11), corte del grupo más activo de PN09 (DQ-17), lista de campos y significado de «anónima» (DQ-12), regla de cero votos totales (spec §6.4), mínimo de votos totales por producto (DQ-23), definición de palabra y rangos de longitud de PN08 (DQ-24) | Necesitan datos reales | Spec §12 y §13 |

---

## 7. Fase 1 — Diseño

### 7.1 Estructura de documentación y código (siempre)

```text
specs/00-preguntas-negocio/
├── spec.md                    # qué y porqué: catálogo PN01–PN12 (ya existe; se ajusta según §5.4)
├── plan.md                    # este archivo
├── research.md                # Fase 0: viabilidad e identificación de personas por PN
├── matriz-trazabilidad.md     # Fase 1: PN → campos → tablero → marcas → especificaciones destino
├── quickstart.md              # Fase 1: pasos para que otra persona repita la revisión
├── checklists/
│   ├── validacion.md          # evidencia de CE-00-01 a CE-00-04 y firma del insumo de Oro (D-00-06, DQ-34)
│   ├── legibilidad.md         # lectura en frío firmada (RNF-00-01, CE-00-05, Const. XIII.7)
│   └── analisis.md            # informe de /analyze en modo completo (T-00-10, D-00-02)
├── adr/
│   └── D-00-01-compuerta-de-cierre-sin-datos.md   # firmada el 2026-10-19
└── task.md                    # lo genera /tasks (ADR-0006)

docs/
└── glosario.md                # nuevo: primeras entradas (RNF-00-02, Const. XIII.6)
```

**Decisión de estructura**: no se crean `src/<capa>/`, `tests/`, `contracts/` ni `data-model.md` porque no hay scripts, pruebas, capas ni tablas (D-00-05, DQ-31). Fuera de la carpeta de la spec, solo se tocó `specs/README.md` para citar D-00-01 (§5.4, cambio 5, aplicado el 2026-10-19).

### 7.2 Flujo de trabajo (pasos manuales numerados)

| Orden | Paso | Qué hace (una frase) | Entradas | Salidas | Requisito | Repetible |
|---|---|---|---|---|---|---|
| — | `/clarify` (hecho 2026-10-14, 2026-10-15 y 2026-10-19) | Cerró DQ-01 a DQ-32 salvo las diferidas (DQ-11, DQ-12, DQ-17, DQ-23 y los rangos de DQ-24) | `spec.md` | `spec.md` del 2026-10-19 | RNF-00-01 a RNF-00-04, CE-00-05, RF-00-09 a RF-00-11 | Sí |
| 01 | Aplicar §5.4 en la spec | Cambio 11 en la spec y cambio 5 en `specs/README.md`, aplicados y confirmados por el responsable el 2026-10-19; cambio 12 (DQ-32) aplicado en la spec el 2026-10-19 | `spec.md`, este plan | `spec.md` ajustada; después se regeneran plan y tareas | RF-00-06, RF-00-10 | Sí |
| 02 | Firmas previas | ADR-0006, ADR-0007 y D-00-01 firmados; D-00-02, D-00-04, D-00-05 y D-00-06 aceptadas y D-00-03 rechazada (2026-10-19) | §5.2 | §5.2 con estado | Const. X | Sí |
| 03 | `/plan`, `/tasks` y segunda `/analyze` | Regenera `plan.md` y `task.md` (2026-10-19, de nuevo tras DQ-32) y corre la segunda pasada de `/analyze` en modo completo, con los puntos (a) a (d) de la tabla XIII-C (D-00-02); el primer informe dio NO LISTO y se repite | `spec.md`, `plan.md`, `task.md` | `checklists/analisis.md` | Todos | Sí |
| 04 | Producir documentos | Las personas producen glosario, `research.md`, matriz, `quickstart.md` y `checklists/validacion.md` siguiendo `task.md` (`/implement` no aplica en la 00) | `task.md` | Documentos | RF-00-01 a RF-00-11, RNF-00-02 a RNF-00-04 | Sí |
| 05 | Validación de las PN | El responsable y el segundo validador aprueban cada PN en la spec §11 | Spec §3, §5, §11, matriz | Spec §11 con nombre, fecha y estado | RF-00-07, CE-00-03 | Sí |
| 06 | Firma del insumo de Oro | El responsable de la 00 firma la spec §6.1 y §6.2; Oro la acepta en la 04 (DQ-34) | Spec §6 | `checklists/validacion.md` firmado | CE-00-04 | Sí |
| 07 | Verificación humana | La persona responsable ejecuta `V-00-01` a `V-00-09` (`V-00-10` va en el paso 09) | Documentos | Resultados en la evidencia de las tareas | Compuerta (condición 3) | Sí |
| 08 | Lectura en frío | El agente en contexto limpio lee la muestra y responde las cinco preguntas; el responsable revisa y firma (DQ-34) | Muestra de §9 | `checklists/legibilidad.md` | RNF-00-01, CE-00-05 | Sí |
| 09 | Cierre | La persona responsable ejecuta `V-00-10` sobre los documentos ya leídos en frío, recorre la compuerta (§14) e integra el Pull Request | Todo lo anterior | Pull Request a `main` | Compuerta | Sí |

**Reproducibilidad**: partiendo de `spec.md` y de `quickstart.md`, otra persona obtiene la misma matriz (12 filas) con las mismas marcas de viabilidad, tablero, respuesta agregada, corte por mes y conteo de usuarios.
**Estado de la especificación**: abierta → plan aprobado → tareas generadas → documentos producidos → cerrada. «Cerrada» se observa en el Pull Request integrado a `main`; la spec 01 no sigue hasta entonces (Principio XII).

### 7.3 Modelo de información de los documentos

No hay tablas de base de datos. Si la spec y un documento difieren, gana la spec.

**`matriz-trazabilidad.md`** — una fila por PN (U-00-01):

| Columna | Qué representa | Obligatoria | Origen |
|---|---|---|---|
| `id_pregunta` | ID de la pregunta (`PN01` … `PN12`), igual al de la spec | Sí | Spec §5 |
| `enunciado_resumido` | La pregunta en una frase, sin tecnología | Sí | Spec §5 |
| `prioridad` | D (debe), S (debería) o P (podría) | Sí | Spec §5 |
| `campos_fuente` | Campos de la spec §3 que necesita | Sí | Spec §11 («Disponible con los campos») |
| `viabilidad` | `viable`, `viable con reserva` o `no viable con esta fuente` | Sí | `research.md` |
| `motivo_viabilidad` | Por qué; obligatorio si no es `viable` | Condicional | `research.md` |
| `solo_agregada` | `sí` si la pregunta trata de usuarios y se responde solo de forma agregada | Sí | RF-00-09 |
| `tablero` | T1, T2 o T3 | Sí | Spec §7 |
| `corte_por_mes` | `sí` si se muestra por mes; entonces lleva la marca «mes parcial» en 2010-03 y 2013-03 | Sí | RF-00-05, DQ-19 |
| `cuenta_usuarios` | `sí` si cuenta usuarios distintos; entonces excluye las reseñas anónimas (RF-00-08) e informa cuántas se excluyeron (RF-00-11) | Sí | RF-00-08, RF-00-11, DQ-04, DQ-15 |
| `calculo_en_spec` | Referencia a la fila de la spec §6.2 (no se copia el cálculo, D-00-05) | Sí | Spec §6.2 |
| `decisiones_diferidas` | DQ abiertas que la afectan (DQ-11 en PN06; DQ-12 en las que cuentan o comparan anónimas; DQ-17 en PN09; DQ-23 y DQ-24 en PN08) | Condicional | Spec §12 |
| `especificaciones_destino` | Specs que la atienden: 01, 02, 03, 04, 05 | Sí | Spec §13 |
| `criterio_de_aceptacion` | Cómo se sabrá que la pregunta quedó respondida en el tablero | Sí | Spec §7 y §10 |

**`checklists/validacion.md`** — evidencia de CE-00-01 a CE-00-04 (D-00-06):

| Parte | Contenido | Requisito |
|---|---|---|
| Revisión por pregunta | Una fila por PN con sí/no para: ID, decisión y prioridad (RF-00-01); campos disponibles (RF-00-02); no identifica personas (RF-00-03); tablero asignado (RF-00-04); estado en la spec §11 (RF-00-07); respuesta solo agregada si trata de usuarios (RF-00-09) | CE-00-01 |
| Conteo por tablero | Número de PN en T1, T2 y T3 frente a U-00-02 y U-00-03 | CE-00-02 |
| Preguntas D | Las siete PN de prioridad D (PN01, PN02, PN03, PN04, PN05, PN07, PN11) con su estado en la spec §11 | CE-00-03 |
| Revisión de §6.1 y §6.2 | Cada fila nombra medida, cortes y nivel de detalle con nombres completos | RNF-00-03 |
| Firma del insumo de Oro | Nombre y fecha del responsable de la 00 sobre la spec §6.1 y §6.2 | CE-00-04 |

Reglas: las columnas salen solo de la spec; no se copian dimensiones, nombres de tablas de Oro ni requerimientos del modelo anterior.

### 7.4 a 7.9

| Sección de la plantilla | Estado |
|---|---|
| 7.4 Catálogo de reglas del EDA | No aplica: esta spec no crea ni aplica reglas. Los traspasos a la spec 02 están abajo |
| 7.5 Cuadre de filas y linaje | No aplica: no hay filas. Se deja el **linaje de requisitos**: cada PN apunta a las especificaciones que la atenderán (columna `especificaciones_destino`) |
| 7.6 Bitácora de calidad | No aplica: la define la spec 03 (ADR-0009) |
| 7.7 Seguridad del dato | Los documentos no contienen datos ni credenciales; `userId` y `profileName` aparecen solo como nombres de campos. PN09, PN10 y PN11 se responden solo de forma agregada (RF-00-09, spec §8). El dataset no se cruza con otras fuentes |
| 7.8 Rendimiento y volumen | No aplica |
| 7.9 Exportación a Parquet | No aplica |

**Traspasos explícitos hacia otras especificaciones** (alineados con la spec §13, «Qué heredan las siguientes especificaciones»):

| Traspaso | Destino | Qué debe confirmar o decidir |
|---|---|---|
| Los diez campos de la spec §3, su nombre exacto en el archivo y que el título llega | Spec 01 | Confirmar contra los datos (DQ-12, DQ-13) |
| Ventana cerrada 2010-03-04 a 2013-03-04, ambos extremos incluidos (DQ-36) | Spec 01 | Confirmar que el 2013-03-04 completo entra en la carga y que el conteo 9.707.634 cuadra antes de cerrar Bronce |
| DDL documentado y flujo de los scripts SQL de Bronce | Spec 01 | Lo pide la spec §13 |
| Cómo aparece una reseña anónima (campo ausente o valor repetido) | Specs 01 y 02 | Regla del EDA con acción y conteo en la bitácora (DQ-04, DQ-12, DQ-15) |
| Exclusión de anónimas en PN02, PN09 y PN10 | Specs 02 y 04 | Regla y medida que excluya (RF-00-08) |
| Informe de cuántas anónimas se excluyeron en PN02, PN09 y PN10 | Specs 02, 04 y 05 | Conteo en la bitácora (02), medida (04) y cifra visible (05) (RF-00-11) |
| Reseñas con cero votos totales en la razón de utilidad | Spec 02 | Regla explícita (spec §6.4, DQ-02) |
| «% con al menos un voto útil» sobre todas las reseñas del corte | Specs 04 y 05 | Usar U-00-16 sin cambiarlo (DQ-22) |
| Mínimo de votos totales para una lectura de utilidad por producto | Spec 02 | Fijarlo con datos (DQ-23, DQ-27, U-00-17); no aplica a PN08 |
| PN08 como suma ÷ suma por calificación y rango, sin mínimo de votos | Spec 04 | Medida no aditiva (DQ-27) |
| Qué cuenta como palabra y rangos de longitud de PN08 | Spec 02 | Fijarlos con la distribución real (DQ-24, U-00-18) |
| Meses parciales 2010-03 y 2013-03 | Specs 02, 04 y 05 | Regla en 02; indicador de mes parcial en la dimensión de fecha en 04; marca visible en T1 y T3 en 05 (RF-00-05, DQ-03, DQ-19) |
| Umbral de volumen mínimo de PN06 | Spec 02 | Fijarlo con datos (DQ-11, DQ-28, U-00-11); no aplica a PN05 |
| Top 10 de PN05 con su desempate | Specs 04 y 05 | Usar U-00-14; T2 muestra exactamente 10 productos (DQ-25, DQ-29) |
| Corte del grupo más activo de PN09 | Spec 02 | Fijarlo con la distribución real (DQ-17, U-00-12) |
| Usuario recurrente = 2 o más reseñas en la ventana completa (PN10) | Specs 04 y 05 | Usar U-00-15; una sola cifra por grupo, sin corte por año (DQ-26) |
| Calificación baja de PN06 = promedio ≤ 2,5 | Specs 04 y 05 | Usar U-00-10 sin cambiarlo (DQ-18) |
| Fechas convertidas con UTC | Specs 03 y 04 | Aplicar UTC en mes y día de la semana (DQ-14) |
| Nivel de detalle mínimo = una reseña; conteos distintos no sumables; promedios y razones como suma entre suma | Spec 04 | Declarar grano y clasificar medidas sin reutilizar el modelo anterior (spec §6.1, §6.4) |
| Preguntas que dependen de un estado de capa («Bronce validada») | Spec 01 | La constitución no define un registro consultable del estado de una capa; definirlo antes de redactar requisitos con `MIENTRAS` |

---

## 8. Componentes del plan (siempre)

| ID | Enunciado (EARS) | Satisface | Verificación |
|---|---|---|---|
| C-00-01 | La matriz de trazabilidad `matriz-trazabilidad.md` DEBE contener exactamente una fila por cada pregunta de la spec §5 (U-00-01), con su ID `PNnn` y su prioridad. | RF-00-01 | `V-00-01` |
| C-00-02 | CUANDO se agregue, modifique o retire una PN en `spec.md`, la matriz de trazabilidad DEBE actualizarse en el mismo commit. | RF-00-06 | `V-00-01` |
| C-00-03 | La matriz de trazabilidad DEBE listar, en cada fila, los campos de la spec §3 que la pregunta necesita, idénticos a la columna «Disponible con los campos» de la spec §11. | RF-00-02 | `V-00-02` |
| C-00-04 | SI una PN necesita un dato que no está entre los diez campos de la spec §3, ENTONCES la matriz de trazabilidad DEBE marcarla «no viable con esta fuente» con el dato que falta. | RF-00-02 | `V-00-03` |
| C-00-05 | La matriz de trazabilidad DEBE marcar `cuenta_usuarios = sí` exactamente en PN02, PN09 y PN10, con la consigna de excluir las reseñas anónimas del conteo de usuarios. | RF-00-08 | `V-00-06` |
| C-00-06 | La matriz de trazabilidad DEBE indicar, en cada fila, las especificaciones que atienden la pregunta. | RNF-00-04 (y el traspaso de RF-00-05, RF-00-08 y RF-00-11 a las specs 02, 04 y 05, spec §13) | `V-00-02` |
| C-00-07 | El glosario `docs/glosario.md` DEBE definir cada término de dominio y cada sigla usados en `spec.md`, en este plan y en los documentos nuevos, con un solo nombre por concepto (U-00-06). | RNF-00-02 | `V-00-10` |
| C-00-08 | Cada documento nuevo de la especificación DEBE abrir con un encabezado de propósito, autor, fecha, dependencias e IDs de requisitos que atiende (U-00-07). | RNF-00-04 | `V-00-10` |
| C-00-09 | Retirado el 2026-10-15: la revisión de tecnología en la spec ya se hizo (§5.4, S-00-03) y ningún requisito de la spec la pide. | — | — |
| C-00-10 | Retirado el 2026-10-19: el validador del catálogo en Python no se crea (D-00-03 rechazada, spec DQ-31). | — | — |
| C-00-11 | CUANDO termine la lectura en frío, el checklist `checklists/legibilidad.md` DEBE registrar, por cada artefacto leído, las respuestas a las cinco preguntas estándar, el nombre de quien leyó y la fecha. | RNF-00-01, CE-00-05 | Checklist firmado |
| C-00-12 | El documento `research.md` DEBE registrar, para cada una de las doce PN, si su respuesta identifica a una persona o se entrega solo de forma agregada. | RF-00-03, RF-00-09 | `V-00-04` |
| C-00-13 | SI una PN pretende identificar a una persona, ENTONCES la lista de validación `checklists/validacion.md` DEBE marcarla «descartar» e impedir su paso a «Validada». | RF-00-03 | `V-00-04` |
| C-00-14 | La matriz de trazabilidad DEBE asignar a cada PN exactamente un tablero (T1, T2 o T3), igual al de la spec §7. | RF-00-04 | `V-00-05` |
| C-00-15 | La lista de validación DEBE registrar el número de PN de cada tablero frente a U-00-02 y U-00-03. | CE-00-02 | `V-00-05` |
| C-00-16 | La matriz de trazabilidad DEBE marcar `corte_por_mes = sí` exactamente en PN01, PN02, PN03, PN04, PN07 y PN11, con la consigna de mostrar 2010-03 y 2013-03 como «mes parcial» sin excluirlos ni normalizarlos. | RF-00-05 | `V-00-06` |
| C-00-17 | SI el encabezado de `plan.md` o de `task.md` declara en «Basada en» una fecha anterior al último cambio de PN, de requisitos o de la spec §6–§7 (DQ-32), ENTONCES la persona responsable DEBE regenerar ese archivo antes de usarlo. | RF-00-10 | `V-00-07` |
| C-00-18 | CUANDO el responsable y el segundo validador aprueben una PN, la tabla de la spec §11 DEBE registrar el nombre de quien aprueba, la fecha y el estado «Validada». | RF-00-07, CE-00-03 | `V-00-08` |
| C-00-19 | SI una PN de prioridad D no puede pasar a «Validada», ENTONCES la persona responsable DEBE registrar en la spec §12 la reapertura de esa pregunta (RF-00-06) antes del cierre. | CE-00-03 | `V-00-08` |
| C-00-20 | La lista de validación DEBE registrar, para cada una de las doce PN, el cumplimiento de RF-00-01, RF-00-02, RF-00-03, RF-00-04 y RF-00-09 (U-00-05). | CE-00-01 | `V-00-09` |
| C-00-21 | CUANDO se prepare el cierre de la spec 00, la lista de validación DEBE contener el nombre y la fecha del responsable de la 00 como firma de la spec §6.1 y §6.2 (DQ-34). | CE-00-04 | `V-00-09` |
| C-00-22 | SI la revisión de la spec §6.1 o §6.2 encuentra cambios, ENTONCES la persona responsable DEBE actualizar primero `spec.md` y firmar después; los cambios que pida Oro se tratan en el `/clarify` de la 04 (DQ-34). | CE-00-04 | `V-00-09` |
| C-00-23 | La lista de validación DEBE registrar, para cada fila de la spec §6.2, si nombra medida, cortes y nivel de detalle (§6.1) con nombres completos y sin abreviaturas. | RNF-00-03 | `V-00-09` |
| C-00-24 | SI quien lee en frío no responde correctamente alguna de las cinco preguntas estándar, ENTONCES el autor DEBE corregir el artefacto y repetir la lectura antes del cierre. | RNF-00-01, CE-00-05 | Checklist firmado |
| C-00-25 | SI al preparar el cierre una PN marcada «no viable con esta fuente» no tiene decisión registrada en la spec §12, ENTONCES la persona responsable DEBE mantener abierta la spec 00. | RF-00-02 | `V-00-03` |
| C-00-26 | SI una PN cambió en `spec.md` y la matriz de trazabilidad no cambió en el mismo commit, ENTONCES la persona responsable DEBE retener la integración del Pull Request hasta alinearlas. | RF-00-06 | `V-00-01` |
| C-00-27 | SI un documento de la spec 00 cambia una PN antes de que la cambie `spec.md`, ENTONCES la persona responsable DEBE aplicar primero el cambio en `spec.md` y rehacer después ese documento. | RF-00-06 | `V-00-07` |
| C-00-28 | Los encabezados de `plan.md` y de `task.md` DEBEN declarar, en la línea «Basada en», la fecha del último cambio de PN, de requisitos o de la spec §6–§7 que usaron; las aprobaciones, firmas y fechas de la spec §11 no la mueven (DQ-32). | RF-00-10 | `V-00-07` |
| C-00-29 | La matriz de trazabilidad DEBE marcar `solo_agregada = sí` exactamente en PN09, PN10 y PN11. | RF-00-09 | `V-00-06` |
| C-00-30 | La matriz de trazabilidad DEBE registrar, en cada fila con `cuenta_usuarios = sí`, la obligación de informar el conteo de reseñas anónimas excluidas y las especificaciones que lo producen (02, 04 y 05). | RF-00-11 | `V-00-06` |

Pares de flujo y error: C-00-02 ↔ C-00-26; C-00-11 ↔ C-00-24; C-00-18 ↔ C-00-19; C-00-21 ↔ C-00-22; C-00-28 ↔ C-00-17.

---

## 9. Verificación de legibilidad — Principio XIII (siempre)

| Regla | Qué artefactos de esta spec alcanza | Cómo se comprueba | Herramienta | Umbral | Responsable |
|---|---|---|---|---|---|
| XIII.1 SQL | Ninguno | No aplica: sin SQL | — | — | — |
| XIII.2 DDL | Ninguno | No aplica: sin DDL | — | — | — |
| XIII.3 Pruebas | Ninguno | No aplica: sin pruebas de Python (spec DQ-31) | — | — | — |
| XIII.4 General | `research.md`, `matriz-trazabilidad.md`, `quickstart.md`, `checklists/validacion.md`, `checklists/legibilidad.md`, `checklists/analisis.md`, `docs/glosario.md` | Encabezado presente; español; nombres completos | Inspección con esta tabla (`V-00-10`, después de la lectura en frío T-00-55 y antes del Pull Request T-00-39, para alcanzar `legibilidad.md`) | U-00-07 = 0 documentos sin encabezado | Dario Andres Bernate Canas |
| XIII.5 Trazabilidad | Los mismos documentos, este plan y `task.md` | Todo documento cita IDs que existen en la spec; todo ID citado en este plan y en `task.md` existe en la spec, en §2.3 de este plan o en `task.md` | Inspección (`V-00-07`, `V-00-10`, este último tras T-00-55 y antes de T-00-39) | 0 documentos sin ID; 0 IDs inexistentes | Dario Andres Bernate Canas |
| XIII.6 Glosario | `spec.md`, este plan y los documentos nuevos | Todo término y sigla está en `docs/glosario.md`, con un solo nombre por concepto | Inspección (`V-00-10`) | U-00-06 = 0 términos o siglas sin definir | Dario Andres Bernate Canas |
| XIII.7 Lectura en frío | Muestra (artefactos de tipo documento; capa tocada: ninguna): la matriz, el glosario y las 12 PN de la spec (PN01 a PN12), porque RNF-00-01 pide «cada pregunta» (decisión del responsable del 2026-10-19) | Las cinco preguntas estándar | `checklists/legibilidad.md` | U-00-08 = cinco de cinco sin consultar al autor; tiempo U-00-09 = 45 minutos por bloque (ADR-0012 firmado el 2026-10-19) | Agente en contexto limpio; firma Dario Andres Bernate Canas (DQ-34, anexo 2 de D-00-01) |

**Las cinco preguntas aplicadas a una PN**: (1) ¿Qué pregunta de negocio plantea? (2) ¿Qué campos de la fuente entran y qué respuesta debe salir? (3) ¿Qué requisito o decisión atiende? (4) ¿Por qué se pide cada medida, corte y condición de tiempo? (5) ¿Cómo se sabrá que está bien respondida y en qué especificación?

---

## 10. Estrategia de verificación (siempre)

### 10.1 Pruebas automatizadas (en `tests/`)

No hay pruebas automatizadas en esta spec: D-00-03 se rechazó (spec DQ-31) y la condición 1 de la compuerta se cumple con CE-00-01 a CE-00-04 y la spec §11 firmada (D-00-01).

| Archivo | Qué comprueba | Requisito | Valor esperado |
|---|---|---|---|
| — | Retirado: `tests/test_catalogo_preguntas.py` no se crea (C-00-10 retirado) | — | — |

### 10.2 Verificación humana (Principio XI)

No hay tablas para consultar con SQL (D-00-01). La persona responsable ejecuta estas verificaciones sobre los documentos. El valor de referencia sale siempre de otra ruta: se cuenta en la spec y se compara con el documento, nunca con el mismo documento que se revisa.

| ID | Qué verifica | Sobre qué objeto | Resultado esperado |
|---|---|---|---|
| V-00-01 | Conteo de PN y alineación por commit | Spec §5 frente a `matriz-trazabilidad.md`; historial del Pull Request | U-00-01 filas en ambos; 0 IDs repetidos; todo cambio de PN acompañado del cambio en la matriz |
| V-00-02 | Campos y destinos | Matriz frente a la spec §3 y §11 | 0 filas cuyos campos difieran de la spec §11; 0 filas sin especificaciones destino |
| V-00-03 | Preguntas no viables | Matriz y spec §12 | Cada fila «no viable» tiene el dato que falta y una decisión en la spec §12 |
| V-00-04 | Identificación de personas y respuesta agregada | `research.md` y lista de validación | 12 de 12 PN revisadas; 0 PN que identifiquen a una persona sin marca «descartar»; PN09, PN10 y PN11 registradas como solo agregadas |
| V-00-05 | Tableros | Matriz, spec §7 y lista de validación | 12 de 12 PN con un tablero igual al de la spec; T1 y T3 con al menos U-00-02, T2 con al menos U-00-03 |
| V-00-06 | Marcas de la matriz | Matriz | `corte_por_mes = sí` exactamente en PN01, PN02, PN03, PN04, PN07, PN11; `cuenta_usuarios = sí` exactamente en PN02, PN09, PN10, cada una con la obligación de informar las anónimas excluidas; `solo_agregada = sí` exactamente en PN09, PN10, PN11 |
| V-00-07 | Versión de la spec usada y orden de cambios | Encabezados de `plan.md` y `task.md` frente a la fecha del último cambio de PN, requisitos o spec §6–§7 (spec §12 «Decisiones tomadas» e historial de commits de `spec.md`) | Ambos declaran en «Basada en» una fecha igual o posterior a ese último cambio; los cambios solo de la spec §11 (aprobaciones, firmas, fechas) no cuentan (DQ-32); 0 cambios de PN que aparezcan en un documento antes que en la spec |
| V-00-08 | Validación de las PN | Spec §11 | U-00-04: siete de siete PN de prioridad D en «Validada», con nombre y fecha |
| V-00-09 | Lista de validación completa | `checklists/validacion.md` | U-00-05 de cumplimiento de RF-00-01 a RF-00-04 y RF-00-09; §6.1 y §6.2 revisadas; firma del responsable de la 00 con fecha (DQ-34) |
| V-00-10 | Glosario, encabezados e IDs citados | `research.md`, `matriz-trazabilidad.md`, `quickstart.md`, `checklists/validacion.md`, `checklists/legibilidad.md`, `checklists/analisis.md` y `docs/glosario.md`; IDs citados en `plan.md` y `task.md` | U-00-06 y U-00-07 en cero; 0 IDs citados en `plan.md` y `task.md` que no existan en la spec, en §2.3 de este plan o en `task.md`. Se ejecuta después de la lectura en frío (T-00-55) y antes del Pull Request (T-00-39) |

**Requisitos que la 00 solo verifica en parte.** RF-00-05 (marca de «mes parcial»), RF-00-08 (excluir anónimas al contar usuarios) y RF-00-11 (informar cuántas anónimas se excluyeron) hablan de lo que muestra el tablero o de cómo se calcula, y en la 00 no hay tablero ni cálculo. Aquí `V-00-06` solo comprueba que la matriz deja escrita la consigna en las PN correctas. La verificación completa es un traspaso que la spec §13 nombra: la regla y su conteo en la spec 02, la medida en la 04 y la marca o cifra visible en la 05 (ver «Traspasos explícitos», §7.4–7.9). Mientras esas specs no los verifiquen, estos tres requisitos cuentan como «cubiertos en la 00 en lo que le toca».

---

## 11. Trazabilidad (siempre)

| Requisito | Componente (plan) | Tarea (`task.md`) | Prueba o consulta | Evidencia (archivo o commit) |
|---|---|---|---|---|
| RF-00-01 | C-00-01 | T-00-16, T-00-47, T-00-28 | `V-00-01` | `matriz-trazabilidad.md` |
| RF-00-02 | C-00-03, C-00-04, C-00-25 | T-00-13, T-00-17, T-00-29, T-00-30 | `V-00-02`, `V-00-03` | `matriz-trazabilidad.md`, `research.md` |
| RF-00-03 | C-00-12, C-00-13 | T-00-14, T-00-47, T-00-49 | `V-00-04` | `research.md`, `checklists/validacion.md` |
| RF-00-04 | C-00-14 | T-00-45, T-00-24, T-00-50 | `V-00-05` | `matriz-trazabilidad.md` |
| RF-00-05 | C-00-16 | T-00-18, T-00-51 | `V-00-06` (parcial en la 00; completa en 02, 04 y 05, traspaso de spec §13) | `matriz-trazabilidad.md` |
| RF-00-06 | C-00-02, C-00-26, C-00-27 | T-00-41, T-00-28, T-00-52 | `V-00-01`, `V-00-07` | Historial del Pull Request |
| RF-00-07 | C-00-18 | T-00-23, T-00-53 | `V-00-08` | Spec §11 |
| RF-00-08 | C-00-05 | T-00-18, T-00-51 | `V-00-06` (parcial en la 00; completa en 02 y 04, traspaso de spec §13) | `matriz-trazabilidad.md` |
| RF-00-09 | C-00-12, C-00-29 | T-00-14, T-00-45, T-00-47, T-00-49, T-00-51 | `V-00-04`, `V-00-06` | `research.md`, `matriz-trazabilidad.md` |
| RF-00-10 | C-00-17, C-00-28 | T-00-42, T-00-43, T-00-56, T-00-52 | `V-00-07` | Encabezados de `plan.md` y `task.md` |
| RF-00-11 | C-00-30 | T-00-18, T-00-51 | `V-00-06` (parcial en la 00; completa en 02, 04 y 05, traspaso de spec §13) | `matriz-trazabilidad.md` |
| RNF-00-01 | C-00-11, C-00-24 | T-00-38, T-00-55 | Checklist firmado | `checklists/legibilidad.md` |
| RNF-00-02 | C-00-07 | T-00-12, T-00-15, T-00-31 | `V-00-10` | `docs/glosario.md` |
| RNF-00-03 | C-00-23 | T-00-48, T-00-54 | `V-00-09` | `checklists/validacion.md` |
| RNF-00-04 | C-00-08, C-00-06 | T-00-11, T-00-16, T-00-22, T-00-46, T-00-47, T-00-20, T-00-31, T-00-29 | `V-00-10`, `V-00-02` | Documentos de la spec |
| CE-00-01 | C-00-20 | T-00-47, T-00-54, T-00-34 | `V-00-09` | `checklists/validacion.md` |
| CE-00-02 | C-00-15 | T-00-24, T-00-50, T-00-34 | `V-00-05` | `checklists/validacion.md` |
| CE-00-03 | C-00-18, C-00-19 | T-00-23, T-00-53, T-00-34 | `V-00-08` | Spec §11 |
| CE-00-04 | C-00-21, C-00-22 | T-00-25, T-00-54, T-00-34 | `V-00-09` | `checklists/validacion.md` |
| CE-00-05 | C-00-11, C-00-24 | T-00-38, T-00-55 | Checklist firmado | `checklists/legibilidad.md` |

**Cobertura calculada**: la spec tiene 20 requisitos (11 RF, 4 RNF, 5 CE); 20 de 20 tienen al menos un componente, una tarea y una verificación. De ellos, 17 se verifican por completo en la 00 y 3 (RF-00-05, RF-00-08, RF-00-11) solo en parte: su verificación completa es un traspaso a las specs 02, 04 y 05 (spec §13; nota de §10.2). Componentes: 28 vigentes y 2 retirados (C-00-09, C-00-10); los 28 citan al menos un requisito, y C-00-06 cita RNF-00-04 en lugar de RF-00-06 y CE-00-04, que siguen cubiertos por C-00-02, C-00-26, C-00-27 y por C-00-21, C-00-22. Las tareas son las de `task.md` regenerado el 2026-10-19.

---

## 12. Riesgos y mitigaciones

| Riesgo | Probabilidad | Impacto | Mitigación | Quién la vigila |
|---|---|---|---|---|
| La spec vuelve a cambiar y plan o tareas quedan con una fecha de spec anterior | Media | Medio | C-00-17, C-00-28 y `V-00-07`, comparados contra el último cambio de PN, requisitos o spec §6–§7 (DQ-32); regenerar con `/plan` y `/tasks` | Dario Andres Bernate Canas |
| La matriz y la spec divergen (dos fuentes de verdad) | Media | Medio | La matriz cita la spec §6.2 en lugar de copiarla (D-00-05); C-00-02 y C-00-26 | Dario Andres Bernate Canas |
| Un mismo concepto recibe varios nombres en documentos nuevos | Media | Medio | Glosario con «usuario» como único término (C-00-07); `V-00-10` | Agente en contexto limpio (lectura en frío, anexo 2 de D-00-01) |
| Se pierde un traspaso (anónimas, cero votos, meses parciales, DQ-11, DQ-17, DQ-23, DQ-24) | Media | Alto | Tabla «Traspasos explícitos»; cada spec destino los copia en su §5 | Dario Andres Bernate Canas |
| Cambios de la 00 hechos en la rama `01-ingesta-bronce` quedan fuera del Pull Request de la 00 o entran a `main` con la 01 | Media | Medio | Mitigado: el commit y el PR de cierre (`00-preguntas-negocio-cierre`) excluyen `specs/01-ingesta-bronce/`; los cambios de la 00 se hacen en esta rama (S-00-05) | Dario Andres Bernate Canas |
| RF-00-05, RF-00-08 o RF-00-11 se dan por verificados en la 00 aunque solo se comprobó la consigna de la matriz | Media | Medio | Nota de §10.2 y columna «Prueba o consulta» de §11 marcadas «parcial»; traspasos de spec §13 que las specs 02, 04 y 05 copian | Dario Andres Bernate Canas |
| `AGENTS.md` y `README.md` remiten a principios (XIV, XV) que la constitución v1.1.0 no define | Alta | Bajo | Corregirlo fuera de esta spec por Pull Request; este plan solo cita los principios I–XIII | Dario Andres Bernate Canas |
| Una PN hereda un requerimiento del modelo anterior | Baja | Alto | Cada PN declara su decisión de negocio (spec §5); la constitución lo prohíbe | Dario Andres Bernate Canas |

---

## 13. Seguimiento de complejidad

No hay filas en ❌ ni advertencias pendientes: IX y XIII.4 a XIII.7 se cerraron con `quickstart.md` (T-00-22), el glosario (C-00-07), la lectura en frío (T-00-38 y T-00-55) y la evidencia de las tareas.

La variante de compuerta de la 00 (condiciones 1 a 4) no es un incumplimiento: es la decisión firmada D-00-01, con su fecha de revisión (al hacer el `/plan` de la 02 o de la 05, lo que ocurra primero) y su anexo U-00-08.

| Incumplimiento | Por qué es necesario | Alternativa más simple descartada porque | ADR | Fecha de revisión |
|---|---|---|---|---|
| Ninguno | — | — | — | — |

---

## 14. Compuerta de cierre de la especificación (siempre)

| # | Condición | Cómo se comprueba en esta spec | Estado |
|---|---|---|---|
| 1 | Tests en verde (variante D-00-01) | CE-00-01 a CE-00-04 cumplidos y spec §11 firmada (`V-00-05`, `V-00-08`, `V-00-09`); sin `pytest` (spec DQ-31) | Cumplida: CE-00-01 a CE-00-04 cumplen; spec §11 firmada (7 de 7 PN D en «Validada» el 2026-10-19); CE-00-04 firmada por el responsable de la 00 (DQ-34) |
| 2 | Cuadre exacto | No aplica: no hay filas (D-00-01) | — |
| 3 | Verificación humana | Sustituida por `V-00-01` a `V-00-10` ejecutadas por la persona responsable (D-00-01); `V-00-10` corre después de la lectura en frío (T-00-55) y antes del Pull Request (T-00-39) | Cumplida: V-00-01 a V-00-09 con resultado igual al esperado y V-00-10 ejecutada tras la lectura en frío; 10 de 10 en `checklists/validacion.md` §6 |
| 4 | README de la capa actualizado | No aplica: no hay capa. Se verifica que `docs/glosario.md` y los documentos de la spec estén al día (D-00-01) | Cumplida: glosario (G-50 a G-54), `research.md`, matriz y listas al día; ADR-0012 firmado; fila S-00 actualizada (T-00-37) |
| 5 | Checklist de legibilidad firmado | `checklists/legibilidad.md` tras la lectura en frío (CE-00-05, Const. XIII.7) | Cumplida: 2 de 2 bloques con 5 de 5 cada uno; firmado por el responsable el 2026-10-19 (T-00-38 y T-00-55) |
| 6 | Pull Request integrado a `main` | Rama `00-preguntas-negocio-cierre` (PR de cierre #2) | Pendiente: PR de cierre #2 abierto; se marca al integrar (T-00-39) |

Las seis condiciones coinciden con la spec §13 y con D-00-01, firmada el 2026-10-19 (fecha de revisión: `/plan` de la 02 o de la 05; anexo U-00-08).

---

## 15. Glosario y umbrales (siempre)

### 15.1 Términos de esta especificación

Términos para sembrar `docs/glosario.md` (C-00-07). El ID de glosario se asigna al crearlo.

| Término | Definición |
|---|---|
| DWS | Data Warehouse (almacén de datos) de reseñas de Amazon de este proyecto |
| SNAP | Stanford Network Analysis Project, origen público del dataset (McAuley y Leskovec, 2013) |
| PN (pregunta de negocio) | Pregunta que la persona analista necesita responder con los datos de reseñas; ID `PNnn` |
| Prioridad D, S, P | D: debe estar en la primera entrega; S: debería; P: podría si hay tiempo |
| DQ | Pregunta abierta o decisión registrada en la spec §12; ID `DQ-nn` |
| RF | Requisito funcional: qué DEBE cumplir la especificación; ID `RF-NN-MM` |
| RNF | Requisito no funcional: una cualidad exigida, como la legibilidad; ID `RNF-NN-MM` |
| CE | Criterio de éxito: condición medible para dar la especificación por lograda; ID `CE-NN-MM` |
| ADR | Registro de una decisión de arquitectura, firmado por el responsable |
| EDA | Análisis exploratorio de datos (spec 02); de él nacen las reglas `Rnn` |
| EARS | Forma de redactar requisitos en una oración con patrón fijo (§2) |
| UTC | Tiempo universal coordinado; zona con la que se convierten las fechas (DQ-14) |
| IDs del plan (C, V, U, T, D, S) | Componente `C-NN-MM`, verificación humana `V-NN-MM`, umbral `U-NN-MM`, tarea `T-NN-MM`, decisión propuesta `D-NN-xx` y supuesto `S-NN-nn` |
| Medida | Valor que se calcula o agrega para responder una pregunta (un conteo, un promedio) |
| Corte | Punto de vista por el que se agrupa una medida (mes, producto, calificación) |
| Nivel de detalle mínimo | Unidad más pequeña que exigen las preguntas: una reseña (spec §6.1); insumo del grano |
| Grano | Qué representa una fila de un hecho, dicho en una frase (lo declara la spec 04) |
| Campo de la fuente | Cada uno de los diez campos de la spec §3 |
| Ventana de datos | Periodo del 2010-03-04 al 2013-03-04 que cubre la fuente; ambos extremos incluidos (DQ-36) |
| Reseña anónima | Reseña sin usuario identificable; la forma exacta de reconocerla `[POR DEFINIR en las specs 01 y 02, DQ-12]` |
| Usuario | Persona seudónima que escribe reseñas (campo `userId`); término único fijado por la spec DQ-20. No se usan «reseñador» ni «cliente» en ese sentido; «cliente» solo aparece en el rol «analista de experiencia del cliente» |
| Usuario de una sola vez | Usuario con exactamente 1 reseña en la ventana completa (PN10, DQ-26) |
| Usuario recurrente | Usuario con 2 o más reseñas en la ventana completa (PN10, DQ-26, U-00-15) |
| Mes parcial | Primer (2010-03) o último (2013-03) mes de la ventana, que no tiene todos sus días; se muestra marcado (RF-00-05) |
| Voto útil | Voto que marca una reseña como útil; la fuente lo trae en `helpfulness` junto con los votos totales |
| Razón de utilidad | Suma de votos útiles ÷ suma de votos totales del corte (DQ-02); no se promedian razones |
| % con al menos un voto útil | Reseñas con votos útiles ≥ 1 ÷ todas las reseñas del corte, incluidas las de cero votos totales (PN07, DQ-22, U-00-16) |
| Palabra | Unidad con la que se mide la longitud del texto en PN08 (DQ-24); qué cuenta como palabra `[POR DEFINIR en la spec 02, DQ-24]` |
| Top 10 | Los 10 productos con más reseñas de PN05; los empates se resuelven por mayor calificación promedio y después por identificador de producto en orden alfabético (DQ-25, DQ-29, U-00-14) |
| Calificación baja | Calificación promedio de un producto ≤ 2,5 (DQ-18, U-00-10) |
| Tablero T1, T2, T3 | Panorama de reseñas, Productos, y Usuarios y utilidad (spec §7) |
| Estados de una PN | Propuesta → Validada → Confirmada con datos (spec §11) |
| Viabilidad | Si la fuente puede responder una pregunta: `viable`, `viable con reserva` o `no viable con esta fuente` |
| Matriz de trazabilidad | Documento con una fila por PN que la une con sus campos, su tablero y las especificaciones que la atienden |
| Lista de validación | Documento `checklists/validacion.md` con la evidencia de CE-00-01 a CE-00-04 |
| Perfil junior | Persona que conoce SQL básico y Python básico, pero no el repositorio ni el dataset (Const. XIII) |
| Lectura en frío | Revisión por una persona distinta del autor, que responde las cinco preguntas estándar sin consultarlo; en la `00`, la hace un agente en contexto limpio con la firma del responsable (anexo 2 de D-00-01, DQ-34) |
| Capa (Bronce, Plata, Oro) | Cada etapa del modelo Medallion: `raw`, `silver`, `gold` |
| Regla del EDA (`Rnn`) | Hallazgo del EDA convertido en regla con acción (descarta, corrige o marca) y conteo en la bitácora |

### 15.2 Umbrales con nombre

| ID | Nombre | Valor | Fuente de la decisión |
|---|---|---|---|
| U-00-01 | Número de preguntas del catálogo | 12 | Spec §5 |
| U-00-02 | Mínimo de preguntas por tablero (T1 y T3) | 3 | CE-00-02 |
| U-00-03 | Mínimo de preguntas en T2 | 2 | CE-00-02 |
| U-00-04 | PN de prioridad D en «Validada» al cierre | 100 % (7 de 7) | CE-00-03 |
| U-00-05 | PN que cumplen RF-00-01 a RF-00-04 y RF-00-09 | 100 % | CE-00-01 |
| U-00-06 | Términos o siglas sin definir en el glosario | 0 | RNF-00-02, Const. XIII.6 |
| U-00-07 | Documentos nuevos sin encabezado o sin IDs | 0 | RNF-00-04, Const. XIII.4 y XIII.5 |
| U-00-08 | Preguntas estándar respondidas correctamente en la lectura en frío | 5 de 5, sin consultar al autor | CE-00-05, Const. XIII.7; fijado para la 00 en el anexo de D-00-01 el 2026-10-19 y extendido a todas las especificaciones por el ADR-0012 |
| U-00-09 | Tiempo máximo de la lectura en frío | 45 minutos por bloque de lectura (ADR-0012, firmado el 2026-10-19) | Firmado |
| U-00-10 | Calificación baja de PN06 | Promedio ≤ 2,5 | Spec DQ-18 |
| U-00-11 | Volumen mínimo de reseñas por producto, solo en PN06 | `[POR DEFINIR: spec 02, DQ-11]` | Diferido; DQ-28 lo limita a PN06 |
| U-00-12 | Corte del grupo más activo de PN09 | `[POR DEFINIR: spec 02, DQ-17]` | Diferido |
| U-00-13 | Diferencia de cuadre admitida | No aplica: no hay filas | Constitución, Principio VI |
| U-00-14 | Tamaño del ranking de PN05 | 10 productos; desempate por mayor calificación promedio y después por identificador de producto en orden alfabético | Spec DQ-25, DQ-29 |
| U-00-15 | Mínimo de reseñas en la ventana completa para ser «usuario recurrente» | 2 (exactamente 1 = «una sola vez») | Spec DQ-26 |
| U-00-16 | Votos útiles mínimos para contar una reseña en «% con al menos un voto útil» | 1; denominador: todas las reseñas del corte | Spec DQ-22 |
| U-00-17 | Mínimo de votos totales para una lectura de utilidad por producto | `[POR DEFINIR: spec 02, DQ-23]`; no aplica a PN08 (DQ-27) | Diferido |
| U-00-18 | Rangos de longitud en palabras de PN08 | `[POR DEFINIR: spec 02, DQ-24]` | Diferido |

---

## 16. Historial de cambios del plan

| Fecha | Cambio | Motivo | Autor |
|---|---|---|---|
| 2026-10-14 | Versión inicial (borrador sin `spec.md`) | Primer plan de la especificación 00 | Claude (skill `/plan`) |
| 2026-10-15 | Reconciliación con la spec del 2026-10-15: IDs reales, cobertura 17 de 17 con C-00-12 a C-00-26 (C-00-09 retirado), D-00-06 y D-00-07, §5.4 con diez cambios, umbrales U-00-01 a U-00-13 | `/clarify` cambió la spec; RF-00-06 | Claude (skill `/plan`, agente `architect`) |
| 2026-10-15 | Segunda pasada tras DQ-20 y DQ-21: IDs `RF-00-MM`, D-00-07 decidida, «usuario» único, compuerta de seis condiciones | La spec cambió después del plan y de `/analyze` | Claude (skill `/plan`, agente `architect`) |
| 2026-10-19 | Regeneración sobre la spec del 2026-10-19 (DQ-22 a DQ-31): cobertura 20 de 20 con RF-00-09 a RF-00-11; nuevos C-00-27 a C-00-30; C-00-10 retirado y §10.1 sin pruebas (DQ-31); C-00-05, C-00-12, C-00-17 y C-00-20 ajustan su requisito; V-00-04, V-00-06, V-00-07 y V-00-09 amplían su resultado esperado; D-00-01 firmada y D-00-03 rechazada en §5.2; ADR-0006, 0007 y 0013 firmados en §5.1; §5.4 marca hechos los cambios 4, 6 y 9, resuelve el 7 en el plan (D-00-06) y agrega el 11; Fase 0 recoge DQ-22 a DQ-31; traspasos a la 02 de DQ-23 y DQ-24 y a 04/05 de DQ-22, DQ-25, DQ-26 y DQ-29; umbrales U-00-14 a U-00-18; glosario con siglas separadas y los términos de DQ-22 a DQ-29; paso «/implement» sustituido por la producción manual de documentos (no aplica en la 00); §11 con los IDs de `task.md` regenerado | La spec cambió el 2026-10-19 y el informe de `/analyze` pidió corregir hallazgos; RF-00-10 exige regenerar y declarar la versión de la spec | Claude (skill `/plan`, agente `architect`) |
| 2026-10-19 | Actualización T-00-42 tras la última `/analyze`, conservando lo decidido por el responsable (§5.2 D-00-02 dos pasadas, D-00-03 rechazada, D-00-04/05/06 aceptadas; §9 lectura en frío de las 12 PN; U-00-08 anexo de D-00-01): §5.4 cambios 5 y 11 marcados hechos (falta confirmación, T-00-41 y T-00-44); fila IX del Constitution Check pasa a ⚠️ porque `quickstart.md` aún no existe; fila XII y XIII.7 actualizadas; C-00-06 satisface RNF-00-04 (no RF-00-06 ni CE-00-04, que siguen cubiertos); §10.2 y §11 marcan RF-00-05, RF-00-08 y RF-00-11 como verificación parcial con traspaso a 02, 04 y 05 (spec §13); D-00-01 citada con fecha de revisión y anexo U-00-08; §7.2, §12 y §13 al día; «Basada en» = spec con última actualización 2026-10-19 | Hallazgos de la última `/analyze`; RF-00-10 | Claude (skill `/plan`, agente `architect`) |
| 2026-10-19 | Actualización T-00-56 por DQ-32 (RF-00-10 acotado) y por `checklists/analisis.md` (T-00-10), conservando §5.2 D-00-01 a D-00-08, el anexo U-00-08 y la lectura en frío de las 12 PN (T-00-38 y T-00-55): C-00-17, C-00-28 y V-00-07 comparan «Basada en» con el último cambio de PN, requisitos o spec §6–§7; §6 y §5.4 (cambio 12) registran DQ-32; §4 fila XII pasa a ✅ y §5.4 cambios 5 y 11, §7.2 paso 01 y §13 quedan confirmados por el responsable el 2026-10-19; §2.3 con T-00-01 … T-00-56, D-00-08 y el prefijo S; §11 cita T-00-55 en RNF-00-01 y CE-00-05 y T-00-56 en RF-00-10; §15.1 agrega S; §3 y §7.1 agregan `checklists/analisis.md`; V-00-10 y §9 (XIII.4, XIII.5) alcanzan `legibilidad.md`, `analisis.md` y los IDs citados en plan y tareas, y V-00-10 corre tras T-00-55 y antes de T-00-39 (§7.2 pasos 07 y 09, §14) | Spec DQ-32 y hallazgos 2, 3 y 6 y correcciones mecánicas 1, 2 y 4 de `/analyze`; RF-00-10 | Claude (skill `/plan`, agente `architect`) |
| 2026-10-19 | Documentos del cierre de la spec: ADR-0012 propuesto (opción A: sin linter nuevo; 5 de 5 aciertos y 45 minutos por bloque), `checklists/legibilidad.md` creado y spec §11 firmada por el responsable (7 PN D en «Validada», DQ-10); §4 XIII.7 y §14 al día; U-00-09 pasa de «por definir» a propuesto | Cierre de la `00`: firmas humanas, lectura en frío y Pull Request de cierre | agente principal (OpenCode) |
| 2026-10-19 | Cierre de la spec 00: DQ-34 a DQ-36 (firmas sin Jose Julio, cortes de PN07 y ventana), ADR-0012 firmado (opción A), CE-00-04 firmada por el responsable, PN11 con `time`, `checklists/legibilidad.md` lleno y firmado (2 de 2 bloques, 5 de 5), §2.3 a DQ-36, §4 XIII.7 en ✅ y §14 con las condiciones 1, 3, 4 y 5 cumplidas; §13 y §7.9 con la ventana cerrada (DQ-36); RNF-00-01, CE-00-05 y G-37 citan la excepción de DQ-34; V-00-07, V-00-09 y V-00-10 ejecutadas | T-00-31, T-00-34, T-00-36 a T-00-38, T-00-52, T-00-54 y T-00-55; spec DQ-34 a DQ-36; ADR-0012 | agente principal (OpenCode) |

---

## Lista de revisión antes de entregar el plan

- [x] Cada componente tiene un sujeto con nombre, un solo `DEBE`, una sola respuesta y un ID.
- [x] Ningún valor numérico queda fuera de la tabla de umbrales; ningún adjetivo vago.
- [x] Cada `CUANDO` de un flujo tiene su `SI … ENTONCES` de error (pares en §8).
- [x] Cada requisito de la spec tiene al menos un componente (20 de 20); cada componente vigente cita su requisito.
- [x] El Constitution Check lista los trece principios y las siete reglas XIII.n, sin filas vacías.
- [x] La sección 9 existe y cada regla XIII.n que aplica tiene método, umbral y responsable.
- [x] Los pendientes ADR que afectan a la spec están en §5.1, sin resolverlos.
- [x] El plan no contiene código ni sentencias SQL y no reutiliza dimensiones ni nombres del modelo anterior.
- [x] Una persona junior que lea solo este plan y el glosario puede decir qué se va a construir y cómo se comprueba: no aplica en la `00`; la muestra de XIII.7 es el catálogo y el glosario (RNF-00-01, DQ-34), no el plan, y la lectura en frío los cubrió (T-00-38 y T-00-55).
