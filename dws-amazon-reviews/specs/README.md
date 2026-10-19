# Especificaciones

Una carpeta por especificación (`NN-nombre/`, dos dígitos). El orden es obligatorio (Principio XII): una no empieza hasta que la anterior pasa sus tests o su variante de cierre.

| Orden | Carpeta | Rama | Entrega | Depende de | Resolver antes |
|---|---|---|---|---|---|
| 0 | `00-preguntas-negocio/` | `00-preguntas-negocio` | Preguntas de negocio validadas (insumo del grano y de los dashboards) | — | ADR-0006, 0007 (antes de `/tasks`) |
| 1 | `01-ingesta-bronce/` | `01-ingesta-bronce` | Bronce (`raw`) y su Parquet | 00 | ADR-0003, 0008 |
| 2 | `02-exploracion-eda/` | `02-exploracion-eda` | Catálogo de reglas R01… sobre `raw` | 01 | — |
| 3 | `03-etl-plata/` | `03-etl-plata` | Plata (`silver`) y su Parquet | 02 | ADR-0009 |
| 4 | `04-modelo-oro/` | `04-modelo-oro` | Oro (`gold`), rol de solo lectura y su Parquet | 03 | ADR-0010 |
| 5 | `05-dashboards-bi/` | `05-dashboards-bi` | Tableau sobre Oro | 04 | ADR-0011 |
| 6 | `06-reproducibilidad-integracion/` | `06-reproducibilidad-integracion` | Flujo completo reproducible desde `all_3y.txt.gz` | 05 | — |

## Orden dentro de cada especificación (GitHub Spec Kit)

`/specify` → `/clarify` → `/plan` → `/analyze` → `/tasks` → `/implement`. La constitución fija el flujo (sección «Flujo de desarrollo y compuertas»); quién ejecuta cada paso y qué produce está en el [README raíz](../README.md). `00` no tiene código ni datos, así que `/implement` no aplica en ella.

## Equivalencias con Spec Kit

