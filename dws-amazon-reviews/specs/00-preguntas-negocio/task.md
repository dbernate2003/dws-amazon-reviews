# Tareas — 00-preguntas-negocio

**Propósito**: lista de trabajo verificable para validar el catálogo de preguntas de negocio de la spec 00, dejar su trazabilidad y pasar su compuerta de cierre (D-00-01) | **Autor**: skill `tasks` (agente `task-breaker`) | **Fecha**: 2026-10-19
**Dependencias**: `spec.md`, `plan.md`, ninguna especificación anterior (es la primera), ADR-0006 y ADR-0007 firmados el 2026-10-19, D-00-01 firmada el 2026-10-19 (`adr/D-00-01-compuerta-de-cierre-sin-datos.md`)
**Rama**: `00-preguntas-negocio` | **Constitución**: v1.1.0 | **Estado**: borrador
**Responsable**: Dario Andres Bernate Canas | **Segundo validador**: Dario Andres Bernate Canas (spec DQ-10; `docs/gestion/roles.md`)
**Generado por**: skill `/tasks` (estructura de `templates/task-template.md`, autorizada por el responsable en lugar de `templates/task-list-template.md`)
**Basada en**: `spec.md` (última actualización 2026-10-19, «Revisada» por el responsable el 2026-10-19; último cambio de PN, requisitos o §6–§7: 2026-10-19, DQ-32 y DQ-33) · `plan.md` (2026-10-19, borrador, actualizado por T-00-56)

---

## 1. Resumen (siempre)

Al terminar esta lista, las doce preguntas de negocio (PN01 a PN12) quedan trazadas a sus campos, tableros y especificaciones destino, las siete de prioridad D quedan «Validadas» y la spec 00 queda lista para su compuerta de cierre.
Capas y esquemas que toca: ninguna. Son tareas documentales y de validación; no hay SQL ni pruebas de Python (spec DQ-31).
**Tareas**: 42 activas (más T-00-35 «No aplica» y 13 retiradas) | **Tiempo estimado**: 1590 min | **Fases**: 5
**Requisitos que cubre**: RF-00-01 … RF-00-11, RNF-00-01 … RNF-00-04, CE-00-01 … CE-00-05

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
| `[P]` | Paralelizable: no depende de otra tarea de su ola y no toca los mismos archivos que otra tarea de su ola. Anotar la evidencia de la propia fila de `task.md` al cerrar no cuenta como compartir archivo; sí cuenta cuando el resultado de la tarea vive solo en esa línea (verificaciones de la ola 13) |
| Minutos | Estimación entre 30 y 60. Si la tarea pide más, se parte (la lectura en frío de las 12 PN se partió en T-00-38 y T-00-55) |
| Cubre | IDs de `spec.md` y `plan.md`; toda tarea cita al menos uno (si no cita ninguno, es huérfana) |
| Hecho cuando | Una sola condición que otra persona puede comprobar sin preguntar al autor |
| Evidencia | El archivo o el commit que demuestra que se hizo (Principio X) |
| `retirada` | La tarea ya no aplica; conserva su ID y su motivo y no se reutiliza (§4, «Tareas retiradas») |

---

## 3. Mapa de dependencias y paralelismo (siempre)

| Ola | Tareas | ¿Paralelas? | Por qué | Se abre cuando |
|---|---|---|---|---|
| 1 | T-00-40, T-00-05, T-00-44, T-00-41 | sí | Cuatro archivos distintos y ninguna dependencia | Ya (no hay spec anterior) |
| 2 | T-00-42 | no | Regenera `plan.md` con lo que dejan T-00-05 y T-00-41 | T-00-05, T-00-40 y T-00-41 hechas |
| 3 | T-00-43 | no | Regenera `task.md` desde el plan nuevo | T-00-42 hecha |
| 3b | T-00-56 | no | Regenera plan y tareas tras DQ-32 (RF-00-10 acotado) | T-00-43 hecha |
| 4 | T-00-10 | no | `/analyze` necesita plan y tareas al día (D-00-02) | T-00-43, T-00-44 y T-00-56 hechas |
| 5 | T-00-11, T-00-12, T-00-22 | sí | `research.md`, `docs/glosario.md` y `quickstart.md` son archivos distintos | T-00-10 hecha |
| 6 | T-00-13, T-00-15 | sí | Una escribe `research.md`, la otra el glosario | T-00-11 y T-00-12 hechas |
| 7 | T-00-14, T-00-16 | sí | `research.md` frente a la matriz | T-00-13 hecha |
| 8 | T-00-17, T-00-47 | sí | Matriz frente a `checklists/validacion.md` | T-00-16, T-00-14 y T-00-05 hechas |
| 9 | T-00-18, T-00-24, T-00-23 | sí | Matriz, lista de validación y `spec.md` | T-00-17 y T-00-47 hechas |
| 10 | T-00-45, T-00-48 | sí | Matriz frente a lista de validación | T-00-18 y T-00-24 hechas |
| 11 | T-00-46, T-00-25 | sí | Matriz frente a lista de validación | T-00-45 y T-00-48 hechas |
| 12 | T-00-20 | no | Última columna de la matriz | T-00-46 hecha |
| 13 | T-00-28, T-00-29, T-00-30, T-00-49, T-00-50, T-00-51, T-00-52, T-00-53, T-00-54 | no (en cualquier orden) | Sin `[P]`: todas escriben su resultado en `task.md` (cada una en su línea «Evidencia») y las hace la misma persona; no dependen entre sí, así que el orden es libre | T-00-20, T-00-23 y T-00-25 hechas |
| 14 | T-00-36 | no | Junta los nueve resultados de la ola 13 (V-00-01 a V-00-09) | Ola 13 hecha |
| 15 | T-00-34, T-00-33 | sí | Lista de validación frente a `plan.md` | T-00-36 hecha |
| 16 | T-00-37 | no | Documentación al día con todo lo anterior | T-00-33 y T-00-34 hechas |
| 17 | T-00-38 | no | La lectura en frío lee los documentos terminados | T-00-37 hecha |
| 17b | T-00-55 | no | Segunda mitad de la lectura en frío, después de corregir lo que salga de la primera | T-00-38 hecha |
| 17c | T-00-31 | no | V-00-10 revisa también `checklists/legibilidad.md`, que nace en la lectura en frío | T-00-55 hecha |
| 18 | T-00-39 | no | El Pull Request cierra la compuerta | T-00-31 hecha |

---

## 4. Fases y tareas (siempre)

### Fase 0 — Preparación

**Objetivo**: dejar decididas las propuestas del plan, alineada la spec y regeneradas las tareas antes de producir documentos (Principio XII).
**Entregable**: firmas confirmadas, D-00-02, D-00-04, D-00-05 y D-00-06 decididas, `specs/README.md` citando D-00-01, plan y tareas al día (también tras DQ-32, T-00-56), informe de `/analyze` en `checklists/analisis.md`.

