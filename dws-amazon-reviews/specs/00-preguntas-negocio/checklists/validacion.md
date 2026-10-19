# Lista de validación — 00-preguntas-negocio

**Propósito:** reunir la evidencia de CE-00-01 a CE-00-04 y la firma del responsable de Oro sobre el insumo del grano y la tabla de cálculos (D-00-06) | **Autor:** agente principal (OpenCode), por encargo de Dario Andres Bernate Canas | **Fecha:** 2026-10-19 | **Constitución:** v1.1.0
**Dependencias:** `spec.md` §5, §6, §7, §10 y §11; `plan.md` §7.3, §10.2 y §14; `matriz-trazabilidad.md`; `research.md`; `docs/glosario.md`.
**IDs que atiende:** CE-00-01, CE-00-02, CE-00-03, CE-00-04, RF-00-01, RF-00-03, RF-00-04, RF-00-07, RF-00-09, RNF-00-03, RNF-00-04 · Componentes C-00-08, C-00-13, C-00-15, C-00-18 a C-00-23 · Tareas T-00-24, T-00-25, T-00-34, T-00-36, T-00-47 y T-00-48 (Const. XIII.4, XIII.5, XI).

> Las respuestas se leen contra la spec vigente; si algo no cumple, se corrige la spec antes y se repite la revisión. Esta lista no sustituye la firma del responsable: donde dice «pendiente» falta una persona.

## 1. Revisión por pregunta (CE-00-01)

| PN | RF-00-01: ID, decisión y prioridad | RF-00-02: campos disponibles | RF-00-03: no identifica personas | RF-00-04: tablero asignado | RF-00-07: estado en §11 | RF-00-09: solo agregada | Estado en spec §11 | ¿Descartar? |
|---|---|---|---|---|---|---|---|---|
| PN01 | Sí | Sí | Sí | Sí | Sí | No aplica | Propuesta | No |
| PN02 | Sí | Sí | Sí | Sí | Sí | No aplica | Propuesta | No |
| PN03 | Sí | Sí | Sí | Sí | Sí | No aplica | Propuesta | No |
| PN04 | Sí | Sí | Sí | Sí | Sí | No aplica | Propuesta | No |
| PN05 | Sí | Sí | Sí | Sí | Sí | No aplica | Propuesta | No |
| PN06 | Sí | Sí | Sí | Sí | Sí | No aplica | Propuesta | No |
| PN07 | Sí | Sí | Sí | Sí | Sí | No aplica | Propuesta | No |
| PN08 | Sí | Sí | Sí | Sí | Sí | No aplica | Propuesta | No |
| PN09 | Sí | Sí | Sí | Sí | Sí | Sí | Propuesta | No |
| PN10 | Sí | Sí | Sí | Sí | Sí | Sí | Propuesta | No |
| PN11 | Sí | Sí | Sí | Sí | Sí | Sí | Propuesta | No |
| PN12 | Sí | Sí | Sí | Sí | Sí | No aplica | Propuesta | No |

**Resultado:** 12 de 12 PN cumplen RF-00-01 a RF-00-04 y RF-00-09 (U-00-05 = 100 %); 0 PN se descartan. La columna «Estado» coincide con la spec §11: **12 en «Propuesta»**. La validación de negocio (paso a «Validada») la firma el responsable en el punto 3.

## 2. Conteo por tablero (CE-00-02)

| Tablero | PN que lo usan | Conteo | Umbral | ¿Cumple? |
|---|---|---|---|---|
| T1 — Panorama de reseñas | PN01, PN02, PN03, PN04, PN12 | 5 | U-00-02: al menos 3 | Sí |
| T2 — Productos | PN05, PN06 | 2 | U-00-03: al menos 2 | Sí |
| T3 — Usuarios y utilidad | PN07, PN08, PN09, PN10, PN11 | 5 | U-00-02: al menos 3 | Sí |

**Resultado:** conteo tomado de la spec §7 (5, 2 y 5), no de la matriz; T1 y T3 cumplen U-00-02 y T2 cumple U-00-03.

## 3. Preguntas de prioridad D (CE-00-03)

| PN | Prioridad | Estado en spec §11 | Aprobada por | Fecha |
|---|---|---|---|---|
| PN01 | D | Propuesta | Pendiente | Pendiente |
| PN02 | D | Propuesta | Pendiente | Pendiente |
| PN03 | D | Propuesta | Pendiente | Pendiente |
| PN04 | D | Propuesta | Pendiente | Pendiente |
| PN05 | D | Propuesta | Pendiente | Pendiente |
| PN07 | D | Propuesta | Pendiente | Pendiente |
| PN11 | D | Propuesta | Pendiente | Pendiente |

