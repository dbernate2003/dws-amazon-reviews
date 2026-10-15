# Constitución del [NOMBRE_DEL_PROYECTO]

<!--
PLANTILLA DE CONSTITUCIÓN. Guárdala como templates/constitution.md; el resultado va en memory/constitution.md.
- Todo lo que está entre [CORCHETES] se reemplaza. Borra estos comentarios al terminar.
- Cada regla se escribe con DEBE / NO DEBE y debe poder comprobarse: si no se puede verificar, reescríbela con una cifra, un archivo o un comando.
- No inventes datos: si algo no está decidido, no lo escribas como regla; llévalo a "Decisiones pendientes".
- Las secciones de estándares equivalen a las cinco categorías clásicas: Seguridad → "Seguridad del dato"; Rendimiento y escalabilidad → "Rendimiento, volumen y costos"; Opciones tecnológicas → "Estándares tecnológicos"; Estándares y patrones → "Modelado y calidad"; Cumplimiento → "Gobernanza y cumplimiento".
-->

Principios no negociables del proyecto. Todo agente ([AGENTES_DEL_PROCESO]) y toda persona que trabaje en este repositorio DEBE leerla antes de actuar y comprobar que su trabajo la cumple. Si una especificación, un plan o una tarea la contradice, gana la constitución.

## Propósito

[Qué es el proyecto en 2-3 frases: fuente de datos, metodología de modelado, arquitectura de capas, motor y restricción de costo.]

## Principios fundamentales

<!-- Formato de cada principio: título en una línea; regla en 1-3 frases; línea "Verificación" con el archivo, test o comando que la comprueba. Agrega o quita principios según haga falta y renumera en romanos. -->

### I. [Metodología del modelo analítico]
[Metodología] para el modelo de [capa final]. Toda tabla de hechos DEBE declarar [grano en una frase], usar [tipo de claves], tener [fila especial para datos faltantes] y clasificar cada medida como [aditiva, semiaditiva o no aditiva].
**Verificación:** [dónde queda documentado y qué debe contener].

### II. [Arquitectura de capas: un esquema por capa]
[Capa 1] (`[esquema_1]`), [capa 2] (`[esquema_2]`) y [capa 3] (`[esquema_3]`) son [N] esquemas de [motor]. Cada capa DEBE exportarse a [formato de archivo] con [herramienta] y documentarse con su DDL (esquema, tablas, campos, tipos y restricciones) en su `README.md`.
**Verificación:** [carpetas de `src/` que deben tener `README.md` y script de exportación].

### III. [La capa cruda no se modifica nunca]
[Capa cruda] contiene [qué datos: periodo y número de registros] y es el respaldo para reprocesar. Una vez cargada y validada, NINGÚN script ejecuta [operaciones prohibidas] sobre ella; las correcciones se hacen en [capa siguiente].
**Verificación:** [test que valida conteo y rango de fechas].

### IV. [Toda transformación nace de una regla del EDA]
Cada hallazgo del EDA se convierte en una regla con código (`R01`, `R02`…), una acción ([descarta, corrige o marca]) y su conteo en [la bitácora de calidad]. NO DEBE existir en el ETL ninguna transformación sin regla.
**Verificación:** [dónde se listan las reglas y qué debe existir por cada una].

### V. [Lenguaje y herramientas permitidas]
[Etapas] se escriben en [lenguaje/motor]. [Herramienta auxiliar] solo [para qué]. [Otro lenguaje] solo vive en [carpeta]. Toda excepción requiere un ADR aprobado.
**Verificación:** [cómo se comprueba que no hay código fuera de lo permitido].

### VI. [Cada regla tiene un test y el cuadre es exacto]
[Un test por regla], más un cuadre de filas entre capas: filas que entran = filas que salen + [rechazadas] + [eliminadas]. El cuadre DEBE dar exacto, [tolerancia].
**Verificación:** [qué debe pasar en verde y dónde se documenta el cuadre].

### VII. [Los datos nunca se versionan]
[Qué guarda el control de versiones]. Los datos viven en [carpeta ignorada] y se respaldan en [lugar de respaldo].
**Verificación:** [comando que demuestra que no hay datos versionados y qué extensiones revisa].

### VIII. [Costo en el estado actual]
[Qué herramientas se usan y que son gratuitas/locales]. Ninguna especificación ni plan puede introducir [lo que está prohibido]. [Qué queda como trabajo futuro].

### IX. [Orquestación]
La ejecución es [manual/automática], con [convención de scripts numerados] que se corren en orden, [restricciones de portabilidad], pensada para [migración futura].
**Verificación:** [prueba de reproducibilidad: desde qué insumo y con qué resultado esperado].

### X. [Gestión del proyecto dentro del repositorio]
[Qué archivos de `docs/gestion/` existen y qué contiene cada uno; qué campos tiene cada tarea; qué herramienta externa queda fuera].

### XI. [Verificación humana antes de cerrar]
[Quién genera y ejecuta el código]; el [responsable de la capa] DEBE verificar con [qué consultas] antes de cerrar una especificación. Un agente NO da una especificación por cerrada.

