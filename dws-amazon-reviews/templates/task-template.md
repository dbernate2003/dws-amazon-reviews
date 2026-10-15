# Tareas — [NN-nombre]

<!--
PLANTILLA DE TAREAS DEL DWS. Guárdala como templates/task.md; el resultado va en specs/[NN-nombre]/task.md
(nombre del archivo según ADR-0006). La usa el skill /tasks, o se llena a mano.

Cómo usarla:
- Todo lo que está entre [CORCHETES] se reemplaza. Borra estos comentarios al terminar.
- Las tareas salen de spec.md (qué y por qué) + plan.md (cómo) + la constitución (principios).
  No inventes trabajo que no cite un requisito del plan.
- Una tarea = UNA operación, de 30 a 60 minutos. Si no cabe en 60 minutos, se parte en dos.
- No escribas código aquí: la tarea dice qué producir y cómo comprobarlo. El código nace en /implement.
- No edites specs/README.md ni crees una tarea para actualizarlo: se actualiza solo con la lista de tareas.
- Mantén igual el formato de la primera línea de cada tarea (`- [ ] T-NN-MM ...`): es la línea que se lista.
- Las fases que no apliquen a la spec se conservan con «No aplica: <motivo>»; nunca se borran en silencio.

Las seis cualidades de una buena tarea (apuntes del curso de Spec Kit):
  ACCIONABLE   empieza con un verbo y nombra el artefacto concreto
  VERIFICABLE  tiene una línea «Hecho cuando:» que se comprueba con un comando, una cifra o un archivo
  INDEPENDIENTE no espera a un trabajo no relacionado; si depende de algo, lo declara
  LIMITADA     de 30 a 60 minutos
  TRAZABLE     cita el requisito que cubre (RF, RNF, CE, Rnn, Const.)
  LEGIBLE      encabezados y comentarios se crean junto con el artefacto, no después (Const. XIII)

Ejemplo ilustrativo (los códigos son de muestra):
  MALA   - [ ] Implementar el ETL de Plata.  Hecho cuando: funciona.
  BUENA  - [ ] T-03-07 Escribir la CTE que descarta reseñas con puntaje fuera de 1 a 5 (R07) · 40 min · [rol]
           - Cubre: RF-03-05 · Componente: C-03-04 · R07 · Const. XIII.1, XIII.5
           - Depende de: T-03-04
           - Hecho cuando: `psql -f src/silver/02_etl.sql` termina sin error y la bitácora tiene la fila R07 con el
             mismo conteo que la consulta V-03-02.
-->

**Propósito**: [una frase: qué lista de trabajo es esta y para qué spec] | **Autor**: [nombre o rol] | **Fecha**: [AAAA-MM-DD]
**Dependencias**: `spec.md`, `plan.md`, [especificación anterior cerrada], [ADR firmados que esta lista necesita]
**Rama**: `[NN-nombre]` | **Constitución**: v[1.1.0] | **Estado**: [borrador | en curso | cerrada]
**Responsable**: [rol; ver `docs/gestion/roles.md`] | **Segundo validador**: [rol]
**Generado por**: [skill `/tasks` | manual]

---

## 1. Resumen (siempre)

<!-- 2 a 4 frases. Qué entrega esta lista, qué capas toca, cuántas tareas son y cuánto trabajo suman. -->

[Qué entrega la especificación al terminar esta lista, en una frase.]
[Capas y esquemas que toca: `raw`, `silver`, `gold`, ninguna.]
**Tareas**: [total] | **Tiempo estimado**: [suma en minutos] | **Fases**: [número]
**Requisitos que cubre**: [IDs: RF-NN-01 … RF-NN-MM, RNF-NN-01 … RNF-NN-MM, CE-NN-01 …]

---

## 2. Cómo leer este archivo (siempre)

Formato de cada tarea (idéntico en todas):

