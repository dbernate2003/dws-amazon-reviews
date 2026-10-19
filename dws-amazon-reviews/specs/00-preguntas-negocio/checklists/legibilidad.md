# Checklist de legibilidad — lectura en frío de 00-preguntas-negocio

**Propósito:** dejar constancia de que un lector distinto del autor (agente en contexto limpio, anexo 2 de D-00-01, spec DQ-34) leyó en frío los documentos de la spec 00 y respondió sin ayuda las cinco preguntas estándar del principio XIII.7 | **Quien lee:** agente en contexto limpio (anexo 2 de D-00-01, spec DQ-34) · **Firma:** Dario Andres Bernate Canas, responsable | **Fecha:** 2026-10-19 | **Constitución:** v1.1.0
**Dependencias:** `spec.md` §5 a §7, `matriz-trazabilidad.md`, `research.md` y `docs/glosario.md`.
**IDs que atiende:** RNF-00-01, CE-00-05 · Const. XIII.7 y XI · Umbral U-00-08 (5 de 5) · Tareas T-00-38 y T-00-55.

> **Instrucciones para quien lee:** usa solo los documentos y el glosario, sin consultar al autor. Responde las cinco preguntas de cada bloque con tus palabras. Si algo no se entiende, anótalo en «Tropiezos»: el artefacto se corrige antes de cerrar (Const. XIII.7). U-00-08 exige acertar 5 de 5.

## Bloque 1 (T-00-38) — PN01 a PN06 y la matriz

**Muestra:** PN01–PN06 de `spec.md` y `matriz-trazabilidad.md` (las 12 filas). Puede consultar el catálogo completo (`spec.md`), `docs/glosario.md` y `quickstart.md` (RNF-00-01: «solo el catálogo y el glosario»; la pregunta 5 la responde `quickstart.md`).

| # | Pregunta estándar | Respuesta de quien lee |
|---|---|---|
| 1 | ¿Qué hace? | Fija y valida el catálogo de preguntas de negocio; no construye tablas ni calcula cifras. PN01–PN06 cubren volumen y tendencia (PN01, PN02), satisfacción (PN03, PN04) y productos (PN05, PN06). Cada PN declara pregunta, decisión que apoya, prioridad, campos, medida, corte, tablero y estado; la matriz la traza. El insumo del grano es una reseña individual, no el grano final. |
| 2 | ¿Qué entra y qué sale? | Entra: los campos de la fuente de la spec §3 que cada PN necesita (`time`, `score`, `productId`, `userId`/`profileName`, `helpfulness`). Sale: el catálogo validado con IDs, prioridad, campos, medida y corte, tablero y estado, más la matriz de trazabilidad; no salen tablas ni datos. |
| 3 | ¿Qué regla o requisito atiende? | RF-00-01 a RF-00-05 (ID, decisión y prioridad; campos viables; no identificar personas; tablero; corte por mes con meses parciales), RF-00-07 y RF-00-09; CE-00-01 a CE-00-05 y RNF-00-01/02. La prioridad D exige primera entrega; la compuerta de cierre es D-00-01. |
| 4 | ¿Por qué existe cada filtro o transformación? | No hay filtros de datos: se seleccionan campos y se fijan cortes. El corte por mes marca 2010-03 y 2013-03 como parciales (RF-00-05); los promedios y porcentajes usan las fórmulas de §6.2/§6.4 (suma ÷ conteo, sin redondeos intermedios). Lo que la fuente no tiene (categoría, ventas, país) queda fuera (DQ-13); los umbrales que dependen de los datos se difieren a 02 (DQ-11, DQ-12). |
| 5 | ¿Cómo se ejecuta y se verifica? | No se ejecuta código: se lee la spec, el glosario y la matriz (`quickstart.md`). Se verifica con V-00-01 a V-00-10 de `checklists/validacion.md`, hechas por el responsable; no hay `pytest` (D-00-01). La compuerta exige las seis condiciones y la firma del responsable. |

