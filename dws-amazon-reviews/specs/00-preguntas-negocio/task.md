# Tareas 00 — Preguntas de negocio

**Propósito:** desglosar el `plan.md` de la spec 00 en trabajo verificable para validar el catálogo de preguntas de negocio y dejar su trazabilidad · **Autor:** skill `tasks` (Claude) · **Fecha:** 2026-10-14
**Plan:** `specs/00-preguntas-negocio/plan.md` · **Spec:** `specs/00-preguntas-negocio/spec.md` · **Rama:** `00-preguntas-negocio` · **Constitución:** v1.1.0
**Responsable:** Dario Andres Bernate Canas · **Segundo validador:** Dario Andres Bernate Canas (DQ-10; `docs/gestion/roles.md`)
**Depende de:** ninguna spec anterior (es la primera) · ADR-0006 y ADR-0007 firmados (T-00-01 y T-00-02)
**Requisitos que cubre:** RF-01 … RF-08 y CE-01 … CE-04 de la spec · los cinco requisitos de legibilidad de plan §5.4 · componentes C-00-01 … C-00-11
**Estado:** borrador · **Basada en:** `spec.md` (2026-10-13, en revisión, con aclaraciones de `/clarify` del 2026-10-14) · `plan.md` (2026-10-14, borrador sin reconciliar con la spec)

**Advertencias de este borrador**

1. ADR-0006 y ADR-0007 están decididos pero sin firma, y la spec (DQ-06) pide firmarlos antes de `/tasks`. Este archivo es borrador hasta cerrar T-00-01 y T-00-02.
2. `plan.md` dice ser un borrador escrito sin leer la spec: usa `[SPEC]` y `RF-00-__`. La Fase 1 lo reconcilia; después se vuelve a correr `/tasks`, que conserva los IDs de este archivo.
3. La spec escribe los IDs como `RF-01` y `CE-01`; la plantilla del plan y la constitución piden `RF-00-01`. Aquí se citan tal como existen en la spec, sin renumerar (Const. XIII.5). El formato se decide en T-00-07.
4. 8 de los 12 requisitos de la spec no tienen componente en el plan. Las tareas que los cubren llevan la marca `[PLAN: sin componente]` hasta que T-00-08 los agregue.

Estados: `[ ]` pendiente · `[x]` hecha · `[P]` se puede hacer a la vez que otra tarea de su ola, sin compartir archivo. ID: `T-00-MM`. Esta spec no tiene código ni datos: las tareas son documentales y de validación.

## Fase 1 — Desbloqueo y reconciliación de spec y plan

Objetivo: dejar firmadas las decisiones que bloquean `/tasks` y alinear `spec.md` con `plan.md` antes de producir documentos (Principio XII). Entregable: ADR-0006 y ADR-0007 firmados, D-00-01 a D-00-05 decididas, `plan.md` sin marcadores `[SPEC]` ni IDs con guion bajo, informe de `/analyze` sin Críticos ni Altos.