- [x] T-00-40 [P] Confirmar que ADR-0006, ADR-0007 y D-00-01 constan firmados en sus archivos y en `memory/adr/README.md` · 30 min · Dario Andres Bernate Canas
  - Cubre: plan §5.1, §5.2 · D-00-01 · Const. X, XII
  - Depende de: ninguna
  - Hecho cuando: los tres archivos dicen «Aceptado · firmado» con fecha 2026-10-19 y el índice `memory/adr/README.md` muestra 0006 y 0007 como firmados
  - Evidencia: `memory/adr/0006-nombre-del-archivo-de-tareas.md`, `memory/adr/0007-ubicacion-de-memory-y-lectura-por-agentes.md`, `specs/00-preguntas-negocio/adr/D-00-01-compuerta-de-cierre-sin-datos.md` y `memory/adr/README.md` (firmados 2026-10-19)

- [x] T-00-05 [P] Decidir en `plan.md` §5.2 las propuestas D-00-02, D-00-04, D-00-05 y D-00-06 · 45 min · Dario Andres Bernate Canas
  - Cubre: plan §5.2 · Componente: C-00-07 (D-00-04), C-00-21 (D-00-06) · Const. X
  - Depende de: ninguna
  - Hecho cuando: las cuatro filas de plan §5.2 dicen «Aceptada» o «Rechazada» con fecha y motivo; si D-00-06 se rechaza, plan §7.3 nombra otro lugar para la firma de CE-00-04 antes de empezar T-00-25
  - Evidencia: `specs/00-preguntas-negocio/plan.md` §5.2 (D-00-02 a D-00-06 decididas el 2026-10-19)

- [x] T-00-44 [P] Corregir la sección «Compuerta de cierre» de `specs/README.md` para que cite D-00-01 como origen de la variante de la spec 00 · 30 min · Dario Andres Bernate Canas
  - Cubre: plan §5.4 (cambio 5) · D-00-01 · Const. XIII.5
  - Depende de: ninguna
  - Hecho cuando: la fila `00` de esa tabla enlaza `00-preguntas-negocio/adr/D-00-01-compuerta-de-cierre-sin-datos.md` y la sección ya no dice que la variante de la 00 está «fijada en la constitución»
  - Evidencia: `specs/README.md`, sección «Compuerta de cierre» (cita D-00-01). Confirmada por el responsable el 2026-10-19

- [x] T-00-41 [P] Aplicar en `spec.md` el cambio 11 de plan §5.4: línea «Estado» y filas DQ-06, DQ-07 y DQ-08 sin «falta firma» · 30 min · Dario Andres Bernate Canas
  - Cubre: RF-00-06 · Componente: C-00-27 · Const. XII, XIII.5
  - Depende de: ninguna
  - Hecho cuando: buscar «falta firma» y «falta la firma» en `spec.md` da 0 resultados y «Última actualización» muestra la fecha del cambio
  - Evidencia: `spec.md`, línea «Estado» del encabezado y filas DQ-06 a DQ-08 de §12. Confirmada por el responsable el 2026-10-19

- [x] T-00-42 Regenerar `plan.md` con `/plan 00-preguntas-negocio` sobre la spec ajustada · 30 min · Dario Andres Bernate Canas
  - Cubre: RF-00-10 · Componente: C-00-17, C-00-28 · Const. XII
  - Depende de: T-00-05, T-00-40, T-00-41
  - Hecho cuando: la línea «Basada en» de `plan.md` muestra la misma fecha que «Última actualización» de `spec.md` y plan §16 registra el cambio
  - Evidencia: `specs/00-preguntas-negocio/plan.md` (2026-10-19; «Basada en» y §16). Confirmada por el responsable el 2026-10-19

- [x] T-00-43 Regenerar `task.md` con `/tasks 00-preguntas-negocio` sobre el plan regenerado · 30 min · Dario Andres Bernate Canas
  - Cubre: RF-00-10 · Componente: C-00-17, C-00-28 · Const. X
  - Depende de: T-00-42
  - Hecho cuando: la línea «Basada en» de `task.md` muestra las fechas vigentes de `spec.md` y `plan.md`, y el bloque `00-preguntas-negocio` de `specs/README.md` tiene las mismas filas que `task.md`
  - Evidencia: `specs/00-preguntas-negocio/task.md` (2026-10-19; «Basada en» y §8). Confirmada por el responsable el 2026-10-19

- [x] T-00-56 Regenerar `plan.md` y `task.md` sobre la spec con DQ-32 (RF-00-10 acotado) y los hallazgos de `checklists/analisis.md` · 60 min · Dario Andres Bernate Canas
  - Cubre: RF-00-10 · Componente: C-00-17, C-00-28 · DQ-32 · Const. XII, XIII.5
  - Depende de: T-00-43
  - Hecho cuando: la línea «Basada en» de `plan.md` y de `task.md` declara 2026-10-19, fecha del último cambio de PN, requisitos o spec §6–§7 (DQ-32); plan §16 y task §8 registran el cambio, y el bloque `00-preguntas-negocio` de `specs/README.md` tiene las mismas filas y cifras que `task.md`
  - Evidencia: `specs/00-preguntas-negocio/plan.md` (§16) y `task.md` (§8). Confirmada por el responsable el 2026-10-19

- [x] T-00-10 Correr `/analyze 00-preguntas-negocio` en modo completo (tercera pasada de D-00-02: se repitió porque la segunda dio un hallazgo alto) y guardar su informe en `specs/00-preguntas-negocio/checklists/analisis.md` · 30 min · Dario Andres Bernate Canas
  - Cubre: D-00-02 (dos pasadas más repetición si hay hallazgo alto; esta es la tercera, con `task.md`) · Const. XIII (puntos a, b, c y d de la tabla XIII-C), XIII.4, XIII.5 (encabezado del informe)
  - Depende de: T-00-43, T-00-44, T-00-56
  - Hecho cuando: el informe guardado dice «LISTO», con 0 hallazgos críticos y 0 altos
  - Evidencia: `specs/00-preguntas-negocio/checklists/analisis.md` (2026-10-19): pasada 2 NO LISTO (1 alto); pasada 3 LISTO con 0 críticos, 0 altos, 1 medio y 6 bajos. Confirmada por el responsable el 2026-10-19

**Punto de verificación de la Fase 0** (checklist manual):
- [x] ADR-0006, ADR-0007 y D-00-01 firmados; D-00-02, D-00-04, D-00-05 y D-00-06 con estado decidido en plan §5.2.
- [x] `plan.md` y `task.md` declaran en «Basada en» la fecha del último cambio de PN, requisitos o spec §6–§7 (DQ-32).
- [x] El informe de `/analyze` no tiene hallazgos críticos ni altos.

### Fase 1 — Fundamentos

**Objetivo**: cerrar la Fase 0 del plan (`research.md`), sembrar el glosario único del proyecto (Const. XIII.6) y dejar la guía para repetir la revisión.
**Entregable**: `research.md` con viabilidad e identificación de personas de las 12 PN, `docs/glosario.md` y `quickstart.md`.

- [x] T-00-11 [P] Crear `specs/00-preguntas-negocio/research.md` con encabezado y las 17 decisiones de plan §6 · 45 min · Dario Andres Bernate Canas
  - Cubre: RNF-00-04 · Componente: C-00-08 · plan §6 · Const. XIII.4, XIII.5
  - Depende de: T-00-10
  - Hecho cuando: el archivo abre con encabezado (propósito, autor, fecha, dependencias e IDs que atiende) y tiene 17 de 17 filas de plan §6 con pregunta, decisión, justificación y fuente
  - Evidencia: `specs/00-preguntas-negocio/research.md` (2026-10-19): encabezado con propósito, autor, fecha, dependencias e IDs que atiende, y 17 de 17 filas de plan §6 verificadas fila por fila (idénticas y en el mismo orden, comparación mecánica del 2026-10-19); 0 IDs citados inexistentes (Const. XIII.5)

