---
name: spec
description: Redacta o completa la spec.md de una especificación del DWS (qué y por qué, sin tecnología) siguiendo templates/spec-template.md y la Constitución. Úsala con /spec, o cuando pidan «escribir la spec», «redactar la especificación», «llenar la plantilla de spec» o mencionen una carpeta como specs/01-ingesta-bronce sin spec.md. Si no se nombra la especificación, la pide y se detiene.
---

# Skill `/spec`

Es el paso *Specify* de **GitHub Spec Kit** (`/spec → /clarify → /plan → /analyze → /tasks → /implement`). La `spec.md` dice **qué** se entrega y **por qué**; el **cómo** va en `plan.md` (Principio XII). Todo lo que la spec deje sin decir se descubre después en el plan, las tareas o el código, donde rehacerlo cuesta mucho más. Por eso esta skill llena la plantilla completa, sin inventar y dejando marcado lo que falta para que `/clarify` lo cierre.

Está adaptada a este repositorio: manda la Constitución y el único archivo que editas es `spec.md`.

## 0. Variables (declaradas ANTES de usar esta skill)

El comando `.opencode/commands/spec.md` las fija primero y después apunta a este archivo. Si no están definidas, fíjalas tú con estos valores y dilo.

```text
SPECS=specs
SPEC=$SPECS/<NN-nombre>        # el argumento del comando, p. ej. specs/01-ingesta-bronce
```

Todo lo demás se deriva de esas dos:

| Variable | Valor | Para qué |
|---|---|---|
| `SPEC_FILE` | `$SPEC/spec.md` | El único archivo que editas. |
| `PLAN_FILE` | `$SPEC/plan.md` | Solo lectura. Si existe, cualquier cambio a la spec lo deja obsoleto (XII). |
| `TASKS_FILE` | `$SPEC/task.md` o `$SPEC/tasks.md` | Solo lectura. ADR-0006 decide el nombre; usa el que exista. |
| `SPEC_ADR` | `$SPEC/adr/` | ADR propios de esta especificación. |
| `SPECS_INDEX` | `$SPECS/README.md` | Lista y orden de las especificaciones. |
| `CONSTITUCION` | `memory/constitution.md` | Se lee primero y completa. |
| `ADR_GLOBAL` | `memory/adr/` | ADR que afectan a todo el proyecto. |
| `GESTION` | `docs/gestion/` | `roles.md` (responsables) y `tareas.md` (estado real y compuertas). |
| `PLANTILLA_SPEC` | `templates/spec-template.md` | La estructura obligatoria de la spec. |
| `SPEC_ANTERIOR` | `$SPECS/<NN-1>-…/` | Su `plan.md` («Traspasos explícitos») y su spec son entradas de esta. |

## 1. Cuándo usarla y qué NO hace

- Úsala para crear una spec nueva o completar una en **Borrador** o **En revisión**.
- No aclara a fondo (eso es `/clarify`), no diseña (eso es `/plan`) y no aprueba: la aprobación es del responsable (XI).
- Si la spec está **Aprobada**, avisa y detente: reabrirla es decisión del responsable, porque obliga a regenerar plan y tareas.

## 2. Flujo

### Paso 1 — Resolver y validar

1. Fija `SPEC` y con ella las demás variables. Si el argumento viene como ruta (`specs/NN-nombre` o `specs/NN-nombre/spec.md`), quédate con la carpeta.
2. El nombre cumple `^[0-9]{2}-[a-z0-9]+(-[a-z0-9]+)*$` (XIII) y está en la lista del Principio XII. Lee la lista en la Constitución; no la des por sabida.
3. Si `SPEC_FILE` **no existe**: no crees la carpeta a mano. Propón `bash scripts/new-spec.sh <NN-nombre>` (crea rama, carpeta, `spec.md` y `plan.md` con la versión de la Constitución) y espera la confirmación del usuario.
4. Si **existe**: léelo completo. Lo que una persona escribió no se borra; se reubica en la sección de la plantilla que le corresponde.

