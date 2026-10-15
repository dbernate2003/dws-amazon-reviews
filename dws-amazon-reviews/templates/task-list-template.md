# Tareas NN — [nombre]

> Salen del `plan.md`, no de la imaginación (Principio XII). Este archivo se llama `task.md` (ADR-0006). Borra las instrucciones entre `>`.
>
> Cada vez que se genera o se cambia esta lista, se actualiza `specs/README.md` con las mismas filas (formato de `templates/task-list-template.md`). No lo edites a mano ni crees una tarea para eso.

**Propósito:** [una frase: qué trabajo agrupa esta lista] · **Autor:** [nombre o rol] · **Fecha:** [AAAA-MM-DD]
**Plan:** `specs/NN-nombre/plan.md` · **Spec:** `specs/NN-nombre/spec.md` · **Rama:** `NN-nombre` · **Constitución:** v[1.1.0]
**Responsable:** [rol; ver `docs/gestion/roles.md`] · **Segundo validador:** [rol]
**Depende de:** [spec anterior cerrada] · [ADR firmados que esta lista necesita]
**Requisitos que cubre:** [RF-NN-01 … RF-NN-MM, RNF-NN-01 … RNF-NN-MM, CE-NN-01 …]

> **Una tarea buena es:**
> - **Accionable**: empieza con un verbo y nombra el artefacto concreto (`Escribir la CTE …`, no `Hacer el ETL`).
> - **Verificable**: su `Hecho cuando` se comprueba con un comando, una cifra o un archivo (nunca «funciona»).
> - **Independiente**: no espera a un trabajo no relacionado; si depende de algo, lo declara en `Depende de`.
> - **Limitada**: de 30 a 60 minutos (`Min`). Si no cabe, se parte en dos.
> - **Trazable**: `Cubre` cita al menos un requisito (RF, RNF, CE), una regla (`Rnn`) o un principio (`Const.`).
> - **Legible**: encabezados y comentarios se crean junto con el artefacto, no después (Const. XIII).
>
> `[ ]` pendiente · `[x]` hecha · `[P]` se puede hacer en paralelo (no depende de una tarea abierta ni comparte archivos con otra). ID: `T-NN-MM`.
> Si la tarea crea una transformación, `Cubre` DEBE incluir su `Rnn` (Const. IV): sin regla no hay tarea.
>
> Ejemplo ilustrativo (los códigos son de muestra):
> - Mala: `Implementar el ETL de Plata` · Hecho cuando: `funciona`.
> - Buena: `Escribir la CTE que descarta reseñas con puntaje fuera de 1 a 5` · `src/silver/02_etl.sql` · 40 min · Cubre: `RF-03-05 · C-03-04 · R07 · Const. XIII.1` · Hecho cuando: `psql -f src/silver/02_etl.sql` termina sin error y la bitácora tiene la fila R07 con el mismo conteo que la consulta V-03-02.

## Fase 1 — [Preparación y fundamentos]

> Objetivo: [dejar listas las entradas, las decisiones y lo que las demás tareas necesitan]. Entregable: [carpetas, scripts base, glosario actualizado].

| ID | Estado | Tarea | Archivo | Responsable | Depende de | Min | Cubre | Hecho cuando | Evidencia |
|---|---|---|---|---|---|---|---|---|---|
| T-NN-01 | [ ] [P] | [Confirmar que la spec anterior pasó su compuerta de cierre] | — | [rol] | ninguna | [30] | [Const. XII] | [el Pull Request de la spec anterior está integrado a `main` y sus pruebas pasan] | |
| T-NN-02 | [ ] [P] | [Confirmar firmados los ADR de la sección 5.1 del plan] | `memory/adr/…` | [rol] | ninguna | [30] | [plan 5.1] | [cada ADR citado existe con firma] | |
| T-NN-03 | [ ] | [Crear el script base con encabezado y comentarios] | `src/…` | [rol] | T-NN-02 | [45] | [RF-NN-MM · C-NN-MM · Const. XIII.2, XIII.4, XIII.5] | [`psql -f src/…` corre dos veces sin error y el catálogo muestra 0 objetos sin comentario] | |

**Punto de verificación de la Fase 1** (checklist manual):
- [ ] [Las entradas existen y están en el estado que pide el plan]
- [ ] [Ningún ADR pendiente bloquea la Fase 2]
- [ ] [Todo término nuevo está en `docs/glosario.md`]

## Fase 2 — [Construcción]

> Objetivo: [producir el artefacto central de la spec, una regla o un requisito a la vez]. Una tarea por regla `Rnn` o por requisito.

| ID | Estado | Tarea | Archivo | Responsable | Depende de | Min | Cubre | Hecho cuando | Evidencia |
|---|---|---|---|---|---|---|---|---|---|
| T-NN-04 | [ ] [P] | [Escribir la CTE o el bloque de la regla Rnn] | `src/…` | [rol] | T-NN-03 | [45] | [RF-NN-MM · C-NN-MM · Rnn · Const. XIII.1] | [la bitácora tiene la fila Rnn y su conteo coincide con la consulta V-NN-MM] | |
| T-NN-05 | [ ] [P] | [Escribir otra regla o requisito independiente de T-NN-04] | `src/…` | [rol] | T-NN-03 | [45] | [RF-NN-MM · C-NN-MM · Rnn · Const. XIII.1] | [condición verificable] | |

