#!/usr/bin/env bash
# Crea la rama y la carpeta de una especificación nueva.
#
# Uso:  bash scripts/new-spec.sh NN-nombre      (por ejemplo: 01-ingesta-bronce)
#
# Reglas de la constitución que aplica:
#   - Principio XIII: el nombre es NN-nombre (dos dígitos, minúsculas, sin tildes, con guiones).
#   - Principio XII: solo se crean las especificaciones de la lista de la constitución.
#   - Principio XIV: spec.md y plan.md nacen con la versión de la constitución en su encabezado.
set -euo pipefail

uso() { echo "Uso: bash scripts/new-spec.sh NN-nombre   (por ejemplo: 01-ingesta-bronce)" >&2; }
falla() { echo "Error: $1" >&2; exit 1; }

[[ $# -eq 1 ]] || { uso; exit 1; }
nombre="$1"

# La raíz del proyecto es la carpeta que contiene scripts/.
raiz="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$raiz"

constitucion="memory/constitution.md"
[[ -f "$constitucion" ]] || falla "no encuentro $constitucion en $raiz"

# Principio XIII
patron='^[0-9]{2}-[a-z0-9]+(-[a-z0-9]+)*$'
[[ "$nombre" =~ $patron ]] || falla "'$nombre' no cumple el principio XIII ($patron)"

# Principio XII: el nombre debe figurar, entre comillas invertidas, en la constitución.
grep -qF "\`$nombre\`" "$constitucion" \
  || falla "'$nombre' no está en la lista del principio XII. Agregar o renombrar una especificación exige enmendar la constitución."

# Principio XIV: versión vigente de la constitución.
version="$(sed -n -E 's/^\*\*Versión\*\*: ([0-9]+\.[0-9]+\.[0-9]+).*/\1/p' "$constitucion" | head -n 1)"
[[ -n "$version" ]] || falla "no pude leer la versión de la constitución"

carpeta="specs/$nombre"
[[ ! -e "$carpeta" ]] || falla "$carpeta ya existe"
for plantilla in spec-template.md plan-template.md; do
  [[ -f "templates/$plantilla" ]] || falla "falta templates/$plantilla"
done

# Rama con el mismo nombre que la especificación.
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  if git show-ref --verify --quiet "refs/heads/$nombre"; then
    falla "la rama '$nombre' ya existe"
  fi
  git switch -c "$nombre"
else
  echo "Aviso: esto no es un repositorio Git; no se creó la rama." >&2
fi

# Carpeta, plantillas y carpeta de ADR de la entrega.
mkdir -p "$carpeta/adr"
: > "$carpeta/adr/.gitkeep"
sed -e "s/\[NNN-nombre\]/$nombre/g" \
    -e "s/\[NN-nombre\]/$nombre/g" \
    -e "s/\[1\.0\.0\]/$version/g" \
    templates/spec-template.md > "$carpeta/spec.md"
sed -e "s/NN-nombre/$nombre/g" \
    -e "s/\[X\.Y\.Z\]/$version/g" \
    templates/plan-template.md > "$carpeta/plan.md"

echo "Listo:"
echo "  rama:     $nombre"
echo "  carpeta:  $carpeta/ (spec.md, plan.md, adr/)"
echo "  constitución declarada en los encabezados: v$version"
echo "El archivo de tareas lo crea /tasks cuando el ADR-0006 fije su nombre."
