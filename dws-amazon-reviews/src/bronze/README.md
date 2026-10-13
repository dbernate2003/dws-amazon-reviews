# Capa Bronce — esquema `raw`

> Se rellena con `templates/layer-readme.md` al implementar `specs/01-ingesta-bronce/`.

**Especificación:** `specs/01-ingesta-bronce/` · **Responsable de la capa:** por asignar · **Estado:** pendiente

## Propósito

Histórico de 3 años de reseñas de Amazon, tal como llega de la fuente. Es el respaldo para reprocesar.

- **Fuente:** `all_3y.txt.gz`, recorte de `all.txt.gz` (34.686.770 reseñas, 1995–2013). Se descarga de Google Drive a `data/raw/`.
- **Rango esperado:** 2010-03-04 a 2013-03-04.
- **Reseñas esperadas:** 9.707.634.
- **Inmutable (Principio III):** una vez cargado y validado, ningún script ejecuta `UPDATE`, `DELETE` ni `TRUNCATE` sobre `raw`.

## Esquema PostgreSQL (DDL)

Pendiente: lo define el plan de la especificación 01.

## Scripts (orden de ejecución)

Pendiente. Esta carpeta debe terminar con un `NN_export_parquet.sql` (Principio II).

## Volumetría

Pendiente.

## Verificación humana

Pendiente. El test `tests/test_bronze.py` valida el conteo (9.707.634) y el rango de fechas.
