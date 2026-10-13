# ADR-0008 — Herramienta del paso `clave: valor` → archivo delimitado por `|`

- **Estado:** Pendiente
- **Fecha:** 2026-10-12
- **Resolver antes de:** `01-ingesta-bronce`
- **Responsable (firma):** pendiente
- **Fecha de revisión:** por definir (si se aprueba una excepción al Principio V)

## Contexto

La fuente `all_3y.txt.gz` es texto plano `clave: valor`. Hay que convertirla en un archivo delimitado por `|` antes de cargarla con `\copy`. Ese paso choca con el Principio V (SQL puro; Python solo en `tests/`). Toda excepción requiere un ADR aprobado.

Mientras este ADR siga pendiente, el `implementer` no escribe código para este paso.

## Opciones consideradas

| Opción | A favor | En contra |
|---|---|---|
| | | |

## Decisión

Pendiente.

## Consecuencias

Si la decisión es una excepción al Principio V: ajustar los permisos de `opencode.json` y de `.opencode/agents/implementer.md` (hoy niegan `.py` fuera de `tests/`) y la verificación del principio.
