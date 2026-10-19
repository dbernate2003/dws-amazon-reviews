# Especificación 00 — Preguntas de negocio

**Rama:** `00-preguntas-negocio-cierre` | **Constitución:** v1.1.0 | **Fecha:** 2026-10-13
**Estado:** Revisada por el responsable (Dario Andres Bernate Canas) el 2026-10-19 — aclaraciones de `/clarify` del 2026-10-14, 2026-10-15 y 2026-10-19; ADR-0006, ADR-0007 y D-00-01 firmados el 2026-10-19; DQ-34 a DQ-36 (firmas sin Jose Julio, cortes de PN07 y ventana de datos) el 2026-10-19
**Última actualización:** 2026-10-19
**Responsable:** Dario Andres Bernate Canas | **Segundo validador:** Dario Andres Bernate Canas (ver `docs/gestion/roles.md`)

> Esta especificación dice **qué** necesita saber el negocio y **por qué**. No elige tecnología, tablas ni consultas: eso es trabajo de `plan.md` y de las especificaciones siguientes.

## 1. Por qué existe

El Data Warehouse se construye desde cero (constitución, Propósito y principio I). Un modelo Kimball empieza por los procesos de negocio y las preguntas que deben responder, no por las columnas del archivo. Esta especificación fija ese punto de partida y entrega tres insumos:

1. **El grano** del modelo analítico (`04-modelo-oro`): el nivel de detalle mínimo que exigen las preguntas.
2. **Las medidas y los cortes** que el modelo debe soportar.
3. **Los tableros** de `05-dashboards-bi`: qué se muestra y a quién le sirve.

Sin preguntas validadas, el grano y los tableros se decidirían por intuición y el modelo anterior se repetiría con otro nombre (constitución, Fuera de alcance).

## 2. Alcance

**Dentro:** formular, priorizar y validar las preguntas de negocio; verificar que cada una se pueda responder con los campos de la fuente; dejar el insumo del grano, de las medidas, de los cortes y de los tableros.

**Fuera:**
- Elegir el grano final, las claves o las tablas (`04-modelo-oro`).
- Confirmar la calidad real del dato (`02-exploracion-eda`); aquí solo se anticipa qué debe revisarse.
- Preguntas que requieran datos que la fuente no tiene (sección 8).
- Cualquier técnica de análisis del texto de las reseñas.

**Principios transversales aplicables:** Const. XIII (legibilidad y trazabilidad para perfiles junior).

## 3. Qué puede responder la fuente

Según la documentación de SNAP, cada reseña de `all_3y.txt.gz` trae diez campos. Esta lista se confirma contra los datos en `01-ingesta-bronce` y `02-exploracion-eda`.

| Campo | Significado de negocio |
|---|---|
| `productId` | Producto reseñado |
| `title` | Título del producto |
| `price` | Precio del producto; puede venir como «unknown» |
| `userId` | Seudónimo de quien reseña (puede estar ausente en reseñas anónimas) |
| `profileName` | Nombre público de perfil (mismo caso) |
| `helpfulness` | Votos útiles sobre votos totales que recibió la reseña, escritos como «útiles/totales» (p. ej. `3/5`: 3 votos útiles de 5) |
| `score` | Calificación de 1 a 5 |
| `time` | Fecha de la reseña (a nivel de día) |
| `summary` | Título corto de la reseña |
| `text` | Texto completo |

**Lo que la fuente NO tiene:** categoría o marca del producto, ventas, devoluciones, país o ciudad del usuario, ni la hora de la reseña. El título y el precio sí vienen, pero quedan fuera del análisis (DQ-13).

**Ventana de datos:** 2010-03-04 a 2013-03-04, 9.707.634 reseñas. La ventana es cerrada en ambos extremos (DQ-36): el 2010-03-04 y el 2013-03-04 cuentan. El primer y el último mes están incompletos; cualquier pregunta cortada por mes DEBE tratarlos como meses parciales (RF-00-05).

## 4. Quién pregunta

Rol de negocio simulado: **analista de experiencia del cliente de un marketplace**. Necesita entender cómo se comportan las reseñas, qué productos concentran la conversación y qué tan confiable es la señal que dejan los usuarios.

> Decisión DQ-05: el curso no exige un rol ni un número de tableros; se mantiene este rol. Si el enunciado cambia, se sustituye y se revisan las preguntas (RF-00-06).

## 5. Preguntas de negocio (propuestas)

Prioridad: **D** = debe estar en la primera entrega, **S** = debería, **P** = podría si hay tiempo. Las tablas agrupan por tema; los IDs conservan el orden en que se propusieron (por eso PN12 va con «Volumen y tendencia»). El estado de cada PN (Propuesta o Validada) está en la sección 11.

### Volumen y tendencia

| ID | Pregunta | Decisión que apoya | Prioridad |
|---|---|---|---|
| PN01 | ¿Cómo evoluciona el número de reseñas por mes entre 2010 y 2013 y qué tan estacional es? | Dimensionar la actividad y anticipar picos de moderación | D |
| PN02 | ¿Cuántos productos distintos y cuántos usuarios distintos reseñan cada mes? | Saber si crece la base activa o solo el volumen por usuario | D |
| PN12 | ¿Hay diferencias por día de la semana en el volumen y la calificación? | Programar campañas de solicitud de reseñas | P |

### Satisfacción

