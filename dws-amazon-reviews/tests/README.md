# Pruebas

Único lugar donde vive Python en este repositorio (Principio V). Se usa pytest.

## Reglas

- Un script por regla del EDA, más un cuadre de filas entre capas (Principio VI).
- El cuadre es exacto: filas que entran = filas que salen + rechazadas + eliminadas. Sin tolerancia.
- La conexión a PostgreSQL sale de variables de entorno (`PGHOST`, `PGDATABASE`, `PGUSER`; la contraseña solo en el `.env` local). Nunca se escribe una credencial en un test.
- Los datos no se versionan (Principio VII).

## Qué se espera aquí

Los tests nacen de las tareas de cada especificación, no antes (Principio XII). Por ejemplo, `tests/test_bronze.py` valida los 9.707.634 registros de `raw` y el rango 2010-03-04 a 2013-03-04, y lo crea la especificación `01-ingesta-bronce`.
