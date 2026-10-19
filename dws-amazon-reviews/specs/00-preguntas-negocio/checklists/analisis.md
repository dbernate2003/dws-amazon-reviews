# Análisis de coherencia — 00-preguntas-negocio

**Propósito:** auditoría de solo lectura de la coherencia entre Constitución, spec, plan y tareas (T-00-10, segunda pasada de D-00-02: `/analyze` corre antes y después de `/tasks`) | **Autor:** skill analyze (agente architect) | **Fecha:** 2026-10-19 (pasadas 1 a 4)
**Documentos analizados:** `memory/constitution.md` v1.1.0 · `spec.md`, `plan.md` y `task.md` (los tres del 2026-10-19) · `adr/D-00-01` · `memory/adr/` (README, 0003, 0006 a 0011, 0012 y 0013) · `checklists/legibilidad.md` · `specs/README.md` · `AGENTS.md` · `README.md` · `docs/gestion/roles.md` y `tareas.md`
**IDs que atiende:** RNF-00-01, RNF-00-04 · Componente C-00-08 · Tareas T-00-10 y T-00-56 (Const. XIII.4, XIII.5)
**Modo:** completo (existe `task.md`)

## Veredicto

**NO LISTO** para producir los documentos (Fase 1): 0 Críticos, 1 Alto, 3 Medios, 4 Bajos.

## Hallazgos

| # | Sev. | Chequeo | Hallazgo y evidencia | Corregir en |
|---|---|---|---|---|
| 1 | Alto | Contradicción | RF-00-10 (regenerar plan y tareas cuando la spec se actualice), C-00-17/C-00-28 («Basada en» igual a la spec) y V-00-07 (comparar «Basada en» con «Última actualización») chocan con plan §7.2 paso 05, T-00-23 (validar las 7 PN D) y C-00-22/T-00-25 (cambios pedidos por Oro), que escriben en spec §11 después de generar plan y tareas. T-00-52 (ejecuta V-00-07) fallará por diseño y bloqueará la condición 3 de la compuerta | spec (RF-00-10) o tareas → P1 |
| 2 | Medio | Contradicción | Plan §4 (fila XII), §5.4 (cambios 5 y 11), §7.2 (paso 01) y §13 dicen «falta la confirmación del responsable (T-00-41, T-00-44)»; `task.md` las marca [x] confirmadas el 2026-10-19. Igual en `docs/gestion/tareas.md`, fila S-00 | plan, `tareas.md` |
| 3 | Medio | XIII-C (b) | Plan §9 filas XIII.4 y XIII.5 incluyen `checklists/legibilidad.md`, `plan.md` y `task.md`, pero T-00-31 (V-00-10) revisa solo 5 documentos y T-00-37 corre antes de que exista `legibilidad.md`. Ninguna tarea comprueba que los IDs citados en plan y tareas existan. `checklists/analisis.md` no figura en plan §3 ni §7.1 | tareas, plan §7.1 |
| 4 | Medio | Contradicción | «Compuerta de cierre» de `specs/README.md` lista 5 condiciones (omite el checklist de legibilidad) y su fila `00` no coincide con D-00-01. Spec §13 remite a ese README | `specs/README.md`, spec §13 → P3 |
| 5 | Bajo | Contradicción | `task.md` §1 dice «40 activas» y §6 «40 de 40»; §5 y `specs/README.md` cuentan 41. Chequeo 4 y «Lista de revisión» citan solo T-00-38. Última fila de §8 dice que T-00-41 a T-00-44 «siguen [ ]» | tareas |
| 6 | Bajo | Trazabilidad | Plan §2.3 dice «T-00-01 … T-00-54»; §11 cita solo T-00-38 en RNF-00-01 y CE-00-05 (falta T-00-55); §15.1 omite el prefijo S (supuestos) | plan |
| 7 | Bajo | XIII-C (tareas) | Unas 20 de 41 tareas no citan `Const. XIII.n` (p. ej. T-00-17, 18, 20, 23, 24, 25, 45 y las de verificación) | tareas → P2 |
| 8 | Bajo | Contradicción | La tabla «Decisiones pendientes» de la Constitución aún lista 0006 y 0007, ya firmados. «Equivalencias» de `specs/README.md` dice que `/analyze` va «antes» y habla de «compuerta de cinco puntos» | constitución, `specs/README.md` |

