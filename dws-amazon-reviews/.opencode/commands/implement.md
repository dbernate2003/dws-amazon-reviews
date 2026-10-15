---
description: Ejecuta las tareas pendientes de una especificación, en orden. No la cierra. Uso /implement 01-ingesta-bronce
agent: implementer
subtask: false
---

Implementa las tareas pendientes de la especificación `$1`.

Argumentos completos del usuario (el primero es la carpeta de la especificación; el resto indica qué tarea o fase atacar): $ARGUMENTS

Sigue tu flujo de trabajo: lee `memory/constitution.md` ANTES que cualquier otro documento (principio XIV), luego `specs/$1/spec.md`, `specs/$1/plan.md` y `specs/$1/task.md`. Verifica con `git branch` que estás en la rama `$1`. Si el usuario indicó una tarea o fase, haz solo eso; si no, toma la primera tarea pendiente con sus dependencias resueltas.

Si una tarea depende de un ADR «Pendiente», detente y dilo.

No cierres la especificación. Al terminar, entrega las consultas SQL de verificación para el responsable de la capa y el estado de la compuerta de cierre.
