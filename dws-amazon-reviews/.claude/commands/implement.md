---
description: Ejecuta en orden de dependencias las tareas pendientes de task.md (SQL en src/, pruebas en tests/, README de la capa). Corre aislado en el agente implementer y no cierra la especificación. Uso /implement 01-ingesta-bronce [T-01-04 | fase 2]
argument-hint: "[NN-nombre] [T-NN-MM | fase N]"
context: fork
agent: implementer
---

Implementa las tareas pendientes de una especificación siguiendo la skill `skill-implement`.

Argumentos del usuario (el primero es la carpeta de la especificación; el resto indica qué tarea, fase o prioridad atacar): $ARGUMENTS

## Variables (sección 0 de la skill)

```text
SPECS=specs
SPEC=$SPECS/<primer argumento>
TASK_FILE=$SPEC/task.md
```

- Si el argumento viene como ruta (`specs/NN-nombre`), quédate solo con `NN-nombre`.
- Si no hay argumentos, haz la única pregunta de la sección 0 de la skill y termina.
- Muestra primero el bloque de variables y la tabla de rutas con `existe` / `no existe`, comprobado listando el directorio.

## Cómo seguir

1. La skill `skill-implement` viene precargada en tu agente. Si no la ves, lee `.claude/skills/skill-implement/SKILL.md` completo.
2. Síguela paso a paso.

## Comandos

- Cargar el entorno (Git Bash): `set -a; source .env; set +a`
- Ejecutar un script: `psql -f src/<capa>/NN_nombre.sql`
- Exportar a Parquet: `duckdb < src/<capa>/NN_export_parquet.sql`
- Tests: `pytest tests/`
- Lint/formato: no definido; no añadir herramienta sin ADR (ADR-0012)

## Estilo y convenciones

- SQL de PostgreSQL; DuckDB solo para Parquet; Python solo en `tests/`.
- Scripts numerados `NN_nombre.sql`; tablas y campos en `snake_case`, en español y sin tildes.
- Documentación, comentarios y mensajes en español. Encabezado con propósito, autor, fecha, dependencias e IDs en cada archivo (Const. XIII.4, XIII.5).

## Reglas

- Lee `memory/constitution.md` (v1.1.0) completa antes que cualquier otro documento; después `AGENTS.md`, `memory/adr/README.md`, `task.md`, `plan.md` y `spec.md`. Cita solo los principios I a XIII.
- Revisa los ADR cuyo «Resolver antes de» alcanza a la spec. Si alguno sigue «Pendiente» o «falta firma», dilo antes de empezar: las tareas que dependen de él quedan bloqueadas.
- Comprueba con `git branch --show-current` que estás en la rama de la spec. Si no, detente.
- Una tarea a la vez, solo si sus dependencias están en `[x]`. Si se indicó una tarea o fase, esa manda dentro de lo que permiten las dependencias.
- No puedes preguntar a mitad de la tarea. Ante una ambigüedad, un ADR pendiente o un choque con la spec, el plan o la Constitución: detente, anótalo en la bitácora y devuélvelo.
- No marques `[x]` sin haber visto cumplirse el «Hecho cuando». No ejecutes tareas humanas.

## Al terminar cualquier tarea

- Corre el comando del «Hecho cuando» y `pytest tests/` si ya hay pruebas. Reporta la salida real.
- Actualiza `task.md` (estado, evidencia, bitácora), el bloque de `specs/README.md` y la fila de `docs/gestion/tareas.md`.
- No cierres la especificación: entrega las consultas `V-NN-MM` al responsable de la capa y el estado de las seis condiciones de la compuerta de cierre de la Constitución.
