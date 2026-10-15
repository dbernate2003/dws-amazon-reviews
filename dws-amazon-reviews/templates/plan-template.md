# Plan técnico — [NN-nombre]

<!--
PLANTILLA DE PLAN TÉCNICO DEL DWS. Guárdala como templates/plan.md; scripts/new-spec.sh la copia a specs/NN-nombre/plan.md.
Cómo usarla:
- Todo lo que está entre [CORCHETES] se reemplaza. Borra estos comentarios al terminar.
- plan.md dice CÓMO. El qué y el porqué viven en spec.md: no los reescribas, cita su ID (RF-NN-MM).
- NO escribas código. Describe scripts, tablas y pruebas con tablas y oraciones. El código nace en /implement.
- Si algo no está decidido, no lo inventes: escribe [POR DEFINIR: ADR-nnnn] y llévalo a la sección 5.
- Las secciones marcadas (siempre) no se pueden borrar: la constitución las exige. Las marcadas (según capa) se
  conservan con "No aplica: <motivo>" cuando no corresponden; nunca se borran en silencio.
- Cada requisito del plan usa la convención de la sección 2: un requisito, un patrón, una respuesta, un ID.
- Todo lo que escribas aquí debe poder entenderlo una persona junior sin contexto (Principio XIII).
-->

**Rama**: `[NN-nombre]` | **Fecha**: [AAAA-MM-DD] | **Spec**: `specs/[NN-nombre]/spec.md` | **Constitución**: v[1.1.0]
**Estado**: [borrador | en revisión | aprobado] | **Responsable**: [rol; ver `docs/gestion/roles.md`] | **Segundo validador**: [rol]
**Generado por**: [skill `/plan` | manual]

---

## 1. Resumen (siempre)

<!-- 3 a 6 frases. Qué entrega esta especificación, qué capas toca, qué decisión técnica central toma el plan y qué NO hace. -->

[Qué entrega la especificación, en una frase.]
[Capas y esquemas que toca: `raw`, `silver`, `gold`, ninguna.]
[Enfoque técnico en 2-3 frases: de qué entra a qué sale y por qué pasos.]
[Qué queda fuera de este plan.]

**Requisitos que cubre este plan**: [lista de IDs: RF-NN-01 … RF-NN-MM, RNF-NN-01 … RNF-NN-MM, CE-NN-01 …]

---

## 2. Convención de requisitos (siempre)

<!-- Esta sección es idéntica en todos los planes. Si necesita cambiar, cámbiala aquí en la plantilla y por ADR. -->

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
2. **Sujeto con nombre, nunca «el sistema».** En `spec.md`: «el DWS», «la capa Bronce», «el ETL de Plata», «la bitácora de calidad». En `plan.md`: el artefacto concreto (un script, un rol, una prueba).
3. **`DEBE` es el único modal** (`DEBEN` si el sujeto es plural). `NO DEBE` solo para prohibiciones heredadas de la constitución o bloqueos de estado; si existe, se prefiere la forma afirmativa. No se usa «debería» ni «puede»: lo no obligatorio va en Supuestos. Nunca «debe de».
4. **Modo verbal:** `CUANDO` y `MIENTRAS` con subjuntivo («CUANDO termine…», «MIENTRAS esté…»); `SI` con indicativo («SI se detecta…»).
5. **Máximo dos palabras clave por requisito** (`DONDE` no cuenta). Con más de tres precondiciones, se parte en varios requisitos o se usa una tabla de decisión.
6. **Todo número es un umbral con nombre (`U-NN-MM`) o `[POR DEFINIR: ADR-nnnn]`.** Prohibidos los adjetivos: «rápido», «limpio», «adecuado», «robusto».
7. **Los cuantificadores universales («cada», «toda») llevan población cerrada** y criterio de cero excepciones o 100 %.
8. **`spec.md` dice qué y por qué.** Prohibido en sus enunciados: nombres de producto o lenguaje (PostgreSQL, DuckDB, Python, pytest, SQL), objetos físicos (esquema, índice, vista, script, columna, llave foránea) y rutas. Permitido: capa Bronce/Plata/Oro, hecho, dimensión, grano, medida, bitácora, regla, linaje y el formato Parquet como entregable.
9. **`plan.md` dice cómo.** Reutiliza el ID del requisito de la spec y agrega componentes `C-NN-MM`.
10. **Todo `CUANDO` que describe un flujo tiene su `SI … ENTONCES` de error.** Un camino feliz sin camino de error está incompleto.

