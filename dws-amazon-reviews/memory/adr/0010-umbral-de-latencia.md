# ADR-0010 — Umbral de latencia de las consultas principales

- **Estado:** Pendiente
- **Fecha:** 2026-10-12
- **Resolver antes de:** `04-modelo-oro`
- **Responsable (firma):** pendiente

## Contexto

Las consultas principales de Oro se miden con `EXPLAIN ANALYZE` antes y después de crear los índices (`src/gold/03_indexes.sql`), y los tiempos quedan en el README de `gold`. Falta fijar el umbral que se considera aceptable.

## Opciones consideradas

| Opción | A favor | En contra |
|---|---|---|
| | | |

## Decisión

Pendiente.

## Consecuencias

Al decidir: reflejarlo en el plan de `04-modelo-oro` y en la tabla de tiempos del `README.md` de `src/gold/`.
