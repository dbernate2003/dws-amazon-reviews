# Plan técnico — 00-preguntas-negocio

**Rama**: `00-preguntas-negocio` | **Fecha**: 2026-10-15 | **Spec**: `specs/00-preguntas-negocio/spec.md` (última actualización 2026-10-15, estado «En revisión», con las aclaraciones de `/clarify` del 2026-10-14 y del 2026-10-15 hasta DQ-21 inclusive) | **Constitución**: v1.1.0
**Estado**: borrador | **Responsable**: Dario Andres Bernate Canas | **Segundo validador**: Dario Andres Bernate Canas (spec DQ-10; `docs/gestion/roles.md`)
**Generado por**: skill `/plan` (`skill-plan`, agente `architect`)

---

## 1. Resumen (siempre)

La especificación 00 fija y valida las doce preguntas de negocio (PN01 a PN12) que el DWS de reseñas de Amazon debe poder responder, y deja tres insumos: el nivel de detalle mínimo (insumo del grano de `04-modelo-oro`), las medidas y cortes (spec §6) y la asignación de preguntas a tableros (spec §7, insumo de `05-dashboards-bi`).

No toca ninguna capa ni esquema: no carga datos, no crea tablas y no ejecuta SQL.

El plan define cómo se **comprueba** el catálogo de preguntas contra los requisitos de la spec y cómo se **traza** cada pregunta hacia los campos de la fuente (spec §3) y hacia las especificaciones que la atienden. Para eso produce documentos: una matriz de trazabilidad (`matriz-trazabilidad.md`), una lista de validación firmada (`checklists/validacion.md`), la investigación de viabilidad (`research.md`), una guía para repetir la revisión (`quickstart.md`), el checklist de lectura en frío (`checklists/legibilidad.md`) y el glosario único del proyecto (`docs/glosario.md`). La validación de cada pregunta queda en la tabla de la spec §11.

Fuera de este plan: diseñar hechos, dimensiones o claves (spec 04), definir reglas del EDA, umbrales con datos o el corte del grupo más activo (spec 02), tocar `raw` y escribir cualquier script.

**Requisitos que cubre este plan** (IDs tal como existen en la spec desde DQ-21, sin renumerar): RF-00-01, RF-00-02, RF-00-03, RF-00-04, RF-00-05, RF-00-06, RF-00-07, RF-00-08, RNF-00-01, RNF-00-02, RNF-00-03, RNF-00-04, CE-00-01, CE-00-02, CE-00-03, CE-00-04, CE-00-05. Preguntas de negocio: PN01 a PN12. Decisiones de la spec que el plan respeta: DQ-01 a DQ-21 (spec §12).

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
| Requisito funcional | `RF-NN-MM` | `RF-00-01` … `RF-00-08` | Coincide desde DQ-21 (2026-10-15); antes la spec usaba `RF-01` |
| Requisito no funcional | `RNF-NN-MM` | `RNF-00-01` … `RNF-00-04` | Coincide (DQ-21) |
| Criterio de éxito | `CE-NN-MM` | `CE-00-01` … `CE-00-05` | Coincide (DQ-21) |
| Pregunta de negocio | `PNnn` | `PN01` … `PN12` | Coincide |
| Decisión de la spec | — | `DQ-01` … `DQ-21` | Propio de la spec (spec §12) |
| Regla de calidad del EDA | `Rnn` | — | No nacen en esta spec |
| Umbral | `U-NN-MM` | `U-00-01` … | §15.2 |
| Componente del plan | `C-NN-MM` | `C-00-01` … | §8 |
| Verificación humana | `V-NN-MM` | `V-00-01` … | §10.2 |
| Tarea | `T-NN-MM` | `T-00-__` hasta regenerar `task.md` | D-00-02 |
| Decisión propuesta del plan | `D-NN-xx` | `D-00-01` … | §5.2 |

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
| Entradas | `spec.md` (2026-10-15): catálogo PN01–PN12 (§5), campos de la fuente (§3), insumo del modelo (§6), tableros (§7), requisitos (§9), criterios (§10), validación (§11), decisiones (§12); Constitución v1.1.0; `templates/plan-template.md`; `docs/gestion/roles.md` |
| Salidas | `research.md`, `matriz-trazabilidad.md`, `quickstart.md`, `checklists/validacion.md`, `checklists/legibilidad.md`, `docs/glosario.md` (nuevo), tabla de la spec §11 completa y firmada por las personas, `task.md` (lo genera `/tasks`) |
| Motor | No se usa en esta especificación |
| Lenguajes | Markdown. Python solo en `tests/` y solo si se aprueba D-00-03 |
| Herramientas | Editor de texto y Git. Sin herramientas nuevas |
| Volumen esperado | 12 preguntas de negocio (U-00-01), 3 tableros, 10 campos de la fuente. Referencia de la fuente: 9.707.634 reseñas entre 2010-03-04 y 2013-03-04 (Constitución, Principio III) |
| Rendimiento | No aplica: no hay consultas |
| Frescura | Dataset cerrado; último dato 2013-03-04 |
| Concurrencia | 2 usuarios, cada uno con su copia local |
| Restricciones | Costo $0; los documentos contienen nombres de campos, nunca datos; sin credenciales |
| Ejecución | Manual, en el orden de los pasos de la sección 7.2 |

**Campos de la fuente**: se usan los diez nombres de la spec §3 (`productId`, `title`, `price`, `userId`, `profileName`, `helpfulness`, `score`, `time`, `summary`, `text`). La spec 01 confirma contra los datos su nombre exacto en el archivo y cómo aparecen las reseñas anónimas (spec DQ-12). Por DQ-13, `title` y `price` no entran en el análisis; `title` solo se muestra como etiqueta legible del producto en T2.

---

## 4. Constitution Check (siempre; compuerta)

Estados: ✅ cumple · ⚠️ cumple con riesgo (explicado) · ❌ incumple · — no aplica (explicado).

