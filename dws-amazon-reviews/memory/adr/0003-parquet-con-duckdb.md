# ADR-0003 — Parquet exportado con DuckDB

- **Estado:** Aceptado (decisión citada por la constitución v1.0.0; falta la firma del responsable)
- **Fecha:** 2026-10-12
- **Resolver antes de:** —
- **Responsable (firma):** pendiente

## Contexto

El Principio II exige que cada capa (`raw`, `silver`, `gold`) se exporte a `.parquet`. El Principio V limita Python a `tests/` y deja a DuckDB (SQL) solo para exportar.

## Decisión

Cada capa se exporta con DuckDB desde `src/<capa>/NN_export_parquet.sql` hacia `data/parquet/{bronze,silver,gold}/`. DuckDB solo exporta; no transforma. Ningún SQL versionado contiene credenciales, tampoco el `ATTACH` a PostgreSQL.

## Consecuencias

- Cada capa lleva su script `NN_export_parquet.sql`.
- Los `.parquet` viven en `data/` y nunca se versionan (Principio VII).
