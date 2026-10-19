@memory/constitution.md
@AGENTS.md

## Flujo Spec-Driven en Claude Code

La configuración vive en `.claude/` con la misma arquitectura que `.opencode/`: `agents/`, `commands/` y `skills/`, más `settings.json` con los permisos.

| Paso | Comando | Dónde corre | Agente | Skill |
|---|---|---|---|---|
| 1 | `/spec NN-nombre` | Sesión principal | `spec-writer` (con `claude --agent spec-writer`) | `skill-spec` + plantilla `templates/spec-template.md` |
| 2 | `/clarify NN-nombre` | Sesión principal | `spec-writer` (con `claude --agent spec-writer`) | `skill-clarify` |
| 3 | `/plan NN-nombre` | Subagente aislado | `architect` | `skill-plan` |
| 4 | `/analyze NN-nombre` | Subagente aislado, sin escritura | `architect` | `skill-analyze` |
| 5 | `/tasks NN-nombre [borrador]` | Subagente aislado | `task-breaker` | `skill-tasks` |
| 6 | `/implement NN-nombre [T-NN-MM]` | Subagente aislado | `implementer` | `skill-implement` |
| — | `/check NN-nombre` | Subagente aislado, solo lectura | `Explore` | — |
| 1→7 | `/flujo NN-nombre [desde <paso>]` | Sesión principal; delega 3–7 a sus subagentes | `spec-writer` (con `claude --agent spec-writer`) | Las de cada paso |

- `/flujo` encadena todos los pasos: lee en qué paso va la spec, ejecuta uno y se detiene en su compuerta hasta que digas «continuar». Retoma con `/flujo NN-nombre` o `/flujo NN-nombre desde <paso>`.
- `/spec` y `/clarify` corren en la sesión principal porque te hacen preguntas, y un subagente no puede preguntar a mitad de la tarea.
- Un subagente que necesita una decisión tuya se detiene y la devuelve en su respuesta. Contestas volviendo a correr el comando con el dato, por ejemplo `/tasks 01-ingesta-bronce borrador`.
- Claude Code no limita por agente las rutas que se editan. Lo que cada agente puede escribir está en sus reglas; los bloqueos globales están en `.claude/settings.json`.

## Ponytail: siempre activo (ahorro de tokens)

Claude Code trabaja siempre en modo **Ponytail** (<https://github.com/dietrichgebert/ponytail>), el «senior perezoso»: el cambio más pequeño que resuelve el problema completo. Se instala una sola vez, con dos prompts separados:

```text
/plugin marketplace add DietrichGebert/ponytail
```
```text
/plugin install ponytail@ponytail
```

El ruleset entra en cada turno de la sesión principal y de sus subagentes (los hooks necesitan `node` en el PATH) y añade los comandos `/ponytail`, `/ponytail-review`, `/ponytail-audit`, `/ponytail-debt`, `/ponytail-gain` y `/ponytail-help`. Nivel `full` por defecto (`/ponytail lite|full|ultra|off`); no se apaga en este repositorio. La convivencia con la constitución y lo que no se poda están en la sección «Ponytail: siempre activo» de `AGENTS.md`.