| ID | Estado | Tarea | Archivo | Responsable | Depende de | Min | Cubre | Hecho cuando | Evidencia |
|---|---|---|---|---|---|---|---|---|---|
| T-00-01 | [ ] [P] | Firmar el ADR-0006 (nombre del archivo de tareas: `task.md`) | `memory/adr/0006-nombre-del-archivo-de-tareas.md` | Dario Andres Bernate Canas | ninguna | 30 | DQ-07 · plan 5.1 · Const. X | el campo «Responsable (firma)» trae nombre y fecha y el «Estado» ya no dice «falta su firma» | |
| T-00-02 | [ ] [P] | Firmar el ADR-0007 (ubicación de `memory/` e `instructions`) | `memory/adr/0007-ubicacion-de-memory-y-lectura-por-agentes.md` | Dario Andres Bernate Canas | ninguna | 30 | DQ-08 · plan 5.1 · Const. X | el campo «Responsable (firma)» trae nombre y fecha y el «Estado» ya no dice «falta su firma» | |
| T-00-03 | [ ] | Actualizar el estado de ADR-0006 y ADR-0007 en el índice de decisiones | `memory/adr/README.md` | Dario Andres Bernate Canas | T-00-01, T-00-02 | 30 | plan 5.1 · Const. X | las filas 0006 y 0007 del índice ya no dicen «falta firma» y muestran la fecha de firma | |
| T-00-04 | [ ] [P] | Firmar D-00-01 (compuerta de cierre adaptada a una spec sin datos) | `specs/00-preguntas-negocio/plan.md` | Dario Andres Bernate Canas | ninguna | 30 | D-00-01 · plan 5.2, 13 · Const. XI | la fila D-00-01 de plan §5.2 dice «firmada» con nombre y fecha; si se rechaza, existe el ADR de excepción en `specs/00-preguntas-negocio/adr/` (plan §13) | |
| T-00-05 | [ ] | Decidir D-00-02 a D-00-05, incluida D-00-03 (validador del catálogo: sí o no) | `specs/00-preguntas-negocio/plan.md` | Dario Andres Bernate Canas | T-00-04 | 45 | D-00-02 · D-00-03 · D-00-04 · D-00-05 · plan 5.2 · Const. V | cada fila D-00-02 a D-00-05 de plan §5.2 dice «firmada» o «descartada» con su motivo; si D-00-03 se descarta, T-00-26 y T-00-27 se marcan «No aplica» con ese motivo | |
| T-00-06 | [ ] [P] | Agregar a `spec.md` los cuatro RNF y el CE de legibilidad de plan §5.4 y la línea de principios transversales aplicables | `specs/00-preguntas-negocio/spec.md` | Dario Andres Bernate Canas | ninguna | 45 | plan 5.4 · Const. XII, XIII.4, XIII.5, XIII.6, XIII.7 | spec.md contiene los cinco enunciados de plan §5.4, cada uno con ID propio y sin nombrar productos, lenguajes, objetos físicos ni rutas, y declara «Const. XIII» como principio transversal aplicable `[PLAN: spec.md no tiene sección «Supuestos»; decidir dónde va la línea]` | |
| T-00-07 | [ ] | Reemplazar en `plan.md` los marcadores `[SPEC]` y los IDs `RF-00-__`, `RNF-00-__` y `CE-00-__` por los IDs reales de la spec (decidir antes si el formato es `RF-01` como en la spec o `RF-00-01` como en la plantilla) | `specs/00-preguntas-negocio/plan.md` | Dario Andres Bernate Canas | T-00-05, T-00-06 | 60 | RF-06 · plan encabezado · Const. XII, XIII.5 | `grep -c` da 0 para `[SPEC`, `RF-00-__`, `RNF-00-__` y `CE-00-__` en plan.md; el encabezado del plan declara la fecha y el estado de la spec que usó; plan §16 registra el cambio | |
| T-00-08 | [ ] | Agregar a plan §8 un componente por cada requisito que hoy no tiene: RF-03, RF-04, RF-05, RF-07, CE-01, CE-02, CE-03, CE-04 y plan §5.4 (3) | `specs/00-preguntas-negocio/plan.md` | Dario Andres Bernate Canas | T-00-07 | 60 | RF-03 · RF-04 · RF-05 · RF-07 · CE-01 · CE-02 · CE-03 · CE-04 · plan 5.4 (3) · Const. XII | cada uno de esos nueve requisitos aparece en la columna «Satisface» de al menos un componente de plan §8, con un solo `DEBE`, sujeto con nombre y verificación | |
| T-00-09 | [ ] | Completar la columna «Tarea» de plan §11 con los IDs `T-00-MM` de este archivo | `specs/00-preguntas-negocio/plan.md` | Dario Andres Bernate Canas | T-00-08 | 45 | plan 11 · D-00-02 · Const. XIII.5 | `grep -c "T-00-__" plan.md` da 0 y cada fila de plan §11 cita al menos una tarea que existe en este archivo | |
| T-00-10 | [ ] | Correr `/analyze specs/00-preguntas-negocio` en modo completo y guardar su informe | `specs/00-preguntas-negocio/checklists/analisis.md` | Dario Andres Bernate Canas | T-00-03, T-00-09 | 30 | D-00-02 · Const. XIII (puntos de control a, b, c y d de la tabla XIII-C) | el informe guardado dice «LISTO» para `/implement`, con 0 Críticos y 0 Altos; lo que encuentre se corrige antes de empezar la Fase 2 | |

