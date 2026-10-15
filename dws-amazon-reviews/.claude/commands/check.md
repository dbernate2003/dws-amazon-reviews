---
description: Ayuda a verificar una especificación contra la Constitución y su compuerta de cierre. Solo lectura y no sustituye la verificación humana. Corre aislado en el agente Explore. Uso /check 01-ingesta-bronce
argument-hint: "[NN-nombre]"
context: fork
agent: Explore
---

Verifica una especificación sin modificar ningún archivo.

Argumentos del usuario (el primero es la carpeta de la especificación): $ARGUMENTS

Si no hay argumentos, pide el nombre de la spec y termina. En los pasos, `<NN-nombre>` es el primer argumento.

1. Lee `memory/constitution.md` completa antes que cualquier otro documento.
2. Lee lo que exista en `specs/<NN-nombre>/`: `spec.md`, `plan.md`, `task.md` y los ADR. Lee también `memory/adr/README.md`.
3. Nombre y orden: `<NN-nombre>` cumple `^[0-9]{2}-[a-z0-9]+(-[a-z0-9]+)*$` (Principio XIII), está en la lista del Principio XII, coincide con el nombre de su rama, y la especificación anterior pasó su compuerta de cierre. Revisa los ADR «Pendiente» o sin firma que la bloquean.
4. Encabezados: `spec.md` y `plan.md` declaran la versión de la Constitución con la que se escribieron.
5. Tareas: ¿salen del plan?, ¿cada `RF` y cada regla tiene tarea y test?, ¿hay un cuadre?, ¿cada tarea hecha tiene su evidencia en `task.md` y en `docs/gestion/tareas.md`?
6. Si ya hay código en `src/` o `tests/`, comprueba lo que la Constitución pide verificar: no hay `.py` fuera de `tests/`, ningún script modifica `raw`, no hay credenciales ni rutas absolutas, cada capa tiene `README.md` (DDL y flujo de scripts) y `NN_export_parquet.sql`, y desde cada fila de Oro se llega a su fila de Plata y de Bronce.
7. Informa el estado de las seis condiciones de la compuerta de cierre de la Constitución, punto por punto: (1) tests en verde, (2) cuadre exacto, (3) verificación humana con SQL, (4) README de la capa actualizado, (5) checklist de legibilidad firmado tras la lectura en frío, (6) Pull Request integrado a `main`. Para las variantes de (1) y (2) por spec usa la tabla de `specs/README.md`; si allí la compuerta tiene cinco puntos, gana la Constitución y lo avisas.

Entrega un informe corto: lo que cumple, lo que incumple (con el principio y el archivo) y lo que falta. No arregles nada. La verificación con SQL y la aprobación del Pull Request son del responsable y del segundo validador (Principio XI).