**Punto de verificación de la Fase 2**:
- [ ] [Cada regla `Rnn` de esta fase tiene fila en la bitácora]
- [ ] [El cuadre de filas da exacto: entran = salen + rechazadas + eliminadas]

## Fase 3 — [Pruebas]

> Objetivo: [una prueba por regla `Rnn` y el cuadre entre capas]. Las pruebas viven solo en `tests/`.

| ID | Estado | Tarea | Archivo | Responsable | Depende de | Min | Cubre | Hecho cuando | Evidencia |
|---|---|---|---|---|---|---|---|---|---|
| T-NN-06 | [ ] [P] | [Escribir la prueba de la regla Rnn] | `tests/test_[dominio].py` | [rol] | T-NN-04 | [45] | [Rnn · C-NN-MM · Const. VI, XIII.3] | [`pytest tests/test_[dominio].py` pasa; la prueba tiene docstring, nombre descriptivo y `assert` con mensaje] | |
| T-NN-07 | [ ] [P] | [Escribir la prueba de la regla Rnn de T-NN-05] | `tests/test_[dominio].py` | [rol] | T-NN-05 | [45] | [Rnn · C-NN-MM · Const. VI, XIII.3] | [`pytest` pasa con la prueba nueva] | |

**Punto de verificación de la Fase 3**:
- [ ] [`pytest tests/` pasa completo]
- [ ] [Toda prueba abre con encabezado y cita un ID que existe]

## Fase N — Cierre (compuerta de la constitución)

> Estas seis filas son obligatorias en toda especificación (compuerta de cierre, Constitución v1.1.0). Un agente NO da la especificación por cerrada: la verificación humana la hace la persona responsable (Principio XI).

| ID | Estado | Tarea | Responsable | Depende de | Min | Cubre | Hecho cuando | Evidencia |
|---|---|---|---|---|---|---|---|---|
| T-NN-08 | [ ] | Tests en verde | [rol] | T-NN-07 | 30 | Const. VI | `pytest tests/` termina sin fallos | |
| T-NN-09 | [ ] | Cuadre exacto | [rol] | T-NN-08 | 30 | Const. VI · plan 7.5 | la diferencia entre filas que entran y salen + rechazadas + eliminadas es 0 | |
| T-NN-10 | [ ] | Verificación humana con SQL (conteos, cuadres y muestras) | responsable de la capa | T-NN-09 | 60 | Const. XI · [CE-NN-MM] | cada consulta V-NN-MM se ejecutó y su resultado coincide con el esperado del plan, sección 10.2 | |
| T-NN-11 | [ ] | README de la capa actualizado | [rol] | T-NN-10 | 60 | Const. II, XIII.4 | el README tiene DDL, reglas con conteos y volumetría | |
| T-NN-12 | [ ] | Checklist de legibilidad firmado (lectura en frío por una persona junior) | persona distinta del autor | T-NN-11 | 60 | Const. XIII.7 · [CE-NN-MM] | `checklists/legibilidad.md` firmado, con las cinco preguntas respondidas sin consultar al autor | |
| T-NN-13 | [ ] | Pull Request integrado a `main` | [rol] | T-NN-12 | 30 | Const. XII | el Pull Request está integrado con las seis condiciones de la compuerta marcadas | |

## Seguimiento de avance

> Se recalcula al cerrar cada tarea. % hecho = hechas ÷ total × 100; % falta = 100 − % hecho.

| Fase | Tareas | Hechas | % hecho | % falta | Minutos estimados |
|---|---|---|---|---|---|
| 1 — [nombre] | [ ] | [ ] | [ ] | [ ] | [ ] |
| 2 — [nombre] | [ ] | [ ] | [ ] | [ ] | [ ] |
| 3 — [nombre] | [ ] | [ ] | [ ] | [ ] | [ ] |
| N — Cierre | 6 | [ ] | [ ] | [ ] | 270 |
| **Total** | [ ] | [ ] | [ ] | [ ] | [ ] |

## Cobertura de requisitos

> La comprueba `/analyze`. Todo RF, RNF y CE tiene al menos una tarea; toda tarea cita al menos un requisito (si no, es huérfana); toda regla `Rnn` tiene una tarea de construcción y una de prueba.

| Requisito | Tareas que lo cubren | Prueba o consulta | Estado |
|---|---|---|---|
| [RF-NN-MM] | [T-NN-MM] | [prueba · V-NN-MM] | [cubierto · sin tarea] |

## Lista de revisión antes de entregar las tareas

- [ ] Cada tarea empieza con un verbo y nombra un artefacto concreto.
- [ ] Cada `Hecho cuando` se comprueba con un comando, una cifra o un archivo.
- [ ] Cada dependencia está declarada; las tareas `[P]` no comparten archivo.
- [ ] Ninguna tarea supera 60 minutos.
- [ ] Cada tarea cita al menos un requisito, y cada requisito tiene al menos una tarea.
- [ ] Ninguna tarea depende de otra que aparece después.
- [ ] Toda tarea que crea una transformación cita su regla `Rnn` (Const. IV).
- [ ] Ninguna tarea propone algo fuera de alcance (Airflow, Dagster, dbt, nube, Notion, Python fuera de `tests/`).
- [ ] Ninguna tarea toca `raw` después de validada, ni versiona datos ni credenciales.
- [ ] Ninguna tarea edita `specs/README.md` a mano.
- [ ] Están las seis filas de la Fase N, incluida la lectura en frío.