| Principio | Qué exige (resumen) | ¿Aplica? | Cómo lo cumple el diseño | Evidencia o verificación | Estado |
|---|---|---|---|---|---|
| I. Kimball | Grano, claves subrogadas, fila especial, medidas clasificadas | No directamente | La spec solo entrega insumos (§6.1 nivel de detalle mínimo = una reseña; §6.4 advertencias de aditividad). El plan los traspasa a la spec 04 sin diseñar el modelo y sin reutilizar nada del modelo anterior | Tabla «Traspasos explícitos» (§7.4–7.9); firma del responsable de Oro (C-00-21) | — |
| II. Medallion | Un esquema por capa; Parquet; README con DDL | No | No existen capas en esta spec | — | — |
| III. Bronce inmutable | Sin `UPDATE`/`DELETE`/`TRUNCATE` sobre `raw` | No | No se toca ningún dato | — | — |
| IV. Transformación con regla | Toda transformación nace de una regla `Rnn` | No | No hay ETL. Las decisiones que exigen regla (anónimas DQ-04 y DQ-15, cero votos totales, meses parciales) se traspasan a la spec 02 | Tabla «Traspasos explícitos» | — |
| V. SQL puro | Python solo en `tests/` | Sí | Solo Markdown. El único Python posible es el validador opcional en `tests/` (D-00-03) | Ningún `.py` fuera de `tests/` | ✅ |
| VI. Test por regla y cuadre | Un test por `Rnn`; cuadre exacto | No | No hay reglas ni filas. La condición de cuadre de la compuerta no aplica (D-00-01) | — | — |
| VII. Datos sin versionar | Ningún dato en Git | Sí | Los documentos contienen nombres de campos y definiciones, no datos | Ningún `.gz`, `.parquet`, `.csv`, `.twbx` ni `.env` en Git | ✅ |
| VIII. Costo $0 | Nada de pago ni de nube | Sí | Solo documentos, editor y Git | §3, fila «Herramientas» | ✅ |
| IX. Orquestación manual | Pasos numerados y reproducibles | Sí | Pasos 01–09 de §7.2; `quickstart.md` permite que otra persona repita la revisión | `quickstart.md` | ✅ |
| X. Gestión en el repositorio | Tareas con responsable, estado y evidencia | Sí | `task.md` de la spec y `docs/gestion/tareas.md`. ADR-0006 (nombre `task.md`) está decidido pero **falta firma**; la spec (DQ-06) exige firmarlo antes de `/tasks`. El `task.md` actual es un borrador sobre la versión anterior del plan y debe regenerarse (RF-00-06) | §5.1; D-00-02 | ⚠️ |
| XI. Verificación humana | La persona responsable verifica con sus consultas | Sí, adaptado | No hay tablas para consultar con SQL. Se sustituye por las verificaciones `V-00-01` a `V-00-10` sobre los documentos y por la firma de la spec §11 (D-00-01, pendiente de firma) | §10.2 | ⚠️ |
| XII. Spec primero y en orden | Spec antes que plan; orden 00 → 06 | Sí | El plan usa la spec del 2026-10-15 hasta DQ-21. La spec ya adoptó IDs `RF-00-MM`, el modal `DEBE`, un sujeto con nombre en RF-00-08 y la compuerta de seis condiciones. Quedan en §5.4 cambios de redacción pendientes: requisitos con más de una respuesta (RF-00-03, RF-00-06, RF-00-08), §6.2 sin nivel de detalle, CE-00-04 sin lugar de firma, la abreviatura «Prio.» y el origen de la variante de compuerta | §5.4 | ⚠️ |
| XIII. Legibilidad y trazabilidad | Siete reglas XIII.1–XIII.7 | Sí | Ver filas siguientes y §9 | §9 | ⚠️ |
| ↳ XIII.1 SQL | CTEs, sin `SELECT *`, comentarios | No | Esta spec no tiene SQL | — | — |
| ↳ XIII.2 DDL | Comentarios de tabla y columna; llaves explícitas | No | Esta spec no tiene DDL | — | — |
| ↳ XIII.3 Pruebas | Docstring, nombres, mensajes, constantes | Solo si D-00-03 | Aplica únicamente al validador opcional `tests/test_catalogo_preguntas.py` | §9 | — |
| ↳ XIII.4 General | Nombres completos, porqué, español, encabezado | Sí | Diseño: todo documento nuevo abre con encabezado (propósito, autor, fecha, dependencias) y usa nombres completos (C-00-08, C-00-23). Motivo del ⚠️: todavía no existe ningún documento nuevo que inspeccionar, así que no hay evidencia; además la spec conserva la abreviatura «Prio.» (§5.4, cambio 9) | C-00-08, C-00-23; evidencia futura: `V-00-09`, `V-00-10` | ⚠️ |
| ↳ XIII.5 Trazabilidad | Todo artefacto cita IDs `RF-NN-MM`/`RNF-NN-MM` que existen | Sí | La spec usa `RF-00-MM`, `RNF-00-MM` y `CE-00-MM` desde DQ-21 y este plan cita esos mismos IDs; la matriz es la trazabilidad misma. Riesgo: el `task.md` vigente aún cita los IDs anteriores (`RF-01`) y componentes del plan viejo | C-00-08, C-00-17; `V-00-07` | ⚠️ |
| ↳ XIII.6 Glosario | Términos y siglas definidos, un nombre por concepto | Sí | Se crea `docs/glosario.md` (hoy no existe) con los términos de §15.1. La spec ya fija «usuario» como término único (DQ-20). Riesgo: la spec usa siglas que aún no tienen glosario donde definirse (PN, DQ, RF, RNF, CE, EDA, UTC, SNAP) | C-00-07; `V-00-10` | ⚠️ |
| ↳ XIII.7 Lectura en frío | Persona junior distinta del autor responde cinco preguntas | Sí | Diseño: la otra persona del equipo lee una muestra de los documentos y registra las respuestas; si falla, se corrige y se repite (C-00-11, C-00-24). Motivo del ⚠️: no hay evidencia todavía (no existen los documentos ni `checklists/legibilidad.md`) y el umbral de tiempo depende de ADR-0012 (U-00-09) | C-00-11, C-00-24; U-00-08 | ⚠️ |

**Resultado de la compuerta antes de la Fase 0**: pasa con advertencias en X, XI, XII y XIII (XIII.4, XIII.5, XIII.6 y XIII.7). Ninguna fila en ❌. Ninguna advertencia bloquea `/analyze`; X bloquea `/tasks` hasta firmar ADR-0006 y ADR-0007.
**Resultado de la compuerta después de la Fase 1**: pasa con las mismas advertencias. El diseño (§7 y §8) cubre los 17 requisitos de la spec, no introduce código ni herramientas, no toca capas y deja cada advertencia con su salida: §5.4 (spec), D-00-01 (firma), C-00-07 (glosario), la regeneración de `task.md` (C-00-17) y la evidencia que producen `/implement` y la lectura en frío.

---

## 5. Decisiones, ADR y supuestos (siempre)

### 5.1 Pendientes de la constitución que afectan a esta especificación

| ADR | Pendiente | ¿Bloquea esta spec? | Cómo la trata este plan |
|---|---|---|---|
| 0006 | Nombre del archivo de tareas | Sí, para `/tasks` (spec DQ-06 y DQ-07) | Decidido, falta firma: `task.md`. Este plan usa `task.md`. No se firma aquí |
| 0007 | Ubicación de `memory/` y cómo la leen los agentes | Sí, para `/tasks` (spec DQ-06 y DQ-08) | Decidido, falta firma: `memory/` en la raíz más `instructions` en `opencode.json`. No se firma aquí |
| 0008 | Herramienta de `clave: valor` a archivo delimitado | No | Es de la spec 01 |
| 0009 | Dónde vive la bitácora de calidad | No | Es de la spec 03. La matriz solo anota qué PN dependerán de reglas con conteo en bitácora (anónimas, cero votos) |
| 0010 | Umbral de latencia | No | Es de la spec 04 |
| 0011 | Cómo llega Oro a Tableau Public | No | Es de la spec 05 |
| 0012 | Herramienta y umbrales de legibilidad | No para esta spec | La lectura en frío usa un criterio provisional de cinco de cinco respuestas (U-00-08); el tiempo queda `[POR DEFINIR: ADR-0012]`. Observación: ADR-0012 figura en la constitución pero no tiene archivo en `memory/adr/` ni fila en su índice |

### 5.2 Decisiones nuevas que propone este plan

