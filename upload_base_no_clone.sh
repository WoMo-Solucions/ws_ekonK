#!/usr/bin/env bash
set -euo pipefail

ORG="WoMo-Solucions"
BRANCH="chore/add-base"
TEMPLATE_DIR="/workspaces/ws_base_template"
REPOS_FILE="./repos.txt"

[[ -d "$TEMPLATE_DIR" ]] || { echo "Falta TEMPLATE_DIR"; exit 1; }
[[ -f "$REPOS_FILE" ]]   || { echo "Falta REPOS_FILE"; exit 1; }

# Utilidad: base64 sin saltos
b64() { 
  if base64 --help 2>&1 | grep -q "\-w"; then base64 -w0 "$1"; else base64 "$1" | tr -d '\n'; fi
}

echo -e "\n🚀 Subiendo base desde $TEMPLATE_DIR a repos de $ORG (sin clonar)\n"

# Recorre repositorios
while read -r REPO; do
  [[ -z "$REPO" ]] && continue
  echo "=============================================================="
  echo "📦 Repo: $REPO"

  # 1) Obtener rama por defecto y SHA
  DEFAULT_BRANCH=$(gh api "repos/${ORG}/${REPO}" -q .default_branch 2>/dev/null || echo main)
  BASE_SHA=$(gh api "repos/${ORG}/${REPO}/git/ref/heads/${DEFAULT_BRANCH}" -q .object.sha)

  # 2) Crear ref de la rama si no existe
  if gh api "repos/${ORG}/${REPO}/git/ref/heads/${BRANCH}" >/dev/null 2>&1; then
    echo "   🔀 Rama ${BRANCH} ya existe"
  else
    echo "   🌱 Creando rama ${BRANCH} desde ${DEFAULT_BRANCH}"
    gh api -X POST "repos/${ORG}/${REPO}/git/refs" \
      -f ref="refs/heads/${BRANCH}" \
      -f sha="${BASE_SHA}" >/dev/null
  fi

  # 3) Recorrer archivos del template y subir solo los que no existan
  while IFS= read -r -d '' FILE; do
    REL="${FILE#$TEMPLATE_DIR/}"           # ruta relativa dentro del repo
    # Nunca subas .git/ ni nada raro
    [[ "$REL" == ".git/"* ]] && continue

    # Si es directorio, saltar (la API crea carpetas implícitamente al subir el archivo)
    [[ -d "$FILE" ]] && continue

    # ¿Ya existe el archivo en la rama destino?
    if gh api "repos/${ORG}/${REPO}/contents/${REL}?ref=${BRANCH}" >/dev/null 2>&1; then
      # Ya existe → NO lo pisamos
      # echo "   ↪️  Existe: ${REL} (saltando)"
      continue
    fi

    MSG="chore: add base file ${REL}"
    CONTENT="$(b64 "$FILE")"
    # Crear/actualizar archivo
    gh api -X PUT "repos/${ORG}/${REPO}/contents/${REL}" \
      -f message="${MSG}" \
      -f branch="${BRANCH}" \
      -f content="${CONTENT}" >/dev/null \
      && echo "   ➕ ${REL}"
  done < <(find "$TEMPLATE_DIR" -type f ! -path '*/.git/*' -print0)

  echo "   ✅ Base aplicada (solo faltantes) en ${BRANCH}"
  echo "   ➡️ PR: https://github.com/${ORG}/${REPO}/compare/${BRANCH}?expand=1"
done < "$REPOS_FILE"

echo -e "\n🏁 Terminado. Abre los enlaces, crea el PR y haz Merge.\n"
