# Guía rápida — repetir la revisión de 00-preguntas-negocio

**Propósito:** permitir que otra persona repita, paso a paso, la revisión y el cierre de la especificación 00 y obtenga la misma matriz de 12 filas con las mismas marcas (viabilidad, tablero, respuesta agregada, corte por mes y conteo de usuarios) | **Autor:** agente principal (OpenCode), por encargo de Dario Andres Bernate Canas | **Fecha:** 2026-10-19 | **Constitución:** v1.1.0
**Dependencias:** `specs/00-preguntas-negocio/spec.md`, `plan.md`, `task.md`, `research.md`, `matriz-trazabilidad.md` y `checklists/`; `docs/glosario.md`.
**IDs que atiende:** RNF-00-04 · Componente C-00-08 · Tarea T-00-22 (Const. IX, XIII.4, XIII.5).

> Los pasos se ejecutan en orden y cada uno deja su salida en el repositorio. Las rutas son relativas a la raíz del repositorio; ninguna depende de una máquina ni de una cuenta.

## Pasos

| Orden | Paso | Qué hace (una frase) | Entradas | Salidas | Requisito | Repetible |
|---|---|---|---|---|---|---|
| 01 | Aplicar los cambios de plan §5.4 en la especificación | Ajusta la spec antes que cualquier otro documento (cambios 5, 11 y 12 ya aplicados y confirmados por el responsable el 2026-10-19) | `spec.md`, `plan.md` | `spec.md` ajustada; después se regeneran plan y tareas | RF-00-06, RF-00-10 | Sí |
| 02 | Reunir las firmas previas | Confirma ADR-0006, ADR-0007 y D-00-01 firmados, y D-00-02, D-00-04, D-00-05 y D-00-06 decididas | `plan.md` §5.2 y §5.1 | `plan.md` §5.2 con el estado de cada decisión | Const. X | Sí |
| 03 | Regenerar plan y tareas y correr `/analyze` | Ejecuta `/plan` y `/tasks` sobre la spec vigente y la segunda pasada de `/analyze` en modo completo; si hay un hallazgo crítico o alto, se corrige y se repite | `spec.md`, `plan.md`, `task.md` | `plan.md`, `task.md` y `checklists/analisis.md` | Todos | Sí |
| 04 | Producir los documentos | Redacta `research.md`, `docs/glosario.md`, `quickstart.md`, `matriz-trazabilidad.md` y `checklists/validacion.md` siguiendo `task.md` | `task.md`, `spec.md`, `plan.md` | Documentos de la spec y glosario | RF-00-01 a RF-00-11, RNF-00-02 a RNF-00-04 | Sí |
| 05 | Validar las preguntas de negocio | El responsable y el segundo validador aprueban cada PN con el análisis de la spec §3 y dejan nombre, fecha y estado en la spec §11 | `spec.md` §3, §5 y §11; `matriz-trazabilidad.md` | Spec §11 con nombre, fecha y estado | RF-00-07, CE-00-03 | Sí |
| 06 | Firmar el insumo de Oro | El responsable de Oro revisa y firma la spec §6.1 y §6.2 | `spec.md` §6 | `checklists/validacion.md` firmado | CE-00-04 | Sí |
| 07 | Ejecutar la verificación humana | Corre `V-00-01` a `V-00-09` sobre los documentos y anota el resultado de cada una | Documentos de la spec | Resultados en la evidencia de las tareas | Compuerta, condición 3 | Sí |
| 08 | Hacer la lectura en frío | La persona del equipo que no escribió los artefactos lee una muestra y responde las cinco preguntas estándar sin consultar al autor | Muestra de la spec §9 | `checklists/legibilidad.md` firmado | RNF-00-01, CE-00-05 | Sí |
| 09 | Cerrar la especificación | Ejecuta `V-00-10` sobre los documentos ya leídos, recorre las seis condiciones de la compuerta (§14 del plan) e integra el Pull Request | Todo lo anterior | Pull Request a `main` con las condiciones marcadas | Compuerta de cierre | Sí |

## Qué se obtiene al final

- `research.md` con 12 de 12 PN con campos, viabilidad e identificación de personas.
- `matriz-trazabilidad.md` con 12 filas y ninguna columna obligatoria vacía.
- `checklists/validacion.md` con la revisión por pregunta, el conteo por tablero, la revisión de §6.1 y §6.2 y las firmas.
- `checklists/legibilidad.md` firmado y la spec §11 con las siete PN de prioridad D en «Validada».
- Pull Request de la rama `00-preguntas-negocio` integrado a `main`.
