# 💼 EkonK  
## Sistema Integral de Proyección de Flujo de Caja  

![Estado](https://img.shields.io/badge/🚧_En_Construcción-yellow) ![Licencia](https://img.shields.io/badge/Licencia-🔒_Privada-red) ![SQLite](https://img.shields.io/badge/SQLite-07405E?logo=sqlite&logoColor=white) ![Supabase](https://img.shields.io/badge/Supabase-DB_%26_Auth-3ECF8E?logo=supabase&logoColor=white) ![Node.js](https://img.shields.io/badge/Node.js-339933?logo=nodedotjs&logoColor=white) ![Express](https://img.shields.io/badge/Express-000000?logo=express&logoColor=white) ![HTML5](https://img.shields.io/badge/HTML5-E34F26?logo=html5&logoColor=white) ![CSS3](https://img.shields.io/badge/CSS3-1572B6?logo=css3&logoColor=white) ![JavaScript](https://img.shields.io/badge/JavaScript-F7DF1E?logo=javascript&logoColor=black) ![n8n](https://img.shields.io/badge/n8n-Automation-orange?logo=n8n&logoColor=white) ![Docker](https://img.shields.io/badge/Docker-2496ED?logo=docker&logoColor=white) ![Render](https://img.shields.io/badge/Render-0099FF?logo=render&logoColor=white)

---

## 📋 Descripción del Sistema  
Aplicativo diseñado para proyectar, analizar y anticipar el **flujo de caja** tanto de personas naturales como jurídicas.  
Integra cálculos financieros, análisis predictivo y visualizaciones automáticas basadas en inflación, crecimiento del sector y parámetros económicos.  
Su enfoque es **gerencial y preventivo**, mostrando cómo se comportará la liquidez con el paso del tiempo y cómo las decisiones de gasto, inversión o crédito impactan el futuro financiero.

---

## 🛠 Stack Tecnológico  
**Backend:** Node.js + Express (API REST)  
**Base de Datos:** SQLite / Supabase (escenario productivo)  
**Frontend:** HTML5 / CSS3 / JavaScript + Chart.js  
**Automatizaciones:** n8n (avisos, análisis, recordatorios financieros)

---

## 🖥️ Infraestructura  
**Render (Despliegue planificado):**  
- `backend`, `frontend`, `n8n`  
- Docker + HTTPS + variables `.env` seguras  

**Supabase:**  
- Auth / DB (tablas de usuarios, escenarios, proyecciones)  
- Políticas RLS por usuario  
- Auditoría y métricas  

**Integraciones:**  
- **GateKeeper / ws-auth**: autenticación centralizada  
- **n8n**: alertas automáticas (saldo negativo, punto de equilibrio)

---

## 🗂️ Estructura del Proyecto  
📁 **EkonK**  
├── 📂 backend/  
│   ├── src/routes/ (auth, projections, investment)  
│   ├── src/services/ (cálculos y lógica financiera)  
│   └── src/config.js  
├── 📂 frontend/  
│   ├── templates/ (módulos: personal, empresarial, inversión, informes)  
│   ├── static/css/style.css  
│   └── static/js/ (app, charts, projection)  
├── 📂 docs/  
│   ├── API.md  
│   └── ARCHITECTURE.md  
└── .env.example / docker-compose.yml  

---

## 🔍 Módulos Principales  
- **Flujo Personal:** proyección mensual de ingresos, gastos y costos con variaciones por inflación.  
- **Flujo Empresarial:** proyección anual con porcentaje sugerido por actividad económica.  
- **Flujo de Inversión:** cálculo de cuotas, intereses y amortización por año.  
- **Informes Gerenciales:** análisis gráfico, porcentual y diagnóstico automático.

---

## 💡 Características Destacadas  
- Análisis predictivo con base en inflación y crecimiento sectorial.  
- Gráficas interactivas por período.  
- Escenarios personalizables y exportables a PDF.  
- Integración con Supabase y ws-auth.  
- Módulo de inversión autónomo.  
- Informes narrativos automáticos.  

---

## 🛡️ Seguridad y Control  
- Autenticación mediante GateKeeper/ws-auth.  
- Roles definidos (usuario / admin).  
- Cifrado de variables sensibles.  
- HTTPS obligatorio en entorno productivo.  

---

## 📊 Reportes y Métricas  
- Margen promedio anual.  
- Utilidad acumulada.  
- Sensibilidad ante inflación y variaciones del sector.  
- Relación deuda/ingresos y alertas automáticas.  

---

## 🧩 Gestión y Versionado  
- Estructura GitFlow + CI/CD en Render.  
- Versionado semántico.  
- Backups automáticos en Supabase.  

💡 **Notas Técnicas:**  
✅ Arquitectura modular (independencia por módulo)  
✅ Integración directa con n8n para alertas de flujo crítico  
✅ Preparado para persistencia Supabase (multiusuario)  
✅ Optimizado para impresión en PDF  

“Donde la planeación financiera se convierte en visión estratégica.”

---

## 📬 Contacto Corporativo  
**Julián Alberto Ramírez Caicedo**  
💻 Socio Fundador & Visionario Tecnológico  
⚙️ Estrategia | 💡 Innovación | 🧩 Soluciones Digitales | 🔍 Análisis Financiero  
<img width="222" height="29" alt="Image" src="https://github.com/user-attachments/assets/24519130-f605-4762-a4f2-374c450f2b64" />  
🏢 **WoMo Soluciónˢ**  
<img width="150" height="150" alt="Image" src="https://github.com/user-attachments/assets/09c23a95-e483-452e-880f-e7c90c222014" />

📅 **Control de Versiones**  
![Versión](https://img.shields.io/badge/Versión-1.0.0-blue) ![Actualizado](https://img.shields.io/badge/Actualizado-Oct_2025-green)