**Resultado:** 0 de 7 en «Validada». La aprobación de negocio y documental la hacen el responsable y el segundo validador (T-00-23); hasta entonces CE-00-03 no se cumple y la compuerta queda abierta.

## 4. Revisión de la spec §6.1 y §6.2 (RNF-00-03)

Nivel de detalle mínimo (§6.1): **una reseña individual**, revisado: **Sí**.

| PN de §6.2 | Medida con nombre completo | Cortes con nombre completo | Nivel de detalle | ¿Cambio propuesto? |
|---|---|---|---|---|
| PN01 | Sí | Sí | Sí | Ninguno |
| PN02 | Sí | Sí | Sí | Ninguno |
| PN03 | Sí | Sí | Sí | Ninguno |
| PN04 | Sí | Sí | Sí | Ninguno |
| PN05 | Sí | Sí | Sí | Ninguno |
| PN06 | Sí | Sí | Sí | Ninguno |
| PN07 | Sí | Sí | Sí | Ninguno |
| PN08 | Sí | Sí | Sí | Ninguno |
| PN09 | Sí | Sí | Sí | Ninguno |
| PN10 | Sí | Sí | Sí | Ninguno |
| PN11 | Sí | Sí | Sí | Ninguno |
| PN12 | Sí | Sí | Sí | Ninguno |

**Resultado:** 12 de 12 filas de la spec §6.2 revisadas; 0 «no»; no hay cambios que proponer a la spec.

## 5. Firma del insumo de Oro (CE-00-04)

| Revisó | Rol | Fecha | Firma |
|---|---|---|---|
| Jose Julio Gomez Palmera | Responsable de Oro | Pendiente | Pendiente |

**Resultado:** pendiente. La firma cubre la spec §6.1 y la tabla de la spec §6.2 (T-00-25). Mientras falte, CE-00-04 no se cumple.

## 6. Resultado de las verificaciones V-00-01 a V-00-10

Ejecución mecánica del 2026-10-19 sobre los documentos; la confirmación final es del responsable (Principio XI).

| ID | Resultado | ¿Coincide con plan §10.2? |
|---|---|---|
| V-00-01 | 12 PN en la spec §5 y 12 en la matriz; 0 IDs repetidos. La alineación por commit se comprueba cuando existan los commits del Pull Request | Parcial: falta el historial de commits |
| V-00-02 | 12 de 12 filas con los campos de la spec §11 y con especificaciones destino; 0 diferencias | Sí |
| V-00-03 | 0 filas `no viable con esta fuente`; no hay datos faltantes que justificar | Sí |
| V-00-04 | 12 de 12 PN revisadas; 0 identifican a una persona; PN09, PN10 y PN11 figuran como solo agregadas | Sí |
| V-00-05 | 12 de 12 PN con el tablero de la spec §7; T1 = 5, T2 = 2, T3 = 5 | Sí |
| V-00-06 | `corte_por_mes = sí` en 6 (PN01, PN02, PN03, PN04, PN07, PN11); `cuenta_usuarios = sí` en 3 (PN02, PN09, PN10) con el informe de anónimas; `solo_agregada = sí` en 3 (PN09, PN10, PN11) | Sí |
| V-00-07 | «Basada en» de `plan.md` y `task.md` = 2026-10-19, igual al último cambio de PN, requisitos o spec §6–§7; faltan los commits para comprobar el orden | Parcial: falta el historial de commits |
| V-00-08 | 0 de 7 PN de prioridad D en «Validada» | No: pendiente T-00-23 (humano) |
| V-00-09 | Lista completa en sus puntos 1 a 4; firma del responsable de Oro pendiente | No: pendiente T-00-25 (humano) |
| V-00-10 | Pendiente: se ejecuta después de la lectura en frío (T-00-31) | Pendiente |

## 7. Estado de la compuerta de cierre (D-00-01)

| # | Condición | Estado |
|---|---|---|
| 1 | CE-00-01 a CE-00-04 cumplidos y spec §11 firmada | Pendiente: CE-00-01 y CE-00-02 cumplen; CE-00-03 y CE-00-04 pendientes de firma humana |
| 2 | Cuadre exacto | No aplica (la spec 00 no mueve datos) |
| 3 | Verificación humana V-00-01 a V-00-10 | Parcial: V-00-01 a V-00-07 cumplen o cumplen con la salvedad de los commits; V-00-08 y V-00-09 dependen de firmas; V-00-10 va tras la lectura en frío |
| 4 | Documentación actualizada | En curso: glosario, `research.md`, matriz y esta lista creados; falta plan §4 (T-00-33) y la fila S-00 (T-00-37) |
| 5 | Checklist de legibilidad firmado | Pendiente: T-00-38 y T-00-55 (lectura en frío) |
| 6 | Pull Request integrado a `main` | Pendiente: T-00-39 |
