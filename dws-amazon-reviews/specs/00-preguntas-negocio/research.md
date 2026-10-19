# Investigación (Fase 0) — 00-preguntas-negocio

**Propósito:** fijar las decisiones de investigación que sostienen la viabilidad de las doce preguntas de negocio antes de producir la matriz de trazabilidad y la lista de validación | **Autor:** agente principal (OpenCode), por encargo de Dario Andres Bernate Canas | **Fecha:** 2026-10-19 | **Constitución:** v1.1.0
**Basada en:** `plan.md` (2026-10-19) §6, con las 17 decisiones de la Fase 0; `spec.md` (2026-10-19).
**Dependencias:** `spec.md` §3, §6, §11, §12 y §13; `plan.md` §5.2, §6 y §7.3; `checklists/analisis.md` (LISTO: 0 críticos y 0 altos).
**IDs que atiende:** RF-00-02, RF-00-03, RF-00-09, RNF-00-04 · Componentes C-00-03, C-00-04, C-00-08 y C-00-12 · Tareas T-00-11, T-00-13 y T-00-14 (Const. XIII.4, XIII.5).

> La sección 1 recoge las 17 decisiones de `plan.md` §6 (T-00-11); las secciones 2 y 3 agregan la viabilidad por pregunta (T-00-13) y la identificación de personas (T-00-14), sobre esas mismas decisiones.

## 1. Decisiones de investigación

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

## 2. Viabilidad por pregunta de negocio

Los campos salen de la columna «Disponible con los campos» de la spec §11 y de la tabla de la spec §3. La viabilidad usa los tres valores de `plan.md` §7.3: `viable`, `viable con reserva` o `no viable con esta fuente`. «Con reserva» significa que la fuente tiene los campos, pero una decisión diferida (DQ) fija el corte o la unidad en la spec 02 con los datos reales.

| PN | Campos de la fuente | Viabilidad | Motivo |
|---|---|---|---|
| PN01 | `time` | `viable` | La fecha a nivel de día alcanza para el conteo mensual; los meses parciales se marcan (RF-00-05). |
| PN02 | `time`, `productId`, `userId` | `viable con reserva` | `userId` puede faltar en reseñas anónimas (DQ-12); se excluyen del conteo y se informa cuántas (RF-00-08, RF-00-11). |
| PN03 | `time`, `score` | `viable` | Fecha y calificación alcanzan para el promedio mensual. |
| PN04 | `score`, `time` | `viable` | Calificación y fecha alcanzan para la distribución y su evolución. |
| PN05 | `productId`, `score` | `viable` | Identificador y calificación alcanzan para el Top 10 y su promedio; el desempate está fijado (DQ-29). |
| PN06 | `productId`, `score` | `viable con reserva` | Falta el umbral mínimo de volumen por producto (DQ-11, U-00-11), que fija la spec 02 con datos; el corte de calificación ≤ 2,5 ya está decidido (DQ-18). |
| PN07 | `helpfulness`, `time`, `score` | `viable` | `helpfulness` trae votos útiles y totales; el denominador del % está fijado (DQ-22) y la regla de cero votos totales nace en la spec 02 (spec §6.4). |
| PN08 | `helpfulness`, `score`, `text` | `viable con reserva` | La unidad en palabras está decidida (DQ-24); qué cuenta como palabra y los rangos de longitud se fijan en la spec 02 con la distribución real (DQ-24, U-00-18). |
| PN09 | `userId` | `viable con reserva` | El corte del grupo más activo se fija en la spec 02 (DQ-17, U-00-12); además, las anónimas se excluyen y se informa cuántas (DQ-12, RF-00-08, RF-00-11). |
| PN10 | `userId` | `viable con reserva` | Las anónimas se excluyen del conteo y se informa cuántas (DQ-12, RF-00-08, RF-00-11); la clasificación en la ventana completa ya está decidida (DQ-26). |
| PN11 | `userId`, `profileName`, `score`, `helpfulness` | `viable con reserva` | La forma exacta de reconocer una reseña anónima se confirma en las specs 01 y 02 (DQ-12); la comparación se entrega agregada (RF-00-09). |
| PN12 | `time`, `score` | `viable` | Fecha y calificación alcanzan para el corte por día de la semana. |

**Resultado:** 12 de 12 PN son viables; 6 son `viable con reserva` por decisiones diferidas y **0 son `no viable con esta fuente`**. Por eso `V-00-03` se cumple sin filas que justificar.

## 3. Identificación de personas por pregunta

Ninguna pregunta necesita identificar a una persona. Las tres preguntas sobre usuarios se responden solo de forma agregada (RF-00-09); las demás no tratan de personas.

| PN | ¿Identifica a una persona? | Forma de entrega | Decisión |
|---|---|---|---|
| PN01 | No | Agregada por mes | Se mantiene. |
| PN02 | No | Agregada: conteo de usuarios distintos, sin singularizar a nadie; excluye anónimas e informa cuántas | Se mantiene (RF-00-08, RF-00-11). |
| PN03 | No | Agregada por mes | Se mantiene. |
| PN04 | No | Agregada por calificación y mes | Se mantiene. |
| PN05 | No | Agregada por producto | Se mantiene. |
| PN06 | No | Agregada por producto | Se mantiene. |
| PN07 | No | Agregada por mes y calificación | Se mantiene. |
| PN08 | No | Agregada por calificación y rango de longitud | Se mantiene. |
| PN09 | No | Solo agregada (RF-00-09) | Se mantiene. |
| PN10 | No | Solo agregada (RF-00-09) | Se mantiene. |
| PN11 | No | Solo agregada (RF-00-09) | Se mantiene. |
| PN12 | No | Agregada por día de la semana | Se mantiene. |

**Resultado:** 12 de 12 PN revisadas; 0 identifican a una persona y 0 se descartan; PN09, PN10 y PN11 quedan registradas como solo agregadas.