| ID | Pregunta | Decisión que apoya | Prioridad |
|---|---|---|---|
| PN03 | ¿Cómo evoluciona la calificación promedio mensual? | Detectar deterioro o mejora de la percepción | D |
| PN04 | ¿Cuál es la distribución de calificaciones (1 a 5) y qué parte son extremas (1 y 5) frente a intermedias? ¿Cambia con el tiempo? | Saber si el promedio esconde polarización | D |

### Productos

| ID | Pregunta | Decisión que apoya | Prioridad |
|---|---|---|---|
| PN05 | ¿Qué productos concentran más reseñas y cuál es su calificación promedio? | Priorizar los productos que más influyen en la imagen | D |
| PN06 | ¿Qué productos tienen mucho volumen de reseñas y calificación baja (promedio ≤ 2,5)? | Alertar sobre productos de riesgo | S |

### Utilidad de las reseñas

| ID | Pregunta | Decisión que apoya | Prioridad |
|---|---|---|---|
| PN07 | ¿Qué porcentaje de reseñas recibe al menos un voto útil y cuál es su razón de utilidad (votos útiles ÷ votos totales)? | Medir cuánto valor percibe la comunidad en las reseñas | D |
| PN08 | ¿Las reseñas más largas o con ciertas calificaciones se perciben como más útiles? | Orientar qué tipo de reseña destacar o pedir | S |

### Usuarios

| ID | Pregunta | Decisión que apoya | Prioridad |
|---|---|---|---|
| PN09 | ¿Qué proporción de las reseñas escribe el grupo pequeño de usuarios más activos? | Medir la concentración de la voz de los usuarios | S |
| PN10 | ¿Cuántos usuarios reseñan una sola vez frente a los recurrentes? | Estimar la fidelidad del usuario | S |
| PN11 | ¿Qué proporción de reseñas son anónimas y cómo difieren en calificación y utilidad frente a las identificadas? | Evaluar la confiabilidad de la señal anónima | D |

## 6. Insumo del modelo analítico

### 6.1 Nivel de detalle mínimo (insumo del grano)

Todas las preguntas se pueden responder con **una reseña individual** como unidad más pequeña. Ninguna pide un detalle inferior a la reseña. PN08 (longitud y votos por reseña) y PN11 (anonimato por reseña) exigen no agregar antes de tiempo, porque agregar mensualmente perdería esas lecturas.

> Esto es un **insumo**, no una decisión. El grano se declara en una frase en `04-modelo-oro`, según el principio I.

### 6.2 Qué se calcula y cómo se corta

| ID | Qué se calcula | Se corta por |
|---|---|---|
| PN01 | Conteo de reseñas; la estacionalidad se lee comparando el mismo mes entre años | Mes |
| PN02 | Conteo de productos distintos y de usuarios distintos | Mes |
| PN03 | Promedio de calificación (suma de calificaciones ÷ número de reseñas) | Mes |
| PN04 | Conteo de reseñas por calificación; porcentaje de extremas (reseñas con 1 o 5 ÷ todas las reseñas del corte; intermedias = 2, 3 y 4) | Calificación, mes |
| PN05 | Conteo de reseñas; promedio de calificación; ranking de los 10 productos con más reseñas (DQ-25); empates por mayor calificación promedio y después por identificador de producto (DQ-29) | Producto |
| PN06 | Conteo y promedio, con umbral mínimo de volumen (DQ-11) y calificación promedio ≤ 2,5 (DQ-18) | Producto |
| PN07 | Porcentaje con al menos un voto útil (reseñas con votos útiles ≥ 1 ÷ todas las reseñas del corte, DQ-22); razón votos útiles / votos totales. Se presenta en dos cortes separados, por mes y por calificación, sin cruzarlos (DQ-35) | Mes, calificación |
| PN08 | Razón de utilidad; longitud del texto en palabras (DQ-24) | Calificación, rango de longitud (rangos definidos en `02`, DQ-24) |
| PN09 | Parte de las reseñas que aporta el grupo más activo (corte definido en `02`, DQ-17) | Usuario (solo agregado) |
| PN10 | Conteo de usuarios con exactamente 1 reseña frente a usuarios recurrentes (2 o más reseñas), contadas en la ventana completa (DQ-26) | Usuario (solo agregado) |
| PN11 | Porcentaje de anónimas; promedio de calificación y razón de utilidad | Anónima / identificada, mes |
| PN12 | Conteo y promedio | Día de la semana |

### 6.3 Dimensiones candidatas (nombres de negocio, no de tablas)

- **Fecha** (día, semana, mes, año, día de la semana).
- **Producto** (el identificador; el título solo como etiqueta legible en T2, sin análisis; el precio no se usa, DQ-13).
- **Usuario**: quien escribe la reseña (identificado o anónimo). Las reseñas anónimas no cuentan como un usuario en PN02, PN09 y PN10 (DQ-04, DQ-15); en todas las PN sí cuentan como reseñas. No se confunde con el analista que consulta los tableros (sección 4).
- **Mes** con indicador de **mes parcial** (primer y último mes de la ventana; DQ-03).
- **Calificación** (1 a 5).

### 6.4 Advertencias para el diseño