| ID | Decisión propuesta | Alternativas descartadas | Motivo | Estado |
|---|---|---|---|---|
| D-00-01 | La compuerta de cierre de la spec 00 sigue la spec §13: condición 1 sustituida por CE-00-01 a CE-00-04 cumplidos y spec §11 firmada (más `pytest tests/` en verde si se aprueba D-00-03); condición 2 «no aplica»; condición 3 cumplida con las verificaciones `V-00-01` a `V-00-10`; condición 4 con el glosario y los documentos de la spec al día; condiciones 5 y 6 sin cambio | Exigir SQL sin tablas; saltarse la compuerta | La spec §13 remite la variante a `specs/README.md`, y este dice que está «fijada en la constitución», pero la constitución v1.1.0 no contiene variantes de compuerta. Hace falta una firma o un ADR para que `/analyze` no lo marque como conflicto | Propuesta; requiere firma del responsable |
| D-00-02 | `/analyze` corre antes de `/tasks`, así que no puede comprobar la cobertura requisito → tarea ni la tarea final de legibilidad. Se repite una pasada corta de `/analyze` después de regenerar `task.md` | Mover `/analyze` después de `/tasks`; omitir los chequeos | Los puntos (b) y (c) de la tabla XIII-C necesitan `task.md` | Propuesta |
| D-00-03 | Validador opcional del catálogo en `tests/` (C-00-10) | No tenerlo; escribirlo fuera de `tests/` | Detecta PN repetidas o incompletas sin depender solo de la vista humana; el Principio V permite Python en `tests/` | Propuesta; el responsable decide si entra |
| D-00-04 | El glosario vive en `docs/glosario.md` y se siembra en esta spec | Glosario por spec; glosario en el README raíz | XIII.6 pide un glosario único y la spec 00 es la primera que define términos | Propuesta |
| D-00-05 | La trazabilidad PN → campos → tablero → especificaciones destino vive en `matriz-trazabilidad.md`. La matriz no copia las medidas ni los cortes de la spec §6.2 (la spec manda); solo los cita por ID | Usar `data-model.md`; copiar §6.2 dentro de la matriz | Esta spec no tiene modelo de datos; copiar §6.2 crearía dos fuentes de verdad | Propuesta (ajustada el 2026-10-15) |
| D-00-06 | La evidencia de CE-00-01 a CE-00-04 (revisión por lista, conteo por tablero, estado de las PN D y firma del responsable de Oro sobre §6.1 y §6.2) vive en `checklists/validacion.md` | Firmar dentro de `spec.md`; usar el Pull Request como evidencia | La spec no dice dónde queda la firma de CE-00-04 (§5.4 cambio 7); un archivo propio deja evidencia trazable | Propuesta |
| D-00-07 | Formato de los IDs de la spec: renombrar a `RF-00-MM`, `RNF-00-MM` y `CE-00-MM`, con `DEBE` como único modal | Mantener `RF-01` con un ADR de excepción | La constitución («Flujo de desarrollo», XIII.5) fija `RF-NN-MM` | **Decidida** por el responsable el 2026-10-15 (spec DQ-21) y ya aplicada en la spec; este plan usa los IDs nuevos |

### 5.3 Supuestos

- **S-00-01**: la spec 00 no carga datos ni ejecuta SQL. Verificado contra la spec §2 y §13 (2026-10-15).
- **S-00-02**: los diez campos de la spec §3 son la única fuente de datos de las preguntas. Se confirma en la spec 01 (spec DQ-12).
- **S-00-03**: las preguntas se redactan en español y sin tecnología. Verificado contra la spec §5 y §9 (2026-10-15): ningún enunciado de requisito nombra productos, lenguajes, objetos físicos ni rutas.
- **S-00-04**: en un equipo de dos, la lectura en frío la hace la persona que no escribió el artefacto (Jose Julio Gomez Palmera si el autor es Dario Andres Bernate Canas).
- **S-00-05**: marzo de 2010 y marzo de 2013 son meses parciales. Ya no es supuesto: lo deciden la spec DQ-03, DQ-19 y RF-00-05.

### 5.4 Cambios que este plan exige a `spec.md`

Principio XII: estos cambios se aplican primero en la spec y después se regeneran plan y tareas. Este plan no los aplica.

| # | Cambio en la spec | Motivo | Estado |
|---|---|---|---|
| — | Agregar requisitos no funcionales de legibilidad, un criterio de éxito de legibilidad y la línea «Principios transversales aplicables: Const. XIII» | Tabla XIII-C de la constitución | **Hecho** el 2026-10-15 por `/clarify` (spec DQ-16): RNF-00-01 a RNF-00-04, CE-00-05 y la línea en la spec §2 |
| — | Revisar que ningún enunciado de requisito nombre productos, lenguajes, objetos físicos ni rutas | Principio XII | **Hecho**: revisado el 2026-10-15, cero menciones (S-00-03) |
| 1 | Formato de IDs `RF-NN-MM`, `RNF-NN-MM` y `CE-NN-MM` | Constitución, «Flujo de desarrollo» y XIII.5 | **Hecho** el 2026-10-15 (spec DQ-21; D-00-07) |
| 2 | Modal `DEBE` en RF-00-01 a RF-00-08 en lugar de «deberá» | §2.2 regla 3 | **Hecho** el 2026-10-15 (spec DQ-21) |
| 3 | Sujeto con nombre en RF-00-08 en lugar de «el sistema» | §2.2 regla 2 | **Hecho** el 2026-10-15: el sujeto es «el cálculo» (spec DQ-21) |
| 4 | Requisitos con más de una respuesta: RF-00-03 (descartar la pregunta / responder las de usuarios solo de forma agregada), RF-00-06 (actualizar primero la spec / regenerar plan, tareas e insumos) y RF-00-08 (excluir las reseñas anónimas / informar aparte cuántas son). Partirlos en requisitos de una sola respuesta | §2.2 regla 1 | Pendiente |
| 5 | Compuerta de la spec §13 con las seis condiciones y CE-00-05 | Constitución, «Compuerta de cierre»; XIII.7 | **Hecho** el 2026-10-15 (spec DQ-21). Queda abierto solo el origen de la variante: §13 la remite a `specs/README.md`, que dice que la fija la constitución, y la constitución v1.1.0 no la contiene. Pendiente: citar D-00-01 (o su ADR) como origen |
| 6 | RNF-00-03 se verifica «por inspección de la sección 6.2», pero §6.2 no tiene columna de nivel de detalle por pregunta. Agregar la columna o remitir a §6.1 («una reseña» para todas) | RNF-00-03 sin criterio verificable completo | Pendiente |
| 7 | CE-00-04 no dice dónde queda la firma del responsable de Oro | CE-00-04 sin evidencia definida | Pendiente; propuesta D-00-06 (`checklists/validacion.md`) |
| 8 | Extender RF-00-08 a PN02 (DQ-15) | Decisión de la spec sin requisito que la recogiera | **Hecho** el 2026-10-15: RF-00-08 cubre PN02, PN09 y PN10 (spec DQ-21) |
| 9 | Las tablas de la spec §5 usan la abreviatura «Prio.»; escribir «Prioridad» | XIII.4 (nombres completos) | Pendiente |
| 10 | Un solo nombre para quien escribe la reseña | XIII.6 (un solo nombre por concepto) | **Hecho** el 2026-10-15: «usuario» (spec DQ-20); el glosario debe registrarlo (C-00-07) |

---

## 6. Fase 0 — Investigación (`research.md`)

