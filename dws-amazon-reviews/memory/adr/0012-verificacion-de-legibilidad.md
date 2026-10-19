# ADR-0012 — Herramienta y umbrales de la verificación de legibilidad

- **Estado:** Aceptado · firmado por el responsable el 2026-10-19
- **Fecha:** 2026-10-19
- **Resolver antes de:** `01-ingesta-bronce`
- **Responsable (firma):** Dario Andres Bernate Canas — 2026-10-19
- **Fecha de revisión:** — (no aplica: se firmó la opción A, sin herramienta nueva)

## Contexto

La constitución (principio XIII.7) exige que, antes de cerrar cada especificación, una persona distinta del autor lea en frío una muestra de los artefactos y responda sin ayuda las cinco preguntas estándar, y fija que «los umbrales de tiempo y de aciertos se calibran en el ADR-0012». La tabla «Decisiones pendientes» amplía el alcance: decidir también si la verificación de legibilidad usa un linter de SQL o de Python, sabiendo que toda herramienta de Python fuera de `tests/` choca con el Principio V («SQL puro; Python solo para pruebas») y que el proyecto corre con costo $0 (Principio VIII). El anexo de D-00-01 fijó, solo para la `00`, el umbral de aciertos en 5 de 5 y dejó el tiempo (U-00-09) pendiente de este ADR.

Con este ADR firmado, la `01-ingesta-bronce` queda desbloqueada en cuanto cierre la `00`.

## Opciones consideradas

| Opción | A favor | En contra |
|---|---|---|
| A. Sin herramienta nueva: revisión manual con `checklists/validacion.md`, `/analyze` y la lectura en frío | No choca con el Principio V; $0; nada que instalar ni mantener; suficiente para 2 personas y 7 especificaciones | El estilo del SQL (XIII.1) depende del ojo humano; ningún bloqueo automático |
| B. Linter de SQL (p. ej. sqlfluff) corrido a mano, fuera del repositorio y sin versionar su configuración | Detecta el estilo de XIII.1 automáticamente cuando se corre | Es Python fuera de `tests/` (excepción al Principio V); hay que fijar versión y reglas; solo lo corre quien lo instale |
| C. Linters de SQL y de Python integrados al flujo del repositorio | Cobertura máxima, comprobable en cada commit | Excepción al Principio V de mayor alcance; dependencia de herramientas y de instalación; sobra para este proyecto |

## Decisión

**Opción A**, firmada por el responsable el 2026-10-19, con estos umbrales:

1. **Aciertos:** 5 de 5 preguntas estándar respondidas correctamente por bloque de lectura (extiende U-00-08 a todas las especificaciones).
2. **Tiempo:** cada bloque de lectura en frío se agenda en máximo 45 minutos (como T-00-38 y T-00-55 de la `00`); si un bloque no se supera, se corrige el artefacto y se repite la lectura (XIII.7).
3. **Aplicación:** desde `01-ingesta-bronce`. Para la `00` rige el anexo de D-00-01; con estos umbrales, U-00-09 queda definido también para la `00`.

## Consecuencias

- Las specs y sus planes citan los umbrales en su tarea de lectura en frío; `templates/plan.md` y la tabla XIII-C no cambian.
- Si en el futuro se elige B o C: es una excepción al Principio V; hay que ajustar los permisos de `.opencode/agents/implementer.md` y de `opencode.json`, y anotar una fecha de revisión.
- La `00` deja de tener el umbral U-00-09 «por definir»: `checklists/legibilidad.md` usa 5 de 5 por bloque y 45 minutos.
- Quién lee: en la `00`, un agente en contexto limpio con firma del responsable (anexo 2 de D-00-01), porque Jose Julio Gomez Palmera no firma ni verifica las especificaciones `00` a `03`. Para `01` a `03` se decide en su `/clarify`.
- Se actualiza el índice `memory/adr/README.md`. La constitución no se enmienda: su tabla de pendientes se limpia cuando haya una enmienda.