- Los **conteos de productos distintos y de usuarios distintos** (PN02, PN10) no se pueden sumar entre cortes sin repetir elementos. `04-modelo-oro` DEBE tenerlo en cuenta al clasificar medidas.
- Los **promedios y las razones** (PN03, PN07) se calculan como suma entre suma, no promediando promedios.
- La **razón de utilidad** es la ponderada: suma de votos útiles ÷ suma de votos totales (DQ-02). El «% con al menos un voto útil» se mide aparte y su denominador son todas las reseñas del corte, incluidas las de cero votos totales (DQ-22). La razón de una sola reseña no existe cuando esa reseña tiene cero votos totales; PN07 y PN08 exigen una regla clara en `02-exploracion-eda`. PN08 se calcula como suma ÷ suma por calificación y rango de longitud, sin mínimo de votos. Solo si una lectura futura muestra la razón por producto, entran los productos con un mínimo de votos totales, para que un 1 de 1 no se lea como 100 % de utilidad; el valor lo fija `02` con datos (DQ-23, DQ-27).

## 7. Insumo de los tableros

| Tablero | Para quién | Preguntas |
|---|---|---|
| **T1 — Panorama de reseñas** | Analista de experiencia del cliente | PN01, PN02, PN03, PN04, PN12 |
| **T2 — Productos** | Analista de experiencia del cliente | PN05, PN06 |
| **T3 — Usuarios y utilidad** | Analista de experiencia del cliente | PN07, PN08, PN09, PN10, PN11 |

La primera entrega de `05-dashboards-bi` DEBE cubrir todas las preguntas de prioridad **D**.

## 8. Fuera de alcance de negocio

Preguntas descartadas por falta de dato o de enfoque:

- Ventas, devoluciones o margen: la fuente no los trae. El precio y el título sí vienen, pero no se analizan: el precio queda fuera y el título solo identifica el producto en T2 (DQ-13).
- Análisis por categoría, marca o geografía: la fuente no los trae.
- Sentimiento o temas del texto: requiere técnicas fuera del enfoque SQL del proyecto (principio V).
- Predicciones o recomendaciones personalizadas.
- Identificar a una persona o cruzar con otras fuentes (constitución, Seguridad del dato). Las preguntas sobre usuarios (PN09, PN10, PN11) se responden **solo de forma agregada**.

## 9. Requisitos

- **RF-00-01 (Ubicuo):** Cada pregunta DEBE tener un identificador `PNxx`, una decisión que apoya y una prioridad. *Verif.:* revisión por lista (CE-00-01).
- **RF-00-02 (Ubicuo):** Cada pregunta DEBE poder responderse solo con los campos de la sección 3. *Verif.:* columna «Disponible con los campos» de la sección 11.
- **RF-00-03 (No deseado):** SI una pregunta pretende identificar a una persona, ENTONCES la especificación DEBE descartarla. *Verif.:* revisión por lista (CE-00-01).
- **RF-00-04 (Ubicuo):** Cada pregunta DEBE asignarse a un tablero (sección 7). *Verif.:* revisión por lista (CE-00-01).
- **RF-00-05 (Por evento):** Cuando una pregunta cortada por mes (PN01, PN02, PN03, PN04, PN07 y PN11) incluya el primer o el último mes de la ventana, el tablero DEBE mostrarlos marcados como «mes parcial», sin excluirlos ni normalizarlos. *Verif.:* T1 y T3 muestran la marca en 2010-03 y 2013-03.
- **RF-00-06 (Por evento):** CUANDO cambie una pregunta, la especificación DEBE actualizarse antes que cualquier otro documento (principio XII). *Verif.:* el último cambio de una PN, de un requisito o de las secciones 6 y 7 aparece en la spec antes o en el mismo cambio que en la matriz, el plan y las tareas (V-00-07; DQ-33).
- **RF-00-07 (Ubicuo):** Cada pregunta DEBE tener un estado en la sección 11: Propuesta, Validada o Confirmada con datos. *Verif.:* revisión de la tabla de la sección 11.
- **RF-00-08 (Por evento):** CUANDO PN02, PN09 o PN10 cuenten usuarios, el cálculo DEBE excluir las reseñas anónimas (DQ-04, DQ-15). *Verif.:* el conteo de usuarios de PN02, PN09 y PN10 no incluye reseñas anónimas.
- **RF-00-09 (Ubicuo):** Las preguntas sobre usuarios (PN09, PN10, PN11) DEBEN responderse solo de forma agregada (sale de RF-00-03, DQ-30). *Verif.:* revisión por lista (CE-00-01).
- **RF-00-10 (Por evento):** CUANDO cambie una pregunta de negocio, un requisito o las secciones 6 y 7 de la especificación, el plan, las tareas y los insumos del grano DEBEN regenerarse y declarar la versión de la spec que usaron; registrar aprobaciones, firmas o fechas en la sección 11 no exige regenerarlos (sale de RF-00-06, DQ-30, DQ-32). *Verif.:* encabezados «Basada en» de plan y tareas frente a la fecha del último cambio de PN, requisitos o secciones 6 y 7.
- **RF-00-11 (Por evento):** CUANDO PN02, PN09 o PN10 excluyan reseñas anónimas, el resultado DEBE informar cuántas se excluyeron (sale de RF-00-08, PN11, DQ-30). *Verif.:* el resultado de PN02, PN09 y PN10 muestra el conteo de anónimas excluidas.

### Requisitos no funcionales de legibilidad (Const. XIII)

*Perfil junior*, *sin ayuda* y *artefacto* tienen el significado del principio XIII de la constitución.