### Paso 2 — Cargar el contexto, en este orden

1. `CONSTITUCION` completa. Anota su versión vigente (línea `**Versión**`), sus principios y su «Fuera de alcance».
2. `AGENTS.md` y el `README.md` raíz.
3. `PLANTILLA_SPEC` completa, incluidos sus comentarios: son las reglas de redacción.
4. `SPECS_INDEX`, `GESTION/tareas.md` y `GESTION/roles.md`: orden, estado de la spec anterior y responsables.
5. `ADR_GLOBAL` y `SPEC_ADR`: qué está «Pendiente» y qué bloquea esta spec.
6. `SPEC_ANTERIOR` (spec y plan) y, si existen, las specs siguientes en lo que heredan de esta.
7. `PLAN_FILE` y `TASKS_FILE`, solo para saber si existen.

### Paso 3 — Reunir lo que falta (máximo 3 preguntas)

Antes de redactar, revisa si tienes lo mínimo: qué se entrega, para quién y de qué spec depende. Si la descripción del usuario y los documentos no lo dicen, pregunta **una cosa por turno** (máximo 3), con opción recomendada cuando haya base para recomendar. Lo demás no se pregunta aquí: queda como `[NECESITA ACLARACIÓN: …]` para `/clarify`.

No preguntes por tecnología, por lo que la Constitución ya decidió ni por los ADR pendientes que afectan a todo el proyecto.

### Paso 4 — Llenar la plantilla sección por sección

Copia la estructura de `PLANTILLA_SPEC` tal cual (encabezado, secciones 1 a 7 y «Revisión final») y reemplaza cada `[CORCHETE]`.

| Sección | Cómo llenarla |
|---|---|
| Encabezado | Rama = `NN-nombre`. Responsable y segundo validador desde `GESTION/roles.md`; si no figuran, `[NECESITA ACLARACIÓN]`. «Depende de» = spec anterior del orden XII. Principios aplicables (siempre incluye XII y XIII). ADR relacionados. Versión vigente de la Constitución · `Borrador`. |
| 1. Resumen | Qué, para quién, por qué ahora, en lenguaje de negocio. Los «resultados esperados» llevan ID `CE-NN-MM` y son medibles (cifra, archivo, consulta o comando), sin tecnología. Conserva el criterio de éxito de legibilidad de la plantilla (tabla XIII-C). |
| 2. Requisitos | EARS: una oración, un patrón, sujeto con nombre, `DEBE` como único modal, prioridad `[D]/[S]/[P]` y *Verif.:* (test, consulta o comando). IDs `RF-NN-MM` y `RQ-NN-MM`. Cubre con el patrón «No deseado» los datos inválidos, los duplicados y la re-ejecución del mismo paso (IX). En §2.3 deja los `RNF-NN-MM` de legibilidad que correspondan a los artefactos que produce la entrega y borra los que no apliquen. |
| 3. Datos y dominio | Conceptos de negocio, nivel de detalle y relaciones. Los campos de la fuente citan su documentación; lo que la fuente NO trae se dice. Sin tablas ni columnas de base de datos. |
| 4. Restricciones propias | Solo cifras de esta entrega, con valor y unidad. Lo que fija la Constitución (costo $0, local, datos no versionados…) no se repite. Cifra desconocida = pendiente, no estimación. |
| 5. Fuera de alcance | Lo que no se construye y a qué spec pertenece. Supuestos y restricciones heredadas citando el principio. Conserva «Principios transversales aplicables» con XIII como mínimo y ajusta los IDs que cita. |
| 6. Preguntas y decisiones | Una fila `DQ-MM` por cada `[NECESITA ACLARACIÓN]`. Los ADR pendientes globales van como «Escalada a ADR». |
| 7. Criterios de finalización | Los seis primeros de la plantilla no se quitan (espejan la compuerta). Añade los propios, verificables. |
| Revisión final | Marca solo lo que de verdad cumple. |