### 2.3 IDs

| Tipo | Formato | Ejemplo | Nota |
|---|---|---|---|
| Requisito funcional | `RF-NN-MM` | `RF-03-07` | NN = número de la especificación (00 a 06) |
| Requisito no funcional | `RNF-NN-MM` | `RNF-01-02` | Incluye las restricciones heredadas de la constitución |
| Criterio de éxito | `CE-NN-MM` | `CE-00-01` | Medible y verificable |
| Pregunta de negocio | `PNnn` | `PN09` | Nace en la spec 00 |
| Regla de calidad del EDA | `Rnn` | `R07` | Una por hallazgo (Principio IV) |
| Umbral | `U-NN-MM` | `U-00-01` | Se cita el nombre, nunca el número suelto |
| Componente del plan | `C-NN-MM` | `C-03-02` | Un script, un rol, una prueba o un bloque de regla |
| Consulta de verificación humana | `V-NN-MM` | `V-01-01` | La corre la persona responsable (Principio XI) |
| Tarea | `T-NN-MM` | `T-03-14` | La evidencia es el archivo o commit que la cierra |
| Regla de la constitución | `Const. XIII.3` | | Así se cita un principio |

Los IDs no se reutilizan; un requisito retirado se marca «retirado» y no se renumera; el ID no contiene palabras del enunciado y va al inicio de la línea.

### 2.4 Formato de línea

```text
RF-NN-MM  · <enunciado EARS> · Origen: <Const. n | PN-nn | Rnn> · Verificación: <prueba automatizada | consulta de verificación humana | inspección>
C-NN-MM   · <enunciado EARS con sujeto concreto> · Satisface: RF-NN-MM · Verificación: <…>
```

---

## 3. Contexto técnico (siempre)

<!-- Una fila por campo. Si algo no se decide en este plan, escribe [POR DEFINIR: ADR-nnnn]. -->

| Campo | Valor |
|---|---|
| Capas y esquemas | [`raw` \| `silver` \| `gold` \| ninguna] |
| Entradas | [archivo o capa de origen; estado requerido, p. ej. «Bronce validada»] |
| Salidas | [tablas, `.parquet`, documentos y README que produce] |
| Motor | PostgreSQL local (único motor del DW) |
| Lenguajes | SQL (ingesta, exploración, ETL); DuckDB (SQL) solo para exportar a Parquet; Python solo en `tests/` |
| Herramientas | [pgAdmin, `psql`, DuckDB, pytest, Tableau Public; solo las de la constitución] |
| Volumen esperado | [filas y MB por capa; referencia: 9.707.634 reseñas en Bronce] |
| Rendimiento | [umbral con nombre `U-NN-MM` o `[POR DEFINIR: ADR-0010]`] |
| Frescura | Carga histórica única; último dato 2013-03-04 |
| Concurrencia | 2 usuarios, cada uno con su copia local |
| Restricciones | Costo $0; todo local; sin rutas atadas a una máquina; sin credenciales en archivos versionados |
| Ejecución | Manual, con scripts numerados que se corren en orden |

---

## 4. Constitution Check (siempre; compuerta)

<!-- GATE: debe pasar antes de la Fase 0. Se vuelve a verificar al terminar la Fase 1. Una fila en ❌ bloquea el avance
hasta que se corrija el diseño o se registre en la sección 13 con su ADR. -->

Estados: ✅ cumple · ⚠️ cumple con riesgo (explicar) · ❌ incumple · — no aplica (explicar).

