---
name: clarify
description: Detecta brechas y vacíos en la spec.md de una especificación del DWS antes de /plan, con hasta 5 preguntas dirigidas hechas de una en una, y registra cada respuesta en la propia spec. Úsala cuando se ejecute /clarify, cuando pidan «aclarar la spec», «qué le falta a la spec», «revisar vacíos o ambigüedades», o cuando se quiera pasar de /specify a /plan, aunque no nombren la habilidad.
---

# Habilidad `/clarify`

Es el paso *Clarify* de **GitHub Spec Kit** (`/specify → /clarify → /plan → /tasks → /implement`). Su razón de ser es barata de entender: lo que la spec deja sin decir se descubre en el plan, en las tareas o en el código, y entonces rehacerlo cuesta mucho más. Aquí se descubre antes, con preguntas cortas, y la respuesta queda escrita en la spec.

Está adaptada a este repositorio: manda la constitución, y lo único que se edita es la `spec.md`.

## 0. Variables (se declaran ANTES de usar esta habilidad)

El comando `.opencode/commands/clarify.md` las fija primero y después remite a este archivo. Si no están definidas, las fijas tú con estos valores y lo dices.

```text
SPECS=specs
SPEC=$SPECS/<NN-nombre>      # el argumento del comando, p. ej. specs/00-preguntas-negocio
```

Todo lo demás se deriva de esas dos. Con ellas encuentras cada elemento del repositorio sin rutas escritas a mano:

| Variable | Valor | Para qué |
|---|---|---|
| `SPEC_FILE` | `$SPEC/spec.md` | Lo único que se edita. |
| `PLAN_FILE` | `$SPEC/plan.md` | Solo lectura. Si existe, quedará obsoleto con cada cambio (principio XII). |
| `TASKS_FILE` | `$SPEC/task.md` o `$SPEC/tasks.md` | Solo lectura. El nombre lo decide el ADR-0006; usa el que exista. |
| `SPEC_ADR` | `$SPEC/adr/` | ADR propios de la especificación. |
| `SPECS_INDEX` | `$SPECS/README.md` | Lista y orden de las especificaciones. |
| `CONSTITUCION` | `memory/constitution.md` | Se lee primero (XIV). |
| `ADR_GLOBAL` | `memory/adr/` | ADR que afectan a todo el proyecto. |
| `GESTION` | `docs/gestion/` | `tareas.md` y `roles.md`: estado real y responsables. |
| `PLANTILLA_SPEC` | `templates/spec-template.md` | Estructura que se espera de una spec. |

## 1. Cuándo se usa y qué NO hace

- Se usa con una spec en **Borrador** o **En revisión**, antes de `/plan`.
- No redacta la spec desde cero (eso es `/specify`), no diseña (eso es `/plan`) y no la aprueba: la aprobación y el cierre son del responsable (principio XI).
- Si la spec está en **Aprobada**, avisa y detente: aclararla exige que el responsable la reabra, porque cualquier cambio obliga a regenerar plan y tareas.

## 2. Flujo

### Paso 1 — Resolver y validar

1. Fija `SPEC`, y con él las demás variables.
2. El nombre cumple `^[0-9]{2}-[a-z0-9]+(-[a-z0-9]+)*$` (XIII) y está en la lista del principio XII. Léela en la constitución; no la des por sabida.
3. `SPEC_FILE` existe. Si no, no lo crees: indica `/specify` o `bash scripts/new-spec.sh <nombre>`.

### Paso 2 — Cargar el contexto, en este orden (XIV)