**Punto de verificación de la Fase 1** (checklist manual):
- [ ] ADR-0006, ADR-0007 y D-00-01 tienen firma con nombre y fecha.
- [ ] `plan.md` no tiene marcadores `[SPEC]` ni IDs con guion bajo, y cita la versión de la spec que usó.
- [ ] Cada requisito de la spec tiene al menos un componente en plan §8.
- [ ] El informe de `/analyze` no tiene Críticos ni Altos.

## Fase 2 — Investigación y glosario

Objetivo: cerrar la Fase 0 del plan (`research.md`) y sembrar el glosario único del proyecto (Const. XIII.6). Entregable: `research.md` con la viabilidad de las 12 preguntas y `docs/glosario.md`.

| ID | Estado | Tarea | Archivo | Responsable | Depende de | Min | Cubre | Hecho cuando | Evidencia |
|---|---|---|---|---|---|---|---|---|---|
| T-00-11 | [ ] [P] | Crear `research.md` con encabezado y las cinco decisiones de plan §6 | `specs/00-preguntas-negocio/research.md` | Dario Andres Bernate Canas | T-00-10 | 45 | plan 6 · C-00-08 · Const. XIII.4, XIII.5 | el archivo abre con encabezado (propósito, autor, fecha y dependencias), cita IDs que existen en la spec y tiene las cinco filas pregunta, decisión, justificación y fuente de plan §6 | |
| T-00-12 | [ ] [P] | Crear `docs/glosario.md` con encabezado y los 12 términos de plan §15.1 | `docs/glosario.md` | Dario Andres Bernate Canas | T-00-10 | 45 | C-00-07 · plan 15.1 · plan 5.4 (2) · Const. XIII.6 | el archivo abre con encabezado y define los 12 términos de plan §15.1, un solo nombre por concepto | |
| T-00-13 | [ ] [P] | Analizar en `research.md`, para cada una de las 12 PN, qué campos de la fuente necesita y si la fuente puede responderla | `specs/00-preguntas-negocio/research.md` | Dario Andres Bernate Canas | T-00-11 | 60 | RF-02 · C-00-03 · C-00-04 · plan 7.2 (paso 04) | 12 de 12 PN tienen sus campos (de los diez de spec §3, con el nombre exacto del formato) y una viabilidad: `viable`, `viable con reserva` o `no viable con esta fuente`; cada una no viable dice qué dato falta | |
| T-00-14 | [ ] | Revisar que ninguna PN pretenda identificar a una persona y que PN09, PN10 y PN11 se respondan solo de forma agregada, y anotar el resultado en `research.md` | `specs/00-preguntas-negocio/research.md` | Dario Andres Bernate Canas | T-00-13 | 30 | RF-03 · Const. Seguridad del dato · `[PLAN: sin componente]` | la anotación lista las 12 PN y, para cada una que pida identificar a una persona, la decisión tomada (reformular o descartar) | |
| T-00-15 | [ ] [P] | Agregar al glosario las siglas y términos de `spec.md` y `plan.md` que faltan (por ejemplo EDA, ADR, SNAP, UTC y EARS) y fijar un solo nombre para usuario, cliente y reseñador | `docs/glosario.md` | Dario Andres Bernate Canas | T-00-12 | 45 | C-00-07 · U-00-02 · plan 5.4 (2) · Const. XIII.6 | cada sigla que aparece en spec.md y plan.md tiene entrada en el glosario (0 sin definir, U-00-02) y el glosario fija un solo nombre para usuario, cliente y reseñador | |

**Punto de verificación de la Fase 2** (checklist manual):
- [ ] `research.md` tiene 12 de 12 PN con campos y viabilidad.
- [ ] Ninguna PN pretende identificar a una persona.
- [ ] Toda sigla de `spec.md` y `plan.md` está en `docs/glosario.md`.

## Fase 3 — Matriz de trazabilidad y validación de preguntas

