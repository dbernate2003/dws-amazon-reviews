# Exploración (EDA) y catálogo de reglas

> Se rellena al implementar `specs/02-exploracion-eda/`.

**Especificación:** `specs/02-exploracion-eda/` · **Responsable:** por asignar · **Estado:** pendiente

Solo SQL sobre `raw`. El archivo completo (`all.txt.gz`) no se carga en PostgreSQL; sus cifras son referencia de la fuente.

Cada hallazgo se vuelve una regla (Principio IV). Esta tabla es el catálogo: de ella salen las transformaciones de Plata, las filas de la bitácora de calidad y los tests.

- `descarta` cubre las filas rechazadas y las eliminadas.
- `corrige` y `marca` no cambian el número de filas.
- Las reseñas anónimas llevan una regla explícita, con su acción y su conteo.

## Reglas

| Código | Hallazgo | Acción | Filas afectadas | Fila en la bitácora | Test |
|---|---|---|---|---|---|
| R01 | | descarta / corrige / marca | | | `tests/…` |

## Scripts

Pendiente. SQL numerado (`01_`, `02_`…), ejecutable en orden.
