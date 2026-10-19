# Glosario del proyecto — DWS de reseñas de Amazon

**Propósito:** definir en un solo lugar los términos de dominio, las siglas y los estados de capa del proyecto, con un nombre por concepto (Const. XIII.6) | **Autor:** agente principal (OpenCode), por encargo de Dario Andres Bernate Canas | **Fecha:** 2026-10-19 | **Constitución:** v1.1.0
**Dependencias:** `specs/00-preguntas-negocio/spec.md` §3, §5, §6 y §12; `specs/00-preguntas-negocio/plan.md` §15.1 y §15.2; `specs/00-preguntas-negocio/task.md` T-00-12 y T-00-15.
**IDs que atiende:** RNF-00-02 · Componente C-00-07 · D-00-04 · Tareas T-00-12 y T-00-15 (Const. XIII.4, XIII.6).

> Las 39 entradas de `plan.md` §15.1 se siembran en T-00-12; las entradas G-40 a G-49 agregan las siglas y los términos de `spec.md` y `plan.md` que faltaban (T-00-15). Si un término cambia, se cambia aquí y en la spec que lo usa; el glosario no reemplaza a la spec.

## Términos y siglas

| ID | Término | Definición |
|---|---|---|
| G-01 | DWS | Data Warehouse (almacén de datos) de reseñas de Amazon de este proyecto |
| G-02 | SNAP | Stanford Network Analysis Project, origen público del dataset (McAuley y Leskovec, 2013) |
| G-03 | PN (pregunta de negocio) | Pregunta que la persona analista necesita responder con los datos de reseñas; ID `PNnn` |
| G-04 | Prioridad D, S, P | D: debe estar en la primera entrega; S: debería; P: podría si hay tiempo |
| G-05 | DQ | Pregunta abierta o decisión registrada en la spec §12; ID `DQ-nn` |
| G-06 | RF | Requisito funcional: qué DEBE cumplir la especificación; ID `RF-NN-MM` |
| G-07 | RNF | Requisito no funcional: una cualidad exigida, como la legibilidad; ID `RNF-NN-MM` |
| G-08 | CE | Criterio de éxito: condición medible para dar la especificación por lograda; ID `CE-NN-MM` |
| G-09 | ADR | Registro de una decisión de arquitectura, firmado por el responsable |
| G-10 | EDA | Análisis exploratorio de datos (spec 02); de él nacen las reglas `Rnn` |
| G-11 | EARS | Forma de redactar requisitos en una oración con patrón fijo (plan §2) |
| G-12 | UTC | Tiempo universal coordinado; zona con la que se convierten las fechas (DQ-14) |
| G-13 | IDs del plan (C, V, U, T, D, S) | Componente `C-NN-MM`, verificación humana `V-NN-MM`, umbral `U-NN-MM`, tarea `T-NN-MM`, decisión propuesta `D-NN-xx` y supuesto `S-NN-nn` |
| G-14 | Medida | Valor que se calcula o agrega para responder una pregunta (un conteo, un promedio) |
| G-15 | Corte | Punto de vista por el que se agrupa una medida (mes, producto, calificación) |
| G-16 | Nivel de detalle mínimo | Unidad más pequeña que exigen las preguntas: una reseña (spec §6.1); insumo del grano |
| G-17 | Grano | Qué representa una fila de un hecho, dicho en una frase (lo declara la spec 04) |
| G-18 | Campo de la fuente | Cada uno de los diez campos de la spec §3 |
| G-19 | Ventana de datos | Periodo del 2010-03-04 al 2013-03-04 que cubre la fuente |
| G-20 | Reseña anónima | Reseña sin usuario identificable; la forma exacta de reconocerla `[POR DEFINIR en las specs 01 y 02, DQ-12]` |
| G-21 | Usuario | Persona seudónima que escribe reseñas (campo `userId`); término único fijado por la spec DQ-20. No se usan «reseñador» ni «cliente» en ese sentido; «cliente» solo aparece en el rol «analista de experiencia del cliente» |
| G-22 | Usuario de una sola vez | Usuario con exactamente 1 reseña en la ventana completa (PN10, DQ-26) |
| G-23 | Usuario recurrente | Usuario con 2 o más reseñas en la ventana completa (PN10, DQ-26, U-00-15) |
| G-24 | Mes parcial | Primer (2010-03) o último (2013-03) mes de la ventana, que no tiene todos sus días; se muestra marcado (RF-00-05) |
| G-25 | Voto útil | Voto que marca una reseña como útil; la fuente lo trae en `helpfulness` junto con los votos totales |
| G-26 | Razón de utilidad | Suma de votos útiles ÷ suma de votos totales del corte (DQ-02); no se promedian razones |
| G-27 | % con al menos un voto útil | Reseñas con votos útiles ≥ 1 ÷ todas las reseñas del corte, incluidas las de cero votos totales (PN07, DQ-22, U-00-16) |
| G-28 | Palabra | Unidad con la que se mide la longitud del texto en PN08 (DQ-24); qué cuenta como palabra `[POR DEFINIR en la spec 02, DQ-24]` |
| G-29 | Top 10 | Los 10 productos con más reseñas de PN05; los empates se resuelven por mayor calificación promedio y después por identificador de producto en orden alfabético (DQ-25, DQ-29, U-00-14) |
| G-30 | Calificación baja | Calificación promedio de un producto ≤ 2,5 (DQ-18, U-00-10) |
| G-31 | Tablero T1, T2, T3 | Panorama de reseñas, Productos, y Usuarios y utilidad (spec §7) |
| G-32 | Estados de una PN | Propuesta → Validada → Confirmada con datos (spec §11) |
| G-33 | Viabilidad | Si la fuente puede responder una pregunta: `viable`, `viable con reserva` o `no viable con esta fuente` |
| G-34 | Matriz de trazabilidad | Documento con una fila por PN que la une con sus campos, su tablero y las especificaciones que la atienden |
| G-35 | Lista de validación | Documento `checklists/validacion.md` con la evidencia de CE-00-01 a CE-00-04 |
| G-36 | Perfil junior | Persona que conoce SQL básico y Python básico, pero no el repositorio ni el dataset (Const. XIII) |
| G-37 | Lectura en frío | Revisión por una persona distinta del autor, que responde las cinco preguntas estándar sin consultarlo |
| G-38 | Capa (Bronce, Plata, Oro) | Cada etapa del modelo Medallion: `raw`, `silver`, `gold` |
| G-39 | Regla del EDA (`Rnn`) | Hallazgo del EDA convertido en regla con acción (descarta, corrige o marca) y conteo en la bitácora |
| G-40 | SQL | Lenguaje de consultas de PostgreSQL, el único motor del Data Warehouse |
| G-41 | DDL | Definición de datos: las sentencias que crean y documentan esquemas, tablas, campos, tipos y restricciones |
| G-42 | ETL | Extracción, transformación y carga: el flujo que lleva los datos de una capa a la siguiente |
| G-43 | ID | Identificador único de un requisito, una pregunta, una tarea, una decisión u otro objeto del proyecto |
| G-44 | README | Archivo de presentación de una capa o del repositorio; resume su contenido y su uso |
| G-45 | AGENTS.md | Archivo de instrucciones del repositorio para los agentes de OpenCode y Claude Code |
| G-46 | Pull Request | Solicitud de integración de una rama a `main`, revisada y aprobada por el responsable |
| G-47 | Kimball | Enfoque de modelado dimensional que organiza el análisis en hechos y dimensiones; lo usa la spec 04 |
| G-48 | Medallion | Arquitectura por capas (Bronce, Plata y Oro) que separa los datos crudos de los datos listos para análisis |
| G-49 | Compuerta de cierre | Conjunto de condiciones que una especificación DEBE cumplir antes de integrarse a `main`; en la spec 00 rige la variante de D-00-01 |