```text
- [ ] T-NN-MM [P] <Verbo + artefacto concreto> · <30 | 45 | 60> min · <rol>
  - Cubre: <RF/RNF/CE/Rnn> · Componente: <C-NN-MM> · <Const. n>
  - Depende de: <T-NN-MM | ninguna>
  - Hecho cuando: <condición verificable: comando, cifra, archivo o consulta V-NN-MM>
  - Evidencia: <archivo o commit que la cierra; se llena al cerrar>
```

| Elemento | Significa |
|---|---|
| `[ ]` / `[x]` | Pendiente / hecha. Se marca solo cuando se cumple su «Hecho cuando» |
| `[P]` | Paralelizable: no depende de ninguna tarea abierta y no toca los mismos archivos que otra tarea de su ola |
| Minutos | Estimación entre 30 y 60. Si la tarea pide más, se parte |
| Cubre | IDs de `spec.md` y `plan.md`; toda tarea cita al menos uno (si no cita ninguno, es huérfana) |
| Hecho cuando | Una sola condición que otra persona puede comprobar sin preguntar al autor |
| Evidencia | El archivo o el commit que demuestra que se hizo (Principio X) |

---

## 3. Mapa de dependencias y paralelismo (siempre)

<!-- Decide qué se hace en secuencia y qué en paralelo.
Secuencial: una tarea produce lo que otra lee. Paralelo: no dependen entre sí y no editan el mismo archivo.
En un equipo de dos, paralelo significa que cada persona toma una tarea de la misma ola. -->

| Ola | Tareas | ¿Paralelas? | Por qué | Se abre cuando |
|---|---|---|---|---|
| 1 | [T-NN-01, T-NN-02] | [sí | no] | [no comparten archivo ni dependencia] | [la spec anterior está cerrada] |
| 2 | [T-NN-03] | [no] | [lee lo que produce T-NN-02] | [T-NN-02 hecha] |

---

## 4. Fases y tareas (siempre)

<!-- Una fase agrupa tareas con un mismo objetivo y termina en un punto de verificación (checklist manual).
Reparte el objetivo de cada fase en operaciones únicas. Puedes añadir o quitar tareas; conserva el formato. -->

### Fase 0 — Preparación

**Objetivo**: [dejar listas las entradas y las decisiones pendientes antes de construir].
**Entregable**: [entradas confirmadas, ADR firmados, estructura de carpetas].

- [ ] T-NN-01 [P] [Confirmar que la capa o spec anterior pasó su compuerta de cierre] · [30] min · [rol]
  - Cubre: [Const. XII]
  - Depende de: ninguna
  - Hecho cuando: [el Pull Request de la spec anterior está integrado a `main` y sus pruebas pasan]
  - Evidencia: [commit o enlace al Pull Request]

- [ ] T-NN-02 [P] [Confirmar firmados los ADR de la sección 5.1 del plan] · [30] min · [rol]
  - Cubre: [plan sección 5.1]
  - Depende de: ninguna
  - Hecho cuando: [cada ADR citado está en `memory/adr/` o `specs/[NN-nombre]/adr/` con firma]
  - Evidencia: [archivos de ADR]

**Punto de verificación de la Fase 0** (checklist manual):
- [ ] [Las entradas existen y están en el estado que pide el plan]
- [ ] [Ningún ADR pendiente bloquea la Fase 1]

### Fase 1 — Fundamentos

**Objetivo**: [crear lo que las demás tareas necesitan: estructura, definiciones, esquema vacío].
**Entregable**: [carpetas, scripts base, glosario actualizado].

- [ ] T-NN-03 [Crear el script `src/[capa]/01_[nombre].sql` con encabezado y comentarios] · [45] min · [rol]
  - Cubre: [RF-NN-MM] · Componente: [C-NN-MM] · [Const. XIII.2, XIII.4, XIII.5]
  - Depende de: [T-NN-02]
  - Hecho cuando: [`psql -f src/[capa]/01_[nombre].sql` termina sin error y el catálogo muestra 0 objetos sin comentario]
  - Evidencia: [archivo o commit]