| Principio | Qué exige (resumen) | ¿Aplica? | Cómo lo cumple el diseño | Evidencia o verificación | Estado |
|---|---|---|---|---|---|
| I. Kimball | Grano en una frase, claves subrogadas, fila especial de faltantes, medidas clasificadas | [sí / no] | [ ] | [README de `src/gold/`] | [ ] |
| II. Medallion | Un esquema por capa; exportación a Parquet; README con DDL | [ ] | [ ] | [`README.md` + `NN_export_parquet.sql`] | [ ] |
| III. Bronce inmutable | Sin `UPDATE`, `DELETE` ni `TRUNCATE` sobre `raw` tras validar | [ ] | [ ] | [`tests/test_bronze.py`] | [ ] |
| IV. Transformación con regla | Toda transformación nace de una regla `Rnn` con acción y conteo | [ ] | [ ] | [matriz transformación → regla] | [ ] |
| V. SQL puro | Python solo en `tests/`; DuckDB solo exporta | [ ] | [ ] | [sin `.py` fuera de `tests/`] | [ ] |
| VI. Test por regla y cuadre exacto | Un test por `Rnn`; entran = salen + rechazadas + eliminadas | [ ] | [ ] | [`pytest tests/`; cuadre en README] | [ ] |
| VII. Datos sin versionar | Ningún `.gz`, `.parquet`, `.csv`, `.twbx`, `.env` en Git | [ ] | [ ] | [`git ls-files`] | [ ] |
| VIII. Costo $0 | Nada de pago ni de nube | [ ] | [ ] | [lista de herramientas] | [ ] |
| IX. Orquestación manual | Scripts numerados, reproducibles, sin rutas de una máquina | [ ] | [ ] | [orden de la sección 7.2] | [ ] |
| X. Gestión en el repositorio | Tareas con responsable, estado y evidencia; archivo de tareas de la spec | [ ] | [ ] | [`docs/gestion/tareas.md`] | [ ] |
| XI. Verificación humana | La persona responsable verifica con sus consultas antes de cerrar | [ ] | [ ] | [sección 10.2] | [ ] |
| XII. Spec primero y en orden | La spec se actualiza antes que el plan; orden 00 → 06 | [ ] | [ ] | [spec y plan sin contradicciones] | [ ] |
| XIII. Legibilidad y trazabilidad | Ver las siete filas siguientes | [ ] | [ ] | [sección 9] | [ ] |
| ↳ XIII.1 SQL | CTEs con nombre, sin `SELECT *`, comentarios de bloque | [ ] | [ ] | [ ] | [ ] |
| ↳ XIII.2 DDL | Comentarios de tabla y columna; llaves y restricciones explícitas; nombres | [ ] | [ ] | [ ] | [ ] |
| ↳ XIII.3 Pruebas | Docstring, nombre, mensajes, agrupación por dominio, constantes | [ ] | [ ] | [ ] | [ ] |
| ↳ XIII.4 General | Nombres completos, comentario del porqué, español, encabezado | [ ] | [ ] | [ ] | [ ] |
| ↳ XIII.5 Trazabilidad | Todo artefacto cita su `RF/RNF` y su `Rnn` | [ ] | [ ] | [ ] | [ ] |
| ↳ XIII.6 Glosario | Términos y siglas definidos en `docs/glosario.md` | [ ] | [ ] | [ ] | [ ] |
| ↳ XIII.7 Lectura en frío | Persona junior distinta del autor responde las cinco preguntas | [ ] | [ ] | [ ] | [ ] |

**Resultado de la compuerta antes de la Fase 0**: [pasa | bloquea; motivo]
**Resultado de la compuerta después de la Fase 1**: [pasa | bloquea; motivo]

---

## 5. Decisiones, ADR y supuestos (siempre)

### 5.1 Pendientes de la constitución que afectan a esta especificación

<!-- Copia solo los ADR de la tabla «Decisiones pendientes» que afecten a esta spec. NO los resuelvas: propón el ADR y espera al responsable. -->

| ADR | Pendiente | ¿Bloquea esta spec? | Cómo la trata este plan |
|---|---|---|---|
| [0006] | [ ] | [sí / no] | [ ] |

### 5.2 Decisiones nuevas que propone este plan

| ID | Decisión propuesta | Alternativas descartadas | Motivo | Estado |
|---|---|---|---|---|
| [D-NN-01] | [ ] | [ ] | [ ] | [propuesta \| ADR creado \| firmada] |

### 5.3 Supuestos

<!-- Lo no obligatorio va aquí, no en un requisito. Cada supuesto se verifica o se descarta antes de cerrar. -->

- **S-NN-01**: [supuesto] — se verifica con [qué].

### 5.4 Cambios que este plan exige a `spec.md`

<!-- Principio XII: si el plan descubre que la spec está incompleta o contradice la constitución, se corrige primero la spec. -->

| Cambio en la spec | Motivo | Estado |
|---|---|---|
| [ ] | [ ] | [pendiente \| hecho] |

---

## 6. Fase 0 — Investigación (`research.md`)

<!-- Cada pregunta abierta del contexto técnico se cierra aquí con una decisión y su justificación. -->

| Pregunta | Opciones evaluadas | Decisión | Justificación | Fuente |
|---|---|---|---|---|
| [ ] | [ ] | [ ] | [ ] | [enlace o documento] |

---

## 7. Fase 1 — Diseño