Objetivo: construir la matriz de trazabilidad (Fase 1 del plan), validar las preguntas de prioridad D y firmar el insumo del grano. Entregable: `matriz-trazabilidad.md`, `quickstart.md`, sección 11 de `spec.md` con las PN D en «Validada» y la firma del responsable de Oro.

| ID | Estado | Tarea | Archivo | Responsable | Depende de | Min | Cubre | Hecho cuando | Evidencia |
|---|---|---|---|---|---|---|---|---|---|
| T-00-16 | [ ] | Crear `matriz-trazabilidad.md` con encabezado y 12 filas con `id_pregunta` y `enunciado_resumido` | `specs/00-preguntas-negocio/matriz-trazabilidad.md` | Dario Andres Bernate Canas | T-00-13 | 45 | RF-01 · C-00-01 · Const. XIII.4, XIII.5 | el archivo abre con encabezado y tiene 12 filas, PN01 a PN12 sin repetir, con el mismo ID y enunciado que spec §5 | |
| T-00-17 | [ ] | Completar `campos_fuente`, `viabilidad` y `motivo_viabilidad` en las 12 filas de la matriz | `specs/00-preguntas-negocio/matriz-trazabilidad.md` | Dario Andres Bernate Canas | T-00-16 | 60 | RF-02 · C-00-03 · C-00-04 | 0 filas con `campos_fuente` o `viabilidad` vacíos; cada fila que no es `viable` trae su motivo; los campos coinciden con `research.md` y con la columna «Disponible con los campos» de spec §11 | |
| T-00-18 | [ ] | Completar `usa_conteo_de_usuarios` y `usa_periodos_de_tiempo` en las 12 filas de la matriz | `specs/00-preguntas-negocio/matriz-trazabilidad.md` | Dario Andres Bernate Canas | T-00-17 | 45 | RF-05 · RF-08 · C-00-05 · DQ-03 · DQ-04 · DQ-14 · DQ-15 | cada fila con `usa_conteo_de_usuarios = sí` (al menos PN02, PN09 y PN10) dice que las reseñas anónimas se excluyen y se informan aparte; cada fila con `usa_periodos_de_tiempo = sí` dice que marzo de 2010 y marzo de 2013 son meses parciales y que las fechas usan UTC | |
| T-00-19 | [ ] | Completar `medida_candidata`, `dimensiones_candidatas` y `grano_candidato` a partir de spec §6.2 y §6.3 | `specs/00-preguntas-negocio/matriz-trazabilidad.md` | Dario Andres Bernate Canas | T-00-18 | 60 | plan 7.3 · plan 5.4 (3) · C-00-01 · Const. XIII.4 | 0 filas sin esas tres columnas; cada valor sale de spec §6.2 o §6.3 y va marcado «candidato, no vinculante»; ningún nombre viene del modelo anterior | |
| T-00-20 | [ ] | Completar `especificaciones_destino` y `criterio_de_aceptacion` en las 12 filas de la matriz | `specs/00-preguntas-negocio/matriz-trazabilidad.md` | Dario Andres Bernate Canas | T-00-19 | 45 | C-00-06 · plan 7.3 | 0 filas con `especificaciones_destino` o `criterio_de_aceptacion` vacíos; cada destino es 02, 03, 04 o 05 | |
| T-00-21 | [ ] [P] | Reconciliar la tabla «Traspasos explícitos» del plan con «Qué heredan las siguientes especificaciones» de spec §13 | `specs/00-preguntas-negocio/plan.md` | Dario Andres Bernate Canas | T-00-10 | 45 | plan 7.4 a 7.9 · spec 13 · Const. XII | cada herencia de spec §13 (01: diez campos y anónimas; 02: regla de anonimato, `helpfulness` con cero votos totales, meses parciales y umbral de volumen; 04: sección 6; 05: sección 7) aparece en la tabla de traspasos del plan, o la diferencia queda anotada con su motivo | |
| T-00-22 | [ ] [P] | Crear `quickstart.md` con los pasos para que otra persona repita la revisión | `specs/00-preguntas-negocio/quickstart.md` | Dario Andres Bernate Canas | T-00-20 | 45 | plan 7.1 · plan 7.2 · Const. IX, XIII.4, XIII.5 | el archivo abre con encabezado y lista los 10 pasos de plan §7.2, cada uno con su entrada y su salida, sin rutas atadas a una máquina | |
| T-00-23 | [ ] [P] | Validar en spec §11 las siete PN de prioridad D (PN01, PN02, PN03, PN04, PN05, PN07 y PN11): aprobada por, fecha y estado «Validada» | `specs/00-preguntas-negocio/spec.md` | Dario Andres Bernate Canas (responsable y segundo validador) | T-00-14, T-00-17 | 60 | CE-03 · RF-07 · DQ-01 · `[PLAN: sin componente]` | las siete filas D de spec §11 tienen «Aprobada por», fecha y estado «Validada», y las 12 filas tienen un estado | |
| T-00-24 | [ ] | Comprobar RF-04 y CE-02 contra spec §7: cada PN asignada a un tablero y cada tablero con su mínimo de preguntas | `specs/00-preguntas-negocio/spec.md` | Dario Andres Bernate Canas | T-00-23 | 30 | RF-04 · CE-02 · `[PLAN: sin componente]` | 12 de 12 PN tienen tablero; T1 tiene al menos 3 PN, T2 al menos 2 y T3 al menos 3 (al 2026-10-14: 5, 2 y 5); si falla, la corrección queda en spec §7 | |
| T-00-25 | [ ] | Firmar como responsable de Oro el insumo del grano (spec §6.1) y la tabla de cálculos (spec §6.2) | `specs/00-preguntas-negocio/spec.md` | Jose Julio Gomez Palmera | T-00-24 | 30 | CE-04 · `[PLAN: sin componente]` | spec §6.1 y §6.2 llevan nombre y fecha de firma de Jose Julio Gomez Palmera `[PLAN: spec.md no define dónde va la firma]` | |

