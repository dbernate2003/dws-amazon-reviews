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
| `/speckit-analyze` | `/analyze` (por crear; solo lectura). Spec Kit lo corre después de `/tasks`; aquí va antes | Orden decidido por el proyecto |
| `/speckit-checklist` y `checklists/` | Sin comando propio: la «Revisión final» de `templates/spec-template.md` | La constitución no prevé una carpeta `checklists/` |
| `/speckit-converge` | Sin comando propio: compuerta de cierre de cinco puntos y verificación humana con SQL | Un agente no cierra una especificación (principio XI) |

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
| Trazabilidad de datos (Principio XV) | `03` y `04` | `03` conserva la llave de origen de Bronce; `04` conserva la de Plata en la tabla de hechos |
| Trazabilidad del trabajo (Principio XV) | todas | Cada RF enlaza con su verificación; cada regla con su conteo y su test; cada tarea con su evidencia |
| Rol de solo lectura para Tableau | `04` | Se crea con el esquema `gold`; `05` solo lo usa y lo verifica |
| Parquet por capa (Principio II) | `01`, `03`, `04` | Cada una exporta el Parquet de su capa; `06` comprueba que coincide tras reconstruir |

## Compuerta de cierre

Los puntos 3, 4 y 5 aplican a todas las specs. Los puntos 1 y 2 tienen una variante cerrada por tipo de spec, fijada en la constitución:

1. Tests en verde.
2. Cuadre exacto.
3. Verificación humana con SQL.
4. Documentación actualizada (README de la capa o de la entrega).
5. Pull Request integrado a `main`.

| Spec | Tests en verde (1) | Cuadre exacto (2) |
|---|---|---|
| `00` | Sustituido: cada pregunta tiene dueño, indicador y fuente, y el responsable la aprobó | No aplica: no mueve datos |
| `01`, `03`, `04` | Un test por regla y por objeto de la capa | Aplica |
| `02` | Sustituido: el conteo de cada regla R01… se reproduce con SQL sobre `raw` | No aplica: solo lectura, no mueve filas |
| `05` | Sustituido: cada dashboard responde su pregunta de `00` y se conecta con el rol de solo lectura | No aplica: no mueve datos |
| `06` | Tras reconstruir desde `all_3y.txt.gz`, los conteos de cada capa y de cada Parquet coinciden con los documentados | Aplica, repetido sobre la reconstrucción |

## Tareas por especificación

<!-- tareas-resumen:inicio -->
| Spec | Archivo | Tareas | Hechas | % hecho | % falta | Min estimados | Bloqueos |
|---|---|---|---|---|---|---|---|
| `00-preguntas-negocio` | [task.md](00-preguntas-negocio/task.md) | 38 | 0 | 0 % | 100 % | 1575 | ADR-0006 y ADR-0007 sin firma · plan en borrador sin reconciliar · 9 requisitos sin componente |
<!-- tareas-resumen:fin -->

### 00-preguntas-negocio