- [x] T-00-12 [P] Crear `docs/glosario.md` con encabezado y los 39 términos de plan §15.1 · 45 min · Dario Andres Bernate Canas
  - Cubre: RNF-00-02 · Componente: C-00-07 · D-00-04 · Const. XIII.4, XIII.6
  - Depende de: T-00-10
  - Hecho cuando: el archivo abre con encabezado y define 39 de 39 términos de plan §15.1, con un solo nombre por concepto y «usuario» como término único para quien escribe la reseña
  - Evidencia: `docs/glosario.md` (2026-10-19): encabezado con propósito, autor, fecha, dependencias e IDs; 39 de 39 términos de plan §15.1 (G-01 a G-39), «usuario» como término único (DQ-20)

- [x] T-00-22 [P] Crear `specs/00-preguntas-negocio/quickstart.md` con encabezado y los pasos 01 a 09 de plan §7.2 · 45 min · Dario Andres Bernate Canas
  - Cubre: RNF-00-04 · Componente: C-00-08 · Const. IX, XIII.4, XIII.5
  - Depende de: T-00-10
  - Hecho cuando: el archivo abre con encabezado y lista 9 de 9 pasos, cada uno con su entrada y su salida, sin rutas atadas a una máquina
  - Evidencia: `specs/00-preguntas-negocio/quickstart.md` (2026-10-19): encabezado y 9 de 9 pasos (01 a 09) con entradas y salidas relativas al repositorio

- [x] T-00-13 [P] Analizar en `research.md`, para cada una de las 12 PN, qué campos de la fuente necesita y si la fuente puede responderla · 60 min · Dario Andres Bernate Canas
  - Cubre: RF-00-02 · Componente: C-00-03, C-00-04 · Const. XIII.5
  - Depende de: T-00-11
  - Hecho cuando: 12 de 12 PN tienen sus campos (de los diez de spec §3) y una viabilidad `viable`, `viable con reserva` o `no viable con esta fuente`; cada una no viable dice qué dato falta
  - Evidencia: `research.md` §2 (2026-10-19): 12 de 12 PN con campos de spec §11 y viabilidad; 6 `viable con reserva` con la decisión diferida que la motiva y 0 `no viable con esta fuente`

- [x] T-00-15 [P] Agregar a `docs/glosario.md` los términos y siglas de `spec.md` y `plan.md` que no estén en plan §15.1 · 45 min · Dario Andres Bernate Canas
  - Cubre: RNF-00-02 · Componente: C-00-07 · U-00-06 · Const. XIII.4, XIII.6
  - Depende de: T-00-12
  - Hecho cuando: cada sigla y término de dominio que aparece en `spec.md` y `plan.md` tiene entrada en el glosario (U-00-06 = 0 sin definir)
  - Evidencia: `docs/glosario.md` (2026-10-19): 10 entradas nuevas (G-40 a G-49) para SQL, DDL, ETL, ID, README, AGENTS.md, Pull Request, Kimball, Medallion y compuerta de cierre; 0 siglas de `spec.md` y `plan.md` sin definir

- [x] T-00-14 [P] Registrar en `research.md`, para cada una de las 12 PN, si su respuesta identifica a una persona o se entrega solo de forma agregada · 30 min · Dario Andres Bernate Canas
  - Cubre: RF-00-03, RF-00-09 · Componente: C-00-12 · Const. «Seguridad del dato», XIII.5
  - Depende de: T-00-13
  - Hecho cuando: 12 de 12 PN tienen la anotación; PN09, PN10 y PN11 figuran como solo agregadas; 0 PN que identifiquen a una persona sin decisión (reformular o descartar)
  - Evidencia: `research.md` §3 (2026-10-19): 12 de 12 PN revisadas; 0 identifican a una persona; PN09, PN10 y PN11 solo agregadas (RF-00-09)

**Punto de verificación de la Fase 1**:
- [ ] `research.md` tiene 12 de 12 PN con campos, viabilidad e identificación de personas.
- [ ] Todo término y sigla de `spec.md` y `plan.md` está en `docs/glosario.md`.
- [ ] `quickstart.md` tiene los 9 pasos de plan §7.2.

### Fase 2 — Construcción

**Objetivo**: construir la matriz de trazabilidad y la lista de validación, validar las PN de prioridad D y obtener la firma del responsable de Oro.
**Entregable**: `matriz-trazabilidad.md` con 12 filas completas, `checklists/validacion.md` firmado, spec §11 con las PN D «Validadas».

- [x] T-00-16 [P] Crear `specs/00-preguntas-negocio/matriz-trazabilidad.md` con encabezado y 12 filas con `id_pregunta`, `enunciado_resumido` y `prioridad` · 45 min · Dario Andres Bernate Canas
  - Cubre: RF-00-01, RNF-00-04 · Componente: C-00-01, C-00-08 · D-00-05 · Const. XIII.4, XIII.5
  - Depende de: T-00-13
  - Hecho cuando: el archivo abre con encabezado y tiene 12 filas, PN01 a PN12 sin repetir, con ID, enunciado y prioridad iguales a spec §5
  - Evidencia: `specs/00-preguntas-negocio/matriz-trazabilidad.md` (2026-10-19): encabezado y 12 filas PN01 a PN12 sin repetir, con enunciado y prioridad tomados de spec §5

- [x] T-00-17 [P] Completar `campos_fuente`, `viabilidad` y `motivo_viabilidad` en las 12 filas de la matriz · 60 min · Dario Andres Bernate Canas
  - Cubre: RF-00-02 · Componente: C-00-03, C-00-04 · Const. XIII.5
  - Depende de: T-00-16
  - Hecho cuando: 0 filas con `campos_fuente` o `viabilidad` vacíos; los campos coinciden con la columna «Disponible con los campos» de spec §11; cada fila que no es `viable` trae su motivo
  - Evidencia: `matriz-trazabilidad.md` (2026-10-19): 12 de 12 filas con campos de spec §11 y viabilidad; las 6 `viable con reserva` traen su motivo, tomado de `research.md` §2

- [x] T-00-47 [P] Crear `specs/00-preguntas-negocio/checklists/validacion.md` con encabezado y la revisión por pregunta de las 12 PN · 60 min · Dario Andres Bernate Canas
  - Cubre: CE-00-01, RF-00-01, RF-00-03, RF-00-09, RNF-00-04 · Componente: C-00-20, C-00-13, C-00-08 · D-00-06 · Const. XIII.4, XIII.5
  - Depende de: T-00-05, T-00-14
  - Hecho cuando: el archivo abre con encabezado y tiene 12 filas con sí o no para RF-00-01, RF-00-02, RF-00-03, RF-00-04, RF-00-07 y RF-00-09; toda PN que identifique a una persona está marcada «descartar»
  - Evidencia: `specs/00-preguntas-negocio/checklists/validacion.md` §1 (2026-10-19): encabezado y 12 filas con sí/no para los seis requisitos; 0 PN que identifiquen personas, ninguna se descarta

