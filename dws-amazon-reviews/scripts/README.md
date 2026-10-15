# Scripts de apoyo

Utilidades del repositorio que no son parte del ETL numerado de `src/`.

| Script | Qué hace | Quién lo corre |
|---|---|---|
| `new-spec.sh` | Crea la rama y la carpeta `specs/NN-nombre/` con `spec.md`, `plan.md` y `adr/` | Quien abre una especificación nueva |

## `new-spec.sh`

```bash
bash scripts/new-spec.sh 01-ingesta-bronce
```

- Rechaza cualquier nombre que no cumpla `^[0-9]{2}-[a-z0-9]+(-[a-z0-9]+)*$` (principio XIII).
- Rechaza los nombres que no estén en la lista del principio XII. Agregar o renombrar una especificación exige enmendar la constitución.
- Crea la rama con el mismo nombre que la especificación y copia las plantillas con la versión vigente de la constitución en el encabezado (principio XIV).
- No crea el archivo de tareas: su nombre lo fija el ADR-0006 y lo crea `/tasks`.
- Se corre con `bash`, por ejemplo desde Git Bash. `.gitattributes` fuerza los finales de línea LF en los `.sh`; sin eso, Git en Windows los convertiría a CRLF y el script fallaría.

## Reglas para cualquier script de esta carpeta

- Sin Python (principio V). Python solo vive en `tests/`, salvo un ADR aprobado.
- Sin rutas absolutas, nombres de máquina ni credenciales (principio IX y «Seguridad del dato»). La conexión sale de variables de entorno.
- Nada que modifique `raw` una vez cargado y validado (principio III).
- Todo script nuevo se documenta en este README: qué hace, quién lo corre y en qué momento.