Reglas de redacción, y por qué:

- **Sin tecnología** (XII): ni motores, ni lenguajes, ni herramientas, ni tablas, ni código. Si el usuario los menciona, se anotan en el informe como insumo para `/plan`.
- **Todo requisito se comprueba.** «Rápido», «adecuado» o «grande» no sirven: de cada *Verif.:* salen las tareas y los tests.
- **Un término por concepto** en toda la spec. Si la spec anterior o `docs/glosario.md` ya fijaron un término, reutilízalo; los términos nuevos se reportan para el glosario (XIII.6).
- **No inventes cifras ni campos.** Salen de la Constitución, de la fuente o de la spec anterior. Una cifra inventada se vuelve un test que pasa por la razón equivocada.
- **Máximo 3 `[NECESITA ACLARACIÓN]`** en el texto, cada uno con su fila en la sección 6. Si hay más huecos, prioriza por impacto y deja el resto como filas `Pendiente` sin marcador.
- **Sección que no aplica:** `No aplica: <motivo>`. Nunca vacía.
- **Tamaño:** orientativo 160–250 líneas. Si pasa de 300, avisa: dividirla exige enmendar la Constitución.
- Borra los comentarios `<!-- -->` de la plantilla al terminar.

### Paso 5 — Guardar y validar

Escribe `SPEC_FILE` y comprueba:

- No quedan `[CORCHETES]` de la plantilla sin reemplazar.
- Ningún marcador sin fila en la sección 6; no más de 3 en el texto.
- Sin tecnología; términos consistentes; nada contradice la Constitución ni reutiliza su «Fuera de alcance».
- Cada `RF`, `RQ` y `RNF` tiene *Verif.:*; datos inválidos, duplicados y re-ejecución cubiertos.
- Hay al menos un `RNF` que cita `Const. XIII.n`, un `CE` de legibilidad y XIII en «Principios transversales aplicables».
- Estado `Borrador` (o `En revisión` si el usuario lo pide) y «Última actualización» con la fecha de hoy `AAAA-MM-DD`.

### Paso 6 — Informe final

```text
## Informe /spec — <NN-nombre>
Ruta: specs/<NN-nombre>/spec.md · Líneas: n · Estado: Borrador
Constitución: vX.Y.Z

Requisitos: RF n · RQ n · RNF n · CE n
Marcadores [NECESITA ACLARACIÓN] abiertos: n (DQ-…)
ADR que la bloquean: …
Huecos del repositorio (no editados): …
Términos nuevos para docs/glosario.md: …
Insumos para /plan (tecnología mencionada por el usuario): …
¿Plan o tareas obsoletos? sí / no

Siguiente paso: /clarify <NN-nombre>   (o /plan <NN-nombre> si no quedan huecos de alto impacto)
```

**Huecos del repositorio** que se reportan, no se editan: la spec anterior no pasó su compuerta en `GESTION/tareas.md`; la spec no está en `SPECS_INDEX` o en `tareas.md`; un ADR pendiente la bloquea; `PLAN_FILE` o `TASKS_FILE` ya existen y quedarán obsoletos.

## 3. Reglas

- **Solo editas `SPEC_FILE`.** Índice, gestión, ADR, plan y tareas se reportan; así `/spec` no deshace decisiones tomadas en otro lado.
- **No resuelvas ADR pendientes** ni los des por resueltos: se escalan al responsable.
- **Specs existentes con otra convención** (por ejemplo `00-preguntas-negocio`, con secciones propias que no siguen la plantilla): no las renumeres ni las reestructures; repórtalo y deja la decisión al responsable.
- **Nunca marques la spec como «Aprobada».** La aprueba el responsable (XI).
- **Idioma:** conversa en español; la spec va en español con los encabezados y marcadores literales de la plantilla (`[NECESITA ACLARACIÓN]`, «Decisiones tomadas», «Última actualización»).