| Pregunta | Opciones evaluadas | Decisión | Justificación | Fuente |
|---|---|---|---|---|
| ¿Qué se necesita de la fuente para responder cada PN? | Revisar la documentación del dataset; revisar una muestra del archivo | Documentación del dataset y la columna «Disponible con los campos» de la spec §11; la muestra real se difiere a las specs 01 y 02 | Esta spec no carga datos (S-00-01); RF-00-02 | Spec §3 y §11; SNAP (McAuley y Leskovec, 2013) |
| ¿Qué hacer con una PN que la fuente no puede responder? | Eliminarla; reformularla; mantenerla marcada | Mantenerla marcada «no viable con esta fuente» y registrar la decisión de la persona responsable en la spec §12 antes del cierre | Eliminarla pierde trazabilidad; RF-00-06 obliga a cambiar primero la spec | C-00-04, C-00-25 |
| ¿Alguna PN identifica a una persona? | Revisión por pregunta | Revisar las doce; PN09, PN10 y PN11 solo de forma agregada | RF-00-03; constitución, «Seguridad del dato» | C-00-12, C-00-13 |
| ¿Cómo se tratan las reseñas anónimas al contar usuarios? | Incluirlas; excluirlas; tratarlas aparte | Decidido en la spec: se excluyen en PN02, PN09 y PN10 y se informan aparte (DQ-04, DQ-15, RF-00-08); la regla con acción y conteo nace en la spec 02 | La constitución exige una regla explícita del EDA | Spec §12 |
| ¿Cómo se tratan marzo de 2010 y marzo de 2013? | Incluirlos tal cual; excluirlos; marcarlos | Decidido en la spec: se muestran marcados «mes parcial» en PN01, PN02, PN03, PN04, PN07 y PN11, sin excluirlos ni normalizarlos (DQ-03, DQ-19, RF-00-05) | Evita leer como caída un mes incompleto | Spec §12 |
| ¿Entran el título y el precio? | Analizarlos; excluirlos | Decidido en la spec: fuera del análisis; el título solo como etiqueta en T2 (DQ-13) | Ninguna PN los necesita | Spec §12 |
| ¿Con qué zona horaria se convierten las fechas? | UTC; hora local | Decidido en la spec: UTC siempre (DQ-14) | Regla única y reproducible | Spec §12 |
| ¿Qué es «calificación baja» en PN06? | Promedio ≤ 2,5; otro corte | Decidido en la spec: promedio ≤ 2,5 (DQ-18, U-00-10) | Debajo del punto medio de la escala 1–5 | Spec §12 |
| ¿Qué falta y se difiere? | — | Umbral de volumen de PN05 y PN06 (DQ-11), corte del grupo más activo de PN09 (DQ-17), lista de campos y significado de «anónima» (DQ-12), regla de cero votos totales (spec §6.4) | Necesitan datos reales | Spec §12 y §13 |

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
│   ├── validacion.md          # evidencia de CE-00-01 a CE-00-04 y firma del responsable de Oro (D-00-06)
│   └── legibilidad.md         # lectura en frío firmada (RNF-00-01, CE-00-05, Const. XIII.7)
├── adr/                       # solo si D-00-01 a D-00-07 se convierten en ADR
└── task.md                    # lo genera /tasks, no este plan (ADR-0006, falta firma)

docs/
└── glosario.md                # nuevo: primeras entradas (RNF-00-02, Const. XIII.6)