- [x] T-00-18 [P] Completar `corte_por_mes` y `cuenta_usuarios` en las 12 filas de la matriz, con la obligación de informar las anónimas excluidas · 45 min · Dario Andres Bernate Canas
  - Cubre: RF-00-05, RF-00-08, RF-00-11 · Componente: C-00-16, C-00-05, C-00-30 · DQ-14, DQ-19 · Const. XIII.5
  - Depende de: T-00-17
  - Hecho cuando: `corte_por_mes = sí` exactamente en PN01, PN02, PN03, PN04, PN07 y PN11; `cuenta_usuarios = sí` exactamente en PN02, PN09 y PN10, y cada una de esas tres filas dice que excluye las anónimas e informa cuántas, con destino 02, 04 y 05
  - Evidencia: `matriz-trazabilidad.md` (2026-10-19): corte por mes en las 6 PN con la marca «mes parcial»; conteo de usuarios en PN02, PN09 y PN10, cada una con «excluye las anónimas e informa cuántas (specs 02, 04 y 05)»

- [x] T-00-24 [P] Registrar en `checklists/validacion.md` el número de PN de cada tablero frente a U-00-02 y U-00-03 · 30 min · Dario Andres Bernate Canas
  - Cubre: CE-00-02, RF-00-04 · Componente: C-00-15 · Const. XIII.5
  - Depende de: T-00-47
  - Hecho cuando: la lista registra el conteo de T1, T2 y T3 contado en spec §7 (al 2026-10-19: 5, 2 y 5) y T1 y T3 tienen al menos 3 y T2 al menos 2
  - Evidencia: `checklists/validacion.md` §2 (2026-10-19): T1 = 5 (U-00-02 ≥ 3), T2 = 2 (U-00-03 ≥ 2), T3 = 5 (U-00-02 ≥ 3)

- [ ] T-00-23 [P] Validar en `spec.md` §11 las siete PN de prioridad D (PN01, PN02, PN03, PN04, PN05, PN07 y PN11) · 60 min · Dario Andres Bernate Canas (responsable y segundo validador)
  - Cubre: RF-00-07, CE-00-03 · Componente: C-00-18, C-00-19 · DQ-01 · Const. XIII.5
  - Depende de: T-00-14, T-00-17
  - Hecho cuando: las siete filas D de spec §11 tienen «Aprobada por», fecha y estado «Validada», las 12 filas tienen un estado, y toda PN D que no pudo validarse tiene su reapertura en spec §12
  - Evidencia:

- [x] T-00-45 [P] Completar `solo_agregada` y `tablero` en las 12 filas de la matriz · 30 min · Dario Andres Bernate Canas
  - Cubre: RF-00-04, RF-00-09 · Componente: C-00-14, C-00-29 · Const. XIII.5
  - Depende de: T-00-18
  - Hecho cuando: `solo_agregada = sí` exactamente en PN09, PN10 y PN11, y 12 de 12 filas tienen un tablero igual al de spec §7
  - Evidencia: `matriz-trazabilidad.md` (2026-10-19): `solo_agregada = sí` en PN09, PN10 y PN11; 12 de 12 filas con el tablero de spec §7 (T1: 5, T2: 2, T3: 5)

- [x] T-00-48 [P] Registrar en `checklists/validacion.md` la revisión de spec §6.1 y §6.2 (medida, cortes y nivel de detalle con nombres completos) · 30 min · Dario Andres Bernate Canas
  - Cubre: RNF-00-03 · Componente: C-00-23 · Const. XIII.4
  - Depende de: T-00-24
  - Hecho cuando: 12 de 12 filas de spec §6.2 están marcadas sí o no para medida, cortes y nivel de detalle, y cada «no» trae el cambio propuesto para la spec
  - Evidencia: `checklists/validacion.md` §4 (2026-10-19): 12 de 12 filas de spec §6.2 en sí; §6.1 revisada (una reseña); 0 cambios propuestos

- [x] T-00-46 [P] Completar `calculo_en_spec` y `decisiones_diferidas` en las 12 filas de la matriz · 45 min · Dario Andres Bernate Canas
  - Cubre: RNF-00-04 · D-00-05 · DQ-11, DQ-12, DQ-17, DQ-23, DQ-24 · Const. XIII.5
  - Depende de: T-00-45
  - Hecho cuando: 12 de 12 filas citan su fila de spec §6.2 sin copiar el cálculo, y `decisiones_diferidas` lista DQ-11 en PN06, DQ-17 en PN09, DQ-23 y DQ-24 en PN08 y DQ-12 en las PN que cuentan o comparan reseñas anónimas
  - Evidencia: `matriz-trazabilidad.md` (2026-10-19): 12 de 12 filas citan «§6.2, fila PNnn» sin copiar el cálculo; DQ-11 en PN06, DQ-17 y DQ-12 en PN09, DQ-23 y DQ-24 en PN08, y DQ-12 en PN02, PN10 y PN11

- [ ] T-00-25 [P] Firmar en `checklists/validacion.md`, como responsable de Oro, el insumo del grano (spec §6.1) y la tabla de cálculos (spec §6.2) · 30 min · Jose Julio Gomez Palmera
  - Cubre: CE-00-04 · Componente: C-00-21, C-00-22 · Const. XIII.4, XIII.5
  - Depende de: T-00-48
  - Hecho cuando: la lista trae nombre y fecha de Jose Julio Gomez Palmera; si pidió cambios, `spec.md` cambió antes y la fecha de la firma es posterior a ese cambio
  - Evidencia:

- [x] T-00-20 Completar `especificaciones_destino` y `criterio_de_aceptacion` en las 12 filas de la matriz · 45 min · Dario Andres Bernate Canas
  - Cubre: RNF-00-04 · Componente: C-00-06 · plan §7.4 a 7.9 (traspasos de RF-00-05, RF-00-08 y RF-00-11, spec §13) · Const. XIII.5
  - Depende de: T-00-46
  - Hecho cuando: 0 filas con esas columnas vacías; cada destino es 01, 02, 03, 04 o 05 y coincide con la tabla «Traspasos explícitos» del plan
  - Evidencia: `matriz-trazabilidad.md` (2026-10-19): 12 de 12 filas con destinos (01, 02, 03, 04 y 05 según el traspaso) y criterio de aceptación; 0 columnas vacías

**Punto de verificación de la Fase 2**:
- [ ] La matriz tiene 12 filas y ninguna columna obligatoria vacía.
- [ ] Las siete PN de prioridad D están en «Validada».
- [ ] `checklists/validacion.md` tiene la revisión por pregunta, el conteo por tablero, la revisión de §6 y la firma del responsable de Oro.

### Fase 3 — Pruebas

No aplica `pytest`: la spec 00 no tiene pruebas de Python (spec DQ-31; D-00-03 rechazada). Según D-00-01, las pruebas se sustituyen por la verificación humana `V-00-01` a `V-00-10` de plan §10.2.

**Objetivo**: la persona responsable ejecuta cada verificación sobre los documentos y anota su resultado (Principio XI).
**Entregable**: el resultado de `V-00-01` a `V-00-09` en la línea «Evidencia» de cada tarea. `V-00-10` (T-00-31) corre en la fase 4, después de la lectura en frío, para alcanzar `checklists/legibilidad.md`.