<!-- tareas:00-preguntas-negocio:inicio -->
| ID | Estado | Tarea | Responsable | Depende de | Evidencia |
|---|---|---|---|---|---|
| T-00-01 | [ ] [P] | Firmar el ADR-0006 (nombre del archivo de tareas: `task.md`) | Dario Andres Bernate Canas | ninguna | |
| T-00-02 | [ ] [P] | Firmar el ADR-0007 (ubicación de `memory/` e `instructions`) | Dario Andres Bernate Canas | ninguna | |
| T-00-03 | [ ] | Actualizar el estado de ADR-0006 y ADR-0007 en el índice de decisiones | Dario Andres Bernate Canas | T-00-01, T-00-02 | |
| T-00-04 | [ ] [P] | Firmar D-00-01 (compuerta de cierre adaptada a una spec sin datos) | Dario Andres Bernate Canas | ninguna | |
| T-00-05 | [ ] | Decidir D-00-02 a D-00-05, incluida D-00-03 (validador del catálogo: sí o no) | Dario Andres Bernate Canas | T-00-04 | |
| T-00-06 | [ ] [P] | Agregar a `spec.md` los cuatro RNF y el CE de legibilidad de plan §5.4 y la línea de principios transversales aplicables | Dario Andres Bernate Canas | ninguna | |
| T-00-07 | [ ] | Reemplazar en `plan.md` los marcadores `[SPEC]` y los IDs `RF-00-__`, `RNF-00-__` y `CE-00-__` por los IDs reales de la spec (decidir antes si el formato es `RF-01` como en la spec o `RF-00-01` como en la plantilla) | Dario Andres Bernate Canas | T-00-05, T-00-06 | |
| T-00-08 | [ ] | Agregar a plan §8 un componente por cada requisito que hoy no tiene: RF-03, RF-04, RF-05, RF-07, CE-01, CE-02, CE-03, CE-04 y plan §5.4 (3) | Dario Andres Bernate Canas | T-00-07 | |
| T-00-09 | [ ] | Completar la columna «Tarea» de plan §11 con los IDs `T-00-MM` de este archivo | Dario Andres Bernate Canas | T-00-08 | |
| T-00-10 | [ ] | Correr `/analyze specs/00-preguntas-negocio` en modo completo y guardar su informe | Dario Andres Bernate Canas | T-00-03, T-00-09 | |
| T-00-11 | [ ] [P] | Crear `research.md` con encabezado y las cinco decisiones de plan §6 | Dario Andres Bernate Canas | T-00-10 | |
| T-00-12 | [ ] [P] | Crear `docs/glosario.md` con encabezado y los 12 términos de plan §15.1 | Dario Andres Bernate Canas | T-00-10 | |
| T-00-13 | [ ] [P] | Analizar en `research.md`, para cada una de las 12 PN, qué campos de la fuente necesita y si la fuente puede responderla | Dario Andres Bernate Canas | T-00-11 | |
| T-00-14 | [ ] | Revisar que ninguna PN pretenda identificar a una persona y que PN09, PN10 y PN11 se respondan solo de forma agregada, y anotar el resultado en `research.md` | Dario Andres Bernate Canas | T-00-13 | |
| T-00-15 | [ ] [P] | Agregar al glosario las siglas y términos de `spec.md` y `plan.md` que faltan (por ejemplo EDA, ADR, SNAP, UTC y EARS) y fijar un solo nombre para usuario, cliente y reseñador | Dario Andres Bernate Canas | T-00-12 | |
| T-00-16 | [ ] | Crear `matriz-trazabilidad.md` con encabezado y 12 filas con `id_pregunta` y `enunciado_resumido` | Dario Andres Bernate Canas | T-00-13 | |
| T-00-17 | [ ] | Completar `campos_fuente`, `viabilidad` y `motivo_viabilidad` en las 12 filas de la matriz | Dario Andres Bernate Canas | T-00-16 | |
| T-00-18 | [ ] | Completar `usa_conteo_de_usuarios` y `usa_periodos_de_tiempo` en las 12 filas de la matriz | Dario Andres Bernate Canas | T-00-17 | |
| T-00-19 | [ ] | Completar `medida_candidata`, `dimensiones_candidatas` y `grano_candidato` a partir de spec §6.2 y §6.3 | Dario Andres Bernate Canas | T-00-18 | |
| T-00-20 | [ ] | Completar `especificaciones_destino` y `criterio_de_aceptacion` en las 12 filas de la matriz | Dario Andres Bernate Canas | T-00-19 | |
| T-00-21 | [ ] [P] | Reconciliar la tabla «Traspasos explícitos» del plan con «Qué heredan las siguientes especificaciones» de spec §13 | Dario Andres Bernate Canas | T-00-10 | |
| T-00-22 | [ ] [P] | Crear `quickstart.md` con los pasos para que otra persona repita la revisión | Dario Andres Bernate Canas | T-00-20 | |
| T-00-23 | [ ] [P] | Validar en spec §11 las siete PN de prioridad D (PN01, PN02, PN03, PN04, PN05, PN07 y PN11): aprobada por, fecha y estado «Validada» | Dario Andres Bernate Canas (responsable y segundo validador) | T-00-14, T-00-17 | |
| T-00-24 | [ ] | Comprobar RF-04 y CE-02 contra spec §7: cada PN asignada a un tablero y cada tablero con su mínimo de preguntas | Dario Andres Bernate Canas | T-00-23 | |
| T-00-25 | [ ] | Firmar como responsable de Oro el insumo del grano (spec §6.1) y la tabla de cálculos (spec §6.2) | Jose Julio Gomez Palmera | T-00-24 | |
| T-00-26 | [ ] | Escribir en `tests/test_catalogo_preguntas.py` las pruebas de campos obligatorios por PN y de IDs únicos | Dario Andres Bernate Canas | T-00-05, T-00-20 | |
| T-00-27 | [ ] | Agregar a `tests/test_catalogo_preguntas.py` la prueba de que cada PN de `spec.md` aparece en la matriz | Dario Andres Bernate Canas | T-00-26 | |
| T-00-28 | [ ] [P] | Ejecutar V-00-01: contar las PN de `spec.md` y de `matriz-trazabilidad.md` | Dario Andres Bernate Canas | T-00-20 | |
| T-00-29 | [ ] [P] | Ejecutar V-00-02: comprobar las columnas obligatorias de `matriz-trazabilidad.md` | Dario Andres Bernate Canas | T-00-20 | |
| T-00-30 | [ ] [P] | Ejecutar V-00-03: revisar las preguntas marcadas «no viable» en `matriz-trazabilidad.md` | Dario Andres Bernate Canas | T-00-20, T-00-23 | |
| T-00-31 | [ ] [P] | Ejecutar V-00-04: comprobar glosario y encabezados de los documentos de la spec | Dario Andres Bernate Canas | T-00-15, T-00-20, T-00-22 | |
| T-00-32 | [ ] [P] | Ejecutar V-00-05: buscar tecnología en los enunciados de requisitos de `spec.md` | Dario Andres Bernate Canas | T-00-25 | |
| T-00-33 | [ ] | Registrar en plan §4 el resultado de la compuerta «después de la Fase 1» y el nuevo estado de las filas X, XI, XII y XIII | Dario Andres Bernate Canas | T-00-21, T-00-31, T-00-32 | |
| T-00-34 | [ ] | Confirmar tests en verde y criterios CE-01 a CE-04 cumplidos | Dario Andres Bernate Canas | T-00-25, T-00-27, T-00-33 | |
| T-00-35 | — | Confirmar cuadre exacto (No aplica) | — | — | |
| T-00-36 | [ ] | Registrar el resultado conjunto de V-00-01 a V-00-05 como verificación humana de la compuerta | Dario Andres Bernate Canas | T-00-28, T-00-29, T-00-30, T-00-31, T-00-32, T-00-34 | |
| T-00-37 | [ ] | Actualizar la documentación: glosario, documentos de la spec y fila S-00 de `docs/gestion/tareas.md` | Dario Andres Bernate Canas | T-00-36 | |
| T-00-38 | [ ] | Realizar la revisión de legibilidad por una persona junior distinta del autor (checklist firmado) | Jose Julio Gomez Palmera | T-00-37 | |
| T-00-39 | [ ] | Integrar a `main` el Pull Request de la rama `00-preguntas-negocio` | Dario Andres Bernate Canas | T-00-38 | |
<!-- tareas:00-preguntas-negocio:fin -->
