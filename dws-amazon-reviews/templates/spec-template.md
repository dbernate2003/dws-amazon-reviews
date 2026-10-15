# Especificación [NN-nombre] — [Nombre de la entrega]

<!--
PLANTILLA spec.md. Cópiala a specs/NN-nombre/spec.md (una carpeta por spec; la crea scripts/new-spec.sh). Borra estos comentarios al terminar.
Base: GitHub Spec Kit, adaptada a un Data Warehouse (Kimball + Medallion) y a la constitución. NO lleva casos de usuario ni casos de aceptación: lo que se entrega son datos, capas y respuestas a preguntas de negocio; lo que se comprueba son requisitos, conteos y cuadres.
UNA SPEC = UNA UNIDAD: entrega valor, es un entregable y se puede construir y validar sola.
TAMAÑO: orientativo, entre 160 y 250 líneas. Si pasa de 300, divídela (agregar una especificación exige enmendar la constitución).
REGLAS
- Lo que está entre [CORCHETES] se reemplaza. Si una sección no aplica, bórrala o escribe "No aplica: [motivo]" (no la dejes vacía).
- QUÉ y POR QUÉ, nunca CÓMO: sin motores, lenguajes, herramientas, tablas ni código (principio XII). Eso va en plan.md.
- Todo requisito debe poder comprobarse: con una cifra, un archivo, una consulta o un comando. "Rápido" o "grande" no sirven.
- Un mismo término para una misma cosa en toda la spec. Lo no decidido: [NECESITA ACLARACIÓN: ...] (máx. 3 en el texto) + fila en la sección 6.
- Lee la constitución antes de redactar; si algo la contradice, gana ella. No reutilices requerimientos del modelo anterior (Fuera de alcance de la constitución). No resuelvas pendientes de ADR: propón el ADR y espera al responsable.
- Los requisitos no funcionales (costo $0, local, seguridad del dato, reproducibilidad, rendimiento) los fija la constitución; aquí solo van las cifras propias de esta entrega (sección 4).
FLUJO
/spec (llena esta plantilla) → /clarify → /plan → /analyze → /tasks → /implement. Comandos y skills en .opencode/ y .claude/.
IDs (convención de la constitución): RF-NN-MM, RQ-NN-MM, RNF-NN-MM, CE-NN-MM, donde NN es el número de la spec y MM el consecutivo. DEBE es el único modal.
Si algo cambia, primero se actualiza esta spec y luego se regeneran plan y tareas.
-->

| Campo | Valor |
|---|---|
| Rama | `[NN-nombre]` |
| Responsable de la entrega | [persona responsable] |
| Segundo validador | [persona que verifica el Pull Request] |
| Depende de | [spec anterior que ya pasó su compuerta, o "ninguna"] |
| Principios de la constitución aplicables | [I, III, VI…] |
| ADR relacionados | [números, o "ninguno"] |
| Versión de la constitución · Estado | [1.0.0] · Borrador |

---

## 1. RESUMEN

### ¿Qué se va a construir?
[Una o dos frases: la capa, el modelo o el insumo que se entrega. Sin tecnología.]

### ¿Para quién?
| Actor | Qué necesita de esta entrega |
|---|---|
| [Rol de negocio, o la spec que depende de esta] | [Necesidad] |
| [Actor 2] | [Necesidad] |

### ¿Qué problema resuelve y por qué ahora?
[Un párrafo: la necesidad y el valor de entregarlo en este punto del orden de specs.]

### ¿Cuál es el resultado esperado?
<!-- Criterios de éxito: medibles y sin nombrar tecnología. Uno de ellos es el de legibilidad (Const. XIII, tabla XIII-C). -->
- CE-NN-01: [Resultado con cifra, archivo o consulta que lo demuestre.]
- CE-NN-02: [Resultado medible.]
- CE-NN-03: Una persona de perfil junior, sin ayuda, responde las cinco preguntas de la lectura en frío sobre la muestra de artefactos de esta entrega (Const. XIII.7).