### XII. [Especificación primero y en orden]
`spec.md` dice qué y por qué, [sin tecnología]. `plan.md` dice cómo. [Qué sale de qué]. Si algo cambia, se actualiza primero [el artefacto fuente] y luego se regeneran [los derivados]. El orden es [`01-nombre` → `02-nombre` → …], y una no empieza hasta que la anterior [condición de paso].

## Estándares tecnológicos

- **Motor:** [motor y dónde corre]. [Si es el único].
- **Fuente:** [archivo, dónde se descarga, a qué carpeta; de qué fuente completa viene; cómo se define el recorte (fecha de corte y regla)]. La especificación [NN-nombre] documenta [qué] y valida [qué].
- **Formatos:** [cadena de formatos desde la fuente hasta el archivo final por capa].
- **Parquet:** [herramienta] desde `[ruta del script]` hacia `[ruta de salida]` ([ADR]).
- **Exploración:** [lenguaje] sobre [capa]. [Qué NO se carga y qué papel tienen sus cifras].
- **Pruebas:** [lenguaje y framework] en `[carpeta]`, con [cómo se lee la conexión].
- **Visualización:** [herramienta], con [nivel de acceso]. [Qué archivos se versionan y cuáles no, y por qué].
- **Nombres:** [convención de esquemas, tablas y campos].

## Seguridad del dato

- **PII:** [los datos personales que existen y cuáles no]. [Cómo se tratan los casos especiales, con acción y conteo en la bitácora].
- **Cruce de fuentes:** [qué NO se cruza y para qué fin].
- **Cifrado:** [aplica o no, y por qué]. [Cuándo se reevalúa].
- **Acceso por rol:** [cómo se separan los accesos]. [Qué rol usa la herramienta de BI y sobre qué capas].
- **Secretos:** [qué nunca se sube]. [Cómo se leen las credenciales, qué archivos de ejemplo se versionan y cuál se ignora]. Ningún SQL versionado contiene credenciales.
- **Auditoría:** [qué campos y tablas dejan rastro: fecha de carga, bitácora, linaje].

## Rendimiento, volumen y costos

- **Volumen:** [qué se mide por capa y dónde se documenta].
- **Latencia de consultas:** [estrategia de índices, cuándo se crean y en qué archivo]. [Cómo se mide: antes y después, con qué comando, dónde se registran los tiempos]. [Regla para índices compuestos].
- **Frescura:** [tipo de carga y fecha del último dato].
- **Concurrencia:** [número de usuarios y cómo trabaja cada uno].
- **Costo:** [costo mensual actual]. [Qué se calculará a futuro y contra qué se comparará].

## Modelado y calidad

- **Reglas del EDA:** [campos de cada regla]. [Qué significa cada acción y si cambia el número de filas].
- **Bitácora de calidad:** [quién la llena y cuándo], con una fila por regla: [campos]. Sirve de [evidencia], de [cuadre] y de [fuente de indicadores de calidad], que los tests comparan contra lo esperado.
- **Linaje:** [de dónde a dónde se puede rastrear una fila].
- **Documentación:** [qué documento por capa], con la plantilla `[ruta de la plantilla]`: [secciones obligatorias].

## Gobernanza y cumplimiento

- **Licencia y uso:** [licencia, cita de la fuente, restricciones de uso y dónde se cita].
- **Retención:** [qué se conserva y por qué].
- **Residencia:** [dónde viven datos, código y documentación].
- **Accesibilidad:** [ramas, revisiones y responsables por carpeta, con el archivo que los define].
- **Auditoría:** [qué deja rastro: commits, bitácora, registro de incidencias].

## Flujo de desarrollo y compuertas

- **Estructura:** [qué va en cada carpeta raíz: qué/por qué, qué se ejecuta, qué gestiona el equipo].
- **Ramas:** [convención de ramas y cómo se integran a `main`].
- **Constitution Check:** todo `plan.md` incluye una sección que lista cada principio aplicable y cómo el diseño lo cumple.
- **Decisiones:** las que afectan a todo el proyecto van en `[ruta de ADR globales]`; las de una sola entrega, en `[ruta de ADR por especificación]`.
- **Compuerta de cierre de una especificación:** (1) [condición], (2) [condición], (3) [condición], (4) [condición], (5) [condición].

## Fuera de alcance

NO DEBE proponerse ni implementarse: [tecnologías descartadas]; [alcance diferido]; [prácticas descartadas]; ni [elementos de versiones anteriores que no se reutilizan].

## Decisiones pendientes

Ningún agente resuelve estos puntos por su cuenta: cada uno se cierra con un ADR y la firma del responsable antes de la especificación indicada.

| ADR | Pendiente | Resolver antes de |
|---|---|---|
| [0006] | [Decisión abierta] | [`NN-nombre`] |
| [0007] | [Decisión abierta] | [`NN-nombre`] |

## Gobernanza de la constitución

- Es un documento vivo que cambia con poca frecuencia. Toda enmienda entra por Pull Request, en una rama propia, con su motivo.
- Versionado: MAJOR si se quita o redefine un principio; MINOR si se agrega un principio o una sección; PATCH si solo cambia la redacción.
- Un incumplimiento detectado al revisar una especificación, un plan o las tareas bloquea el avance. Una excepción exige un ADR que la justifique y una fecha de revisión.

**Versión**: [1.0.0] | **Ratificada**: [AAAA-MM-DD] | **Última enmienda**: [AAAA-MM-DD]
