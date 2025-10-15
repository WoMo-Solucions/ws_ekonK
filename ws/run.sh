#!/usr/bin/env bash
set -euo pipefail

OWNER=""
TEMPLATE_REPO=""
TEMPLATE_BRANCH="main"
REPOS_FILE="./repos.txt"
DRY="${DRY_RUN:-0}"

usage(){ cat <<USAGE
Uso:
  ./run.sh --owner <OrgOUsuario> --template <URL_repo_template> [--branch main] [--repos ./repos.txt]

Ejemplo:
  ./run.sh --owner WoMo-Solucions --template https://github.com/TU/ws_base_template.git
  DRY_RUN=1 ./run.sh --owner WoMo-Solucions --template https://github.com/TU/ws_base_template.git

USAGE
exit 1; }

# Parse args
while [[ $# -gt 0 ]]; do
  case "$1" in
    --owner) OWNER="$2"; shift 2;;
    --template) TEMPLATE_REPO="$2"; shift 2;;
    --branch) TEMPLATE_BRANCH="$2"; shift 2;;
    --repos) REPOS_FILE="$2"; shift 2;;
    *) usage ;;
  esac
done

[[ -n "$OWNER" && -n "$TEMPLATE_REPO" ]] || usage
[[ -f "$REPOS_FILE" ]] || { echo "[x] No existe $REPOS_FILE"; exit 1; }

mapfile -t REPOS < <(grep -v '^\s*#' "$REPOS_FILE" | sed '/^\s*$/d')

say(){ echo -e "==> $*"; }
warn(){ echo -e "[!] $*"; }

for REPO in "${REPOS[@]}"; do
  say "Repo: $REPO"

  # Clona si no existe
  if [[ ! -d "$REPO" ]]; then
    git clone "https://github.com/${OWNER}/${REPO}.git" "$REPO" || { warn "No pude clonar $REPO"; continue; }
  fi
  cd "$REPO"

  git fetch --all --prune >/dev/null 2>&1 || true
  git switch main 2>/dev/null || git switch master
  git pull --ff-only >/dev/null 2>&1 || true

  BRANCH="chore/move-to-legacy"
  git switch "$BRANCH" 2>/dev/null || git switch -c "$BRANCH"

  if [[ "$DRY" != "1" ]]; then
    mkdir -p legacy
    # Mueve solo archivos versionados, preservando estructura
    git ls-files -z | xargs -0 -I{} bash -lc 'mkdir -p legacy/$(dirname "{}"); git mv "{}" "legacy/{}" 2>/dev/null || true'
    git add -A && git commit -m "chore: move current tree into /legacy" || true
  else
    warn "DRY RUN: no se mueve a legacy"
  fi

  # Remoto plantilla
  git remote get-url base >/dev/null 2>&1 || git remote add base "$TEMPLATE_REPO"
  git fetch base >/dev/null 2>&1 || true

  if [[ "$DRY" != "1" ]]; then
    git checkout "base/$TEMPLATE_BRANCH" -- .gitignore 2>/dev/null || true
    git checkout "base/$TEMPLATE_BRANCH" -- . 2>/dev/null || true
    git add -A && git commit -m "chore: bootstrap from ws_base_template" || true
  else
    warn "DRY RUN: no se aplica plantilla"
  fi

  # .gitignore mínimo si faltara
  if [[ ! -f .gitignore ]]; then
    cat > .gitignore <<'EOF'
.env
.env.*.local
*.key
*.pem
__pycache__/
*.pyc
.venv/
dist/
build/
node_modules/
.n8n/
.vscode/
.idea/
.DS_Store
Thumbs.db
EOF
    git add .gitignore && git commit -m "chore: add .gitignore (env/secret safe)" || true
  fi

  if [[ ! -f .gitattributes ]]; then
    echo "legacy/* linguist-vendored" > .gitattributes
    git add .gitattributes && git commit -m "chore: deprioritize legacy/ in linguist stats" || true
  fi

  if [[ "$DRY" != "1" ]]; then
    git push -u origin "$BRANCH" || true
    echo "Abre el PR: https://github.com/${OWNER}/${REPO}/compare/${BRANCH}?expand=1"
  else
    warn "DRY RUN: no push/PR"
  fi

  cd ..
  echo
done

say "Terminado. Revisa los PRs en GitHub."