- **RNF-00-01 (Por evento):** Cuando se entregue el catálogo de preguntas de negocio, cada pregunta DEBE poder ser entendida por una persona de perfil junior —o, en la `00`, por un agente en contexto limpio con la firma del responsable (anexo 2 de D-00-01, DQ-34)— usando solo el catálogo y el glosario (Const. XIII, XIII.7). *Verif.:* lectura en frío firmada (CE-00-05).
- **RNF-00-02 (Ubicuo):** El catálogo DEBE definir en el glosario cada término de dominio y cada sigla que use, con un solo nombre por concepto (Const. XIII.6). *Verif.:* términos fuera del glosario = 0.
- **RNF-00-03 (Ubicuo):** Cada pregunta de negocio DEBE nombrar su medida, sus cortes y su nivel de detalle esperado con nombres completos, sin abreviaturas (Const. XIII.4). *Verif.:* inspección de las secciones 6.1 (nivel de detalle) y 6.2 (medida y cortes).
- **RNF-00-04 (Ubicuo):** Cada documento de esta especificación DEBE citar los IDs de los requisitos que atiende (Const. XIII.5). *Verif.:* documentos sin ID = 0.

## 10. Criterios de éxito

- **CE-00-01:** El 100 % de las preguntas cumple RF-00-01 a RF-00-04 y RF-00-09 (revisión por lista).
- **CE-00-02:** Cada tablero tiene al menos tres preguntas, salvo T2, que puede tener dos.
- **CE-00-03:** Todas las preguntas de prioridad D están **validadas** (sección 11): validación de negocio y documental. La confirmación con datos ocurre en `01` y `02`; si una pregunta resulta imposible de responder, se reabre `00` (RF-00-06).
- **CE-00-04:** El insumo del grano (6.1) y la tabla de cálculos (6.2) quedan firmados por el responsable de esta especificación; el responsable de Oro los acepta al aclarar `04-modelo-oro` (sección 13, DQ-34).
- **CE-00-05 (legibilidad):** Una persona de perfil junior distinta del autor —o, en la `00`, un agente en contexto limpio con la firma del responsable (anexo 2 de D-00-01, DQ-34)— responde correctamente las cinco preguntas estándar del principio XIII.7 sobre una muestra del catálogo, sin consultar al autor. Evidencia: `checklists/legibilidad.md` firmado.

## 11. Validación

Estados: **Propuesta** → **Validada** (el responsable y el segundo validador la aprueban con el análisis de la sección 3; no hay datos todavía) → **Confirmada con datos** (se comprueba con consultas propias, principio XI, después de `01-ingesta-bronce` y `02-exploracion-eda`). `00` se cierra con las preguntas D en «Validada».

| ID | Disponible con los campos | Aprobada por | Fecha | Estado |
|---|---|---|---|---|
| PN01 | `time` | Dario Andres Bernate Canas | 2026-10-19 | Validada |
| PN02 | `time`, `productId`, `userId` | Dario Andres Bernate Canas | 2026-10-19 | Validada |
| PN03 | `time`, `score` | Dario Andres Bernate Canas | 2026-10-19 | Validada |
| PN04 | `score`, `time` | Dario Andres Bernate Canas | 2026-10-19 | Validada |
| PN05 | `productId`, `score` | Dario Andres Bernate Canas | 2026-10-19 | Validada |
| PN06 | `productId`, `score` | | | Propuesta |
| PN07 | `helpfulness`, `time`, `score` | Dario Andres Bernate Canas | 2026-10-19 | Validada |
| PN08 | `helpfulness`, `score`, `text` | | | Propuesta |
| PN09 | `userId` | | | Propuesta |
| PN10 | `userId` | | | Propuesta |
| PN11 | `userId`, `profileName`, `score`, `helpfulness`, `time` | Dario Andres Bernate Canas | 2026-10-19 | Validada |
| PN12 | `time`, `score` | | | Propuesta |

Nota: las siete preguntas de prioridad D (PN01 a PN05, PN07 y PN11) las aprobó Dario Andres Bernate Canas el 2026-10-19 en los dos roles que fija DQ-10 (responsable de la spec y segundo validador). Las de prioridad S y P siguen en «Propuesta» a propósito: la `00` se cierra con las D en «Validada» (sección 10, CE-00-03).

## 12. Preguntas abiertas y decisiones