### 7.1 Estructura de documentación y código (siempre)

```text
specs/[NN-nombre]/
├── spec.md              # qué y porqué (ya existe)
├── plan.md              # este archivo
├── research.md          # Fase 0
├── data-model.md        # Fase 1: modelo descrito en tablas (sin DDL ejecutable)
├── quickstart.md        # Fase 1: cómo ejecutar y verificar paso a paso
├── contracts/           # Fase 1: contratos de entrada y salida entre capas
├── checklists/
│   └── legibilidad.md   # lectura en frío firmada (Principio XIII.7)
├── adr/                 # decisiones de esta entrega
└── task.md              # lo crea /tasks, no este plan [según ADR-0006]
[Agrega o quita carpetas según la especificación.]

src/[capa]/              # [los scripts numerados NN_nombre.sql que crea esta spec]
tests/                   # [archivos de prueba por dominio]
docs/gestion/            # roles.md y tareas.md
```

**Decisión de estructura**: [qué carpetas crea o toca esta spec y por qué].

### 7.2 Flujo de ejecución y orden de scripts (según capa)

<!-- Describe, no programes. Una fila por script. Los scripts se corren en orden, a mano (Principio IX). -->

| Orden | Script | Qué hace (una frase) | Entradas | Salidas | Requisito que atiende | Repetible |
|---|---|---|---|---|---|---|
| 01 | `src/[capa]/01_[nombre].sql` | [ ] | [ ] | [ ] | [RF-NN-MM] | [sí / no, y por qué] |

**Reproducibilidad**: [qué debe obtener otra persona al seguir este orden: tablas, conteos].
**Estado de la capa**: [vacía → cargada → validada; dónde queda registrado el estado, porque `MIENTRAS` solo se usa con un estado que se pueda consultar].

### 7.3 Modelo de datos descrito (según capa)

<!-- Una tabla por objeto. Sin SQL ni DDL ejecutable: el DDL lo escribe /implement a partir de esta descripción. -->

**Objeto**: `[esquema.nombre]` — **Tipo**: [bruta | depurada | hecho | dimensión | bitácora | agregada] — **Grano** (hechos y tablas depuradas): [una frase]

| Columna | Tipo lógico | Obligatoria | Clave | Qué representa y su unidad o dominio | Origen (campo de la fuente o regla `Rnn`) |
|---|---|---|---|---|---|
| [nombre_completo] | [texto \| entero \| decimal \| fecha \| …] | [sí / no] | [PK \| FK a … \| UNIQUE \| —] | [ ] | [ ] |

Restricciones declaradas: [PK, FK, NOT NULL, UNIQUE de la tabla].
Justificación de tipos con alternativa razonable: [columna → tipo elegido y motivo].
Si es un hecho: medidas y clasificación [aditiva | semiaditiva | no aditiva]; fila especial para datos faltantes: [cuál].

### 7.4 Catálogo de reglas del EDA (según capa)

<!-- Solo las specs 02 y 03 crean o aplican reglas. Un requisito por fila. -->

| Código | Condición (lenguaje de negocio) | Acción | Umbral | Requisito | Prueba | Fila en bitácora |
|---|---|---|---|---|---|---|
| [R01] | [ ] | [descarta \| corrige \| marca] | [U-NN-MM] | [RF-NN-MM] | [archivo y función] | [sí] |

Qué cuenta como «filas» por acción: `descarta` = filas descartadas (entran al cuadre); `corrige` y `marca` = filas modificadas (no cambian el número de filas). Cada fila descartada se atribuye a **una sola** regla.

### 7.5 Cuadre de filas y linaje (según capa)

| Frontera | Filas que entran | Filas que salen | Rechazadas | Eliminadas | Diferencia admitida |
|---|---|---|---|---|---|
| [capa origen → capa destino] | [cómo se cuentan] | [ ] | [reglas que las producen] | [ ] | [U-NN-01 = 0 filas] |

**Linaje**: [cómo se llega de una fila de esta capa a su fila de la capa anterior; 1 a 1 o 1 a N si hay deduplicación].

### 7.6 Bitácora de calidad (según capa)

[Qué registra por regla (regla, descripción, filas, acción, fecha de registro), quién la llena y cuándo, dónde vive (**[POR DEFINIR: ADR-0009]** si aún no se decidió) y qué indicadores de calidad alimenta.]

### 7.7 Seguridad del dato (siempre)

