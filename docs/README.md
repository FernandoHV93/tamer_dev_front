# Article Builder Front - Documentación del Proyecto

## 📋 Descripción General

**Article Builder Front** es una aplicación web moderna construida con React y TypeScript, diseñada para crear, editar y gestionar artículos utilizando inteligencia artificial. La aplicación ofrece capacidades avanzadas de generación de contenido, análisis de marca y gestión de APIs de IA.

## 🚀 Características Principales

### ✨ Funcionalidades Core
- **Generador de Artículos con IA**: Creación automática de contenido usando múltiples proveedores de IA
- **Editor de Artículos Avanzado**: Interfaz rica para edición y formateo de contenido
- **Gestión de Marca**: Configuración y análisis de voz de marca
- **Configuración de APIs**: Gestión centralizada de claves API para servicios de IA
- **Análisis de Contenido**: Herramientas para evaluar y mejorar el contenido
- **Roadmap de Contenido**: Planificación y organización de estrategias de contenido

### 🤖 Proveedores de IA Soportados
- **OpenAI GPT-4**: Generación avanzada de texto y procesamiento de lenguaje
- **Anthropic Claude**: Capacidades de razonamiento y comprensión contextual
- **Perplexity**: Modelos de lenguaje de última generación
- **Grok (Tesla)**: IA de Tesla para análisis en tiempo real

## 🏗️ Arquitectura del Proyecto

### 📁 Estructura de Directorios
```
src/
├── components/          # Componentes reutilizables
│   ├── ui/             # Componentes ShadCN UI
│   ├── brandVoice/     # Componentes específicos de Brand Voice
│   └── ...             # Otros componentes
├── context/            # Contextos de React (sesión, notificaciones)
├── features/           # Funcionalidades organizadas por dominio
├── hooks/              # Hooks personalizados de React
├── lib/                # Utilidades y configuraciones
├── pages/              # Páginas principales de la aplicación
├── services/           # Servicios de API y lógica de negocio
├── store/              # Estado global con Zustand
└── types/              # Definiciones de tipos TypeScript
```

### 🔧 Tecnologías Utilizadas
- **Frontend**: React 19 + TypeScript
- **UI Framework**: ShadCN UI + Tailwind CSS
- **Estado Global**: Zustand
- **Enrutamiento**: React Router DOM
- **HTTP Client**: Axios
- **Animaciones**: Framer Motion
- **Build Tool**: Vite
- **Linting**: ESLint
- **Formateo**: Prettier

## 🚀 Instalación y Configuración

### 📋 Prerrequisitos
- Node.js 18+ 
- npm 9+ o yarn 1.22+
- Git

### ⚡ Instalación Rápida
```bash
# Clonar el repositorio
git clone <repository-url>
cd article-builder-front

# Instalar dependencias
npm install

# Configurar variables de entorno
cp .env.example .env

# Iniciar servidor de desarrollo
npm run dev
```

### 🔐 Variables de Entorno
```bash
# .env
VITE_BASE_URL=https://backend.tamercode.com
VITE_APP_NAME=Article Builder
VITE_APP_VERSION=1.0.0
```

## 🎯 Scripts Disponibles

### 📜 Scripts de Desarrollo
```bash
npm run dev          # Servidor de desarrollo (puerto 5173/5174)
npm run build        # Construcción para producción
npm run preview      # Vista previa de la build
npm run lint         # Verificación de código
npm run type-check   # Verificación de tipos TypeScript
```

### 🧹 Scripts de Mantenimiento
```bash
npm run clean        # Limpiar archivos generados
npm run format       # Formatear código con Prettier
npm run test         # Ejecutar tests (cuando estén implementados)
```

## 🌐 Despliegue en AWS

### 📋 Checklist de Despliegue

#### ✅ Configuración del Proyecto
- [x] Variables de entorno configuradas
- [x] Build de producción exitoso
- [x] Optimizaciones de Vite habilitadas
- [x] Compresión de assets configurada
- [x] Lazy loading implementado

#### ✅ Configuración de AWS
- [ ] Bucket S3 configurado para hosting estático
- [ ] CloudFront distribution configurada
- [ ] Certificado SSL configurado
- [ ] Políticas de CORS configuradas
- [ ] Redirecciones configuradas

#### ✅ Seguridad
- [ ] Headers de seguridad configurados
- [ ] CSP (Content Security Policy) implementado
- [ ] HSTS habilitado
- [ ] Rate limiting configurado

### 🚀 Pasos de Despliegue

#### 1. Preparar Build de Producción
```bash
# Construir la aplicación
npm run build

# Verificar que la build sea exitosa
npm run preview
```