## Cobertura y cifras

- **Requisitos:** 20 (11 RF, 4 RNF, 5 CE); 20 con componente, tarea y verificación. 17 se verifican por completo en la 00; RF-00-05, RF-00-08 y RF-00-11 en parte, con traspaso a 02, 04 y 05.
- **PN:** 12 de 12 en catálogo, tablero y §11. **Componentes vigentes:** 28 de 28 con tarea. **Verificaciones:** V-00-01 a V-00-10, 10 de 10 con tarea.
- **IDs citados inexistentes:** 0. **Minutos:** 1530, cuadran por fase. **Principios en incumplimiento:** 0.
- **XIII-C (a):** 5 de 5. **(b):** 4 de 4 filas aplicables con tarea; alcance parcial (hallazgo 3). **(c):** cumple (T-00-38 y T-00-55, Jose Julio Gomez Palmera). **(d):** 0 casos de deriva; evaluación completa pendiente de `docs/glosario.md` (T-00-12).

## Riesgos de juicio

- El tiempo de la lectura en frío, U-00-09, sigue pendiente del ADR-0012.

## Decisiones del responsable

- **P1 (hallazgo 1):** A) acotar RF-00-10 a cambios de PN, requisitos o §6–§7 (recomendada); B) tarea que regenere plan y tareas tras T-00-23 y T-00-25; C) mover la aprobación por PN a `checklists/validacion.md`.
- **P2 (hallazgo 7):** A) citar XIII.n solo en tareas que crean o revisan documentos (recomendada); B) todas; C) dejarlo.
- **P3 (hallazgo 4):** A) corregir el README (6 condiciones, fila `00` igual a D-00-01) y que spec §13 remita a D-00-01 (recomendada); B) quitar la remisión de spec §13.

## Correcciones mecánicas

1. Plan §4, §5.4, §7.2 y §13: «confirmado el 2026-10-19»; fila S-00 de `tareas.md` sin «confirmación de T-00-41 a T-00-44».
2. Plan §2.3 «T-00-01 … T-00-55»; §11 agrega T-00-55; §15.1 agrega S; §7.1 y §3 agregan `checklists/analisis.md`.
3. `task.md`: §1 y §6 a 41; chequeo 4 y «Legible» con T-00-38 y T-00-55; §8 ordenado.
4. T-00-31 incluye `legibilidad.md`, `analisis.md` y la comprobación de IDs de plan y tareas, o una verificación posterior a T-00-55.
5. `specs/README.md`, «Equivalencias»: `/analyze` dos veces (D-00-02) y compuerta de 6 condiciones.

## Resultado para T-00-10

T-00-10 exige «LISTO con 0 críticos y 0 altos». Esta pasada da NO LISTO (1 alto): T-00-10 queda abierta hasta resolver el hallazgo 1.

---

# Pasada 3 de D-00-02 — 2026-10-19

**Autor:** skill analyze (agente architect) | **Documentos:** los mismos de la pasada 2 más este informe | **Modo:** completo

## Veredicto

**LISTO** para producir los documentos (Fase 1): 0 críticos, 0 altos, 1 medio, 6 bajos. T-00-10 cumple su «Hecho cuando» (LISTO con 0 críticos y 0 altos).

## Hallazgos