1. `CONSTITUCION` completa. Anota su versión vigente.
2. `AGENTS.md` y `README.md` de la raíz.
3. `SPEC_FILE` completo, y `PLANTILLA_SPEC` para saber qué estructura debía tener.
4. `SPECS_INDEX` y `GESTION/tareas.md`: orden, estado y bloqueos.
5. `ADR_GLOBAL` y `SPEC_ADR`: qué está «Pendiente» y qué bloquea a esta spec.
6. Las specs vecinas: la anterior (la que debe haber pasado su compuerta) y las siguientes, sobre todo su apartado de lo que heredan. Una brecha suele estar en lo que esta spec debe entregar a otra.
7. `PLAN_FILE` y `TASKS_FILE`, solo para saber si existen.

### Paso 3 — Escanear brechas

Marca cada categoría como **Claro**, **Parcial** o **Ausente**. Las secciones son las de `PLANTILLA_SPEC`.

| Categoría | Dónde mirar | Es una brecha si… |
|---|---|---|
| Alcance y objetivo | §1, §6 | No se puede decir en una frase qué entrega y qué deja fuera; los resultados `SC-xx` no tienen cifra, archivo o comando. |
| Casos de uso y aceptación | §2 | Falta prioridad P1/P2/P3, o un criterio no es comprobable («rápido», «adecuado»). |
| Requisitos funcionales | §3 | Un RF no está en EARS, no enlaza a un caso de uso o no dice cómo se verifica. |
| Datos y dominio | §3 entidades | No se define una entidad, su grano, sus llaves o su relación con otra; un campo no coincide con la fuente. |
| No funcionales | §4 | Una categoría sin métrica (valor y unidad) ni «No aplica: motivo»; costo distinto de $0 sin ADR (VIII). |
| Casos límite y calidad de datos | §5 | Faltan errores, límites, datos inválidos, concurrencia o **re-ejecución del mismo paso** (IX). |
| Dependencias y ADR | encabezado, §7 | «Depende de» no ha pasado su compuerta, o hay un ADR pendiente que la bloquea. |
| Trazabilidad (XV) | §2, §3, §8 | Algún RF, regla o criterio no se puede seguir hasta su verificación o evidencia. |
| Constitución | toda la spec | Aparece tecnología (V, XII), datos versionados (VII), o algo de «Fuera de alcance» de la constitución. |
| Terminología y marcadores | toda la spec | Dos nombres para la misma cosa; más de 3 `[NECESITA ACLARACIÓN]`; marcadores sin fila en la sección de preguntas; `[CORCHETES]` sin reemplazar. |
| Cierre y tamaño | §8 | La lista de cierre no refleja la compuerta; la spec se sale de 160–180 líneas (si pasa de 300, avisa: dividirla exige enmendar la constitución). |

**Brechas del repositorio.** Se **reportan, no se preguntan ni se editan**, porque no viven en la spec:

- La versión de la constitución del encabezado no es la vigente.
- La spec anterior no tiene su compuerta cerrada en `GESTION/tareas.md`.
- Hay ADR «Pendiente» que debían resolverse antes de esta spec.
- La spec no figura en `SPECS_INDEX` ni tiene su entrada en `GESTION/tareas.md`.
- La spec no sigue `PLANTILLA_SPEC` (secciones distintas, o sin tabla de preguntas). Reportarlo basta: reestructurarla es decisión del responsable.
- `PLAN_FILE` o `TASKS_FILE` ya existen y quedarán obsoletos.

### Paso 4 — Armar la cola de preguntas (máximo 5)

Ordena las brechas por **impacto × incertidumbre**. Una pregunta entra solo si su respuesta cambia el plan, los tests, el modelo de datos o un criterio de aceptación. Quedan fuera:

- **Tecnología** (motor, herramienta, librería): es del `plan.md` o de un ADR.
- Lo que la constitución ya decidió.
- **ADR pendientes que afectan a todo el proyecto** (0006 a 0011): no se piden aquí; se marcan «Escalada a ADR» y se reporta el bloqueo.
- Lo que la propia spec **difiere a otra spec** con motivo. Ejemplo: en `00-preguntas-negocio`, el umbral de volumen de los rankings se fija con datos en `02-exploracion-eda`, y los campos reales se confirman en `01-ingesta-bronce`. Se anotan como «Diferida» en el informe, no se preguntan.
- Estilo o redacción que no cambie el significado.