#### 2. Configurar S3
```bash
# Crear bucket S3
aws s3 mb s3://article-builder-front

# Configurar bucket para hosting estático
aws s3 website s3://article-builder-front --index-document index.html --error-document index.html
```

#### 3. Configurar CloudFront
```bash
# Crear distribución CloudFront
aws cloudfront create-distribution \
  --origin-domain-name article-builder-front.s3.amazonaws.com \
  --default-root-object index.html
```

#### 4. Desplegar Contenido
```bash
# Sincronizar build con S3
aws s3 sync dist/ s3://article-builder-front --delete

# Invalidar caché de CloudFront
aws cloudfront create-invalidation \
  --distribution-id <DISTRIBUTION_ID> \
  --paths "/*"
```

## 🔒 Configuración de Seguridad

### 🛡️ Headers de Seguridad
```typescript
// Configuración recomendada para producción
const securityHeaders = {
  'Content-Security-Policy': "default-src 'self'; script-src 'self' 'unsafe-inline'; style-src 'self' 'unsafe-inline';",
  'X-Frame-Options': 'DENY',
  'X-Content-Type-Options': 'nosniff',
  'Referrer-Policy': 'strict-origin-when-cross-origin',
  'Permissions-Policy': 'camera=(), microphone=(), geolocation=()'
}
```

### 🔐 Configuración de CORS
```typescript
// Configuración CORS para APIs
const corsConfig = {
  origin: ['https://yourdomain.com', 'https://api.yourdomain.com'],
  credentials: true,
  methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
  allowedHeaders: ['Content-Type', 'Authorization']
}
```

## 📊 Monitoreo y Logging

### 📈 Métricas Recomendadas
- **Performance**: Core Web Vitals, LCP, FID, CLS
- **Errores**: JavaScript errors, API failures, 404s
- **Usuarios**: Sessions, page views, user engagement
- **Infraestructura**: Response times, availability, throughput

### 🔍 Herramientas de Monitoreo
- **AWS CloudWatch**: Métricas de infraestructura
- **Sentry**: Monitoreo de errores en tiempo real
- **Google Analytics**: Análisis de usuarios
- **Lighthouse**: Auditoría de performance

## 🧪 Testing

### 📝 Estrategia de Testing
- **Unit Tests**: Jest + React Testing Library
- **Integration Tests**: Cypress para flujos completos
- **E2E Tests**: Playwright para pruebas de usuario
- **Performance Tests**: Lighthouse CI

### 🚀 Ejecutar Tests
```bash
# Tests unitarios
npm run test

# Tests de integración
npm run test:integration

# Tests E2E
npm run test:e2e

# Cobertura de código
npm run test:coverage
```

## 🔄 CI/CD

### 📋 Pipeline Recomendado
```yaml
# .github/workflows/deploy.yml
name: Deploy to AWS
on:
  push:
    branches: [main, master]
  pull_request:
    branches: [main, master]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
      - run: npm ci
      - run: npm run test
      - run: npm run build

  deploy:
    needs: test
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/main'
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
      - run: npm ci
      - run: npm run build
      - uses: aws-actions/configure-aws-credentials@v1
      - run: aws s3 sync dist/ s3://article-builder-front --delete
      - run: aws cloudfront create-invalidation --distribution-id ${{ secrets.CLOUDFRONT_ID }} --paths "/*"
```

## 📚 Recursos Adicionales

### 🔗 Enlaces Útiles
- [Documentación de React](https://react.dev/)
- [Documentación de Vite](https://vitejs.dev/)
- [Documentación de Tailwind CSS](https://tailwindcss.com/)
- [Documentación de ShadCN UI](https://ui.shadcn.com/)
- [Documentación de AWS S3](https://docs.aws.amazon.com/s3/)
- [Documentación de AWS CloudFront](https://docs.aws.amazon.com/cloudfront/)

### 📖 Guías de Referencia
- [React Best Practices](https://react.dev/learn)
- [TypeScript Handbook](https://www.typescriptlang.org/docs/)
- [AWS Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/)
- [Web Performance Best Practices](https://web.dev/performance/)

## 🤝 Contribución

### 📝 Guías de Contribución
1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

### 🐛 Reportar Bugs
- Usa el sistema de issues de GitHub
- Incluye pasos para reproducir el bug
- Adjunta logs y screenshots cuando sea posible
- Especifica el entorno (navegador, OS, versión)

## 📄 Licencia

Este proyecto está bajo la licencia [MIT](LICENSE).

## 👥 Equipo

- **Desarrolladores**: Equipo de desarrollo de TamerCode
- **Producto**: Product Managers y UX/UI Designers
- **QA**: Equipo de testing y calidad

---

**Última actualización**: $(date)
**Versión del documento**: 1.0.0