| # | Sev. | Hallazgo | Corregir en |
|---|---|---|---|
| 1 | Medio | La «Verif.» de RF-00-06 (la spec cambia antes que cualquier otro documento) compara la «Última actualización» de la spec con plan y tareas; DQ-32 solo acotó RF-00-10. Cuando T-00-23 escriba en §11, la Verif. literal fallará (V-00-07 sí está acotada) | spec (P1) |
| 2 | Bajo | `task.md` no reflejó la confirmación de T-00-56 (nota de §5, chequeo 5, §8); fila S-00 de `tareas.md` | tareas, `tareas.md` |
| 3 | Bajo | T-00-10 dice «segunda pasada»; plan D-00-02 la llama tercera | tareas |
| 4 | Bajo | Plan §13 lista XII como advertencia; §4 la marca ✅ | plan |
| 5 | Bajo | T-00-52 (V-00-07) no depende de T-00-23 ni T-00-25 | tareas |
| 6 | Bajo | «Equivalencias» de `specs/README.md` dice que la constitución no prevé `checklists/`; Const. XIII, Verificación (4), sí exige `checklists/legibilidad.md` | `specs/README.md` |
| 7 | Bajo | La tabla «Decisiones pendientes» de la Constitución lista 0006 y 0007, ya firmados | constitución (P2) |

## Estado de los hallazgos de la pasada 2

1 resuelto (residuo en RF-00-06, hallazgo 1) · 2 resuelto (residuo S-00) · 3 resuelto · 4 resuelto · 5 resuelto (cifras desfasadas tras T-00-56) · 6 resuelto · 7 resuelto por D-00-08 · 8 parcial (falta la Constitución).

## Cobertura

20 de 20 requisitos con componente, tarea y verificación (RF-00-05, RF-00-08 y RF-00-11 parciales con traspaso a 02, 04 y 05). PN 12 de 12; componentes 28 de 28; verificaciones 10 de 10; IDs inexistentes 0; 42 tareas activas, 1590 min. XIII-C: (a) 5 de 5, (b) 4 de 4, (c) cumple (T-00-38 y T-00-55), (d) sin deriva, evaluación completa en V-00-10.

## Riesgos de juicio

- V-00-07 y C-00-17 comparan por día; cambios del mismo día solo se ven en el historial de commits.
- Si T-00-48 o T-00-25 cambian §6, ninguna tarea explícita regenera plan y tareas (lo cubre C-00-17 de forma condicional).
- T-00-31 (V-00-10) corre después de la lectura en frío: lo que corrija no vuelve a pasar por ella.
- U-00-09 sigue pendiente del ADR-0012.

---

# Pasada 4 — cierre (2026-10-19)

**Autor:** skill analyze (agente architect) | **Documentos:** los mismos de la pasada 3 más `memory/adr/0012-verificacion-de-legibilidad.md` y `checklists/legibilidad.md` | **Modo:** completo

## Veredicto

**LISTO** para integrar el PR #2, con el commit y el push del estado corregido: 0 críticos, 0 altos y 0 medios documentales. Queda la condición 6 (Pull Request integrado) a cargo de T-00-39.

## Qué cambió desde la pasada 3

DQ-34 (firmas sin Jose Julio y lectura en frío por un agente en contexto limpio), DQ-35 (PN07 en dos cortes separados), DQ-36 (ventana cerrada en ambos extremos), ADR-0012 firmado, `checklists/legibilidad.md` lleno y firmado (2 de 2 bloques, 5 de 5), V-00-07, V-00-09 y V-00-10 ejecutadas y T-00-31, T-00-34, T-00-36 a T-00-38, T-00-52, T-00-54 y T-00-55 cerradas.

## Hallazgos cerrados en esta pasada

Rama de cierre en los encabezados; contradicción «se confirmó con el responsable» en la lectura en frío; DQ-34 en plan y tareas; RNF-00-01, CE-00-05 y G-37; DQ-35 en matriz y research; DQ-36 en spec §13, plan §7.9 y glosario; Constitution Check; estados y checkpoints; S-04 y S-05.

## Bajos pendientes

Los tres bajos se cerraron antes del commit (T-00-38 sin «provisional», G-19 del plan, historial de tareas) y V-00-10 se repitió. Sin efecto en la compuerta.