| ID | Pregunta | Estado | Cierre (decisión o ADR) |
|---|---|---|---|
| DQ-01 | ¿Cómo se cierra `00` sin datos de Bronce? | Resuelta | Validación en dos etapas (sección 11) |
| DQ-02 | Definición de la razón de utilidad (PN07, PN08) y del término «voto útil» | Resuelta | Ponderada: suma de votos útiles ÷ suma de votos totales |
| DQ-03 | ¿Cómo se tratan los meses parciales? | Resuelta | Se muestran marcados (RF-00-05) |
| DQ-04 | ¿Cómo se tratan las reseñas anónimas en PN09 y PN10? | Resuelta | Se excluyen e informan aparte (RF-00-08) |
| DQ-05 | ¿El curso exige un rol o un número de tableros? | Resuelta | No exige; se mantiene |
| DQ-06 | Momento de firma de ADR-0006 y ADR-0007 | Resuelta | Firmados el 2026-10-19, antes de `/tasks` de esta spec |
| DQ-07 | Nombre del archivo de tareas | Resuelta | ADR-0006: `task.md` (firmado el 2026-10-19) |
| DQ-08 | Cómo leen la constitución los agentes | Resuelta | ADR-0007: `memory/` en la raíz más `instructions` en `opencode.json` (firmado el 2026-10-19) |
| DQ-10 | Responsable de la spec y segundo validador | Resuelta | Dario Andres Bernate Canas en ambos roles para `00` a `03`; Dario valida siempre los Pull Request |
| DQ-11 | Umbral de volumen mínimo de reseñas por producto (solo PN06, DQ-28) | Diferida | `02-exploracion-eda`, con datos |
| DQ-12 | Lista de campos y significado de «anónima» contra los datos reales | Diferida | `01-ingesta-bronce` y `02-exploracion-eda` |
| DQ-13 | La fuente trae título y precio del producto: ¿entran en el alcance (p. ej. precio frente a calificación)? | Resuelta | Fuera del análisis; el título solo como etiqueta legible en T2 |
| DQ-14 | Zona horaria con la que se convierte la fecha de la reseña a día, mes y día de la semana | Resuelta | UTC siempre |
| DQ-15 | ¿Las reseñas anónimas cuentan en los usuarios distintos por mes de PN02? | Resuelta | Se excluyen y se documentan como regla (acción y conteo en bitácora, spec 02) |
| DQ-16 | ¿Qué requisitos y criterio de legibilidad (Const. XIII) lleva la spec? | Resuelta | RNF-00-01 a RNF-00-04 y CE-00-05, según la propuesta del plan §5.4 |
| DQ-17 | ¿Qué es el «grupo pequeño de usuarios más activos» de PN09 (porcentaje o cantidad de usuarios)? | Diferida | `02-exploracion-eda`, con la distribución real de reseñas por usuario |
| DQ-18 | ¿Qué es «calificación baja» en PN06? | Resuelta | Calificación promedio del producto ≤ 2,5 |
| DQ-19 | ¿A qué preguntas aplica la marca de «mes parcial» de RF-00-05? | Resuelta | A toda pregunta cortada por mes: PN01, PN02, PN03, PN04, PN07 y PN11 |
| DQ-20 | ¿Qué término único nombra a quien escribe la reseña: «usuario», «reseñador» o «cliente»? | Resuelta | «Usuario» |
| DQ-21 | Formato de los IDs y modal de los requisitos (D-00-07 del plan) | Resuelta | `RF-00-MM`, `RNF-00-MM`, `CE-00-MM` y `DEBE`, aplicados ya en `00` |
| DQ-22 | ¿Sobre qué total se calcula el «% con al menos un voto útil» de PN07? | Resuelta | Sobre todas las reseñas del corte |
| DQ-23 | ¿Hace falta un mínimo de votos totales para leer la razón de utilidad en cortes chicos? | Diferida | Sí, solo en una lectura por producto (DQ-27); el valor lo fija `02-exploracion-eda` con datos |
| DQ-24 | ¿En qué unidad se mide la longitud del texto de PN08 y cuáles son sus rangos? | Resuelta (unidad) / Diferida (rangos) | En palabras; qué cuenta como palabra y los rangos los fija `02-exploracion-eda` con datos |
| DQ-25 | ¿Cuántos productos muestra el ranking de PN05 en T2? | Resuelta | Top 10 |
| DQ-26 | ¿En qué periodo se cuentan las reseñas de cada usuario para clasificarlo en PN10 como «una sola vez» o «recurrente»? | Resuelta | Ventana completa; recurrente = 2 o más reseñas |
| DQ-27 | ¿Cómo aplica a PN08 el mínimo de votos de DQ-23? | Resuelta | PN08 usa suma ÷ suma sin mínimo; el mínimo queda solo para una lectura por producto |
| DQ-28 | ¿El umbral de volumen de DQ-11 aplica también a PN05? | Resuelta | No: solo a PN06; el Top 10 de PN05 ya elige los productos de mayor volumen |
| DQ-29 | ¿Cómo se desempata el puesto 10 del Top 10 de PN05? | Resuelta | Por mayor calificación promedio y, si persiste, por identificador de producto en orden alfabético |
| DQ-30 | ¿Se parten RF-00-03, RF-00-06 y RF-00-08, que tienen dos respuestas cada uno? | Resuelta | Sí: las segundas respuestas pasan a RF-00-09, RF-00-10 y RF-00-11 |
| DQ-31 | ¿Se crea un validador automático en Python del catálogo de preguntas (D-00-03 del plan)? | Resuelta | No; basta la verificación humana V-00-01 |
| DQ-32 | ¿Registrar aprobaciones en la sección 11 obliga a regenerar plan y tareas (RF-00-10)? | Resuelta | No: solo los cambios de PN, de requisitos o de las secciones 6 y 7 |
| DQ-33 | ¿Qué compara la verificación de RF-00-06 tras acotar RF-00-10 (DQ-32)? | Resuelta | El último cambio de fondo (PN, requisitos, secciones 6 y 7), no la «Última actualización» |
| DQ-34 | ¿Quién firma el insumo de Oro (CE-00-04) y quién lee en frío la `00`? | Resuelta | Firma el responsable de la `00`; Oro acepta en la `04`. La lectura en frío la hace un agente en contexto limpio (anexo 2 de D-00-01) |
| DQ-35 | ¿PN07 se cruza por mes y por calificación o son dos cortes separados? | Resuelta | Dos cortes separados; no se cruzan |
| DQ-36 | ¿El 2013-03-04 entra en la ventana de datos? | Resuelta | Sí: la ventana es cerrada en ambos extremos |

