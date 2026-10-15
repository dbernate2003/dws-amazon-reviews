---
description: Ayuda a verificar una especificación contra la constitución y su compuerta de cierre. Solo lectura. No sustituye la verificación humana. Uso /check 01-ingesta-bronce
agent: plan
subtask: false
---

Verifica la especificación `$1` sin modificar ningún archivo.

Argumentos completos del usuario: $ARGUMENTS

1. Lee `memory/constitution.md` ANTES que cualquier otro documento (principio XIV).
2. Lee lo que exista en `specs/$1/`: `spec.md`, `plan.md`, `task.md` y los ADR.
3. Nombre y orden: `$1` cumple `^[0-9]{2}-[a-z0-9]+(-[a-z0-9]+)*$` (principio XIII), está en la lista del principio XII, coincide con el nombre de su rama, y la especificación anterior pasó su compuerta de cierre. Revisa los ADR «Pendiente» o sin firma en `memory/adr/` que la bloquean.
4. Encabezados: `spec.md` y `plan.md` declaran la versión de la constitución con la que se escribieron (principio XIV).
5. Tareas: ¿salen del plan?, ¿cada `RF` y cada regla tiene tarea y test?, ¿hay un cuadre?, ¿cada tarea hecha tiene su evidencia en `task.md` y en `docs/gestion/tareas.md`?
6. Si ya hay código en `src/` o `tests/`, comprueba lo que la constitución pide verificar: no hay `.py` fuera de `tests/`, ningún script modifica `raw`, no hay credenciales ni rutas absolutas, cada capa tiene `README.md` (DDL y flujo de scripts) y `NN_export_parquet.sql`, y la consulta de linaje da 0 filas sin origen (principio XV).
7. Informa el estado de la compuerta de cierre, punto por punto: (1) tests en verde, (2) cuadre exacto, (3) verificación humana con SQL, (4) README actualizado, (5) Pull Request a `main`. Donde las condiciones (1) y (2) tienen una variante (`00`, `02`, `05` y `06`), usa la tabla de `specs/README.md`.

Entrega un informe corto: lo que cumple, lo que incumple (con el principio y el archivo) y lo que falta. No arregles nada. La verificación con SQL y la aprobación del Pull Request son del responsable y del segundo validador (principio XI).