| Tema | Qué hace este plan |
|---|---|
| PII (`userId`, `profileName`, reseñas anónimas) | [ ] |
| Roles y permisos | [un esquema por capa; rol de solo lectura sobre `gold` para Tableau] |
| Secretos | [conexión por variables de entorno; sin credenciales en SQL ni en documentos] |
| Cruce de fuentes | [no se cruza para identificar personas] |

### 7.8 Rendimiento y volumen (según capa)

[Índices (solo Oro, tras cargar el hecho), mediciones antes y después, dónde se registran los tiempos, volumen por capa y dónde se documenta.]

### 7.9 Exportación a Parquet (según capa)

[Script `NN_export_parquet.sql`, carpeta de salida `data/parquet/<capa>/`, qué se exporta y cómo se comprueba que el archivo coincide con la tabla (conteo).]

---

## 8. Componentes del plan (siempre)

<!-- Cada componente es una oración EARS con sujeto concreto. Todo componente satisface al menos un requisito de la spec.
Todo requisito de la spec debe tener al menos un componente. -->

| ID | Enunciado (EARS) | Satisface | Verificación |
|---|---|---|---|
| C-NN-01 | [El script `src/…/NN_….sql` DEBE …] | [RF-NN-MM] | [prueba automatizada \| consulta V-NN-MM \| inspección] |
| C-NN-02 | [CUANDO …, el … DEBE …] | [RF-NN-MM] | [ ] |
| C-NN-03 | [SI …, ENTONCES el … DEBE …] | [RF-NN-MM] | [ ] |

---

## 9. Verificación de legibilidad — Principio XIII (siempre)

<!-- Sección exigida por la constitución. /analyze marca CRITICAL si falta. Una fila por regla XIII.n que aplique;
si una regla no aplica a esta spec, escribe «No aplica» y el motivo. -->

| Regla | Qué artefactos de esta spec alcanza | Cómo se comprueba | Herramienta | Umbral | Responsable |
|---|---|---|---|---|---|
| XIII.1 SQL | [scripts de `src/[capa]/`] | [lista de revisión; linter si lo aprueba ADR-0012] | [revisión manual \| [POR DEFINIR: ADR-0012]] | [0 hallazgos] | [rol] |
| XIII.2 DDL | [tablas y columnas de la capa] | [consulta al catálogo: objetos sin comentario] | [`psql`] | [0 tablas y 0 columnas sin comentario] | [rol] |
| XIII.3 Pruebas | [archivos de `tests/`] | [revisión; cobertura de docstrings] | [pytest; [POR DEFINIR: ADR-0012]] | [100 % con docstring y mensaje] | [rol] |
| XIII.4 General | [todos] | [encabezado presente; idioma; nombres] | [prueba de encabezados en `tests/`] | [100 % de archivos] | [rol] |
| XIII.5 Trazabilidad | [todos] | [todo archivo cita un ID existente] | [prueba de IDs en `tests/`] | [0 archivos sin ID; 0 IDs inexistentes] | [rol] |
| XIII.6 Glosario | [documentos y READMEs] | [todo término y sigla está en `docs/glosario.md`] | [revisión] | [0 siglas sin definir] | [rol] |
| XIII.7 Lectura en frío | [muestra: ≥ 1 artefacto por tipo y por capa tocada] | [las cinco preguntas estándar] | [`checklists/legibilidad.md`] | [las cinco respondidas sin consultar al autor; tiempo [POR DEFINIR: ADR-0012]] | [persona distinta del autor] |

**Las cinco preguntas estándar de la lectura en frío**: (1) ¿Qué hace? (2) ¿Qué entra y qué sale? (3) ¿Qué regla o requisito atiende? (4) ¿Por qué existe cada filtro o transformación? (5) ¿Cómo se ejecuta y se verifica?

---

## 10. Estrategia de verificación (siempre)

### 10.1 Pruebas automatizadas (en `tests/`)

| Archivo (por dominio) | Qué comprueba | Requisito o regla | Valor esperado (constante nombrada) |
|---|---|---|---|
| [`tests/test_[dominio].py`] | [ ] | [RF-NN-MM \| Rnn] | [U-NN-MM] |

Reglas: el valor de referencia de una prueba se obtiene por otra ruta que el ETL (un conteo directo sobre la capa de origen o un valor fijo de la constitución), nunca recalculando con el mismo SQL que se prueba.

### 10.2 Verificación humana (Principio XI)

<!-- La persona responsable corre estas consultas antes de cerrar. Descríbelas, no las escribas: qué cuentan, sobre qué, resultado esperado. -->

