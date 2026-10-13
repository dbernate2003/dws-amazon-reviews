# Plan NN — <nombre>

> Cómo se construye lo que dice `spec.md` (Principio XII). Borra las instrucciones entre `>`.

**Especificación:** `specs/NN-nombre/spec.md` · **Estado:** <borrador | aprobado> · **Fecha:** <AAAA-MM-DD>

## Resumen técnico

> Enfoque en pocas frases.

## Constitution Check

> Obligatorio. Lista cada principio aplicable y cómo el diseño lo cumple. Si uno no aplica, dilo y di por qué. Una excepción exige un ADR con fecha de revisión.

| Principio | ¿Aplica? | Cómo lo cumple el diseño |
|---|---|---|
| I. Kimball para el modelo analítico | | |
| II. Medallion: un esquema por capa | | |
| III. Bronce no se modifica nunca | | |
| IV. Toda transformación nace de una regla del EDA | | |
| V. SQL puro; Python solo para pruebas | | |
| VI. Cada regla tiene un test y el cuadre es exacto | | |
| VII. Los datos nunca se versionan | | |
| VIII. Costo $0 en el estado actual | | |
| IX. Orquestación manual y reproducible | | |
| X. Gestión dentro del repositorio | | |
| XI. Verificación humana antes de cerrar | | |
| XII. Especificación primero y en orden | | |

## Decisiones y ADR

| ADR | Decisión | Estado |
|---|---|---|
| | | Propuesto / Aceptado / Pendiente |

## Diseño de datos

> Esquema, tablas, campos, tipos y restricciones. Es el DDL que irá al `README.md` de la capa.

## Scripts y orden de ejecución

| Orden | Script | Propósito | Prueba que lo valida |
|---|---|---|---|
| `01_` | | | |

## Cuadre de filas

> Qué entra, qué sale, qué se rechaza o elimina, y cómo se comprueba que da exacto.

## Pruebas

> Un test por regla del EDA y el cuadre, en `tests/`.

| Test | Qué valida | Regla |
|---|---|---|
| | | |

## Volumetría y rendimiento

> Filas y MB esperados. Si hay hechos: índices y consultas a medir con `EXPLAIN ANALYZE`.

## Documentación

> `README.md` de la capa con `templates/layer-readme.md`.

## Riesgos

-
