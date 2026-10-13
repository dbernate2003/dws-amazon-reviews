# Capa <Bronce | Plata | Oro> — esquema `<raw | silver | gold>`

> Plantilla del README de cada capa (`src/bronze/`, `src/silver/`, `src/gold/`). Copia este archivo como `README.md` de la capa y rellénalo. Borra las instrucciones entre `>`.

**Especificación:** `specs/NN-nombre/` · **Responsable de la capa:** <nombre> · **Estado:** <pendiente | en curso | verificada>

## Propósito

> Una o dos frases: qué contiene la capa y de dónde viene.

## Esquema PostgreSQL (DDL)

> Un bloque por tabla: campos, tipos y restricciones (PK, FK, NOT NULL, UNIQUE, CHECK). Nombres en `snake_case`.

| Tabla | Campo | Tipo | Restricciones | Descripción |
|---|---|---|---|---|
| | | | | |

## Scripts (orden de ejecución)

| Orden | Script | Qué hace |
|---|---|---|
| `01_` | | |
| `NN_` | `NN_export_parquet.sql` | Exporta la capa a `data/parquet/<capa>/` con DuckDB |

## Reglas aplicadas

> Solo Plata y Oro. Cada transformación cita su regla del EDA. `descarta` cubre las filas rechazadas y las eliminadas; `corrige` y `marca` no cambian el número de filas.

| Regla | Descripción | Acción | Filas afectadas | Test |
|---|---|---|---|---|
| R01 | | descarta / corrige / marca | | `tests/…` |

## Volumetría

| Tabla | Filas | MB |
|---|---|---|
| | | |

## Cuadre de filas

> Filas que entran = filas que salen + rechazadas + eliminadas. Exacto, sin tolerancia.

| Concepto | Filas |
|---|---|
| Entran | |
| Salen | |
| Rechazadas | |
| Eliminadas | |
| Diferencia | 0 |

## Linaje

> Cómo llegar de una fila de esta capa a su fila en la capa anterior (y hasta Bronce).

## Modelo dimensional (solo Oro)

> Principio I. Una sección por tabla de hechos.

- **Grano** (una frase):
- **Claves subrogadas:**
- **Fila especial para datos faltantes:**
- **Clasificación de medidas:**

| Medida | Aditiva / semiaditiva / no aditiva | Nota |
|---|---|---|
| | | |

- **Índices** (`src/gold/03_indexes.sql`) y tiempos de `EXPLAIN ANALYZE` antes y después:

| Consulta | Antes (ms) | Después (ms) |
|---|---|---|
| | | |

## Verificación humana

> Principio XI. Consultas que corrió el responsable de la capa (conteos, cuadres y muestras) y su resultado.

| Fecha | Responsable | Consulta | Resultado |
|---|---|---|---|
| | | | |