**Punto de verificación de la Fase 1**:
- [ ] [El script corre dos veces seguidas sin error (repetible)]
- [ ] [Todo término nuevo está en `docs/glosario.md`]

### Fase 2 — Construcción

**Objetivo**: [producir el artefacto central de la spec, un requisito o regla a la vez].
**Entregable**: [tablas cargadas, reglas aplicadas, documentos].

<!-- Una tarea por regla Rnn o por requisito. Si la tarea crea una transformación, DEBE citar su Rnn
(Const. IV): sin regla no hay tarea. -->

- [ ] T-NN-04 [P] [Escribir la CTE o el bloque de la regla Rnn] · [45] min · [rol]
  - Cubre: [RF-NN-MM] · Componente: [C-NN-MM] · [Rnn] · [Const. XIII.1]
  - Depende de: [T-NN-03]
  - Hecho cuando: [la bitácora tiene la fila Rnn y su conteo coincide con la consulta V-NN-MM]
  - Evidencia: [archivo o commit]

- [ ] T-NN-05 [P] [Escribir otra regla o requisito independiente de T-NN-04] · [45] min · [rol]
  - Cubre: [RF-NN-MM] · Componente: [C-NN-MM] · [Rnn] · [Const. XIII.1]
  - Depende de: [T-NN-03]
  - Hecho cuando: [condición verificable]
  - Evidencia: [archivo o commit]

**Punto de verificación de la Fase 2**:
- [ ] [Cada regla Rnn de esta fase tiene fila en la bitácora]
- [ ] [El cuadre de filas da exacto: entran = salen + rechazadas + eliminadas]

### Fase 3 — Pruebas

**Objetivo**: [una prueba por regla y el cuadre entre capas].
**Entregable**: [archivos de `tests/` por dominio].

- [ ] T-NN-06 [Escribir la prueba de la regla Rnn en `tests/test_[dominio].py`] · [45] min · [rol]
  - Cubre: [Rnn] · Componente: [C-NN-MM] · [Const. VI, XIII.3]
  - Depende de: [T-NN-04]
  - Hecho cuando: [`pytest tests/test_[dominio].py` pasa; la prueba tiene docstring, nombre descriptivo y `assert` con mensaje]
  - Evidencia: [archivo o commit]

**Punto de verificación de la Fase 3**:
- [ ] [`pytest tests/` pasa completo]
- [ ] [Toda prueba abre con encabezado y cita un ID que existe]

### Fase 4 — Documentación y cierre

**Objetivo**: [dejar la spec lista para cerrarse con verificación humana].
**Entregable**: [README de la capa, checklist de legibilidad firmado, Pull Request].

<!-- Las tres últimas tareas de esta fase son obligatorias en todas las especificaciones. -->

- [ ] T-NN-07 [Actualizar el `README.md` de la capa (DDL, reglas aplicadas y volumetría)] · [60] min · [rol]
  - Cubre: [RF-NN-MM] · [Const. II, XIII.4]
  - Depende de: [T-NN-06]
  - Hecho cuando: [el README tiene DDL, tabla de reglas con conteos y volumetría, y cita las fuentes]
  - Evidencia: [`src/[capa]/README.md`]

- [ ] T-NN-08 Ejecutar la verificación humana con las consultas V-NN-01 … V-NN-MM · [60] min · [persona responsable de la capa]
  - Cubre: [Const. XI] · [CE-NN-MM]
  - Depende de: [T-NN-07]
  - Hecho cuando: [cada consulta V-NN-MM se ejecutó y su resultado coincide con el esperado del plan, sección 10.2]
  - Evidencia: [resultados registrados en el Pull Request]

- [ ] T-NN-09 Revisión de legibilidad por una persona junior (lectura en frío) · [60] min · [persona distinta del autor]
  - Cubre: [CE-NN-MM] · Const. XIII.7
  - Depende de: [T-NN-08]
  - Hecho cuando: [`checklists/legibilidad.md` está firmado, con las cinco preguntas respondidas sin consultar al autor sobre al menos un artefacto por tipo y por capa tocada]
  - Evidencia: [`specs/[NN-nombre]/checklists/legibilidad.md`]