Lo que este repositorio adapta de [GitHub Spec Kit](https://github.com/github/spec-kit):

| En Spec Kit | Aquí | Motivo |
|---|---|---|
| `/speckit-<paso>` | `/<paso>`: `specify` a mano; `clarify` y `plan` son skills de Claude; `tasks` e `implement`, comandos de OpenCode (más `/check` para verificar) | Así se reparte el trabajo del proyecto |
| Carpeta de la funcionalidad | `specs/NN-nombre/`, dos dígitos desde `00` | Principios XII y XIII: el número fija el orden de ejecución |
| `/speckit-constitution` | Constitución escrita una vez con `templates/constitution-template.md`; enmiendas por Pull Request | Gobernanza de la constitución |
| Ubicación de la constitución | `memory/constitution.md` | Sujeta al ADR-0007 |
| `tasks.md` | `task.md` | ADR-0006; Spec Kit usa `tasks.md` |
| `/speckit-analyze` | `/analyze` (solo lectura). Spec Kit lo corre después de `/tasks`; aquí corre antes y después (D-00-02 de la `00`) | Orden decidido por el proyecto |
| `/speckit-checklist` y `checklists/` | Sin comando propio: la «Revisión final» de `templates/spec-template.md` | La constitución exige `checklists/legibilidad.md` (Const. XIII, Verificación 4); la `00` agrega `validacion.md` (D-00-06) y `analisis.md` (D-00-02) |
| `/speckit-converge` | Sin comando propio: compuerta de cierre de seis condiciones y verificación humana con SQL | Un agente no cierra una especificación (principio XI) |

## Qué contiene cada carpeta

| Archivo | Quién lo crea | Contenido |
|---|---|---|
| `spec.md` | `/specify` · a mano | Qué y por qué, sin tecnología (plantilla: `templates/spec-template.md`). `/clarify` ajusta aquí la spec según las respuestas |
| `plan.md` | `/plan` · skill de Claude | Plan técnico (arquitectura, herramientas y metodología), con su Constitution Check |
| archivo de tareas | `/tasks` · OpenCode (`task-breaker`) | Tareas que salen del plan. Se llama `task.md` (ADR-0006) |
| `adr/` | `/plan` · skill de Claude | Decisiones de esa sola entrega |

Si algo cambia, se actualiza primero la spec, luego se regeneran plan y tareas y se vuelve a correr `/analyze`. Si una spec pasa de 300 líneas al redactarla, se divide (caso probable: `04-modelo-oro`).

## Requisitos transversales y su dueño

| Requisito | Dueño | Qué debe decir la spec |
|---|---|---|
| Preguntas de negocio | `00` | Cada pregunta con indicador, fuente y responsable; de ellas sale el grano de `04` |
| Trazabilidad de datos (Const. XIII.5) | `03` y `04` | `03` conserva la llave de origen de Bronce; `04` conserva la de Plata en la tabla de hechos |
| Trazabilidad del trabajo (Const. XIII.5) | todas | Cada RF enlaza con su verificación; cada regla con su conteo y su test; cada tarea con su evidencia |
| Rol de solo lectura para Tableau | `04` | Se crea con el esquema `gold`; `05` solo lo usa y lo verifica |
| Parquet por capa (Principio II) | `01`, `03`, `04` | Cada una exporta el Parquet de su capa; `06` comprueba que coincide tras reconstruir |

## Compuerta de cierre

Son las seis condiciones de la constitución (sección «Flujo de desarrollo y compuertas»). Los puntos 4, 5 y 6 aplican igual a todas las specs. Los puntos 1, 2 y 3 pueden tener una variante por tipo de spec; la constitución no las fija: cada variante la decide la spec con su ADR (la de `00` está en [D-00-01](00-preguntas-negocio/adr/D-00-01-compuerta-de-cierre-sin-datos.md)):

1. Tests en verde.
2. Cuadre exacto.
3. Verificación humana con SQL.
4. Documentación actualizada (README de la capa o de la entrega).
5. Checklist de legibilidad firmado tras la lectura en frío (Const. XIII.7).
6. Pull Request integrado a `main`.

| Spec | Tests en verde (1) | Cuadre exacto (2) |
|---|---|---|
| `00` | Sustituido: CE-00-01 a CE-00-04 cumplidos y sección 11 de la spec firmada; la condición 3 se cumple con V-00-01 a V-00-10 sobre los documentos ([D-00-01](00-preguntas-negocio/adr/D-00-01-compuerta-de-cierre-sin-datos.md)) | No aplica: no mueve datos |
| `01`, `03`, `04` | Un test por regla y por objeto de la capa | Aplica |
| `02` | Sustituido: el conteo de cada regla R01… se reproduce con SQL sobre `raw` | No aplica: solo lectura, no mueve filas |
| `05` | Sustituido: cada dashboard responde su pregunta de `00` y se conecta con el rol de solo lectura | No aplica: no mueve datos |
| `06` | Tras reconstruir desde `all_3y.txt.gz`, los conteos de cada capa y de cada Parquet coinciden con los documentados | Aplica, repetido sobre la reconstrucción |

## Tareas por especificación

<!-- tareas-resumen:inicio -->
| Spec | Archivo | Tareas | Hechas | % hecho | % falta | Min estimados | Bloqueos |
|---|---|---|---|---|---|---|---|
| `00-preguntas-negocio` | [task.md](00-preguntas-negocio/task.md) | 42 | 8 | 19 % | 81 % | 1590 | U-00-09 `[POR DEFINIR: ADR-0012]` |
<!-- tareas-resumen:fin -->

### 00-preguntas-negocio

<!-- tareas:00-preguntas-negocio:inicio -->
| ID | Estado | Tarea | Responsable | Depende de | Evidencia |
|---|---|---|---|---|---|
| T-00-40 | [x] [P] | Confirmar que ADR-0006, ADR-0007 y D-00-01 constan firmados en sus archivos y en `memory/adr/README.md` | Dario Andres Bernate Canas | ninguna | ADR 0006, 0007, D-00-01 e índice (2026-10-19) |
| T-00-05 | [x] [P] | Decidir en `plan.md` §5.2 las propuestas D-00-02, D-00-04, D-00-05 y D-00-06 | Dario Andres Bernate Canas | ninguna | `plan.md` §5.2 (2026-10-19) |
| T-00-44 | [x] [P] | Corregir la sección «Compuerta de cierre» de `specs/README.md` para que cite D-00-01 como origen de la variante de la spec 00 | Dario Andres Bernate Canas | ninguna | `specs/README.md`, sección «Compuerta de cierre» (confirmada 2026-10-19) |
| T-00-41 | [x] [P] | Aplicar en `spec.md` el cambio 11 de plan §5.4: línea «Estado» y filas DQ-06, DQ-07 y DQ-08 sin «falta firma» | Dario Andres Bernate Canas | ninguna | `spec.md`, línea «Estado» y filas DQ-06 a DQ-08 (confirmada 2026-10-19) |
| T-00-42 | [x] | Regenerar `plan.md` con `/plan 00-preguntas-negocio` sobre la spec ajustada | Dario Andres Bernate Canas | T-00-05, T-00-40, T-00-41 | `plan.md` (2026-10-19) (confirmada 2026-10-19) |
| T-00-43 | [x] | Regenerar `task.md` con `/tasks 00-preguntas-negocio` sobre el plan regenerado | Dario Andres Bernate Canas | T-00-42 | `task.md` (2026-10-19) (confirmada 2026-10-19) |
| T-00-56 | [x] | Regenerar `plan.md` y `task.md` sobre la spec con DQ-32 (RF-00-10 acotado) y los hallazgos de `checklists/analisis.md` | Dario Andres Bernate Canas | T-00-43 | `plan.md` (§16) y `task.md` (§8). Confirmada por el responsable el 2026-10-19 |
| T-00-10 | [x] | Correr `/analyze 00-preguntas-negocio` en modo completo (tercera pasada de D-00-02: se repitió porque la segunda dio un hallazgo alto) y guardar su informe en `specs/00-preguntas-negocio/checklists/analisis.md` | Dario Andres Bernate Canas | T-00-43, T-00-44, T-00-56 | `checklists/analisis.md`, pasada 3 LISTO (2026-10-19) |
| T-00-11 | [ ] [P] | Crear `specs/00-preguntas-negocio/research.md` con encabezado y las 17 decisiones de plan §6 | Dario Andres Bernate Canas | T-00-10 | |
| T-00-12 | [ ] [P] | Crear `docs/glosario.md` con encabezado y los 39 términos de plan §15.1 | Dario Andres Bernate Canas | T-00-10 | |
| T-00-22 | [ ] [P] | Crear `specs/00-preguntas-negocio/quickstart.md` con encabezado y los pasos 01 a 09 de plan §7.2 | Dario Andres Bernate Canas | T-00-10 | |
| T-00-13 | [ ] [P] | Analizar en `research.md`, para cada una de las 12 PN, qué campos de la fuente necesita y si la fuente puede responderla | Dario Andres Bernate Canas | T-00-11 | |
| T-00-15 | [ ] [P] | Agregar a `docs/glosario.md` los términos y siglas de `spec.md` y `plan.md` que no estén en plan §15.1 | Dario Andres Bernate Canas | T-00-12 | |
| T-00-14 | [ ] [P] | Registrar en `research.md`, para cada una de las 12 PN, si su respuesta identifica a una persona o se entrega solo de forma agregada | Dario Andres Bernate Canas | T-00-13 | |
| T-00-16 | [ ] [P] | Crear `specs/00-preguntas-negocio/matriz-trazabilidad.md` con encabezado y 12 filas con `id_pregunta`, `enunciado_resumido` y `prioridad` | Dario Andres Bernate Canas | T-00-13 | |
| T-00-17 | [ ] [P] | Completar `campos_fuente`, `viabilidad` y `motivo_viabilidad` en las 12 filas de la matriz | Dario Andres Bernate Canas | T-00-16 | |
| T-00-47 | [ ] [P] | Crear `specs/00-preguntas-negocio/checklists/validacion.md` con encabezado y la revisión por pregunta de las 12 PN | Dario Andres Bernate Canas | T-00-05, T-00-14 | |
| T-00-18 | [ ] [P] | Completar `corte_por_mes` y `cuenta_usuarios` en las 12 filas de la matriz, con la obligación de informar las anónimas excluidas | Dario Andres Bernate Canas | T-00-17 | |
| T-00-24 | [ ] [P] | Registrar en `checklists/validacion.md` el número de PN de cada tablero frente a U-00-02 y U-00-03 | Dario Andres Bernate Canas | T-00-47 | |
| T-00-23 | [ ] [P] | Validar en `spec.md` §11 las siete PN de prioridad D (PN01, PN02, PN03, PN04, PN05, PN07 y PN11) | Dario Andres Bernate Canas (responsable y segundo validador) | T-00-14, T-00-17 | |
| T-00-45 | [ ] [P] | Completar `solo_agregada` y `tablero` en las 12 filas de la matriz | Dario Andres Bernate Canas | T-00-18 | |
| T-00-48 | [ ] [P] | Registrar en `checklists/validacion.md` la revisión de spec §6.1 y §6.2 (medida, cortes y nivel de detalle con nombres completos) | Dario Andres Bernate Canas | T-00-24 | |
| T-00-46 | [ ] [P] | Completar `calculo_en_spec` y `decisiones_diferidas` en las 12 filas de la matriz | Dario Andres Bernate Canas | T-00-45 | |
| T-00-25 | [ ] [P] | Firmar en `checklists/validacion.md`, como responsable de Oro, el insumo del grano (spec §6.1) y la tabla de cálculos (spec §6.2) | Jose Julio Gomez Palmera | T-00-48 | |
| T-00-20 | [ ] | Completar `especificaciones_destino` y `criterio_de_aceptacion` en las 12 filas de la matriz | Dario Andres Bernate Canas | T-00-46 | |
| T-00-28 | [ ] | Ejecutar V-00-01: contar las PN de `spec.md` §5 y de la matriz y revisar su alineación por commit | Dario Andres Bernate Canas | T-00-20 | |
| T-00-29 | [ ] | Ejecutar V-00-02: comparar campos y especificaciones destino de la matriz con spec §3 y §11 | Dario Andres Bernate Canas | T-00-20 | |
| T-00-30 | [ ] | Ejecutar V-00-03: revisar las PN marcadas «no viable con esta fuente» en la matriz | Dario Andres Bernate Canas | T-00-20, T-00-23 | |
| T-00-49 | [ ] | Ejecutar V-00-04: revisar identificación de personas y respuesta agregada en `research.md` y en la lista de validación | Dario Andres Bernate Canas | T-00-47 | |
| T-00-50 | [ ] | Ejecutar V-00-05: comparar el tablero de cada PN en la matriz, spec §7 y la lista de validación | Dario Andres Bernate Canas | T-00-20, T-00-24 | |
| T-00-51 | [ ] | Ejecutar V-00-06: revisar las marcas `corte_por_mes`, `cuenta_usuarios` y `solo_agregada` de la matriz | Dario Andres Bernate Canas | T-00-20 | |
| T-00-52 | [ ] | Ejecutar V-00-07: comparar la línea «Basada en» de `plan.md` y `task.md` con la fecha del último cambio de PN, requisitos o spec §6–§7 y revisar el orden de los cambios de PN | Dario Andres Bernate Canas | T-00-56, T-00-20, T-00-23, T-00-25 | |
| T-00-53 | [ ] | Ejecutar V-00-08: revisar en spec §11 el estado de las siete PN de prioridad D | Dario Andres Bernate Canas | T-00-23 | |
| T-00-54 | [ ] | Ejecutar V-00-09: revisar que `checklists/validacion.md` esté completa y firmada | Dario Andres Bernate Canas | T-00-25 | |
| T-00-36 | [ ] | Registrar en `checklists/validacion.md` el resultado conjunto de V-00-01 a V-00-09 como condición 3 de la compuerta (verificación humana) | Dario Andres Bernate Canas | T-00-28, T-00-29, T-00-30, T-00-49, T-00-50, T-00-51, T-00-52, T-00-53, T-00-54 | |
| T-00-34 | [ ] [P] | Registrar en `checklists/validacion.md` la condición 1 de la compuerta: CE-00-01 a CE-00-04 cumplidos y spec §11 firmada, sin `pytest` | Dario Andres Bernate Canas | T-00-36 | |
| T-00-35 | — | Confirmar cuadre exacto (condición 2) · No aplica | — | — | — |
| T-00-33 | [ ] [P] | Actualizar en `plan.md` §4 el estado de las filas IX, XII y XIII.4 a XIII.7 con la evidencia producida | Dario Andres Bernate Canas | T-00-36 | |
| T-00-37 | [ ] | Actualizar la documentación de la entrega (condición 4): glosario, documentos de la spec y fila S-00 de `docs/gestion/tareas.md` | Dario Andres Bernate Canas | T-00-33, T-00-34 | |
| T-00-38 | [ ] | Revisión de legibilidad por una persona junior distinta del autor, parte 1: PN01 a PN06 y la matriz (lectura en frío, condición 5) | Jose Julio Gomez Palmera | T-00-37 | |
| T-00-55 | [ ] | Revisión de legibilidad por una persona junior distinta del autor, parte 2: PN07 a PN12 y el glosario, y firma del checklist (lectura en frío, condición 5) | Jose Julio Gomez Palmera | T-00-38 | |
| T-00-31 | [ ] | Ejecutar V-00-10: revisar glosario, encabezados e IDs citados de los documentos de la spec y registrar su resultado en `checklists/validacion.md` | Dario Andres Bernate Canas | T-00-55 | |
| T-00-39 | [ ] | Integrar a `main` el Pull Request de la rama `00-preguntas-negocio` (condición 6) | Dario Andres Bernate Canas | T-00-31 | |
| T-00-01 | retirada | Firmar el ADR-0006 | — | — | — |
| T-00-02 | retirada | Firmar el ADR-0007 | — | — | — |
| T-00-03 | retirada | Actualizar el estado de ADR-0006 y ADR-0007 en el índice | — | — | — |
| T-00-04 | retirada | Firmar D-00-01 | — | — | — |
| T-00-06 | retirada | Agregar a `spec.md` los RNF y el CE de legibilidad | — | — | — |
| T-00-07 | retirada | Reemplazar marcadores `[SPEC]` e IDs con guion bajo en `plan.md` | — | — | — |
| T-00-08 | retirada | Agregar a plan §8 los componentes que faltaban | — | — | — |
| T-00-09 | retirada | Completar la columna «Tarea» de plan §11 | — | — | — |
| T-00-19 | retirada | Completar `medida_candidata`, `dimensiones_candidatas` y `grano_candidato` | — | — | — |
| T-00-21 | retirada | Reconciliar los traspasos del plan con spec §13 | — | — | — |
| T-00-26 | retirada | Escribir `tests/test_catalogo_preguntas.py` | — | — | — |
| T-00-27 | retirada | Agregar la prueba de PN en la matriz a `tests/test_catalogo_preguntas.py` | — | — | — |
| T-00-32 | retirada | Ejecutar la búsqueda de tecnología en los requisitos de `spec.md` | — | — | — |
<!-- tareas:00-preguntas-negocio:fin -->
