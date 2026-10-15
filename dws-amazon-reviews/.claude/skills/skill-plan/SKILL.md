---
name: skill-plan
description: "Genera el plan técnico (plan.md) de una especificación del DWS de reseñas de Amazon, apoyado en templates/plan.md y en la Constitución, sin escribir código. Úsala siempre que el usuario pida un plan, plan técnico, /plan o diseño técnico de una spec, o mencione una ruta como specs/01-ingesta-bronce/spec.md. Solo genera el plan si se nombra la ruta de la spec; si falta, la pide y se detiene."
argument-hint: "[NN-nombre]"
user-invocable: false
---

# Plan técnico del DWS

En este proyecto la `spec.md` dice **qué y por qué**, y el `plan.md` dice **cómo** (Principio XII de la Constitución). Esta skill produce ese `plan.md` a partir de una spec concreta. Un plan sin su spec obliga a inventar requisitos, y un plan inventado se convierte después en tareas y en código; por eso la skill no arranca sin la ruta de la spec.

El flujo del proyecto es `/specify` (manual) → `/clarify` → **este plan** → `/analyze` → `/tasks` → `/implement`. Esta skill solo cubre el paso del plan.

## 1. Condición de entrada: la ruta de la spec

La ruta puede venir como `specs/NN-nombre/spec.md` o como la carpeta `specs/NN-nombre/`.

- **Si el usuario no nombra la ruta**, no busques specs por tu cuenta ni deduzcas cuál es por el número o el nombre. Responde solo con esto y detente:
  > Antes de armar el plan necesito la ruta de la spec, por ejemplo `specs/01-ingesta-bronce/spec.md`. ¿Cuál es?
- **Si la ruta no existe**, dile qué ruta probaste y pide la correcta. No continúes con otra spec.
- `NN` es el prefijo numérico de la carpeta. El plan se escribe en esa misma carpeta: `specs/NN-nombre/plan.md`.

## 2. Qué leer, en este orden

1. `memory/constitution.md`: versión, principios, tabla «Decisiones pendientes», «Flujo de desarrollo y compuertas» y «Fuera de alcance». Si no contiene el Principio XIII (versión anterior a 1.1.0), avisa en la primera línea del plan y deja las filas XIII marcadas «pendiente de enmienda»; no inventes su texto.
2. La spec indicada: requisitos (`RF`, `RNF`, `CE`, `PNnn`), supuestos, aclaraciones y marcadores `[NEEDS CLARIFICATION]`, capas que toca y entradas que necesita.
3. `templates/plan-template.md`: la estructura del plan. Es la única fuente de la plantilla; si no existe, detente y pide que la agreguen. No la reconstruyas de memoria, porque cada copia improvisada deriva de la oficial.
4. Si existen: `docs/glosario.md`, `docs/gestion/roles.md`, el `plan.md` de la spec anterior (sus «Traspasos explícitos» son entradas de este plan) y un `plan.md` previo en la misma carpeta.

## 3. Cómo se construye el plan