- [ ] T-00-28 Ejecutar V-00-01: contar las PN de `spec.md` §5 y de la matriz y revisar su alineación por commit · 30 min · Dario Andres Bernate Canas
  - Cubre: RF-00-01, RF-00-06 · Componente: C-00-01, C-00-02, C-00-26 · Const. XI
  - Depende de: T-00-20
  - Hecho cuando: 12 PN en ambos (U-00-01), 0 IDs repetidos y 0 cambios de PN sin su cambio en la matriz en el mismo commit; el resultado queda en Evidencia
  - Evidencia:

- [x] T-00-29 Ejecutar V-00-02: comparar campos y especificaciones destino de la matriz con spec §3 y §11 · 30 min · Dario Andres Bernate Canas
  - Cubre: RF-00-02, RNF-00-04 · Componente: C-00-03, C-00-06 · Const. XI
  - Depende de: T-00-20
  - Hecho cuando: 0 filas cuyos campos difieran de spec §11 y 0 filas sin especificaciones destino; el resultado queda en Evidencia
  - Evidencia: verificación mecánica del 2026-10-19: 12 de 12 filas con los campos de spec §11 (0 diferencias) y con especificaciones destino (0 vacías); resultado en `checklists/validacion.md` §6 (V-00-02)

- [ ] T-00-30 Ejecutar V-00-03: revisar las PN marcadas «no viable con esta fuente» en la matriz · 30 min · Dario Andres Bernate Canas
  - Cubre: RF-00-02 · Componente: C-00-04, C-00-25 · Const. XI
  - Depende de: T-00-20, T-00-23
  - Hecho cuando: 0 filas «no viable» sin el dato que falta o sin decisión en spec §12; el resultado queda en Evidencia
  - Evidencia:

- [x] T-00-49 Ejecutar V-00-04: revisar identificación de personas y respuesta agregada en `research.md` y en la lista de validación · 30 min · Dario Andres Bernate Canas
  - Cubre: RF-00-03, RF-00-09 · Componente: C-00-12, C-00-13 · Const. XI
  - Depende de: T-00-47
  - Hecho cuando: 12 de 12 PN revisadas, 0 PN que identifiquen a una persona sin marca «descartar» y PN09, PN10 y PN11 registradas como solo agregadas; el resultado queda en Evidencia
  - Evidencia: verificación mecánica del 2026-10-19: 12 de 12 PN revisadas, 0 identifican personas y PN09, PN10 y PN11 solo agregadas; resultado en `checklists/validacion.md` §6 (V-00-04)

- [x] T-00-50 Ejecutar V-00-05: comparar el tablero de cada PN en la matriz, spec §7 y la lista de validación · 30 min · Dario Andres Bernate Canas
  - Cubre: RF-00-04, CE-00-02 · Componente: C-00-14, C-00-15 · Const. XI
  - Depende de: T-00-20, T-00-24
  - Hecho cuando: 12 de 12 PN con el tablero de la spec; T1 y T3 con al menos U-00-02 y T2 con al menos U-00-03; el resultado queda en Evidencia
  - Evidencia: verificación mecánica del 2026-10-19: 12 de 12 PN con el tablero de spec §7; T1 = 5, T2 = 2, T3 = 5; resultado en `checklists/validacion.md` §6 (V-00-05)

- [x] T-00-51 Ejecutar V-00-06: revisar las marcas `corte_por_mes`, `cuenta_usuarios` y `solo_agregada` de la matriz · 30 min · Dario Andres Bernate Canas
  - Cubre: RF-00-05, RF-00-08, RF-00-09, RF-00-11 · Componente: C-00-05, C-00-16, C-00-29, C-00-30 · Const. XI
  - Depende de: T-00-20
  - Hecho cuando: `corte_por_mes = sí` exactamente en 6 PN (PN01, PN02, PN03, PN04, PN07, PN11), `cuenta_usuarios = sí` exactamente en 3 (PN02, PN09, PN10) con el informe de anónimas excluidas, y `solo_agregada = sí` exactamente en 3 (PN09, PN10, PN11); el resultado queda en Evidencia
  - Evidencia: verificación mecánica del 2026-10-19: 6 de 6, 3 de 3 y 3 de 3 con los informes de anónimas excluidas; resultado en `checklists/validacion.md` §6 (V-00-06)

- [ ] T-00-52 Ejecutar V-00-07: comparar la línea «Basada en» de `plan.md` y `task.md` con la fecha del último cambio de PN, requisitos o spec §6–§7 y revisar el orden de los cambios de PN · 30 min · Dario Andres Bernate Canas
  - Cubre: RF-00-06, RF-00-10 · Componente: C-00-17, C-00-27, C-00-28 · DQ-32 · Const. XI
  - Depende de: T-00-56, T-00-20, T-00-23, T-00-25
  - Hecho cuando: ambos encabezados declaran una fecha igual o posterior al último cambio de PN, requisitos o spec §6–§7 (spec §12 «Decisiones tomadas» e historial de commits de `spec.md`); los cambios solo de spec §11 (aprobaciones, firmas, fechas) no cuentan (DQ-32); 0 cambios de PN aparecen en un documento antes que en `spec.md`; el resultado queda en Evidencia
  - Evidencia:

- [ ] T-00-53 Ejecutar V-00-08: revisar en spec §11 el estado de las siete PN de prioridad D · 30 min · Dario Andres Bernate Canas
  - Cubre: RF-00-07, CE-00-03 · Componente: C-00-18, C-00-19 · Const. XI
  - Depende de: T-00-23
  - Hecho cuando: 7 de 7 PN D en «Validada» con nombre y fecha (U-00-04); el resultado queda en Evidencia
  - Evidencia:

- [ ] T-00-54 Ejecutar V-00-09: revisar que `checklists/validacion.md` esté completa y firmada · 30 min · Dario Andres Bernate Canas
  - Cubre: CE-00-01, CE-00-04, RNF-00-03 · Componente: C-00-20, C-00-21, C-00-22, C-00-23 · Const. XI
  - Depende de: T-00-25
  - Hecho cuando: 100 % de las PN cumplen RF-00-01 a RF-00-04 y RF-00-09 (U-00-05), spec §6.1 y §6.2 están revisadas y la firma del responsable de Oro tiene fecha; el resultado queda en Evidencia
  - Evidencia:

**Punto de verificación de la Fase 3**:
- [ ] Las nueve tareas de esta fase tienen su resultado en Evidencia.
- [ ] Cada resultado coincide con el esperado de plan §10.2.

### Fase 4 — Documentación y cierre

**Objetivo**: recorrer las seis condiciones de la compuerta de cierre con la variante de D-00-01 y dejar la spec lista para que la persona responsable la cierre (Principio XI).
**Entregable**: compuerta registrada en `checklists/validacion.md`, plan §4 al día, `checklists/legibilidad.md` firmado y Pull Request integrado.

La compuerta de la constitución tiene seis condiciones; la variante de la 00 la fija D-00-01 (firmada el 2026-10-19). Un agente no da la especificación por cerrada.

- [ ] T-00-36 Registrar en `checklists/validacion.md` el resultado conjunto de V-00-01 a V-00-09 como condición 3 de la compuerta (verificación humana) · 30 min · Dario Andres Bernate Canas
  - Cubre: Const. XI, XIII.5 · D-00-01 · plan §10.2, §14
  - Depende de: T-00-28, T-00-29, T-00-30, T-00-49, T-00-50, T-00-51, T-00-52, T-00-53, T-00-54
  - Hecho cuando: la lista registra 9 de 9 verificaciones (V-00-01 a V-00-09) con resultado igual al esperado de plan §10.2, con fecha y nombre de quien verificó; V-00-10 lo agrega T-00-31 después de la lectura en frío
  - Evidencia:

