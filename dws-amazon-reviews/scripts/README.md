# Scripts de apoyo

Utilidades del repositorio que no son parte del ETL numerado de `src/`. Hoy solo contiene este README: se agrega algo aquí cuando una especificación lo pida.

## Reglas

- Sin Python (Principio V). Python solo vive en `tests/`, salvo un ADR aprobado.
- Sin rutas absolutas, nombres de máquina ni credenciales (Principio IX y «Seguridad del dato»). La conexión sale de variables de entorno.
- Nada que modifique `raw` una vez cargado y validado (Principio III).
- Documenta cada script en este README: qué hace, quién lo corre y en qué momento.