| ID | Qué verifica | Sobre qué objeto | Resultado esperado |
|---|---|---|---|
| V-NN-01 | [conteo \| cuadre \| muestra] | [ ] | [ ] |

---

## 11. Trazabilidad (siempre)

| Requisito | Componente (plan) | Tarea (`task.md`) | Prueba o consulta | Evidencia (archivo o commit) |
|---|---|---|---|---|
| [RF-NN-MM] | [C-NN-MM] | [T-NN-MM] | [prueba \| V-NN-MM] | [ ] |

**Chequeos de completitud** (los comprueba `/analyze`):
1. Todo RF, RNF y CE tiene al menos un componente, una tarea y una prueba o consulta.
2. Todo componente, tarea y prueba cita al menos un requisito; si no, es huérfano (puede delatar una transformación sin regla, que el Principio IV prohíbe).
3. Toda regla `Rnn` aparece en exactamente un requisito, una entrada de bitácora y una prueba.
4. Todo requisito que viene de la constitución cita el principio («Const. n»).

---

## 12. Riesgos y mitigaciones

| Riesgo | Probabilidad | Impacto | Mitigación | Quién la vigila |
|---|---|---|---|---|
| [ ] | [alta \| media \| baja] | [alto \| medio \| bajo] | [ ] | [rol] |

---

## 13. Seguimiento de complejidad

> Llena SOLO si el Constitution Check tiene filas en ❌ o ⚠️ que deban justificarse. Toda excepción exige un ADR y una fecha de revisión.

| Incumplimiento | Por qué es necesario | Alternativa más simple descartada porque | ADR | Fecha de revisión |
|---|---|---|---|---|
| [ ] | [ ] | [ ] | [ ] | [AAAA-MM-DD] |

---

## 14. Compuerta de cierre de la especificación (siempre)

| # | Condición | Cómo se comprueba | Estado |
|---|---|---|---|
| 1 | Tests en verde | `pytest tests/` | [ ] |
| 2 | Cuadre exacto | Sección 7.5 y README de la capa | [ ] |
| 3 | Verificación humana con SQL | Consultas V-NN-MM ejecutadas por la persona responsable | [ ] |
| 4 | README de la capa actualizado | DDL, reglas aplicadas y volumetría | [ ] |
| 5 | Checklist de legibilidad firmado | `checklists/legibilidad.md` tras la lectura en frío (Principio XIII.7) | [ ] |
| 6 | Pull Request integrado a `main` | Rama `[NN-nombre]` | [ ] |

---

## 15. Glosario y umbrales (siempre)

### 15.1 Términos de esta especificación

<!-- Los términos de dominio van también en docs/glosario.md. Un nombre por concepto. -->

| Término | Definición | ID de glosario |
|---|---|---|
| [ ] | [ ] | [ ] |

### 15.2 Umbrales con nombre

| ID | Nombre | Valor | Fuente de la decisión |
|---|---|---|---|
| [U-NN-01] | Diferencia de cuadre admitida (solo si la spec cuadra filas) | 0 filas | Constitución, Principio VI |
| [U-NN-MM] | [ ] | [valor \| POR DEFINIR: ADR-nnnn] | [ ] |

---

## 16. Historial de cambios del plan

| Fecha | Cambio | Motivo | Autor |
|---|---|---|---|
| [AAAA-MM-DD] | Versión inicial | — | [ ] |

---

## Lista de revisión antes de entregar el plan

- [ ] Cada requisito tiene un sujeto con nombre, un solo `DEBE`, una sola respuesta y un ID.
- [ ] Ningún valor numérico queda fuera de la tabla de umbrales; ningún adjetivo vago.
- [ ] Cada `CUANDO` de un flujo tiene su `SI … ENTONCES` de error.
- [ ] Cada requisito de la spec tiene al menos un componente; cada componente cita su requisito.
- [ ] El Constitution Check lista los trece principios y las siete reglas XIII.n, sin filas vacías.
- [ ] La sección 9 existe y cada regla XIII.n que aplica tiene método, umbral y responsable.
- [ ] Los pendientes ADR 0006–0012 que afectan a la spec están en la sección 5, sin resolverlos por cuenta propia.
- [ ] El plan no contiene código ni sentencias SQL, y no reutiliza dimensiones ni nombres del modelo anterior.
- [ ] Una persona junior que lea solo este plan y el glosario puede decir qué se va a construir y cómo se comprueba.