### Decisiones tomadas
- **2026-10-19 · DQ-36:** la ventana de datos es cerrada en ambos extremos: el 2010-03-04 y el 2013-03-04 cuentan. *Motivo:* la fuente declara 9.707.634 reseñas entre esas fechas y el último mes se marca como parcial, no se recorta. *Consecuencia:* sección 3; RF-00-05 y los cortes por mes (PN01, PN02, PN03, PN04, PN07 y PN11).
- **2026-10-19 · DQ-35:** PN07 se presenta en dos cortes separados, por mes y por calificación, sin cruzarlos. *Motivo:* el cruce mes × calificación fragmenta el denominador y produce celdas vacías; la pregunta se responde con la tendencia mensual y la comparación por calificación. *Consecuencia:* sección 6.2 y PN07 en el tablero T3 de la sección 7.
- **2026-10-19 · DQ-34:** CE-00-04 lo firma el responsable de la `00` (Dario Andres Bernate Canas); el responsable de Oro (Jose Julio Gomez Palmera) acepta la sección 6 al aclarar `04-modelo-oro`. Jose Julio no firma ni verifica las especificaciones `00` a `03`. *Motivo:* la `00` es trabajo del responsable; Oro firma lo suyo cuando reciba las especificaciones hasta la `03` (decisión del responsable). *Consecuencia:* CE-00-04 y sección 13; plan C-00-21 y C-00-22, S-00-04 y §9; T-00-25, T-00-38 y T-00-55 cambian de responsable; anexo 2 de D-00-01.
- **2026-10-19 · DQ-33:** la verificación de RF-00-06 compara el último cambio de una PN, de un requisito o de las secciones 6 y 7, igual que V-00-07, y no la «Última actualización» de la spec. *Motivo:* con DQ-32, las firmas de la sección 11 cambian la fecha de la spec sin cambiar el fondo; la verificación literal fallaría tras T-00-23 (hallazgo 1 de la pasada 3 de `/analyze`). *Consecuencia:* sección 9; plan y tareas actualizan su «Basada en».
- **2026-10-19 · DQ-32:** RF-00-10 se acota: regenerar plan y tareas solo cuando cambie una PN, un requisito o las secciones 6 y 7; las aprobaciones, firmas y fechas de la sección 11 no lo exigen. *Motivo:* el fin de RF-00-10 es que plan y tareas no trabajen sobre una pregunta vieja, y una firma no cambia lo que se construye; sin el acote, V-00-07 fallaría por diseño tras T-00-23 y T-00-25 (hallazgo 1 de `/analyze` T-00-10). *Consecuencia:* sección 9; V-00-07 compara contra la fecha del último cambio de fondo.
- **2026-10-19 · DQ-31 (D-00-03):** no se crea validador automático en Python para el catálogo de preguntas. *Motivo:* son 12 preguntas que cambian poco y la verificación humana V-00-01 las revisa en minutos. *Consecuencia:* la condición 1 de la compuerta se cumple con CE-00-01 a CE-00-04 y la sección 11 firmada (D-00-01), sin `pytest`; plan y tareas retiran las pruebas de Python de la 00.
- **2026-10-19 · DQ-30:** RF-00-03, RF-00-06 y RF-00-08 se parten en requisitos de una sola respuesta; las segundas respuestas pasan a RF-00-09 (respuesta agregada), RF-00-10 (regenerar plan y tareas) y RF-00-11 (informar anónimas excluidas), y las palabras clave van en mayúsculas. *Motivo:* convención de requisitos (una respuesta por requisito, una prueba por requisito); hallazgo 11 de `/analyze` y cambio 4 de plan §5.4. *Consecuencia:* sección 9; CE-00-01 cubre ahora RF-00-01 a RF-00-04 y RF-00-09; plan y tareas deben citar los nuevos IDs.
- **2026-10-19 · DQ-29:** los empates del Top 10 de PN05 se resuelven por mayor calificación promedio y, si persisten, por identificador de producto en orden alfabético. *Motivo:* T2 muestra siempre exactamente 10 productos con un criterio fijo y reproducible (hallazgo de `/analyze`). *Consecuencia:* sección 6.2; la verificación de `05` comprueba 10 filas.
- **2026-10-19 · DQ-28 (corrige DQ-11):** el umbral de volumen mínimo aplica solo a PN06; PN05 no lo usa. *Motivo:* el Top 10 de PN05 (DQ-25) se ordena por número de reseñas, así que el filtro no cambiaría el resultado; en PN06 evita que un producto con una sola reseña baja aparezca como de riesgo (hallazgo 9 de `/analyze`). *Consecuencia:* fila DQ-11.
- **2026-10-19 · DQ-27 (corrige DQ-23):** PN08 se calcula como suma ÷ suma por calificación y rango de longitud, sin mínimo de votos; el mínimo de DQ-23 aplica solo a una lectura de utilidad por producto y se retira la palabra «rankings». *Motivo:* al agregar por rango, suma ÷ suma ya evita que un 1 de 1 pese como 100 % y no descarta reseñas; ninguna PN ordena productos por utilidad (hallazgo 8 de `/analyze`). *Consecuencia:* sección 6.4 y fila DQ-23.
- **2026-10-19 · DQ-26:** en PN10, las reseñas de cada usuario se cuentan en la ventana completa (2010-03-04 a 2013-03-04); «una sola vez» = exactamente 1 reseña y «recurrente» = 2 o más. *Motivo:* la fidelidad se ve en el tiempo largo; contar por año clasificaría como «una sola vez» a quien reseña en años distintos. *Consecuencia:* sección 6.2; una sola cifra por grupo, sin corte por año.
- **2026-10-19 · DQ-25:** el ranking de PN05 en T2 muestra los 10 productos con más reseñas. *Motivo:* es lo más compacto y se lee de un vistazo; es una decisión de presentación que no depende de datos. *Consecuencia:* sección 6.2; `05-dashboards-bi` comprueba que T2 muestra exactamente 10 productos; el umbral de volumen de DQ-11 sigue aplicando a PN06.
- **2026-10-19 · DQ-24:** la longitud del texto de PN08 se mide en palabras; qué cuenta como palabra y los rangos de longitud se difieren a `02-exploracion-eda`. *Motivo:* es la lectura que un analista entiende como «reseña larga» y no se infla con signos ni espacios; fijar rangos sin la distribución real sería inventar cifras. *Consecuencia:* sección 6.2 y herencia de `02`.
- **2026-10-19 · DQ-23:** la razón de utilidad leída por producto o por reseña (PN08 y rankings) exige un mínimo de votos totales; el valor se difiere a `02-exploracion-eda`. *Motivo:* evita que un 1 de 1 se lea como 100 % sin inventar una cifra antes de ver la distribución real de votos; mismo criterio que DQ-11. *Consecuencia:* sección 6.4 y herencia de `02`; el umbral es sobre votos totales, no sobre votos útiles, para no sesgar la razón hacia arriba.
- **2026-10-19 · DQ-22:** el «% con al menos un voto útil» de PN07 se calcula como reseñas con votos útiles ≥ 1 ÷ todas las reseñas del corte. *Motivo:* es la lectura literal de la pregunta y no depende de la regla de cero votos totales que fija `02`. *Consecuencia:* secciones 6.2 y 6.4; las reseñas con cero votos totales cuentan en el denominador.
- **2026-10-15 · DQ-21 (D-00-07):** los IDs pasan a `RF-00-MM`, `RNF-00-MM` y `CE-00-MM` y el único modal es `DEBE`, desde esta spec. *Motivo:* la constitución lo exige (Flujo de desarrollo, XIII.5) y así un ID citado desde cualquier capa dice de qué spec viene; no hace falta ADR de excepción. *Consecuencia:* se renombran todas las citas de la spec; RF-00-08 incluye PN02 (DQ-15) y su sujeto pasa a «el cálculo»; la compuerta de §13 lista las seis condiciones con CE-00-05; `plan.md` y las tareas deben usar los nuevos IDs.
- **2026-10-15 · DQ-20:** el único término para quien escribe la reseña es «usuario»; se retiran «reseñador» y «cliente» en ese sentido. *Motivo:* un solo nombre por concepto (Const. XIII.6) y coincide con el campo `userId`. *Consecuencia:* secciones 5 y 6.3; «cliente» se conserva solo dentro del nombre del rol «analista de experiencia del cliente»; el glosario debe registrar «usuario».
- **2026-10-15 · DQ-19:** la marca de «mes parcial» aplica a toda pregunta cortada por mes (PN01, PN02, PN03, PN04, PN07 y PN11). *Motivo:* una sola regla para todos los tableros, coherente con DQ-03; evita leer como caída el volumen de un mes incompleto. *Consecuencia:* RF-00-05 y sección 3; T1 y T3 llevan la marca. Se corrige también la consecuencia de DQ-14 (el día de la semana es de PN12, no de PN06) y la cita «principio XV», que la constitución v1.1.0 no define, pasa a Const. XIII.5.
- **2026-10-15 · DQ-18:** en PN06, «calificación baja» es una calificación promedio del producto ≤ 2,5. *Motivo:* queda por debajo del punto medio de la escala 1–5 y es una regla fija que se comprueba sin datos. *Consecuencia:* secciones 5 y 6.2; el umbral de volumen sigue diferido a `02` (DQ-11).
- **2026-10-15 · DQ-17:** el corte del «grupo más activo» de PN09 se difiere a `02-exploracion-eda`. *Motivo:* elegirlo sin ver la distribución real sería inventar una cifra. *Consecuencia:* `02` fija el corte con su motivo; PN09 sigue siendo prioridad S y no bloquea el cierre de `00`.
- **2026-10-15 · DQ-13:** título y precio quedan fuera del análisis; ninguna pregunta los usa. El título puede mostrarse en T2 solo como etiqueta legible del producto. *Motivo:* ninguna PN los necesita y el precio llega a menudo como «unknown», lo que exigiría reglas de calidad adicionales. *Consecuencia:* secciones 3, 6.3 y 8; `01` confirma que el título llega y `02` no necesita perfilar el precio.
- **2026-10-15 · DQ-16:** se agregan RNF-00-01 a RNF-00-04 y CE-00-05 de legibilidad, y la línea de principios transversales aplicables. *Motivo:* la Tabla XIII-C de la constitución los exige en `spec.md`; se adopta la redacción propuesta en plan §5.4. *Consecuencia:* el plan y las tareas deben referenciar estos IDs; la lectura en frío entra en el cierre.
- **2026-10-14 · Corrección:** la fuente tiene diez campos (se agregan `title` y `price`), no ocho. *Motivo:* lo confirma la documentación oficial de SNAP. *Consecuencia:* secciones 3, 6.3 y 8; DQ-13 decide si se usan.
- **2026-10-14 · DQ-14:** las fechas se convierten siempre con UTC. *Motivo:* regla única, reproducible y coincide con el corte de la constitución. *Consecuencia:* los meses de PN01, PN02, PN03, PN04, PN07 y PN11 y el día de la semana de PN12 usan UTC.
- **2026-10-14 · DQ-15:** PN02 excluye las reseñas anónimas y esa exclusión se documenta como una regla (con su acción y su conteo en la bitácora). *Consecuencia:* se define en `02-exploracion-eda`; igual que PN09, PN10 y PN11.
- **2026-10-14 · Formato:** los requisitos de la sección 9 pasan a EARS.
- **2026-10-14 · DQ-01:** `00` se cierra con validación de negocio y documental; la confirmación con datos pasa a `01` y `02`. *Motivo:* respeta el orden del principio XII y la variante de cierre de `00`. *Consecuencia:* estados de la sección 11; si una pregunta resulta imposible se reabre `00`.
- **2026-10-14 · DQ-03:** el primer y el último mes se muestran marcados como «mes parcial». *Motivo:* no pierde información ni confunde el volumen con una caída. *Consecuencia:* la dimensión fecha lleva ese indicador (6.3).
- **2026-10-14 · DQ-04:** las reseñas anónimas se excluyen del cálculo de usuarios de PN09 y PN10 y se informan aparte. *Motivo:* evita que todas parezcan un solo usuario. *Consecuencia:* RF-00-08; `01` y `02` DEBEN confirmar cómo aparecen en la fuente, con regla, acción y conteo en la bitácora, para dejar trazabilidad (Const. XIII.5).
- **2026-10-14 · DQ-05:** el curso no exige rol ni número de tableros. *Consecuencia:* se mantienen el rol de la sección 4 y los tres tableros.
- **2026-10-14 · DQ-02:** la razón de utilidad se calcula como suma de votos útiles ÷ suma de votos totales; el % con al menos un voto útil se mide aparte. *Motivo:* coherente con la regla de suma entre suma y no se distorsiona con reseñas de pocos votos. *Consecuencia:* medida no aditiva; `02` define la regla para reseñas con cero votos totales.
- **2026-10-14 · DQ-10:** para `00` a `03`, Dario Andres Bernate Canas es el responsable y también el segundo validador, y verifica los Pull Request manualmente en GitHub con SQL. Para `04`, `05` y `06` el responsable es Jose Julio Gomez Palmera y el segundo validador, Dario. *Consecuencia:* `docs/gestion/roles.md` lo refleja.
- **2026-10-14 · DQ-06:** ADR-0006 y ADR-0007 se firman antes de `/tasks` de esta spec. *Consecuencia:* los ADR y la constitución se alinean fuera de esta spec.

