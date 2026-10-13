# Capa Oro — esquema `gold`

> Se rellena con `templates/layer-readme.md` al implementar `specs/04-modelo-oro/`.

**Especificación:** `specs/04-modelo-oro/` · **Responsable de la capa:** por asignar · **Estado:** pendiente

## Propósito

Modelo analítico dimensional, diseñado desde cero con Kimball (Principio I). No reutiliza dimensiones ni nombres de tablas del modelo anterior. Tableau se conecta con un rol de solo lectura que tiene permisos únicamente sobre `gold`.

## Esquema PostgreSQL (DDL)

Pendiente: lo define el plan de la especificación 04.

## Modelo dimensional

Principio I: cada tabla de hechos declara estos cuatro puntos.

- **Grano** (una frase): pendiente
- **Claves subrogadas:** pendiente
- **Fila especial para datos faltantes:** pendiente
- **Clasificación de medidas** (aditiva, semiaditiva, no aditiva): pendiente

## Scripts (orden de ejecución)

Pendiente. Esta carpeta debe terminar con un `NN_export_parquet.sql` (Principio II). Los índices van en `03_indexes.sql`, creados después de cargar el hecho.

## Índices y rendimiento

Un índice B-tree en cada llave foránea de la tabla de hechos. Un índice compuesto solo si una consulta frecuente filtra por dos claves a la vez. Tiempos de `EXPLAIN ANALYZE`:

| Consulta | Antes (ms) | Después (ms) |
|---|---|---|
| | | |

El umbral aceptable está pendiente del ADR-0010.

## Auditoría y linaje

Fecha de carga en Oro. De cada fila de Oro se llega a su fila de Plata y de Bronce. Pendiente.

## Cuadre de filas

Pendiente.

## Volumetría

Pendiente.

## Verificación humana

Pendiente.