- [ ] T-00-34 [P] Registrar en `checklists/validacion.md` la condición 1 de la compuerta: CE-00-01 a CE-00-04 cumplidos y spec §11 firmada, sin `pytest` · 30 min · Dario Andres Bernate Canas
  - Cubre: CE-00-01, CE-00-02, CE-00-03, CE-00-04 · D-00-01 · Const. VI, XIII.5
  - Depende de: T-00-36
  - Hecho cuando: la lista dice «condición 1 cumplida» y cita el resultado de V-00-05, V-00-08 y V-00-09
  - Evidencia:

- — T-00-35 Confirmar cuadre exacto (condición 2) · No aplica
  - Cubre: Const. VI · D-00-01
  - Depende de: —
  - Hecho cuando: No aplica: la spec 00 no mueve datos ni filas (D-00-01; `specs/README.md`, «Compuerta de cierre»)
  - Evidencia: —

- [x] T-00-33 [P] Actualizar en `plan.md` §4 el estado de las filas IX, XII y XIII.4 a XIII.7 con la evidencia producida · 30 min · Dario Andres Bernate Canas
  - Cubre: plan §4 · Const. IX, XII, XIII.5
  - Depende de: T-00-36
  - Hecho cuando: cada una de esas seis filas pasa a ✅ con su evidencia o conserva ⚠️ con su motivo, y plan §4 registra el resultado de la compuerta
  - Evidencia: `plan.md` §4 (2026-10-19): IX, XIII.4, XIII.5 y XIII.6 en ✅ con evidencia (`quickstart.md`, glosario y documentos); XII ya estaba en ✅; XIII.7 conserva ⚠️ hasta la lectura en frío (T-00-38 y T-00-55); se agregó el «Resultado tras producir los documentos»

- [ ] T-00-37 Actualizar la documentación de la entrega (condición 4): glosario, documentos de la spec y fila S-00 de `docs/gestion/tareas.md` · 45 min · Dario Andres Bernate Canas
  - Cubre: Const. X, XIII.4, XIII.6 · D-00-01 · plan §14
  - Depende de: T-00-33, T-00-34
  - Hecho cuando: 0 términos sin definir (U-00-06), 0 documentos sin encabezado (U-00-07) y la fila S-00 de `docs/gestion/tareas.md` trae su evidencia
  - Evidencia:

- [ ] T-00-38 Revisión de legibilidad por una persona junior distinta del autor, parte 1: PN01 a PN06 y la matriz (lectura en frío, condición 5) · 45 min · Jose Julio Gomez Palmera
  - Cubre: RNF-00-01, CE-00-05 · Componente: C-00-11, C-00-24 · U-00-08 · Const. XIII.7
  - Depende de: T-00-37
  - Hecho cuando: `specs/00-preguntas-negocio/checklists/legibilidad.md` registra, para PN01 a PN06 y `matriz-trazabilidad.md`, las cinco preguntas respondidas 5 de 5 sin consultar al autor (U-00-08, provisional según el anexo de D-00-01); el tiempo queda sin umbral (U-00-09 `[POR DEFINIR: ADR-0012]`); si alguna falla, el artefacto se corrigió y la lectura se repitió
  - Evidencia:

- [ ] T-00-55 Revisión de legibilidad por una persona junior distinta del autor, parte 2: PN07 a PN12 y el glosario, y firma del checklist (lectura en frío, condición 5) · 45 min · Jose Julio Gomez Palmera
  - Cubre: RNF-00-01, CE-00-05 · Componente: C-00-11, C-00-24 · U-00-08 · Const. XIII.7
  - Depende de: T-00-38
  - Hecho cuando: `specs/00-preguntas-negocio/checklists/legibilidad.md` registra PN07 a PN12 y `docs/glosario.md` con 5 de 5 sin consultar al autor y está firmado; entre T-00-38 y T-00-55 se cubren las 12 PN (RNF-00-01 dice «cada pregunta», decisión del responsable del 2026-10-19)
  - Evidencia:

- [ ] T-00-31 Ejecutar V-00-10: revisar glosario, encabezados e IDs citados de los documentos de la spec y registrar su resultado en `checklists/validacion.md` · 30 min · Dario Andres Bernate Canas
  - Cubre: RNF-00-02, RNF-00-04 · Componente: C-00-07, C-00-08 · plan §9 (XIII.4, XIII.5), §10.2 · Const. XI, XIII.5
  - Depende de: T-00-55
  - Hecho cuando: 0 términos o siglas sin definir (U-00-06) y 0 documentos sin encabezado ni IDs (U-00-07) entre `research.md`, `matriz-trazabilidad.md`, `quickstart.md`, `checklists/validacion.md`, `checklists/legibilidad.md`, `checklists/analisis.md` y `docs/glosario.md`, y 0 IDs citados en `plan.md` y `task.md` que no existan en `spec.md`, en plan §2.3 o en `task.md`; el resultado queda en Evidencia y en `checklists/validacion.md`, junto a los de T-00-36 (condición 3)
  - Evidencia:

- [ ] T-00-39 Integrar a `main` el Pull Request de la rama `00-preguntas-negocio` (condición 6) · 30 min · Dario Andres Bernate Canas
  - Cubre: Const. XII · compuerta, condición 6
  - Depende de: T-00-31
  - Hecho cuando: el Pull Request desde la rama `00-preguntas-negocio` (con los cambios de la 00 que se hicieron en `01-ingesta-bronce`, plan S-00-05) está integrado a `main` con las seis condiciones marcadas
  - Evidencia:

**Punto de verificación de la Fase 4** (compuerta de cierre de la spec, variante D-00-01):
- [ ] 1. Tests en verde: sustituido por CE-00-01 a CE-00-04 cumplidos y spec §11 firmada (T-00-34)
- [ ] 2. Cuadre exacto: no aplica (T-00-35)
- [ ] 3. Verificación humana: V-00-01 a V-00-09 (T-00-36) y V-00-10 (T-00-31)
- [ ] 4. Documentación actualizada: glosario y documentos de la spec (T-00-37)
- [ ] 5. Checklist de legibilidad firmado (T-00-38 y T-00-55)
- [ ] 6. Pull Request integrado a `main` (T-00-39)

### Tareas retiradas

No cuentan en el seguimiento. Sus IDs no se reutilizan.