**Punto de verificación de la Fase 3** (checklist manual):
- [ ] La matriz tiene 12 filas y ninguna columna obligatoria vacía.
- [ ] Las siete PN de prioridad D están en «Validada».
- [ ] El insumo del grano y la tabla de cálculos tienen la firma del responsable de Oro.
- [ ] Los traspasos del plan coinciden con lo que hereda cada spec según spec §13.

## Fase 4 — Validador del catálogo (solo si D-00-03 se aprueba)

Objetivo: automatizar los chequeos de completitud del catálogo (C-00-10). Si T-00-05 descarta D-00-03, estas dos tareas pasan a «No aplica» con ese motivo. Entregable: `tests/test_catalogo_preguntas.py`.

| ID | Estado | Tarea | Archivo | Responsable | Depende de | Min | Cubre | Hecho cuando | Evidencia |
|---|---|---|---|---|---|---|---|---|---|
| T-00-26 | [ ] | Escribir en `tests/test_catalogo_preguntas.py` las pruebas de campos obligatorios por PN y de IDs únicos | `tests/test_catalogo_preguntas.py` | Dario Andres Bernate Canas | T-00-05, T-00-20 | 45 | RF-01 · C-00-10 · U-00-01 · Const. V, XIII.3, XIII.5 | `pytest tests/test_catalogo_preguntas.py` pasa con 0 incumplimientos (U-00-01); el archivo abre con encabezado y cada prueba tiene docstring, nombre descriptivo, `assert` con mensaje y constantes con nombre | |
| T-00-27 | [ ] | Agregar a `tests/test_catalogo_preguntas.py` la prueba de que cada PN de `spec.md` aparece en la matriz | `tests/test_catalogo_preguntas.py` | Dario Andres Bernate Canas | T-00-26 | 45 | C-00-10 · plan 10.1 · Const. XIII.3 | `pytest tests/test_catalogo_preguntas.py` pasa; el número esperado de PN se cuenta directamente en spec.md y no con el mismo código que se prueba (plan §10.1) | |

**Punto de verificación de la Fase 4** (checklist manual):
- [ ] `pytest tests/` pasa, o D-00-03 consta como descartada en plan §5.2.
- [ ] Las pruebas tienen docstring, mensajes en cada `assert` y constantes con nombre.

## Fase 5 — Verificación humana y compuerta del plan

