WSˢ Bootstrap B1 (legacy + base)
=================================

Qué hace:
- Mueve el contenido actual del repo a /legacy (sin borrar historial)
- Aplica la plantilla ws_base_template encima
- Agrega .gitignore y .gitattributes
- Sube la rama 'chore/move-to-legacy' para abrir PR

Requisitos:
- git instalado y autenticado con GitHub (HTTPS)
- bash (Git Bash/WSL/Linux/Mac)

Uso rápido:
  1) Edita 'repos.txt' con los nombres de tus repos (uno por línea).
  2) Ejecuta:

     chmod +x run.sh
     ./run.sh --owner WoMo-Solucions --template https://github.com/<TU_USUARIO_O_ORG>/ws_base_template.git

     # Modo prueba (sin cambios):
     DRY_RUN=1 ./run.sh --owner WoMo-Solucions --template https://github.com/<TU>/ws_base_template.git

Notas:
- No borra historial. Todo lo viejo queda en /legacy dentro del HEAD.
- Si un repo no tiene rama 'main', intenta 'master' automáticamente.
- No usa 'gh'; al final imprime la URL del PR para abrirlo manualmente.