| ID | Tarea original | Motivo del retiro |
|---|---|---|
| T-00-01 | Firmar el ADR-0006 | Firmado el 2026-10-19 fuera de esta lista; la confirmación pasa a T-00-40 |
| T-00-02 | Firmar el ADR-0007 | Firmado el 2026-10-19 fuera de esta lista; la confirmación pasa a T-00-40 |
| T-00-03 | Actualizar el estado de ADR-0006 y ADR-0007 en el índice | El índice `memory/adr/README.md` ya los muestra firmados; la confirmación pasa a T-00-40 |
| T-00-04 | Firmar D-00-01 | Firmada el 2026-10-19 en `adr/D-00-01-compuerta-de-cierre-sin-datos.md`; la confirmación pasa a T-00-40 |
| T-00-06 | Agregar a `spec.md` los RNF y el CE de legibilidad | Hecho por `/clarify` el 2026-10-15 (spec DQ-16) |
| T-00-07 | Reemplazar marcadores `[SPEC]` e IDs con guion bajo en `plan.md` | Hecho en la reconciliación del plan del 2026-10-15 |
| T-00-08 | Agregar a plan §8 los componentes que faltaban | Hecho en las regeneraciones del plan del 2026-10-15 y 2026-10-19 (20 de 20 requisitos con componente) |
| T-00-09 | Completar la columna «Tarea» de plan §11 | Hecho en la regeneración del plan del 2026-10-19 |
| T-00-19 | Completar `medida_candidata`, `dimensiones_candidatas` y `grano_candidato` | Esas columnas salieron de la matriz por D-00-05 (la matriz cita spec §6.2, no la copia); la sustituye T-00-46 |
| T-00-21 | Reconciliar los traspasos del plan con spec §13 | Hecho en la regeneración del plan del 2026-10-19 |
| T-00-26 | Escribir `tests/test_catalogo_preguntas.py` | D-00-03 rechazada (spec DQ-31): no hay validador en Python |
| T-00-27 | Agregar la prueba de PN en la matriz a `tests/test_catalogo_preguntas.py` | D-00-03 rechazada (spec DQ-31) |
| T-00-32 | Ejecutar la búsqueda de tecnología en los requisitos de `spec.md` | C-00-09 retirado; la verificación V-00-05 es ahora la de tableros (T-00-50) |

---

## 5. Seguimiento de avance (siempre)

% hecho = hechas ÷ total × 100; % falta = 100 − % hecho. No cuentan T-00-35 («No aplica») ni las 13 retiradas.

| Fase | Tareas | Hechas | % hecho | % falta | Minutos estimados |
|---|---|---|---|---|---|
| 0 — Preparación | 8 | 8 | 100 % | 0 % | 285 |
| 1 — Fundamentos | 6 | 1 | 17 % | 83 % | 270 |
| 2 — Construcción | 11 | 0 | 0 % | 100 % | 480 |
| 3 — Pruebas (verificación humana) | 9 | 0 | 0 % | 100 % | 270 |
| 4 — Documentación y cierre | 8 | 0 | 0 % | 100 % | 285 |
| **Total** | **42** | **9** | **21 %** | **79 %** | **1590** |

Recalculado el 2026-10-19 desde las casillas: 42 activas, 9 en `[x]` (T-00-40, T-00-05, T-00-41, T-00-42, T-00-43, T-00-44, T-00-56, T-00-10 y T-00-11). Entra T-00-56 (60 min, fase 0) y T-00-31 pasa de la fase 3 a la 4 porque V-00-10 corre después de la lectura en frío (T-00-55). T-00-38 y T-00-55 siguen en 45 + 45 min.

---

## 6. Cobertura de requisitos (siempre; la comprueba `/analyze`)

| Requisito | Tareas que lo cubren | Prueba o consulta | Estado |
|---|---|---|---|
| RF-00-01 | T-00-16, T-00-47, T-00-28 | V-00-01 | cubierto |
| RF-00-02 | T-00-13, T-00-17, T-00-29, T-00-30 | V-00-02, V-00-03 | cubierto |
| RF-00-03 | T-00-14, T-00-47, T-00-49 | V-00-04 | cubierto |
| RF-00-04 | T-00-45, T-00-24, T-00-50 | V-00-05 | cubierto |
| RF-00-05 | T-00-18, T-00-51 | V-00-06 (parcial en la 00; la marca visible en T1 y T3 se comprueba en 02, 04 y 05, traspaso de spec §13) | cubierto en lo que toca a la 00 |
| RF-00-06 | T-00-41, T-00-28, T-00-52 | V-00-01, V-00-07 | cubierto |
| RF-00-07 | T-00-23, T-00-53 | V-00-08 | cubierto |
| RF-00-08 | T-00-18, T-00-51 | V-00-06 (parcial en la 00; la exclusión real se comprueba en 02 y 04, traspaso de spec §13) | cubierto en lo que toca a la 00 |
| RF-00-09 | T-00-14, T-00-45, T-00-47, T-00-49, T-00-51 | V-00-04, V-00-06 | cubierto |
| RF-00-10 | T-00-42, T-00-43, T-00-56, T-00-52 | V-00-07 | cubierto |
| RF-00-11 | T-00-18, T-00-51 | V-00-06 (parcial en la 00; la cifra se comprueba en 02, 04 y 05, traspaso de spec §13) | cubierto en lo que toca a la 00 |
| RNF-00-01 | T-00-38, T-00-55 | Checklist de legibilidad firmado | cubierto |
| RNF-00-02 | T-00-12, T-00-15, T-00-31 | V-00-10 | cubierto |
| RNF-00-03 | T-00-48, T-00-54 | V-00-09 | cubierto |
| RNF-00-04 | T-00-11, T-00-16, T-00-22, T-00-46, T-00-47, T-00-20, T-00-31, T-00-29 | V-00-10, V-00-02 | cubierto |
| CE-00-01 | T-00-47, T-00-54, T-00-34 | V-00-09 | cubierto |
| CE-00-02 | T-00-24, T-00-50, T-00-34 | V-00-05 | cubierto |
| CE-00-03 | T-00-23, T-00-53, T-00-34 | V-00-08 | cubierto |
| CE-00-04 | T-00-25, T-00-54, T-00-34 | V-00-09 | cubierto |
| CE-00-05 | T-00-38, T-00-55 | Checklist de legibilidad firmado | cubierto |

**Cifras**: 20 de 20 requisitos con tarea (17 verificables por completo en la 00; RF-00-05, RF-00-08 y RF-00-11 solo en parte, con traspaso a 02, 04 y 05 según plan §10.2 y spec §13); 28 de 28 componentes vigentes del plan con al menos una tarea (C-00-09 y C-00-10 retirados); 10 de 10 verificaciones `V-00-MM` con su tarea. Ninguna regla `Rnn` aplica: la spec 00 no crea transformaciones.

**Chequeos de completitud**:
1. Todo RF, RNF y CE tiene al menos una tarea: 20 de 20.
2. Toda tarea cita al menos un requisito, una decisión o un principio: 42 de 42.
3. Toda regla `Rnn` tiene una tarea de construcción y una de prueba: no aplica (sin reglas).
4. Existen las tareas finales de verificación humana (T-00-36 y T-00-31), lectura en frío (T-00-38 y T-00-55) y Pull Request (T-00-39).
5. D-00-08: las 24 tareas abiertas que crean o editan un documento citan `Const. XIII.n`; las 9 de verificación pura (T-00-28, T-00-29, T-00-30, T-00-49 a T-00-54) no la citan; T-00-39 no edita documentos y las 8 hechas conservan su texto.

---

## 7. Lista de revisión antes de entregar las tareas