Objetivo: la persona responsable ejecuta las verificaciones de plan §10.2, que sustituyen la verificación con SQL (D-00-01, Principio XI), y registra el Constitution Check después de la Fase 1 (plan §4). Entregable: resultado de V-00-01 a V-00-05 en la columna Evidencia y plan §4 actualizado.

| ID | Estado | Tarea | Archivo | Responsable | Depende de | Min | Cubre | Hecho cuando | Evidencia |
|---|---|---|---|---|---|---|---|---|---|
| T-00-28 | [ ] [P] | Ejecutar V-00-01: contar las PN de `spec.md` y de `matriz-trazabilidad.md` | — (solo lectura) | Dario Andres Bernate Canas | T-00-20 | 30 | V-00-01 · C-00-01 · C-00-02 · Const. XI | el número de PN es el mismo en spec.md y en la matriz (12 al 2026-10-14) y hay 0 IDs repetidos; el resultado queda en Evidencia | |
| T-00-29 | [ ] [P] | Ejecutar V-00-02: comprobar las columnas obligatorias de `matriz-trazabilidad.md` | — (solo lectura) | Dario Andres Bernate Canas | T-00-20 | 30 | V-00-02 · RF-01 · RF-08 · C-00-05 · C-00-06 · CE-01 · Const. XI | 0 filas sin `campos_fuente`, `viabilidad`, `especificaciones_destino` o `criterio_de_aceptacion`, y toda fila con `usa_conteo_de_usuarios = sí` marca la exclusión de anónimas; el resultado queda en Evidencia | |
| T-00-30 | [ ] [P] | Ejecutar V-00-03: revisar las preguntas marcadas «no viable» en `matriz-trazabilidad.md` | — (solo lectura) | Dario Andres Bernate Canas | T-00-20, T-00-23 | 30 | V-00-03 · C-00-04 · Const. XI | 0 filas «no viable» sin motivo o sin decisión registrada (reformular, descartar o aceptar); el resultado queda en Evidencia | |
| T-00-31 | [ ] [P] | Ejecutar V-00-04: comprobar glosario y encabezados de los documentos de la spec | — (solo lectura) | Dario Andres Bernate Canas | T-00-15, T-00-20, T-00-22 | 30 | V-00-04 · C-00-07 · C-00-08 · U-00-02 · U-00-03 · Const. XI | 0 términos o siglas sin definir y 0 documentos sin encabezado ni IDs entre spec.md, research.md, matriz-trazabilidad.md, quickstart.md y docs/glosario.md; el resultado queda en Evidencia | |
| T-00-32 | [ ] [P] | Ejecutar V-00-05: buscar tecnología en los enunciados de requisitos de `spec.md` | — (solo lectura) | Dario Andres Bernate Canas | T-00-25 | 30 | V-00-05 · C-00-09 · Const. XI, XII | 0 menciones de productos, lenguajes, objetos físicos o rutas en los enunciados de requisitos de spec.md; el resultado queda en Evidencia | |
| T-00-33 | [ ] | Registrar en plan §4 el resultado de la compuerta «después de la Fase 1» y el nuevo estado de las filas X, XI, XII y XIII | `specs/00-preguntas-negocio/plan.md` | Dario Andres Bernate Canas | T-00-21, T-00-31, T-00-32 | 30 | plan 4 · spec 13 · Const. X, XI, XII, XIII | plan §4 dice «pasa» o «bloquea» con su motivo, y las filas X, XI, XII y XIII muestran su estado con evidencia | |

**Punto de verificación de la Fase 5** (checklist manual):
- [ ] V-00-01 a V-00-05 tienen su resultado en la columna Evidencia.
- [ ] El Constitution Check de plan §4 tiene su resultado «después de la Fase 1».

## Fase 6 — Cierre (compuerta de la constitución)

Las seis filas son obligatorias (compuerta de cierre, Constitución v1.1.0). En la spec 00 se adaptan según D-00-01, que debe estar firmada (T-00-04); `specs/README.md` fija la variante de la spec 00. Un agente no da la especificación por cerrada: la verificación humana la hace la persona responsable (Principio XI).