---

## 2. REQUISITOS

<!--
Cada requisito usa un patrón EARS (una oración, un patrón, sujeto con nombre, DEBE como único modal), tiene ID, dice cómo se verifica (de aquí salen las tareas y los tests) y, si hace falta ordenar, lleva prioridad D (debe) / S (debería) / P (podría).
Ubicuo: El sistema DEBE <respuesta>. | Por evento: Cuando <evento>, el sistema DEBE <respuesta>. | Por estado: Mientras <estado>, el sistema DEBE <respuesta>.
No deseado: Si <condición no deseada>, entonces el sistema DEBE <respuesta>. | Opcional: Donde <característica incluida>, el sistema DEBE <respuesta>.
Los datos inválidos, los duplicados y la re-ejecución del mismo paso se cubren aquí con el patrón "No deseado".
-->

### 2.1 Requisitos funcionales (RF)

#### [Área: por ejemplo, carga, limpieza, modelo, consumo]
- RF-NN-01 (Por evento) [D]: Cuando [evento], el sistema DEBE [respuesta]. *Verif.:* [test / consulta / comando]
- RF-NN-02 (No deseado) [D]: Si [condición no deseada, p. ej. fila inválida o re-ejecución], entonces el sistema DEBE [respuesta]. *Verif.:* [test / consulta / comando]
- RF-NN-03 (Por estado) [S]: Mientras [estado], el sistema DEBE [respuesta]. *Verif.:* [test / consulta / comando]
- RF-NN-04 (Ubicuo) [D]: El sistema DEBE [comportamiento permanente]. *Verif.:* [test / consulta / comando]

### 2.2 Requisitos de negocio (RQ) (si la spec responde preguntas del negocio)
- RQ-NN-01 (Ubicuo) [D]: El sistema DEBE permitir al [rol] [consultar o identificar algo]. *Verif.:* [consulta / tablero]

### 2.3 Requisitos no funcionales de legibilidad (Const. XIII)

<!-- Obligatorios (tabla XIII-C). Uno por tipo de artefacto que produzca esta entrega; los que no produzca, bórralos. Sin tecnología: se nombra el tipo de artefacto, no la herramienta. -->
- RNF-NN-01 (Ubicuo) [D]: Cada script de transformación de esta entrega DEBE cumplir las reglas de legibilidad de scripts (Const. XIII.1). *Verif.:* lectura en frío y revisión por lista.
- RNF-NN-02 (Ubicuo) [D]: Cada estructura de datos de esta entrega DEBE documentar su propósito y el de cada campo (Const. XIII.2). *Verif.:* consulta de estructuras y campos sin comentario = 0.
- RNF-NN-03 (Ubicuo) [D]: Cada prueba de esta entrega DEBE decir qué regla valida, por qué importa y qué pasa si falla (Const. XIII.3). *Verif.:* revisión por lista.
- RNF-NN-04 (Ubicuo) [D]: Cada artefacto de esta entrega DEBE citar el ID del requisito y la regla que atiende (Const. XIII.5). *Verif.:* todo ID citado existe en esta spec o en el catálogo de reglas.
- RNF-NN-05 (Ubicuo) [D]: Cada término nuevo de esta entrega DEBE quedar definido en el glosario del proyecto (Const. XIII.6). *Verif.:* revisión del glosario.

---

## 3. DATOS Y DOMINIO

<!-- Conceptos de negocio y sus relaciones, no tablas ni campos de base de datos (salvo los de la fuente). Si la spec no maneja datos: "No aplica: [motivo]". -->

- **Fuente y campos:** [qué trae la fuente, citando su documentación; lo que NO trae.]
- **Entidades y medidas:** [qué representa cada una, su nivel de detalle y cómo se relaciona con las demás.]
- **Calidad del dato que se anticipa:** [qué debe revisarse y en qué spec se confirma.]

---

## 4. RESTRICCIONES PROPIAS