**Tropiezos encontrados:** Ninguno que impida responder las cinco preguntas. Se anotan como diferidos por diseño el umbral de PN06 (DQ-11, U-00-11) y la definición de «anónima» (DQ-12), que se fijan en 01/02. La nota de PN01 («se compara el mismo mes entre años») ya estaba en el catálogo y el lector no consultó al autor; el responsable la confirmó al revisar este checklist como una lectura comparativa, sin índice.

**¿Supera el bloque?** Sí (5 de 5).

## Bloque 2 (T-00-55) — PN07 a PN12 y el glosario

**Muestra:** PN07–PN12 de `spec.md`, `docs/glosario.md` y `research.md` §2 y §3. Puede consultar el catálogo completo (`spec.md`) y `quickstart.md`.

| # | Pregunta estándar | Respuesta de quien lee |
|---|---|---|
| 1 | ¿Qué hace? | Fija y valida PN07–PN12: utilidad (PN07, PN08), usuarios (PN09, PN10), anonimato (PN11) y día de la semana (PN12). Cada PN declara pregunta, decisión, prioridad, campos, medida y corte, tablero y estado; el glosario fija el vocabulario. No construye tablas. |
| 2 | ¿Qué entra y qué sale? | Entra: `score`, `helpfulness`, `text`, `time`, `userId`/`profileName` y `productId`, según la PN. Sale: preguntas medidas y agregadas (PN09–PN11 solo agregadas), con estado y tablero; no salen datos personales ni tablas. |
| 3 | ¿Qué regla o requisito atiende? | RF-00-05 (corte mensual con meses parciales en PN07 y PN11), RF-00-09 (solo agregada en PN09–PN11), RNF-00-02 y CE-00-05; DQ-12 (anónima), DQ-17 (grupo activo), DQ-22 (razón de utilidad), DQ-23/DQ-27 (sin mínimo de votos) y DQ-24 (longitud). |
| 4 | ¿Por qué existe cada filtro o transformación? | La razón de utilidad es suma ÷ suma (DQ-22) y no lleva mínimo (DQ-27); la regla de cero votos se fija en 02. La anónima se define en 01/02 (DQ-12), el grupo activo en 02 (DQ-17) y los rangos de longitud en 02 (DQ-24). PN09–PN11 se entregan agregadas para no identificar personas (RF-00-09); PN07 y PN11 marcan meses parciales (RF-00-05). |
| 5 | ¿Cómo se ejecuta y se verifica? | No hay código: se lee la spec, el glosario, `research.md` §2–§3 y `quickstart.md`. Se verifica con V-00-01 a V-00-10 y la compuerta D-00-01, con el responsable; no hay `pytest`. |

**Tropiezos encontrados:** PN11 no incluía `time` en sus campos aunque se corta por mes (RF-00-05); corregido en spec §11, matriz y `research.md` antes de firmar. Diferidos por diseño: regla de cero votos, grupo activo y rangos de longitud (02).

**¿Supera el bloque?** Sí (5 de 5).

## Resultado y firma

| Bloques superados | Aciertos (U-00-08: 5 de 5 por bloque) | Decisión |
|---|---|---|
| 2 de 2 | 5 de 5 en cada bloque (10 de 10) | Superada; se corrigió PN11 (`time`) antes de firmar |

| Quien hizo la lectura en frío | Rol | Fecha | Firma |
|---|---|---|---|
| Agente en contexto limpio (OpenCode, sesión nueva) | Lector en frío, sin historial ni acceso al resto del repositorio (anexo 2 de D-00-01, DQ-34) | 2026-10-19 | — (no firma; DQ-34) |
| Dario Andres Bernate Canas | Responsable de la 00: revisa las respuestas y firma (DQ-34) | 2026-10-19 | Firmado |

**Si algo no se supera:** se corrige el artefacto, se repite la lectura de ese bloque y se actualiza este checklist antes de cerrar la spec (Const. XIII.7).