- [x] **Accionable**: cada tarea empieza con un verbo y nombra un artefacto concreto.
- [x] **Verificable**: cada tarea tiene una línea «Hecho cuando» que se comprueba con una cifra, un archivo o una verificación `V-00-MM`.
- [x] **Independiente**: cada dependencia está declarada; las tareas `[P]` de una misma ola no comparten archivo.
- [x] **Limitada**: ninguna tarea supera 60 minutos.
- [x] **Trazable**: cada tarea cita al menos un requisito, y cada requisito tiene al menos una tarea.
- [x] **Legible**: los encabezados se crean con el documento que los lleva; están las tareas finales de lectura en frío (T-00-38 y T-00-55, Const. XIII.7), asignada a una persona distinta del autor.
- [x] **Ordenada**: ninguna tarea depende de otra de una ola posterior.
- [x] Toda tarea que crea una transformación cita su regla `Rnn` (Const. IV): no aplica, la spec 00 no tiene transformaciones.
- [x] Ninguna tarea propone algo fuera de alcance (Airflow, Dagster, dbt, nube, Notion, Python fuera de `tests/`); no hay tareas de `pytest` (spec DQ-31).
- [x] Ninguna tarea toca `raw`, ni versiona datos ni credenciales.
- [x] Ninguna tarea edita a mano los bloques de tareas de `specs/README.md` (T-00-44 corrige solo la sección «Compuerta de cierre»).

---

## 8. Historial de cambios

| Fecha | Cambio | Motivo | Autor |
|---|---|---|---|
| 2026-10-14 | Versión inicial (borrador, 38 tareas en seis fases) | Primer `/tasks` de la spec 00, con plan sin reconciliar y ADR-0006 y ADR-0007 sin firma | skill `tasks` |
| 2026-10-19 | Regeneración sobre la spec y el plan del 2026-10-19 con la estructura de `templates/task-template.md` (cinco fases, autorizada por el responsable). Se retiran 13 tareas (T-00-01 a T-00-04, T-00-06 a T-00-09, T-00-19, T-00-21, T-00-26, T-00-27 y T-00-32) con su motivo. Se agregan T-00-40 a T-00-54: confirmar firmas, aplicar el cambio 11 de plan §5.4, regenerar plan y tareas (RF-00-10), citar D-00-01 en `specs/README.md`, columnas `solo_agregada`, `tablero`, `calculo_en_spec` y `decisiones_diferidas` de la matriz, `checklists/validacion.md` y las verificaciones V-00-04 a V-00-09. Se ajustan sin cambiar de ID: T-00-05 (ya no incluye D-00-03 y agrega D-00-06), T-00-12 (39 términos), T-00-15, T-00-18 (columnas `corte_por_mes` y `cuenta_usuarios`), T-00-24 y T-00-25 (la evidencia pasa a `checklists/validacion.md`, D-00-06), T-00-31 (la verificación de glosario y encabezados es ahora V-00-10), T-00-33, T-00-34 (sin `pytest`) y T-00-36 (V-00-01 a V-00-10). IDs citados con el formato `RF-00-MM`. Sin tareas `[x]` previas que conservar | La spec cambió el 2026-10-19 (DQ-22 a DQ-31), ADR-0006, ADR-0007 y D-00-01 se firmaron y el plan se regeneró; RF-00-10 exige regenerar las tareas | skill `tasks` (agente `task-breaker`) |
| 2026-10-19 | Actualización T-00-43 sobre el plan actualizado por T-00-42. Se conservan `[x]` T-00-40 y T-00-05 con su evidencia; ningún ID cambia. T-00-41, T-00-44, T-00-42 y T-00-43 siguen `[ ]` con su evidencia y la nota «aplicada 2026-10-19, falta confirmación del responsable». T-00-10 se precisa como segunda pasada de D-00-02 (puntos a a d de XIII-C). T-00-38 cita U-00-08 provisional (anexo de D-00-01) y U-00-09 pendiente. Ola 13 sin `[P]`: sus diez verificaciones escriben su resultado en `task.md` (regla de archivo compartido de la skill). T-00-20 y T-00-29 cubren RNF-00-04 en lugar de CE-00-04 (C-00-06 cambió en el plan). T-00-33 incluye la fila IX. §6 marca RF-00-05, RF-00-08 y RF-00-11 como verificación parcial en la 00. §5 recalculado: 1530 min (la fase 4 suma 255) | Hallazgos de la última `/analyze` y plan actualizado (RF-00-10) | skill `tasks` (agente `task-breaker`) |
| 2026-10-19 | El responsable confirma T-00-41, T-00-42, T-00-43 y T-00-44 (`[x]`). T-00-38 (90 min) se parte en T-00-38 (PN01 a PN06 y matriz, 45 min) y la nueva T-00-55 (PN07 a PN12, glosario y firma, 45 min); T-00-39 pasa a depender de T-00-55 | Regla de 60 min por tarea; decisión del responsable | sesión principal (Claude), a pedido del responsable |
| 2026-10-19 | Actualización T-00-56 sobre la spec con DQ-32 (RF-00-10 acotado) y el plan actualizado. Se conservan `[x]` T-00-40, T-00-05, T-00-41, T-00-42, T-00-43 y T-00-44 con su evidencia; ningún ID cambia. Nueva T-00-56 (regenerar plan y tareas por DQ-32, 60 min, `[ ]`, aplicada, falta confirmación). T-00-10 sigue `[ ]`, con el primer informe NO LISTO en su evidencia, y depende de T-00-56. T-00-52 (V-00-07) compara contra el último cambio de PN, requisitos o spec §6–§7. T-00-31 (V-00-10) alcanza `legibilidad.md`, `analisis.md` y los IDs citados en plan y tareas, pasa a la fase 4 y corre tras T-00-55 y antes de T-00-39; T-00-36 junta V-00-01 a V-00-09. D-00-08: las tareas que crean o editan un documento citan XIII.4 o XIII.5 y las de verificación pura no. T-00-11 pasa a 17 decisiones (plan §6 agrega DQ-32). §1, §5 y §6 cuentan 42 tareas y 1590 min; chequeo 4 y «Legible» citan T-00-38 y T-00-55; historial en orden cronológico | Spec DQ-32, plan actualizado por T-00-56 y hallazgos 3, 5 y 7 de `checklists/analisis.md` (T-00-10); RF-00-10 | skill `tasks` (agente `task-breaker`) |
| 2026-10-19 | El responsable confirma T-00-56 (`[x]`). Tercera pasada de `/analyze` (T-00-10): LISTO con 0 críticos y 0 altos; se aplican sus correcciones mecánicas 1 a 5 (cifras de §5 y chequeo 5, «tercera pasada» en T-00-10, T-00-52 depende de T-00-23 y T-00-25) | Hallazgos 2, 3 y 5 de la pasada 3 (`checklists/analisis.md`) | sesión principal (Claude), a pedido del responsable |
| 2026-10-19 | El responsable confirma T-00-10 (`[x]`, pasada 3 LISTO) y acepta DQ-33 (verificación de RF-00-06 acotada); «Basada en» se actualiza sin regenerar, porque solo cambia la línea de verificación de un requisito | Hallazgo 1 de la pasada 3 | sesión principal (Claude), a pedido del responsable |
| 2026-10-19 | T-00-11 verificada y cerrada (`[x]`) con su evidencia: `research.md` abre con encabezado (propósito, autor, fecha, dependencias e IDs) y sus 17 filas son idénticas y en el mismo orden que las de plan §6; 0 IDs citados inexistentes. Se marcan las tres casillas del punto de verificación de la Fase 0. §5 recalculado: 9 de 42 | Auditoría de la Fase 0 (verificación mecánica contra plan §6) | agente implementer (OpenCode) |
