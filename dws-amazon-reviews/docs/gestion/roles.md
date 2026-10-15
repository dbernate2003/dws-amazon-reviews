# Roles

Responsable por capa y entregable (Principio X). El equipo es de 2 personas, cada una con su copia local. Dario (`dbernate2003`) es el segundo validador de todos los Pull Request. Hasta la spec `03` también es el responsable; para `04`, `05` y `06` el responsable es Jose Julio (`JoseJulioGP`). Los usuarios de GitHub están en `.github/CODEOWNERS`.

## Responsables por capa

| Capa / carpeta | Entregable | Responsable | Respaldo |
|---|---|---|---|
| Bronce · `src/bronze/` | Carga de `raw`, README de capa, export a Parquet | Dario Andres Bernate Canas | Dario Andres Bernate Canas |
| Exploración · `src/exploration/` | SQL del EDA y catálogo de reglas | Dario Andres Bernate Canas | Dario Andres Bernate Canas |
| Plata · `src/silver/` | ETL, bitácora de calidad, README de capa, export a Parquet | Dario Andres Bernate Canas | Dario Andres Bernate Canas |
| Oro · `src/gold/` | Modelo Kimball, índices, README de capa, export a Parquet | Jose Julio Gomez Palmera | Dario Andres Bernate Canas |
| BI · Tableau | Dashboards (`.twb`) sobre Oro | Jose Julio Gomez Palmera | Dario Andres Bernate Canas |
| Pruebas · `tests/` | Un test por regla y cuadres | El responsable de la capa que prueba | Dario Andres Bernate Canas |
| Gestión · `docs/` | Roles y tareas | Dario Andres Bernate Canas | Dario Andres Bernate Canas |
| Constitución · `memory/` | Enmiendas por Pull Request | Dario Andres Bernate Canas | Dario Andres Bernate Canas |

## Qué hace el responsable de la capa

- Verifica con sus propias consultas (conteos, cuadres y muestras) antes de cerrar una especificación (Principio XI). Los agentes no la dan por cerrada.
- Firma los ADR que tocan su capa.
- Aprueba el Pull Request de su especificación.