| ID | Estado | Tarea | Responsable | Depende de | Min | Cubre | Hecho cuando | Evidencia |
|---|---|---|---|---|---|---|---|---|
| T-00-34 | [ ] | Confirmar tests en verde y criterios CE-01 a CE-04 cumplidos | Dario Andres Bernate Canas | T-00-25, T-00-27, T-00-33 | 30 | Const. VI · CE-01 · CE-02 · CE-03 · CE-04 · D-00-01 | `pytest tests/` termina sin fallos (si D-00-03 se descartó, plan §5.2 lo deja constar) y CE-01 a CE-04 tienen su evidencia anotada | |
| T-00-35 | — | Confirmar cuadre exacto | — | — | — | Const. VI · D-00-01 | No aplica: la spec 00 no mueve datos ni filas (`specs/README.md`, «Compuerta de cierre»; D-00-01) | |
| T-00-36 | [ ] | Registrar el resultado conjunto de V-00-01 a V-00-05 como verificación humana de la compuerta | Dario Andres Bernate Canas | T-00-28, T-00-29, T-00-30, T-00-31, T-00-32, T-00-34 | 30 | Const. XI · plan 10.2 · D-00-01 | T-00-28 a T-00-32 tienen su resultado en Evidencia y cada uno coincide con el esperado de plan §10.2 | |
| T-00-37 | [ ] | Actualizar la documentación: glosario, documentos de la spec y fila S-00 de `docs/gestion/tareas.md` | Dario Andres Bernate Canas | T-00-36 | 60 | Const. X, XIII.4, XIII.6 · plan 14 · D-00-01 | 0 términos sin definir (U-00-02) y la fila S-00 de `docs/gestion/tareas.md` trae su evidencia | |
| T-00-38 | [ ] | Realizar la revisión de legibilidad por una persona junior distinta del autor (checklist firmado) | Jose Julio Gomez Palmera | T-00-37 | 60 | Const. XIII.7 · C-00-11 · plan 5.4 (1), (5) · U-00-04 | `specs/00-preguntas-negocio/checklists/legibilidad.md` está firmado con las cinco preguntas respondidas (5 de 5, U-00-04) sobre al menos tres PN (una de PN09 o PN10 y dos elegidas por quien lee) y su fila de la matriz, sin consultar al autor | |
| T-00-39 | [ ] | Integrar a `main` el Pull Request de la rama `00-preguntas-negocio` | Dario Andres Bernate Canas | T-00-38 | 30 | Const. XII | el Pull Request está integrado a `main` con las condiciones de la compuerta marcadas | |

## Seguimiento de avance

Se recalcula al cerrar cada tarea: % hecho = hechas ÷ total × 100; % falta = 100 − % hecho. T-00-35 («No aplica») no cuenta. Si D-00-03 se descarta, T-00-26 y T-00-27 salen del conteo.

| Fase | Tareas | Hechas | % hecho | % falta | Minutos estimados |
|---|---|---|---|---|---|
| 1 — Desbloqueo y reconciliación | 10 | 0 | 0 % | 100 % | 405 |
| 2 — Investigación y glosario | 5 | 0 | 0 % | 100 % | 225 |
| 3 — Matriz y validación | 10 | 0 | 0 % | 100 % | 465 |
| 4 — Validador del catálogo | 2 | 0 | 0 % | 100 % | 90 |
| 5 — Verificación humana | 6 | 0 | 0 % | 100 % | 180 |
| 6 — Cierre | 5 | 0 | 0 % | 100 % | 210 |
| **Total** | **38** | **0** | **0 %** | **100 %** | **1575** |

## Cobertura de requisitos

Requisitos de la spec (RF-01 a RF-08, CE-01 a CE-04) más los cinco de legibilidad que plan §5.4 manda agregar a la spec. Ninguna regla `Rnn` aplica: la spec 00 no crea transformaciones.

