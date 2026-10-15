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

- `/spec` y `/clarify` corren en la sesión principal porque te hacen preguntas, y un subagente no puede preguntar a mitad de la tarea.
- Un subagente que necesita una decisión tuya se detiene y la devuelve en su respuesta. Contestas volviendo a correr el comando con el dato, por ejemplo `/tasks 01-ingesta-bronce borrador`.
- Claude Code no limita por agente las rutas que se editan. Lo que cada agente puede escribir está en sus reglas; los bloqueos globales están en `.claude/settings.json`.
