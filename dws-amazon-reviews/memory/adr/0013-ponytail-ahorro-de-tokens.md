# ADR-0013 — Ponytail: modo de trabajo de los agentes (ahorro de tokens)

- **Estado:** Aceptado · firmado por el responsable el 2026-10-19, con el acuerdo de Jose Julio Gomez Palmera
- **Fecha:** 2026-10-15
- **Resolver antes de:** — (aplica desde ya a todas las especificaciones)
- **Responsable (firma):** Dario Andres Bernate Canas — 2026-10-19

## Contexto

El trabajo con agentes tiende a producir código de más: funciones, opciones y abstracciones que nadie pidió, justo lo que el repositorio prohíbe («no añadas sin preguntar»). El responsable pide adoptar [Ponytail](https://github.com/dietrichgebert/ponytail), un ruleset para agentes —«el senior más perezoso de la sala: el mejor código es el que no se escribe»— para reducir código, tiempo y tokens.

Ponytail es software libre (MIT), local y gratuito (principio VIII) y no es un servidor MCP ni un servicio de pago: es un plugin para OpenCode y Claude Code, y un archivo de instrucciones para el resto. Toca el principio XIII (menos código no puede significar menos legibilidad), el VIII (costo $0) y la gobernanza de decisiones del proyecto.

## Opciones consideradas

| Opción | A favor | En contra |
|---|---|---|
| A. Copiar el ruleset de Ponytail (`AGENTS.md`) dentro del `AGENTS.md` del repositorio | Sin instalación ni dependencias; funciona en cualquier agente | Texto en inglés que hay que mantener a mano y se desactualiza; choca con el «documentación en español» del XIII.4 |
| B. Plugin oficial en cada agente, más una sección corta en `AGENTS.md`, `CLAUDE.md` y `README.md` | El ruleset se inyecta solo en cada turno y en los subagentes; comandos `/ponytail…`; el plugin se actualiza solo | Cada persona lo instala una vez; la primera carga necesita red (npm) |
| C. No adoptarlo | Cero dependencias nuevas | Se pierde el ahorro y el agente sigue escribiendo de más |

## Decisión

**B.** Se adopta Ponytail como modo de trabajo permanente de los agentes, en nivel `full`; no se apaga (`off` solo con autorización del responsable). La instalación es por persona y global:

- OpenCode: `opencode plugin add @dietrichgebert/ponytail`. Alternativa por proyecto (hoy no declarada en `opencode.json`, para no imponer la instalación a la otra persona): `"plugins": ["@dietrichgebert/ponytail"]`.
- Claude Code: `/plugin marketplace add DietrichGebert/ponytail` y `/plugin install ponytail@ponytail`, en dos prompts separados.

La sección «Ponytail: siempre activo» de `AGENTS.md` fija la convivencia: **la constitución gana**. Ponytail recorta alcance, nunca calidad: no autoriza a omitir nada exigido por el principio XIII (CTEs con comentario, comentarios de DDL, pruebas con docstring, encabezados, trazabilidad, README de capa, bitácora, español), ni la validación en las fronteras, el manejo de errores, la seguridad, el cuadre de filas o la verificación humana del principio XI.

## Consecuencias

- `AGENTS.md` y `CLAUDE.md` declaran el modo siempre activo; el `README.md` lo documenta en «Ahorro de tokens (Ponytail)» y en «Puesta en marcha».
- La constitución no cambia: Ponytail es una herramienta de alcance, no una excepción a un principio.
- Quien clone el repositorio instala el plugin una vez (Claude Code necesita `node` en el PATH para sus hooks). Sin el plugin, la sección de `AGENTS.md` mantiene el modo como instrucción.
- Revisar esta decisión cuando se cierre el ADR-0012 (verificación de legibilidad): ambos definen cómo se controla la calidad de lo escrito.
