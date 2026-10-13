# Especificaciones

Una carpeta por especificación. El orden es obligatorio (Principio XII): una no empieza hasta que la anterior pasa sus tests.

| Orden | Carpeta | Rama | Capa | Resolver antes |
|---|---|---|---|---|
| 1 | `01-ingesta-bronce/` | `01-ingesta-bronce` | Bronce (`raw`) | ADR-0006, 0007, 0008 |
| 2 | `02-exploracion-eda/` | `02-exploracion-eda` | Exploración sobre `raw` | — |
| 3 | `03-etl-plata/` | `03-etl-plata` | Plata (`silver`) | ADR-0009 |
| 4 | `04-modelo-oro/` | `04-modelo-oro` | Oro (`gold`) | ADR-0010 |
| 5 | `05-dashboards-bi/` | `05-dashboards-bi` | Tableau sobre Oro | ADR-0011 |

## Qué contiene cada carpeta

| Archivo | Quién lo crea | Contenido |
|---|---|---|
| `spec.md` | `/specify` · `spec-writer` | Qué y por qué, sin tecnología |
| `plan.md` | `/plan` · `architect` | Cómo, con su Constitution Check |
| archivo de tareas | `/tasks` · `task-breaker` | Tareas que salen del plan. Su nombre (`task.md` o `tasks.md`) lo fija el ADR-0006 |
| `adr/` | `architect` | Decisiones de esa sola entrega |

Si algo cambia, se actualiza primero la spec y luego se regeneran plan y tareas.

## Compuerta de cierre

1. Tests en verde.
2. Cuadre exacto.
3. Verificación humana con SQL.
4. README de la capa actualizado.
5. Pull Request integrado a `main`.