1. **Parte de la plantilla completa.** Conserva numeración y títulos. Las secciones marcadas «(siempre)» no se borran; las «(según capa)» que no correspondan quedan como `No aplica: <motivo>`. Borrar en silencio impide que `/analyze` distinga lo omitido de lo que no aplicaba.
2. **No escribas código.** Nada de SQL, DDL, Python ni comandos. Describe scripts, tablas, pruebas y consultas de verificación en tablas y oraciones. El código nace en `/implement` desde las tareas; si aparece antes, esconde decisiones que nadie revisó.
3. **Requisitos en EARS adaptado** (sección 2 de la plantilla). Un patrón y una respuesta por requisito, sujeto con nombre (nunca «el sistema»), `DEBE` como único modal, todo número como umbral con nombre. Reutiliza los IDs de la spec sin renumerarlos; los componentes son `C-NN-MM` y las verificaciones humanas `V-NN-MM`. Si la spec no tiene IDs, no los inventes dentro del plan: propón el cambio en la sección 5.4.
4. **Constitution Check honesto.** Una fila por principio (I a XIII) y por regla XIII.1–XIII.7, con ¿aplica?, cómo lo cumple el diseño, evidencia y estado. No pongas ✅ sin una evidencia concreta; si el diseño no cumple, ⚠️ o ❌ con el motivo. El resultado de la compuerta sale de esas filas. Llena las dos pasadas (antes de la Fase 0 y después de la Fase 1): la segunda se hace sobre el diseño que el plan describe, no sobre archivos como `research.md` que esta skill no genera.
5. **ADR pendientes: se listan, no se resuelven.** Copia de la tabla «Decisiones pendientes» solo los que afectan a esta spec y di cómo los trata el plan. Si necesitas decidir algo nuevo, regístralo como decisión propuesta (`D-NN-xx`) con alternativas y deja `[POR DEFINIR: ADR-nnnn]` donde dependa de ella. Si el usuario te dice que un ADR ya está decidido pero sin firma, anótalo así: «decidido, falta firma».
6. **Nada inventado.** Umbrales, volúmenes, campos de la fuente, reglas `Rnn` y nombres de objetos salen de la spec o de la Constitución (por ejemplo, las cifras y fechas de Bronce). Lo demás queda como `[POR DEFINIR: ADR-nnnn]` o `[SPEC: qué falta]`. Un marcador visible se arregla; un dato inventado se propaga.
7. **La spec manda sobre el qué.** Si encuentras tecnología en sus enunciados, una contradicción con la Constitución, requisitos ambiguos o sin criterio verificable, no los corrijas en la spec: regístralos en la sección 5.4 («Cambios que este plan exige a `spec.md`»). Principio XII: primero se actualiza la spec.
8. **Trazabilidad calculada, no supuesta.** Cuenta los IDs de requisitos de la spec y los que cubre el plan. Todo `RF`, `RNF` y `CE` debe tener al menos un componente, una tarea (marcador `T-NN-__` hasta que exista `task.md`) y una prueba o consulta; todo componente cita su requisito. Informa los huecos con cifras («18 de 20 requisitos cubiertos»).
9. **Legibilidad (Principio XIII).** Llena la sección 9 con método, umbral y responsable por regla XIII.n. Escribe el propio plan para una persona junior sin contexto: nombres completos, ninguna sigla sin definir en la sección 15 y términos nuevos listados para el glosario.
10. **Restricciones que el plan no puede romper** (verifícalas en la Constitución antes de escribir): Bronce no se modifica después de validado; SQL puro y Python solo en `tests/`; sin servicios de pago, nube, Airflow, Dagster ni dbt; datos y credenciales fuera del repositorio; scripts numerados y reproducibles; no reutilizar dimensiones, nombres de tablas de Oro ni requerimientos del modelo anterior. Una spec nunca se da por cerrada desde el plan: la verificación humana se describe como consultas `V-NN-MM`, sin escribirlas.
11. **Specs sin datos o con compuertas que no aplican** (por ejemplo, una spec de requisitos): marca «No aplica» con motivo y propón la adaptación de la compuerta como decisión nueva para que la firme el responsable. No la des por aprobada.

## 4. Qué escribir y dónde

- Escribe únicamente `specs/NN-nombre/plan.md`. Estado inicial: `borrador`; `Generado por`: skill `plan-tecnico-dws`; fecha: la de hoy.
- Si el plan ya existe, léelo antes. Conserva decisiones firmadas y lo que haya completado una persona, actualiza el resto y registra el cambio en la sección 16 (historial). No lo sobrescribas a ciegas.
- No crees `research.md`, `quickstart.md` ni `task.md`, y no modifiques `spec.md` ni la Constitución. En el plan quedan descritos (sección 7.1) y se generan cuando el usuario lo pida.

## 5. Verifica antes de entregar

Recorre la «Lista de revisión» al final de la plantilla y comprueba además:

- No quedan casillas `[ ]` ni textos de ejemplo de la plantilla sin reemplazar. Lo pendiente está como `[POR DEFINIR: ...]` o `[SPEC: ...]`.
- El plan no contiene sentencias SQL ni bloques de código del proyecto.
- Cada flujo `CUANDO` tiene su `SI … ENTONCES` de error; ningún requisito mezcla dos respuestas.
- La cobertura de requisitos coincide con tu conteo.
- La sección 9 existe y el Constitution Check lista las siete reglas XIII.n.

Corrige lo que falle antes de responder.

## 6. Respuesta al usuario

Máximo diez líneas, sin repetir el contenido del plan: ruta del archivo, requisitos cubiertos («n de m»), principios en ⚠️ o ❌, ADR pendientes que bloquean la siguiente fase, cambios exigidos a la spec, marcadores abiertos y el siguiente paso (revisar el plan y correr `/analyze`). Di con claridad qué dejaste sin decidir.