tests/
└── test_catalogo_preguntas.py # solo si se aprueba D-00-03
```

**Decisión de estructura**: no se crean `src/<capa>/`, `contracts/` ni `data-model.md` porque no hay scripts, capas ni tablas (D-00-05).

### 7.2 Flujo de trabajo (pasos manuales numerados)

| Orden | Paso | Qué hace (una frase) | Entradas | Salidas | Requisito | Repetible |
|---|---|---|---|---|---|---|
| — | `/clarify` (hecho 2026-10-14 y 2026-10-15) | Cerró DQ-01 a DQ-21 salvo las diferidas (DQ-11, DQ-12, DQ-17) y agregó los requisitos de legibilidad | `spec.md` | `spec.md` del 2026-10-15 | RNF-00-01 a RNF-00-04, CE-00-05 | Sí |
| 01 | Aplicar §5.4 en la spec | La persona responsable aplica los cambios pendientes de §5.4 (4, 6, 7, 9 y el origen de la variante de compuerta del cambio 5); los cambios 1, 2, 3, 5, 8 y 10 ya se aplicaron el 2026-10-15 | `spec.md`, este plan | `spec.md` ajustada; después se regenera este plan | RF-00-06 | Sí |
| 02 | `/analyze` | Revisa spec, plan y constitución; se resuelven los hallazgos críticos | `spec.md`, `plan.md`, Constitución | Informe de `/analyze` | Todos | Sí |
| 03 | Firmas previas | Firmar ADR-0006 y ADR-0007; decidir D-00-01 a D-00-06 (D-00-07 ya decidida por DQ-21) | ADR, §5.2 | ADR firmados; §5.2 con estado | Const. X | Sí |
| 04 | `/tasks` | Regenera `task.md` desde este plan, con tarea final de legibilidad | `plan.md` | `task.md` | Const. X, XIII | Sí |
| 05 | `/implement` | Produce glosario, `research.md`, matriz, `quickstart.md`, `checklists/validacion.md` y, si D-00-03, el validador | `task.md` | Documentos | RF-00-01 a RF-00-08, RNF-00-02 a RNF-00-04 | Sí |
| 06 | Validación de las PN | El responsable y el segundo validador aprueban cada PN en la spec §11 | Spec §3, §5, §11, matriz | Spec §11 con nombre, fecha y estado | RF-00-07, CE-00-03 | Sí |
| 07 | Firma del insumo de Oro | El responsable de Oro firma la spec §6.1 y §6.2 | Spec §6 | `checklists/validacion.md` firmado | CE-00-04 | Sí |
| 08 | Lectura en frío | La otra persona del equipo lee la muestra y responde las cinco preguntas | Muestra de §9 | `checklists/legibilidad.md` | RNF-00-01, CE-00-05 | Sí |
| 09 | Verificación humana y cierre | La persona responsable ejecuta `V-00-01` a `V-00-10`, recorre la compuerta (§14) y abre el Pull Request | Todo lo anterior | Pull Request a `main` | Compuerta | Sí |

**Reproducibilidad**: partiendo de `spec.md` y de `quickstart.md`, otra persona obtiene la misma matriz (12 filas) con las mismas marcas de viabilidad, tablero, corte por mes y conteo de usuarios.
**Estado de la especificación**: abierta → plan aprobado → tareas generadas → implementada → cerrada. «Cerrada» se observa en el Pull Request integrado a `main`; la spec 01 no empieza hasta entonces (Principio XII).

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
| `solo_agregada` | `sí` si la pregunta trata de usuarios y se responde solo de forma agregada | Sí | RF-00-03 |
| `tablero` | T1, T2 o T3 | Sí | Spec §7 |
| `corte_por_mes` | `sí` si se muestra por mes; entonces lleva la marca «mes parcial» en 2010-03 y 2013-03 | Sí | RF-00-05, DQ-19 |
| `cuenta_usuarios` | `sí` si cuenta usuarios distintos; entonces excluye reseñas anónimas y las informa aparte | Sí | RF-00-08, DQ-04, DQ-15 |
| `calculo_en_spec` | Referencia a la fila de la spec §6.2 (no se copia el cálculo, D-00-05) | Sí | Spec §6.2 |
| `decisiones_diferidas` | DQ abiertas que la afectan (DQ-11, DQ-12, DQ-17) | Condicional | Spec §12 |
| `especificaciones_destino` | Specs que la atienden: 01, 02, 03, 04, 05 | Sí | Spec §13 |
| `criterio_de_aceptacion` | Cómo se sabrá que la pregunta quedó respondida en el tablero | Sí | Spec §7 y §10 |

**`checklists/validacion.md`** — evidencia de CE-00-01 a CE-00-04 (D-00-06):

| Parte | Contenido | Requisito |
|---|---|---|
| Revisión por pregunta | Una fila por PN con sí/no para: ID, decisión y prioridad (RF-00-01); campos disponibles (RF-00-02); no identifica personas (RF-00-03); tablero asignado (RF-00-04); estado en la spec §11 (RF-00-07) | CE-00-01 |
| Conteo por tablero | Número de PN en T1, T2 y T3 frente a U-00-02 y U-00-03 | CE-00-02 |
| Preguntas D | Las siete PN de prioridad D (PN01, PN02, PN03, PN04, PN05, PN07, PN11) con su estado en la spec §11 | CE-00-03 |
| Revisión de §6.2 | Cada fila nombra medida, cortes y nivel de detalle con nombres completos | RNF-00-03 |
| Firma del insumo de Oro | Nombre y fecha del responsable de Oro sobre la spec §6.1 y §6.2 | CE-00-04 |

Reglas: las columnas salen solo de la spec; no se copian dimensiones, nombres de tablas de Oro ni requerimientos del modelo anterior.

### 7.4 a 7.9

| Sección de la plantilla | Estado |
|---|---|
| 7.4 Catálogo de reglas del EDA | No aplica: esta spec no crea ni aplica reglas. Los traspasos a la spec 02 están abajo |
| 7.5 Cuadre de filas y linaje | No aplica: no hay filas. Se deja el **linaje de requisitos**: cada PN apunta a las especificaciones que la atenderán (columna `especificaciones_destino`) |
| 7.6 Bitácora de calidad | No aplica: la define la spec 03 (ADR-0009) |
| 7.7 Seguridad del dato | Los documentos no contienen datos ni credenciales; `userId` y `profileName` aparecen solo como nombres de campos. PN09, PN10 y PN11 se responden solo de forma agregada (RF-00-03, spec §8). El dataset no se cruza con otras fuentes |
| 7.8 Rendimiento y volumen | No aplica |
| 7.9 Exportación a Parquet | No aplica |

**Traspasos explícitos hacia otras especificaciones** (alineados con la spec §13, «Qué heredan las siguientes especificaciones»):

| Traspaso | Destino | Qué debe confirmar o decidir |
|---|---|---|
| Los diez campos de la spec §3, su nombre exacto en el archivo y que el título llega | Spec 01 | Confirmar contra los datos (DQ-12, DQ-13) |
| Cómo aparece una reseña anónima (campo ausente o valor repetido) | Specs 01 y 02 | Regla del EDA con acción y conteo en la bitácora (DQ-04, DQ-12, DQ-15) |
| Exclusión de anónimas en PN02, PN09 y PN10 e informe aparte de cuántas (PN11) | Specs 02 y 04 | Regla y medida que lo informe (RF-00-08) |
| Reseñas con cero votos totales en la razón de utilidad | Spec 02 | Regla explícita (spec §6.4, DQ-02) |
| Meses parciales 2010-03 y 2013-03 | Specs 02, 04 y 05 | Regla en 02; indicador de mes parcial en la dimensión de fecha en 04; marca visible en T1 y T3 en 05 (RF-00-05, DQ-03, DQ-19) |
| Umbral de volumen mínimo de PN05 y PN06 | Spec 02 | Fijarlo con datos (DQ-11, U-00-11) |
| Corte del grupo más activo de PN09 | Spec 02 | Fijarlo con la distribución real (DQ-17, U-00-12) |
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
| C-00-05 | La matriz de trazabilidad DEBE marcar `cuenta_usuarios = sí` en PN02, PN09 y PN10, con la exclusión de reseñas anónimas y el informe aparte de cuántas se excluyen. | RF-00-08 | `V-00-06` |
| C-00-06 | La matriz de trazabilidad DEBE indicar, en cada fila, las especificaciones que atienden la pregunta. | RF-00-06, CE-00-04 | `V-00-02` |
| C-00-07 | El glosario `docs/glosario.md` DEBE definir cada término de dominio y cada sigla usados en `spec.md`, en este plan y en los documentos nuevos, con un solo nombre por concepto (U-00-06). | RNF-00-02 | `V-00-10` |
| C-00-08 | Cada documento nuevo de la especificación DEBE abrir con un encabezado de propósito, autor, fecha, dependencias e IDs de requisitos que atiende (U-00-07). | RNF-00-04 | `V-00-10` |
| C-00-09 | Retirado el 2026-10-15: la revisión de tecnología en la spec ya se hizo (§5.4, S-00-03) y ningún requisito de la spec la pide. | — | — |
| C-00-10 | DONDE el responsable apruebe D-00-03, la prueba `tests/test_catalogo_preguntas.py` DEBE comprobar que los IDs `PNnn` de la spec son únicos y que cada uno tiene fila en la matriz y estado en la spec §11. | RF-00-01, RF-00-07 | `pytest tests/` |
| C-00-11 | CUANDO termine la lectura en frío, el checklist `checklists/legibilidad.md` DEBE registrar, por cada artefacto leído, las respuestas a las cinco preguntas estándar, el nombre de quien leyó y la fecha. | RNF-00-01, CE-00-05 | Checklist firmado |
| C-00-12 | El documento `research.md` DEBE registrar, para cada una de las doce PN, si su respuesta identifica a una persona o se entrega solo de forma agregada. | RF-00-03 | `V-00-04` |
| C-00-13 | SI una PN pretende identificar a una persona, ENTONCES la lista de validación `checklists/validacion.md` DEBE marcarla «descartar» e impedir su paso a «Validada». | RF-00-03 | `V-00-04` |
| C-00-14 | La matriz de trazabilidad DEBE asignar a cada PN exactamente un tablero (T1, T2 o T3), igual al de la spec §7. | RF-00-04 | `V-00-05` |
| C-00-15 | La lista de validación DEBE registrar el número de PN de cada tablero frente a U-00-02 y U-00-03. | CE-00-02 | `V-00-05` |
| C-00-16 | La matriz de trazabilidad DEBE marcar `corte_por_mes = sí` exactamente en PN01, PN02, PN03, PN04, PN07 y PN11, con la consigna de mostrar 2010-03 y 2013-03 como «mes parcial» sin excluirlos ni normalizarlos. | RF-00-05 | `V-00-06` |
| C-00-17 | SI el encabezado de `plan.md` o de `task.md` declara una fecha de spec anterior a la «Última actualización» de `spec.md`, ENTONCES la persona responsable DEBE regenerar ese archivo antes de `/implement`. | RF-00-06 | `V-00-07` |
| C-00-18 | CUANDO el responsable y el segundo validador aprueben una PN, la tabla de la spec §11 DEBE registrar el nombre de quien aprueba, la fecha y el estado «Validada». | RF-00-07, CE-00-03 | `V-00-08` |
| C-00-19 | SI una PN de prioridad D no puede pasar a «Validada», ENTONCES la persona responsable DEBE registrar en la spec §12 la reapertura de esa pregunta (RF-00-06) antes del cierre. | CE-00-03 | `V-00-08` |
| C-00-20 | La lista de validación DEBE registrar, para cada una de las doce PN, el cumplimiento de RF-00-01, RF-00-02, RF-00-03 y RF-00-04 (U-00-05). | CE-00-01 | `V-00-09` |
| C-00-21 | CUANDO se prepare el cierre de la spec 00, la lista de validación DEBE contener el nombre y la fecha del responsable de Oro como firma de la spec §6.1 y §6.2. | CE-00-04 | `V-00-09` |
| C-00-22 | SI el responsable de Oro pide cambios a la spec §6.1 o §6.2, ENTONCES la persona responsable DEBE actualizar primero `spec.md` y volver a pedir la firma. | CE-00-04 | `V-00-09` |
| C-00-23 | La lista de validación DEBE registrar, para cada fila de la spec §6.2, si nombra medida, cortes y nivel de detalle con nombres completos y sin abreviaturas. | RNF-00-03 | `V-00-09` |
| C-00-24 | SI quien lee en frío no responde correctamente alguna de las cinco preguntas estándar, ENTONCES el autor DEBE corregir el artefacto y repetir la lectura antes del cierre. | RNF-00-01, CE-00-05 | Checklist firmado |
| C-00-25 | SI al preparar el cierre una PN marcada «no viable con esta fuente» no tiene decisión registrada en la spec §12, ENTONCES la persona responsable DEBE mantener abierta la spec 00. | RF-00-02 | `V-00-03` |
| C-00-26 | SI una PN cambió en `spec.md` y la matriz de trazabilidad no cambió en el mismo commit, ENTONCES la persona responsable DEBE retener la integración del Pull Request hasta alinearlas. | RF-00-06 | `V-00-01` |

Pares de flujo y error: C-00-02 ↔ C-00-26; C-00-11 ↔ C-00-24; C-00-18 ↔ C-00-19; C-00-21 ↔ C-00-22.

---

## 9. Verificación de legibilidad — Principio XIII (siempre)

| Regla | Qué artefactos de esta spec alcanza | Cómo se comprueba | Herramienta | Umbral | Responsable |
|---|---|---|---|---|---|
| XIII.1 SQL | Ninguno | No aplica: sin SQL | — | — | — |
| XIII.2 DDL | Ninguno | No aplica: sin DDL | — | — | — |
| XIII.3 Pruebas | Solo `tests/test_catalogo_preguntas.py`, si se aprueba D-00-03 | Docstring, nombre descriptivo, mensajes en cada aserción, constantes con nombre | Revisión manual (`[POR DEFINIR: ADR-0012]` para automatizar) | 100 % de las funciones de prueba | Dario Andres Bernate Canas |
| XIII.4 General | `research.md`, `matriz-trazabilidad.md`, `quickstart.md`, `checklists/validacion.md`, `checklists/legibilidad.md`, `docs/glosario.md` | Encabezado presente; español; nombres completos | Inspección con esta tabla (`V-00-10`) | U-00-07 = 0 documentos sin encabezado | Dario Andres Bernate Canas |
| XIII.5 Trazabilidad | Los mismos documentos y este plan | Todo documento cita IDs que existen en la spec | Inspección (`V-00-10`) | 0 documentos sin ID; 0 IDs inexistentes | Dario Andres Bernate Canas |
| XIII.6 Glosario | `spec.md`, este plan y los documentos nuevos | Todo término y sigla está en `docs/glosario.md`, con un solo nombre por concepto | Inspección (`V-00-10`) | U-00-06 = 0 términos o siglas sin definir | Dario Andres Bernate Canas |
| XIII.7 Lectura en frío | Muestra (artefactos de tipo documento, única capa tocada: ninguna): la matriz, el glosario y al menos tres PN de la spec, una de ellas PN09 o PN10 | Las cinco preguntas estándar | `checklists/legibilidad.md` | U-00-08 = cinco de cinco sin consultar al autor; tiempo U-00-09 `[POR DEFINIR: ADR-0012]` | Jose Julio Gomez Palmera (persona distinta del autor, S-00-04) |

**Las cinco preguntas aplicadas a una PN**: (1) ¿Qué pregunta de negocio plantea? (2) ¿Qué campos de la fuente entran y qué respuesta debe salir? (3) ¿Qué requisito o decisión atiende? (4) ¿Por qué se pide cada medida, corte y condición de tiempo? (5) ¿Cómo se sabrá que está bien respondida y en qué especificación?

---

## 10. Estrategia de verificación (siempre)

### 10.1 Pruebas automatizadas (en `tests/`)

| Archivo | Qué comprueba | Requisito | Valor esperado |
|---|---|---|---|
| `tests/test_catalogo_preguntas.py` (solo si D-00-03) | IDs `PNnn` únicos; cada PN con fila en la matriz y estado en la spec §11 | RF-00-01, RF-00-07 (C-00-10) | U-00-01 filas; 0 IDs repetidos |

El valor de referencia sale de otra ruta: se cuentan las PN de la spec §5 y se comparan con las filas de la matriz; nunca se recalcula con el mismo documento que se prueba. Si D-00-03 no se aprueba, no hay pruebas nuevas y la condición 1 de la compuerta se registra como «sin pruebas en esta spec».

### 10.2 Verificación humana (Principio XI)

No hay tablas para consultar con SQL (D-00-01). La persona responsable ejecuta estas verificaciones sobre los documentos:

| ID | Qué verifica | Sobre qué objeto | Resultado esperado |
|---|---|---|---|
| V-00-01 | Conteo de PN y alineación por commit | Spec §5 frente a `matriz-trazabilidad.md`; historial del Pull Request | U-00-01 filas en ambos; 0 IDs repetidos; todo cambio de PN acompañado del cambio en la matriz |
| V-00-02 | Campos y destinos | Matriz frente a la spec §3 y §11 | 0 filas cuyos campos difieran de la spec §11; 0 filas sin especificaciones destino |
| V-00-03 | Preguntas no viables | Matriz y spec §12 | Cada fila «no viable» tiene el dato que falta y una decisión en la spec §12 |
| V-00-04 | Identificación de personas | `research.md` y lista de validación | 12 de 12 PN revisadas; 0 PN que identifiquen a una persona sin marca «descartar» |
| V-00-05 | Tableros | Matriz, spec §7 y lista de validación | 12 de 12 PN con un tablero igual al de la spec; T1 y T3 con al menos U-00-02, T2 con al menos U-00-03 |
| V-00-06 | Marcas de mes parcial y de conteo de usuarios | Matriz | `corte_por_mes = sí` exactamente en PN01, PN02, PN03, PN04, PN07, PN11; `cuenta_usuarios = sí` exactamente en PN02, PN09, PN10 |
| V-00-07 | Versión de la spec usada | Encabezados de `plan.md` y `task.md` frente a la spec | Ambos declaran la «Última actualización» vigente de la spec |
| V-00-08 | Validación de las PN | Spec §11 | U-00-04: siete de siete PN de prioridad D en «Validada», con nombre y fecha |
| V-00-09 | Lista de validación completa | `checklists/validacion.md` | U-00-05 de cumplimiento de RF-00-01 a RF-00-04; §6.2 revisada; firma del responsable de Oro con fecha |
| V-00-10 | Glosario y encabezados | Documentos de la spec y `docs/glosario.md` | U-00-06 y U-00-07 en cero |

---

## 11. Trazabilidad (siempre)

| Requisito | Componente (plan) | Tarea (`task.md`) | Prueba o consulta | Evidencia (archivo o commit) |
|---|---|---|---|---|
| RF-00-01 | C-00-01, C-00-10 | T-00-__ | `V-00-01`; prueba si D-00-03 | `matriz-trazabilidad.md` |
| RF-00-02 | C-00-03, C-00-04, C-00-25 | T-00-__ | `V-00-02`, `V-00-03` | `matriz-trazabilidad.md`, `research.md` |
| RF-00-03 | C-00-12, C-00-13 | T-00-__ | `V-00-04` | `research.md`, `checklists/validacion.md` |
| RF-00-04 | C-00-14 | T-00-__ | `V-00-05` | `matriz-trazabilidad.md` |
| RF-00-05 | C-00-16 | T-00-__ | `V-00-06` | `matriz-trazabilidad.md` |
| RF-00-06 | C-00-02, C-00-06, C-00-17, C-00-26 | T-00-__ | `V-00-01`, `V-00-07` | Historial del Pull Request; encabezados |
| RF-00-07 | C-00-18, C-00-10 | T-00-__ | `V-00-08`; prueba si D-00-03 | Spec §11 |
| RF-00-08 | C-00-05 | T-00-__ | `V-00-06` | `matriz-trazabilidad.md` |
| RNF-00-01 | C-00-11, C-00-24 | T-00-__ | Checklist firmado | `checklists/legibilidad.md` |
| RNF-00-02 | C-00-07 | T-00-__ | `V-00-10` | `docs/glosario.md` |
| RNF-00-03 | C-00-23 | T-00-__ | `V-00-09` | `checklists/validacion.md` |
| RNF-00-04 | C-00-08 | T-00-__ | `V-00-10` | Documentos de la spec |
| CE-00-01 | C-00-20 | T-00-__ | `V-00-09` | `checklists/validacion.md` |
| CE-00-02 | C-00-15 | T-00-__ | `V-00-05` | `checklists/validacion.md` |
| CE-00-03 | C-00-18, C-00-19 | T-00-__ | `V-00-08` | Spec §11 |
| CE-00-04 | C-00-21, C-00-22, C-00-06 | T-00-__ | `V-00-09` | `checklists/validacion.md` |
| CE-00-05 | C-00-11, C-00-24 | T-00-__ | Checklist firmado | `checklists/legibilidad.md` |

**Cobertura calculada**: la spec tiene 17 requisitos (8 RF, 4 RNF, 5 CE); 17 de 17 tienen al menos un componente y una prueba o verificación. 0 de 17 tienen tarea: el `task.md` actual es un borrador generado sobre la versión anterior de este plan y debe regenerarse con `/tasks` (RF-00-06, D-00-02). Componentes: 25 vigentes y 1 retirado (C-00-09); los 25 citan al menos un requisito.

---

## 12. Riesgos y mitigaciones

| Riesgo | Probabilidad | Impacto | Mitigación | Quién la vigila |
|---|---|---|---|---|
| Los cambios pendientes de §5.4 no se aplican y `/analyze` marca requisitos con más de una respuesta | Media | Alto | Paso 01 de §7.2 antes de `/analyze`; los cambios de formato ya se aplicaron (DQ-21) y quedan los de redacción | Dario Andres Bernate Canas |
| El `task.md` borrador se usa en `/implement` sin regenerarse y cita componentes que cambiaron | Media | Alto | C-00-17 y `V-00-07` | Dario Andres Bernate Canas |
| La matriz y la spec divergen (dos fuentes de verdad) | Media | Medio | La matriz cita la spec §6.2 en lugar de copiarla (D-00-05); C-00-02 y C-00-26 | Dario Andres Bernate Canas |
| Un mismo concepto recibe varios nombres en documentos nuevos (la spec ya fijó «usuario», DQ-20) | Media | Medio | Glosario con «usuario» como único término (C-00-07); `V-00-10` | Jose Julio Gomez Palmera (lectura en frío) |
| Se pierde un traspaso (anónimas, cero votos, meses parciales, DQ-11, DQ-17) | Media | Alto | Tabla «Traspasos explícitos»; cada spec destino los copia en su §5 | Dario Andres Bernate Canas |
| `AGENTS.md` y `README.md` remiten a un número de principio que la constitución v1.1.0 no define | Alta | Bajo | Corregirlo fuera de esta spec por Pull Request; este plan solo cita los principios I–XIII | Dario Andres Bernate Canas |
| Una PN hereda un requerimiento del modelo anterior | Baja | Alto | Cada PN declara su decisión de negocio (spec §5); la constitución lo prohíbe | Dario Andres Bernate Canas |
| La spec 00 se da por cerrada sin una compuerta aplicable a una spec sin datos | Media | Medio | D-00-01 firmada antes de `/tasks`; §5.4 cambio 5 (origen de la variante) | Dario Andres Bernate Canas |

---

## 13. Seguimiento de complejidad

No hay filas en ❌. Las advertencias del Constitution Check (X, XI, XII, XIII.4, XIII.5, XIII.6, XIII.7) no son incumplimientos que justificar con excepción: se cierran con las firmas de ADR-0006 y ADR-0007, la decisión D-00-01, los cambios pendientes de §5.4, el glosario (C-00-07) y la evidencia de `/implement` y de la lectura en frío. Si D-00-01 no se aprueba, la condición 3 de la compuerta quedaría sin forma de cumplirse y haría falta un ADR de excepción con fecha de revisión.

| Incumplimiento | Por qué es necesario | Alternativa más simple descartada porque | ADR | Fecha de revisión |
|---|---|---|---|---|
| Ninguno | — | — | — | — |

---

## 14. Compuerta de cierre de la especificación (siempre)

| # | Condición | Cómo se comprueba en esta spec | Estado |
|---|---|---|---|
| 1 | Tests en verde (variante de la spec §13) | CE-00-01 a CE-00-04 cumplidos y spec §11 firmada (`V-00-05`, `V-00-08`, `V-00-09`); además `pytest tests/` sin fallos si se aprueba D-00-03 | Pendiente |
| 2 | Cuadre exacto | No aplica: no hay filas (D-00-01) | — |
| 3 | Verificación humana | Sustituida por `V-00-01` a `V-00-10` ejecutadas por la persona responsable (D-00-01) | Pendiente |
| 4 | README de la capa actualizado | No aplica: no hay capa. Se verifica que `docs/glosario.md` y los documentos de la spec estén al día (D-00-01) | Pendiente |
| 5 | Checklist de legibilidad firmado | `checklists/legibilidad.md` tras la lectura en frío (CE-00-05, Const. XIII.7) | Pendiente |
| 6 | Pull Request integrado a `main` | Rama `00-preguntas-negocio` | Pendiente |

Las seis condiciones coinciden con la spec §13 (actualizada por DQ-21). El origen de la variante de las condiciones 1 y 2 queda sujeto a D-00-01 (§5.4, cambio 5).

---

## 15. Glosario y umbrales (siempre)

### 15.1 Términos de esta especificación

Términos para sembrar `docs/glosario.md` (C-00-07). El ID de glosario se asigna al crearlo.

| Término | Definición |
|---|---|
| DWS | Data Warehouse (almacén de datos) de reseñas de Amazon de este proyecto |
| SNAP | Stanford Network Analysis Project, origen público del dataset (McAuley y Leskovec, 2013) |
| Pregunta de negocio (PN) | Pregunta que la persona analista necesita responder con los datos de reseñas; ID `PNnn` |
| Prioridad D, S, P | D: debe estar en la primera entrega; S: debería; P: podría si hay tiempo |
| DQ | Pregunta abierta o decisión registrada en la spec §12 |
| RF, RNF, CE | Requisito funcional, requisito no funcional y criterio de éxito de una especificación |
| ADR | Registro de una decisión de arquitectura, firmado por el responsable |
| EDA | Análisis exploratorio de datos (spec 02); de él nacen las reglas `Rnn` |
| EARS | Forma de redactar requisitos en una oración con patrón fijo (§2) |
| UTC | Tiempo universal coordinado; zona con la que se convierten las fechas (DQ-14) |
| Medida | Valor que se calcula o agrega para responder una pregunta (un conteo, un promedio) |
| Corte | Punto de vista por el que se agrupa una medida (mes, producto, calificación) |
| Nivel de detalle mínimo | Unidad más pequeña que exigen las preguntas: una reseña (spec §6.1); insumo del grano |
| Grano | Qué representa una fila de un hecho, dicho en una frase (lo declara la spec 04) |
| Campo de la fuente | Cada uno de los diez campos de la spec §3 |
| Reseña anónima | Reseña sin usuario identificable; la forma exacta de reconocerla `[POR DEFINIR en las specs 01 y 02, DQ-12]` |
| Usuario | Persona seudónima que escribe reseñas (campo `userId`); término único fijado por la spec DQ-20. No se usan «reseñador» ni «cliente» en ese sentido; «cliente» solo aparece en el rol «analista de experiencia del cliente» |
| Mes parcial | Primer (2010-03) o último (2013-03) mes de la ventana, que no tiene todos sus días; se muestra marcado (RF-00-05) |
| Voto útil / razón de utilidad | Voto que marca una reseña como útil; la razón es suma de votos útiles ÷ suma de votos totales (DQ-02) |
| Calificación baja | Calificación promedio de un producto ≤ 2,5 (DQ-18, U-00-10) |
| Tablero T1, T2, T3 | Panorama de reseñas, Productos, y Usuarios y utilidad (spec §7) |
| Estados de una PN | Propuesta → Validada → Confirmada con datos (spec §11) |
| Viabilidad | Si la fuente puede responder una pregunta: `viable`, `viable con reserva` o `no viable con esta fuente` |
| Matriz de trazabilidad | Documento con una fila por PN que la une con sus campos, su tablero y las especificaciones que la atienden |
| Lista de validación | Documento `checklists/validacion.md` con la evidencia de CE-00-01 a CE-00-04 |
| Perfil junior | Persona que conoce SQL básico y Python básico, pero no el repositorio ni el dataset (Const. XIII) |
| Lectura en frío | Revisión por una persona distinta del autor, que responde las cinco preguntas estándar sin consultarlo |
| Capa (Bronce, Plata, Oro) | Cada etapa del modelo Medallion: `raw`, `silver`, `gold` |
| Regla del EDA (`Rnn`) | Hallazgo del EDA convertido en regla con acción (descarta, corrige o marca) y conteo en la bitácora |

### 15.2 Umbrales con nombre

| ID | Nombre | Valor | Fuente de la decisión |
|---|---|---|---|
| U-00-01 | Número de preguntas del catálogo | 12 | Spec §5 |
| U-00-02 | Mínimo de preguntas por tablero (T1 y T3) | 3 | CE-00-02 |
| U-00-03 | Mínimo de preguntas en T2 | 2 | CE-00-02 |
| U-00-04 | PN de prioridad D en «Validada» al cierre | 100 % (7 de 7) | CE-00-03 |
| U-00-05 | PN que cumplen RF-00-01 a RF-00-04 | 100 % | CE-00-01 |
| U-00-06 | Términos o siglas sin definir en el glosario | 0 | RNF-00-02, Const. XIII.6 |
| U-00-07 | Documentos nuevos sin encabezado o sin IDs | 0 | RNF-00-04, Const. XIII.4 y XIII.5 |
| U-00-08 | Preguntas estándar respondidas correctamente en la lectura en frío | 5 de 5, sin consultar al autor | CE-00-05, Const. XIII.7 (criterio provisional) |
| U-00-09 | Tiempo máximo de la lectura en frío | `[POR DEFINIR: ADR-0012]` | Pendiente |
| U-00-10 | Calificación baja de PN06 | Promedio ≤ 2,5 | Spec DQ-18 |
| U-00-11 | Volumen mínimo de reseñas en los rankings de PN05 y PN06 | `[POR DEFINIR: spec 02, DQ-11]` | Diferido |
| U-00-12 | Corte del grupo más activo de PN09 | `[POR DEFINIR: spec 02, DQ-17]` | Diferido |
| U-00-13 | Diferencia de cuadre admitida | No aplica: no hay filas | Constitución, Principio VI |

---

## 16. Historial de cambios del plan

| Fecha | Cambio | Motivo | Autor |
|---|---|---|---|
| 2026-10-14 | Versión inicial (borrador sin `spec.md`) | Primer plan de la especificación 00 | Claude (skill `/plan`) |
| 2026-10-15 | Reconciliación con la spec del 2026-10-15: se quitan el aviso de borrador sin reconciliar, los marcadores de spec pendiente y los IDs con guion bajo; se citan RF-00-01 a RF-00-08, RNF-00-01 a RNF-00-04, CE-00-01 a CE-00-05, PN01 a PN12 y DQ-01 a DQ-19; cobertura 17 de 17 con componentes C-00-12 a C-00-26 (C-00-09 retirado); nueva lista de validación (D-00-06) y decisión de formato de IDs (D-00-07); §5.4 marca como hechos los requisitos de legibilidad (DQ-16) y registra diez cambios pendientes; Fase 0 recoge DQ-13, DQ-14, DQ-17, DQ-18 y DQ-19; traspasos alineados con la spec §13; umbrales U-00-01 a U-00-13 | `/clarify` cambió la spec el 2026-10-15; RF-00-06 exige declarar la versión de la spec usada | Claude (skill `/plan`, agente `architect`) |
| 2026-10-15 | Segunda pasada tras DQ-20 y DQ-21 de la spec: todas las citas pasan a RF-00-01..RF-00-08, RNF-00-01..RNF-00-04 y CE-00-01..CE-00-05; D-00-07 queda decidida (DQ-21); «usuario» como término único en el glosario (DQ-20); D-00-01 y la condición 1 de §14 se alinean con la compuerta de seis condiciones de la spec §13; Constitution Check: XIII.4 y XIII.7 pasan a ⚠️ por falta de evidencia (hallazgo de `/analyze`), XII y XIII.5 se reescriben; §5.4 marca hechos los cambios 1, 2, 3, 5, 8 y 10 y deja pendientes 4 (ahora incluye RF-00-08), 6, 7, 9 y el origen de la variante de compuerta | La spec cambió después del plan y de `/analyze`; RF-00-06 exige declarar la versión de la spec usada | Claude (skill `/plan`, agente `architect`) |

---

## Lista de revisión antes de entregar el plan

- [x] Cada componente tiene un sujeto con nombre, un solo `DEBE`, una sola respuesta y un ID.
- [x] Ningún valor numérico queda fuera de la tabla de umbrales; ningún adjetivo vago.
- [x] Cada `CUANDO` de un flujo tiene su `SI … ENTONCES` de error (pares en §8).
- [x] Cada requisito de la spec tiene al menos un componente (17 de 17); cada componente vigente cita su requisito.
- [x] El Constitution Check lista los trece principios y las siete reglas XIII.n, sin filas vacías.
- [x] La sección 9 existe y cada regla XIII.n que aplica tiene método, umbral y responsable.
- [x] Los pendientes ADR 0006–0012 que afectan a la spec están en §5.1, sin resolverlos.
- [x] El plan no contiene código ni sentencias SQL y no reutiliza dimensiones ni nombres del modelo anterior.
- [ ] Una persona junior que lea solo este plan y el glosario puede decir qué se va a construir y cómo se comprueba: pendiente de la lectura en frío (C-00-11).