<!-- Solo cifras de esta entrega; lo demás lo fija la constitución. Una línea por ítem, con valor y unidad. Si no aplica: "No aplica: [motivo]". -->

- **Volumen esperado:** [filas y MB]
- **Reproducibilidad:** [insumo de partida y conteo o cuadre esperado]
- **Otras:** [especificar]

---

## 5. FUERA DE ALCANCE

<!-- Lo que NO se construye en esta entrega. Además rige la sección "Fuera de alcance" de la constitución. -->

- [Funcionalidad excluida.]
- [Lo que corresponde a otra spec: `NN-nombre`.]

### Supuestos y restricciones heredadas
- [Supuesto que se da por válido.]
- [Restricción heredada de la constitución (cita el principio).]

### Principios transversales aplicables
- **XIII. Legibilidad y trazabilidad para perfiles junior:** aplica a todos los artefactos de esta entrega; se cumple con RNF-NN-01 a RNF-NN-05 y CE-NN-03.

---

## 6. PREGUNTAS ABIERTAS Y DECISIONES

<!-- Cada [NECESITA ACLARACIÓN] del texto tiene su fila. Estado: Pendiente | Resuelta | Diferida | Escalada a ADR. Lo que afecte a todo el proyecto se cierra con ADR y firma del responsable; el agente no lo resuelve. -->

| ID | Pregunta | Estado | Cierre (decisión, spec o ADR) |
|---|---|---|---|
| DQ-01 | [Pregunta pendiente.] | Pendiente | [—] |

### Decisiones tomadas
- **[AAAA-MM-DD] · DQ-xx:** [qué se decidió] · **Motivo:** [por qué] · **Consecuencia:** [cómo afecta a la entrega]

---

## 7. CRITERIOS DE FINALIZACIÓN

<!-- Los seis primeros espejan las seis condiciones de la compuerta de cierre de la constitución: no se quitan. Si la compuerta cambia, esta lista se actualiza. -->

- [ ] Los tests están en verde y cubren cada RF. *(Si no hay código: lista de validación firmada.)*
- [ ] El cuadre es exacto: entran = salen + rechazadas + eliminadas. *(Si no mueve datos: "No aplica: [motivo]".)*
- [ ] El responsable verificó con sus propias consultas (conteos, cuadres y muestras). Un agente no cierra la spec.
- [ ] La documentación de la entrega está actualizada y la tarea quedó registrada con su evidencia (archivo o commit).
- [ ] El checklist de legibilidad está firmado tras la lectura en frío (`specs/NN-nombre/checklists/legibilidad.md`, Const. XIII.7).
- [ ] El Pull Request está integrado a `main` y lo validó el segundo validador.
- [ ] [Criterio propio: otra condición verificable.]

---

## REVISIÓN FINAL

- [ ] **Contenido:** sin tecnología ni código; todas las secciones completas o con "No aplica".
- [ ] **Requisitos:** en EARS, con `DEBE` e IDs `RF/RQ/RNF/CE-NN-MM`, comprobables y sin ambigüedad; datos inválidos, duplicados y re-ejecución cubiertos.
- [ ] **Legibilidad (XIII):** hay RNF que citan `Const. XIII.n`, un CE de legibilidad y XIII en «Principios transversales aplicables».
- [ ] **Alcance:** exclusiones y supuestos documentados; dependencias identificadas; "Depende de" ya pasó su compuerta.
- [ ] **Trazabilidad:** cada RF, RQ y RNF tiene su verificación.
- [ ] **Preguntas:** cada [NECESITA ACLARACIÓN] tiene su fila en la sección 6; ningún pendiente de ADR se resolvió aquí.
- [ ] **Constitución:** nada la contradice ni reutiliza lo que deja fuera de alcance.
- [ ] **Tamaño:** orientativo 160–250 líneas; menos de 300.

**Estado de la especificación:** Borrador / En revisión / Aprobada
<!-- El agente la deja en Borrador o En revisión; la aprobación la da el responsable. -->

**Última actualización:** [AAAA-MM-DD]