Cada pregunta es de **opción múltiple** (2 a 5 opciones que se excluyen entre sí) o de **respuesta corta** (5 palabras o menos).

### Paso 5 — Preguntar de una en una

Formula una sola pregunta por turno y espera la respuesta. No adelantes las siguientes. Formato:

```text
Pregunta 2 de 4 · Datos y dominio · Impacto: alto
<la pregunta>

Recomendada: B — <motivo en una frase>

| Opción | Qué implica |
|---|---|
| A | … |
| B | … |

Responde con la letra, con «sí» (acepto la recomendada) o con tu propia respuesta.
```

- Si la respuesta es ambigua, haz una repregunta rápida sobre lo mismo; no cuenta como pregunta nueva.
- Termina cuando se vacíe la cola, cuando se hayan hecho 5, o cuando la persona diga «listo» o «basta».
- La recomendada se apoya en la constitución, en las specs vecinas o en la fuente de datos. Si no hay base para recomendar, dilo; no la inventes.

### Paso 6 — Registrar cada respuesta al instante

Guarda después de **cada** respuesta, no al final: si la sesión se corta, no se pierde nada.

1. En la sección de preguntas abiertas (`§7 DISCOVERY QUESTIONS`; en una spec anterior a la plantilla, «Puntos abiertos»), pasa la fila a **Resuelta** con la decisión, o a **Escalada a ADR** con su número. Si la pregunta no tenía fila, créala.
2. Añade en «Decisiones tomadas»: `Decisión · Motivo · Consecuencia`, con la fecha `AAAA-MM-DD`.
3. Aplica la respuesta donde corresponde (RF, CA, CL, requisito no funcional, entidad). Reemplaza la frase vaga; no dejes las dos versiones.
4. Si surge un requisito nuevo, dale el siguiente `RF-xx`, enlázalo a su caso de uso y dile cómo se verifica (XV).
5. Quita el `[NECESITA ACLARACIÓN]` que ya no aplica y actualiza «Última actualización».

### Paso 7 — Validar tras cada escritura

- Ningún marcador queda sin fila, y no hay más de 3 en el texto.
- Los términos son los mismos en toda la spec.
- La respuesta no contradice otra anterior ni la constitución.
- No se coló tecnología.

### Paso 8 — Informe final

```text
## Informe de /clarify — <NN-nombre>
Preguntas: n de 5 · Secciones tocadas: …

| Categoría | Antes | Después | Nota |
|---|---|---|---|

Brechas que siguen abiertas (de mayor a menor impacto): …
Diferidas a otra spec: …
Brechas del repositorio (no se editaron): …
¿Plan o tareas obsoletos? sí / no (si sí: regenerarlos, principio XII)

Siguiente paso: /plan <nombre>   (o /clarify otra vez si queda algo de impacto alto)
```

Si no hay ambigüedad que importe, dilo («sin brechas de impacto significativo») y propón `/plan`. No inventes preguntas para llegar a cinco.

## 3. Reglas, con su porqué

- **Solo editas `SPEC_FILE`.** Lo demás se reporta; así `/clarify` no puede deshacer decisiones tomadas en otro sitio.
- **No inventes cifras ni campos.** Se usan las de la constitución o la fuente; si no están, se pregunta o queda «Pendiente». Una cifra inventada se vuelve un test que pasa por la razón equivocada.
- **No resuelvas ADR pendientes ni los des por resueltos.** Resolverlos exige ADR firmado por el responsable.
- **Aclarar no es rediseñar.** Si una respuesta cambia el alcance o la lista de specs, detente: eso es enmendar la constitución.
- **Nunca marques la spec como «Aprobada».** La aprueba el responsable (XI).
- Responde en español.
