# 💼 EkonK — Proyección de Flujo de Caja

![Estado](https://img.shields.io/badge/🚀_MVP-blue) ![Licencia](https://img.shields.io/badge/Licencia-Privada-red) ![Render](https://img.shields.io/badge/Render-ready-0099FF) ![Supabase](https://img.shields.io/badge/Supabase-DB_%26_Auth-3ECF8E) ![n8n](https://img.shields.io/badge/n8n-automation-orange)

Aplicativo para **proyección de flujo de caja** en dos modalidades:
- **Personal (12 meses)**: ingresos/gastos/costos fijos + extras por mes.
- **Empresarial (N años)**: ventas base, actividad económica, inflación y crecimiento sectorial, con % de costos sugeridos por actividad.
Incluye módulo de **inversión (crédito)** con tabla de amortización anual.

---

## ⚙️ Stack
- **Node.js + Express** (API + estáticos)
- **HTML/CSS/JS** + Chart.js (gráficas)
- **Supabase** (planificado para persistencia)
- **ws-auth/GateKeeper** (proxy login; en dev mock)
- **n8n** (webhooks para alertas/avisos)

## ▶️ Arranque rápido (Windows + Docker Compose)
1. Crea `.env` a partir de `.env.example`.
2. En consola (mismo nivel del `docker-compose.yml`):
   ```bash
   docker compose up -d
   ```
3. Abre `http://localhost:5678` → login (mock).

## 📚 Endpoints principales
Ver `docs/API.md`.

## 🧩 Integraciones
- **ws-auth**: setear `WS_AUTH_URL` y usar `POST /auth/token/login/` (proxy incluido).
- **Supabase**: variables `SUPABASE_URL`, `SUPABASE_ANON_KEY` para guardar escenarios.
- **n8n**: `N8N_WEBHOOK_URL` para emitir eventos (p.ej. saldo negativo).

## 🖨️ Impresión / PDF
Todas las vistas están optimizadas para "Imprimir → Guardar como PDF".

## 📦 Despliegue en Render (sugerido)
- Servicio único (Web Service) con `node backend/src/index.js`.
- Variables de entorno desde el dashboard.
- Activar `Auto-Deploy` desde GitHub.

## 🔒 Seguridad
- No expongas claves en el frontend.
- Usa HTTPS siempre.
- GateKeeper/ws-auth para roles y redirecciones por perfil.

## 🗺️ Roadmap
- Persistencia de escenarios (Supabase)
- Exportador gerencial (PDF con resumen y gráficas)
- Sensibilidades (what-if)
- Multi-moneda y tasas diferenciadas

---
**WoMo Soluciónˢ — EkonK**