| Requisito | Tareas que lo cubren | Prueba o consulta | Estado |
|---|---|---|---|
| RF-01 | T-00-16, T-00-26, T-00-29 | V-00-02 · prueba de T-00-26 | cubierto · plan: C-00-01, C-00-10 |
| RF-02 | T-00-13, T-00-17 | V-00-02 | cubierto · plan: C-00-03, C-00-04 |
| RF-03 | T-00-08, T-00-14 | revisión por lista (CE-01) | cubierto por tareas · sin componente en el plan hasta T-00-08 |
| RF-04 | T-00-08, T-00-24 | T-00-24 | cubierto por tareas · sin componente en el plan hasta T-00-08 |
| RF-05 | T-00-08, T-00-18 | V-00-02 · la marca en T1 se verifica en `05-dashboards-bi` | parcial · sin componente hasta T-00-08 |
| RF-06 | T-00-07 y el encabezado de este archivo | inspección del encabezado de plan y tareas | cubierto · plan: C-00-02 (parcial) |
| RF-07 | T-00-08, T-00-23 | revisión de spec §11 | cubierto por tareas · sin componente en el plan hasta T-00-08 |
| RF-08 | T-00-18, T-00-29 | V-00-02 · el conteo de anónimas excluidas se verifica en `02` y `05` | parcial · plan: C-00-05 |
| CE-01 | T-00-08, T-00-29, T-00-34 | V-00-02 | cubierto por tareas · sin componente en el plan hasta T-00-08 |
| CE-02 | T-00-08, T-00-24, T-00-34 | T-00-24 | cubierto por tareas · sin componente en el plan hasta T-00-08 |
| CE-03 | T-00-08, T-00-23, T-00-34 | revisión de spec §11 | cubierto por tareas · sin componente en el plan hasta T-00-08 |
| CE-04 | T-00-08, T-00-25, T-00-34 | firma en spec §6 | cubierto por tareas · sin componente en el plan hasta T-00-08 |
| plan 5.4 (1) · RNF comprensión junior (XIII.7) | T-00-06, T-00-38 | lectura en frío firmada | cubierto · plan: C-00-11 · falta crear el ID en la spec (T-00-06) |
| plan 5.4 (2) · RNF glosario (XIII.6) | T-00-06, T-00-12, T-00-15 | V-00-04 | cubierto · plan: C-00-07 · falta crear el ID en la spec (T-00-06) |
| plan 5.4 (3) · RNF medida, dimensiones y grano (XIII.4) | T-00-06, T-00-08, T-00-19 | inspección de la matriz | cubierto por tareas · sin componente hasta T-00-08 |
| plan 5.4 (4) · RNF IDs en documentos (XIII.5) | T-00-06, T-00-11, T-00-16, T-00-22 | V-00-04 | cubierto · plan: C-00-08 · falta crear el ID en la spec (T-00-06) |
| plan 5.4 (5) · CE lectura en frío (XIII.7) | T-00-06, T-00-38 | checklist firmado | cubierto · plan: C-00-11 · falta crear el ID en la spec (T-00-06) |

**Cifras:** 17 requisitos · 17 con tarea · 8 con componente en el plan hoy (RF-06 solo parcial) · 9 sin componente hasta T-00-08 · 11 de 11 componentes del plan con al menos una tarea.

## Lista de revisión antes de entregar las tareas

- [x] Cada tarea empieza con un verbo y nombra un artefacto concreto.
- [x] Cada `Hecho cuando` se comprueba con un comando, una cifra o un archivo.
- [x] Cada dependencia está declarada; las tareas `[P]` no comparten archivo.
- [x] Ninguna tarea supera 60 minutos.
- [x] Cada tarea cita al menos un requisito, y cada requisito tiene al menos una tarea.
- [x] Ninguna tarea depende de otra que aparece después.
- [x] Toda tarea que crea una transformación cita su regla `Rnn` (Const. IV). No aplica: la spec 00 no tiene transformaciones.
- [x] Ninguna tarea propone algo fuera de alcance (Airflow, Dagster, dbt, nube, Notion, Python fuera de `tests/`).
- [x] Ninguna tarea toca `raw` después de validada, ni versiona datos ni credenciales.
- [x] Ninguna tarea edita `specs/README.md` a mano.
- [x] Están las seis filas de la Fase 6, incluida la lectura en frío.

## Historial de cambios

| Fecha | Cambio | Motivo | Autor |
|---|---|---|---|
| 2026-10-14 | Versión inicial (borrador) | Primer `/tasks` de la spec 00, con plan sin reconciliar y ADR-0006 y ADR-0007 sin firma | skill `tasks` |