- [ ] T-NN-10 Abrir el Pull Request de la rama `[NN-nombre]` a `main` · [30] min · [rol]
  - Cubre: [Const. XII] · Compuerta de cierre, condición 6
  - Depende de: [T-NN-09]
  - Hecho cuando: [el Pull Request está integrado a `main` con las seis condiciones de la compuerta marcadas]
  - Evidencia: [enlace o commit de integración]

**Punto de verificación de la Fase 4** (compuerta de cierre de la spec):
- [ ] 1. Tests en verde (`pytest tests/`)
- [ ] 2. Cuadre exacto
- [ ] 3. Verificación humana con SQL
- [ ] 4. README de la capa actualizado
- [ ] 5. Checklist de legibilidad firmado
- [ ] 6. Pull Request integrado a `main`

---

## 5. Seguimiento de avance (siempre)

<!-- Se recalcula al cerrar cada tarea. % hecho = hechas ÷ total × 100; % falta = 100 − % hecho. -->

| Fase | Tareas | Hechas | % hecho | % falta | Minutos estimados |
|---|---|---|---|---|---|
| 0 — Preparación | [ ] | [ ] | [ ] | [ ] | [ ] |
| 1 — Fundamentos | [ ] | [ ] | [ ] | [ ] | [ ] |
| 2 — Construcción | [ ] | [ ] | [ ] | [ ] | [ ] |
| 3 — Pruebas | [ ] | [ ] | [ ] | [ ] | [ ] |
| 4 — Documentación y cierre | [ ] | [ ] | [ ] | [ ] | [ ] |
| **Total** | [ ] | [ ] | [ ] | [ ] | [ ] |

---

## 6. Cobertura de requisitos (siempre; la comprueba `/analyze`)

| Requisito | Tareas que lo cubren | Prueba o consulta | Estado |
|---|---|---|---|
| [RF-NN-MM] | [T-NN-MM] | [prueba | V-NN-MM] | [cubierto | sin tarea] |

**Chequeos de completitud**:
1. Todo RF, RNF y CE tiene al menos una tarea.
2. Toda tarea cita al menos un requisito; si no, es huérfana.
3. Toda regla `Rnn` tiene una tarea de construcción y una tarea de prueba.
4. Existen las tareas finales de verificación humana, lectura en frío y Pull Request.

---

## 7. Lista de revisión antes de entregar las tareas

- [ ] **Accionable**: cada tarea empieza con un verbo y nombra un artefacto concreto.
- [ ] **Verificable**: cada tarea tiene una línea «Hecho cuando» que se comprueba con un comando, una cifra o un archivo (nunca «funciona» ni «está bien»).
- [ ] **Independiente**: cada dependencia está declarada; las tareas `[P]` no comparten archivo.
- [ ] **Limitada**: ninguna tarea supera 60 minutos.
- [ ] **Trazable**: cada tarea cita al menos un requisito, y cada requisito tiene al menos una tarea.
- [ ] **Legible**: los comentarios y encabezados se crean con el artefacto, no en una tarea aparte; está la tarea final de lectura en frío (Const. XIII.7).
- [ ] **Ordenada**: ninguna tarea depende de otra que aparece después.
- [ ] Toda tarea que crea una transformación cita su regla `Rnn` (Const. IV).
- [ ] Ninguna tarea propone algo fuera de alcance (Airflow, Dagster, dbt, nube, Notion, Python fuera de `tests/`).
- [ ] Ninguna tarea toca `raw` después de validada, ni versiona datos ni credenciales.
- [ ] Ninguna tarea edita `specs/README.md` a mano.

---

## 8. Historial de cambios

| Fecha | Cambio | Motivo | Autor |
|---|---|---|---|
| [AAAA-MM-DD] | Versión inicial | — | [ ] |
