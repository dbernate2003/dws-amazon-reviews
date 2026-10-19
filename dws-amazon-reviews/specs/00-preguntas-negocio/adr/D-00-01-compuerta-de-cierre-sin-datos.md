# D-00-01 — Compuerta de cierre de una especificación sin datos

- **Estado:** Aceptado · firmado por el responsable el 2026-10-19
- **Fecha:** 2026-10-19
- **Resolver antes de:** `/tasks` de `00-preguntas-negocio`
- **Responsable (firma):** Dario Andres Bernate Canas — 2026-10-19
- **Fecha de revisión:** al hacer el `/plan` de `02-exploracion-eda` o de `05-dashboards-bi`, lo que ocurra primero: se decide si se repite la excepción o se enmienda la constitución (decisión del responsable, 2026-10-19)

## Contexto

La constitución (sección «Flujo de desarrollo y compuertas») exige seis condiciones para cerrar una especificación: tests en verde, cuadre exacto, verificación humana con SQL, README actualizado, checklist de legibilidad firmado y Pull Request integrado. `00-preguntas-negocio` no tiene código, tablas ni filas, así que las condiciones 1, 2 y 3 no se pueden cumplir al pie de la letra. `specs/README.md` dice que la variante de cierre está «fijada en la constitución», pero la constitución v1.1.0 no la contiene (hallazgo 6 de `/analyze` del 2026-10-19). Toca los principios VI (cuadre), XI (verificación humana) y XII (orden).

## Opciones consideradas

| Opción | A favor | En contra |
|---|---|---|
| A. Variante propia de la spec 00, registrada como decisión de la entrega | No exige enmendar la constitución; queda trazada | Solo vale para la 00 |
| B. Enmendar la constitución con variantes de compuerta por tipo de spec | Una regla para todas las specs | Enmienda MINOR por Pull Request; retrasa la 00 |
| C. Exigir SQL sin tablas o saltarse la compuerta | — | Imposible o incumple el principio XI |

## Decisión

**A.** La compuerta de la spec 00 queda así (spec §13):

1. **Tests en verde:** se sustituye por CE-00-01 a CE-00-04 cumplidos y la sección 11 de la spec firmada; sin `pytest`, porque D-00-03 se rechazó (spec DQ-31).
2. **Cuadre exacto:** no aplica; la 00 no mueve datos.
3. **Verificación humana:** se cumple con las verificaciones `V-00-01` a `V-00-10` del plan sobre los documentos, ejecutadas por el responsable.
4. **Documentación:** glosario y documentos de la spec al día.
5. y 6. Sin cambio: checklist de legibilidad firmado (CE-00-05) y Pull Request integrado a `main`.

## Consecuencias

- **Anexo (2026-10-19, firmado por el responsable):** el umbral U-00-08 de la lectura en frío es «5 de 5 preguntas estándar respondidas sin consultar al autor», como criterio provisional solo para la 00. El tiempo máximo (U-00-09) sigue pendiente del ADR-0012. Desde la 01 rige lo que decida el ADR-0012.
- `specs/README.md` debe citar esta decisión como origen de la variante de la 00, no la constitución.
- El plan de la 00 (§4 y §5.2) cita este archivo y deja D-00-01 como firmada.
- Si otras specs sin datos (`02`, `05`) necesitan una variante, se evalúa la opción B.