## 13. Entregables y cierre

- `specs/00-preguntas-negocio/spec.md` (este archivo), `plan.md` y el archivo de tareas (nombre según ADR-0006).
- Entradas en `docs/gestion/tareas.md` con su evidencia.
- Sección 11 completa y firmada.

**Compuerta de cierre** (las seis condiciones de la constitución; la variante de la `00` está firmada en `adr/D-00-01-compuerta-de-cierre-sin-datos.md`): (1) en lugar de tests, criterios CE-00-01 a CE-00-04 cumplidos y sección 11 firmada; (2) cuadre exacto: no aplica, `00` no mueve datos; (3) verificación humana del responsable; (4) documentación de la entrega actualizada (`plan.md` con su Constitution Check); (5) checklist de legibilidad firmado tras la lectura en frío (CE-00-05); (6) Pull Request integrado a `main`.

**Qué heredan las siguientes especificaciones**
- `01-ingesta-bronce`: confirmar los diez campos de la sección 3 y cómo aparecen las reseñas anónimas (campo ausente o valor repetido); documentar el DDL (esquema, tablas, campos, tipos y restricciones) y el flujo de los scripts SQL (orden, qué hace cada uno y qué produce); verificar que la ventana incluya el 2013-03-04 completo (DQ-36) contra el conteo de 9.707.634.
- `02-exploracion-eda`: regla de anonimato (con acción y conteo en la bitácora), `helpfulness` con cero votos totales, meses parciales, umbral de volumen de PN06 (DQ-11), mínimo de votos totales para una lectura de utilidad por producto (DQ-23, DQ-27), definición de palabra y rangos de longitud de PN08 (DQ-24) y corte del grupo más activo de PN09 (DQ-17); además, la regla que excluye las reseñas anónimas del conteo de usuarios (RF-00-08) y su conteo de excluidas (RF-00-11).
- `04-modelo-oro`: sección 6 completa; su responsable la acepta o pide cambios en el `/clarify` de la `04` (DQ-34).
- `05-dashboards-bi`: sección 7; la marca de «mes parcial» en T1 y T3 (RF-00-05) y el conteo de anónimas excluidas en PN02, PN09 y PN10 (RF-00-11).
