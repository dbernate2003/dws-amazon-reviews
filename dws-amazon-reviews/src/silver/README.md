# Capa Plata — esquema `silver`

> Se rellena con `templates/layer-readme.md` al implementar `specs/03-etl-plata/`.

**Especificación:** `specs/03-etl-plata/` · **Responsable de la capa:** por asignar · **Estado:** pendiente

## Propósito

Datos limpios a partir de `raw`. Toda transformación nace de una regla del EDA (`src/exploration/README.md`) con código, acción (descarta, corrige o marca) y conteo en la bitácora de calidad. Sin regla no hay transformación.

## Esquema PostgreSQL (DDL)

Pendiente: lo define el plan de la especificación 03.

## Scripts (orden de ejecución)

Pendiente. Esta carpeta debe terminar con un `NN_export_parquet.sql` (Principio II).

## Reglas aplicadas

| Regla | Descripción | Acción | Filas afectadas | Test |
|---|---|---|---|---|
| | | | | |

## Bitácora de calidad

Una fila por regla: regla, descripción, filas, acción y fecha de registro. Dónde vive está pendiente del ADR-0009.

## Cuadre de filas

Filas que entran = filas que salen + rechazadas + eliminadas. Pendiente.

## Volumetría

Pendiente.

## Verificación humana

Pendiente.
