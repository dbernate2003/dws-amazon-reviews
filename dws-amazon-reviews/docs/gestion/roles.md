# Roles

Responsable por capa y entregable (Principio X). El equipo es de 2 personas, cada una con su copia local. Los nombres están por asignar: complétalos aquí y en `.github/CODEOWNERS`.

## Responsables por capa

| Capa / carpeta | Entregable | Responsable | Respaldo |
|---|---|---|---|
| Bronce · `src/bronze/` | Carga de `raw`, README de capa, export a Parquet | por asignar | por asignar |
| Exploración · `src/exploration/` | SQL del EDA y catálogo de reglas | por asignar | por asignar |
| Plata · `src/silver/` | ETL, bitácora de calidad, README de capa, export a Parquet | por asignar | por asignar |
| Oro · `src/gold/` | Modelo Kimball, índices, README de capa, export a Parquet | por asignar | por asignar |
| BI · Tableau | Dashboards (`.twb`) sobre Oro | por asignar | por asignar |
| Pruebas · `tests/` | Un test por regla y cuadres | por asignar | por asignar |
| Gestión · `docs/` | Roles y tareas | por asignar | por asignar |
| Constitución · `memory/` | Enmiendas por Pull Request | por asignar | por asignar |

## Qué hace el responsable de la capa

- Verifica con sus propias consultas (conteos, cuadres y muestras) antes de cerrar una especificación (Principio XI). Los agentes no la dan por cerrada.
- Firma los ADR que tocan su capa.
- Aprueba el Pull Request de su especificación.
