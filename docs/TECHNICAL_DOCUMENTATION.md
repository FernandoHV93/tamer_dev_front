# 📚 Documentación Técnica - Article Builder Front

## 🏗️ Arquitectura del Sistema

### 🔄 Arquitectura General
```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Frontend      │    │   Backend       │    │   AI Services   │
│   (React)       │◄──►│   (API)         │◄──►│   (OpenAI,      │
│                 │    │                 │    │    Claude,      │
│                 │    │                 │    │    Grok)        │
└─────────────────┘    └─────────────────┘    └─────────────────┘
         │                       │                       │
         │                       │                       │
         ▼                       ▼                       ▼
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Browser       │    │   Database      │    │   Storage       │
│   Storage       │    │   (User Data)   │    │   (Files)       │
└─────────────────┘    └─────────────────┘    └─────────────────┘
```

### 🧩 Patrones de Diseño Implementados
- **Component-Based Architecture**: React con componentes reutilizables
- **Context Pattern**: Estado global compartido (Session, Toast)
- **Custom Hooks**: Lógica reutilizable (useBrands, useSession)
- **Service Layer**: Separación de lógica de negocio y UI
- **Repository Pattern**: Abstracción de acceso a datos

## 🔧 Stack Tecnológico

### 🎯 Frontend Core
| Tecnología | Versión | Propósito |
|------------|---------|-----------|
| React | 19.1.0 | Framework principal de UI |
| TypeScript | 5.8.3 | Tipado estático y desarrollo seguro |
| Vite | 7.1.2 | Build tool y dev server |
| Tailwind CSS | 4.1.12 | Framework de CSS utility-first |

### 🎨 UI Components
| Librería | Versión | Propósito |
|----------|---------|-----------|
| ShadCN UI | Latest | Componentes de UI base |
| Lucide React | 0.541.0 | Iconos vectoriales |
| Framer Motion | 12.23.12 | Animaciones y transiciones |
| Class Variance Authority | 0.7.1 | Variantes de componentes |

### 📊 Estado y Datos
| Librería | Versión | Propósito |
|----------|---------|-----------|
| Zustand | 5.0.7 | Estado global ligero |
| Axios | 1.11.0 | Cliente HTTP |
| React Router DOM | 7.8.0 | Enrutamiento de la aplicación |

### 🛠️ Herramientas de Desarrollo
| Herramienta | Versión | Propósito |
|-------------|---------|-----------|
| ESLint | 9.33.0 | Linting de código |
| TypeScript ESLint | 8.39.1 | Linting específico de TS |
| PostCSS | 8.5.6 | Procesamiento de CSS |
| Autoprefixer | 10.4.21 | Prefijos CSS automáticos |

## 📁 Estructura del Proyecto

### 🗂️ Organización de Directorios
```
src/
├── components/              # Componentes reutilizables
│   ├── ui/                 # Componentes base de ShadCN UI
│   │   ├── button.tsx      # Botones con variantes
│   │   ├── card.tsx        # Tarjetas y contenedores
│   │   ├── input.tsx       # Campos de entrada
│   │   ├── badge.tsx       # Badges y etiquetas
│   │   └── ...             # Otros componentes UI
│   ├── brandVoice/         # Componentes específicos de Brand Voice
│   │   ├── DeepWizard.tsx  # Asistente principal
│   │   ├── ContentAnalysis.tsx # Análisis de contenido
│   │   ├── BrandVoicePreview.tsx # Vista previa
│   │   └── ...             # Otros componentes BV
│   ├── articleBuilder/     # Componentes del generador de artículos
│   ├── editor/             # Componentes del editor
│   └── navigation/         # Componentes de navegación
├── context/                # Contextos de React
│   ├── SessionContext.tsx  # Gestión de sesión de usuario
│   └── ToastContext.tsx    # Sistema de notificaciones
├── features/               # Funcionalidades organizadas por dominio
│   ├── article_builder/    # Lógica del generador de artículos
│   ├── brand_voice/        # Lógica de voz de marca
│   ├── content/            # Lógica de gestión de contenido
│   └── ...                 # Otras funcionalidades
├── hooks/                  # Hooks personalizados
│   ├── useBrands.ts        # Gestión de marcas
│   ├── useSession.ts       # Gestión de sesión
│   └── ...                 # Otros hooks
├── lib/                    # Utilidades y configuraciones
│   ├── http.ts             # Cliente HTTP configurado
│   ├── htmlUtils.ts        # Utilidades de HTML
│   ├── wizardData.ts       # Datos del asistente
│   └── ...                 # Otras utilidades
├── pages/                  # Páginas principales
│   ├── ApiSettingsPage.tsx # Configuración de APIs
│   ├── BrandVoicePage.tsx  # Página de voz de marca
│   ├── ArticleBuilderPage.tsx # Generador de artículos
│   └── ...                 # Otras páginas
├── services/               # Servicios de API
│   ├── apiSettings.ts      # Configuración de APIs
│   ├── articleBuilder.ts   # Generación de artículos
│   ├── brandVoice.ts       # Servicios de voz de marca
│   └── ...                 # Otros servicios
├── store/                  # Estado global con Zustand
│   ├── articleBuilder.ts   # Estado del generador
│   ├── content.ts          # Estado del contenido
│   └── ...                 # Otros stores
└── types/                  # Definiciones de tipos TypeScript
    ├── article.ts          # Tipos de artículos
    ├── brandVoice.ts       # Tipos de voz de marca
    ├── deepWizard.ts       # Tipos del asistente
    └── ...                 # Otros tipos
```

### 🔗 Dependencias entre Módulos
```
pages/ → components/ → ui/
  ↓           ↓        ↓
services/ → lib/ → types/
  ↓           ↓        ↓
store/ → hooks/ → context/
```

## ⚙️ Configuración del Proyecto

### 🔧 Configuración de Vite
```typescript
// vite.config.ts
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import tailwindcss from '@tailwindcss/vite'

export default defineConfig({
  plugins: [
    react(),
    tailwindcss()
  ],
  server: {
    port: 5173,
    host: true
  },
  build: {
    outDir: 'dist',
    sourcemap: true,
    rollupOptions: {
      output: {
        manualChunks: {
          vendor: ['react', 'react-dom'],
          ui: ['@radix-ui/react-*'],
          utils: ['axios', 'zustand']
        }
      }
    }
  }
})
```

### 🎨 Configuración de Tailwind CSS
```typescript
// tailwind.config.js
import type { Config } from 'tailwindcss'

export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      colors: {
        background: "hsl(var(--background))",
        foreground: "hsl(var(--foreground))",
        primary: {
          DEFAULT: "hsl(var(--primary))",
          foreground: "hsl(var(--primary-foreground))",
        },
        // ... más colores personalizados
      }
    }
  },
  plugins: []
} satisfies Config
```

### 📱 Configuración de TypeScript
```json
// tsconfig.json
{
  "compilerOptions": {
    "target": "ES2020",
    "useDefineForClassFields": true,
    "lib": ["ES2020", "DOM", "DOM.Iterable"],
    "module": "ESNext",
    "skipLibCheck": true,
    "moduleResolution": "bundler",
    "allowImportingTsExtensions": true,
    "resolveJsonModule": true,
    "isolatedModules": true,
    "noEmit": true,
    "jsx": "react-jsx",
    "strict": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "noFallthroughCasesInSwitch": true
  },
  "include": ["src"],
  "references": [{ "path": "./tsconfig.node.json" }]
}
```

## 🚀 Configuración de Despliegue

### 🌐 Configuración para AWS

#### 📦 Build de Producción
```bash
# Construir la aplicación
npm run build

# Verificar la build
npm run preview

# El resultado estará en la carpeta dist/
```

#### 🗂️ Estructura de Build
```
dist/
├── index.html              # Página principal
├── assets/                 # Assets optimizados
│   ├── index-[hash].js     # JavaScript principal
│   ├── index-[hash].css    # CSS principal
│   └── [hash].png          # Imágenes optimizadas
└── _redirects              # Redirecciones para SPA
```

#### 🔧 Configuración de S3
```json
// Política de bucket S3
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::your-bucket-name/*"
    }
  ]
}
```

#### 🌍 Configuración de CloudFront
```json
// Configuración de distribución
{
  "Origins": {
    "S3Origin": {
      "DomainName": "your-bucket-name.s3.amazonaws.com",
      "OriginPath": "",
      "S3OriginConfig": {
        "OriginAccessIdentity": ""
      }
    }
  },
  "DefaultCacheBehavior": {
    "TargetOriginId": "S3Origin",
    "ViewerProtocolPolicy": "redirect-to-https",
    "Compress": true,
    "CachePolicyId": "4135ea2d-6df8-44a3-9df3-4b5a84be39ad"
  }
}
```

### 🔒 Configuración de Seguridad

#### 🛡️ Headers de Seguridad
```typescript
// Configuración recomendada para producción
const securityHeaders = {
  'Content-Security-Policy': [
    "default-src 'self'",
    "script-src 'self' 'unsafe-inline' 'unsafe-eval'",
    "style-src 'self' 'unsafe-inline'",
    "img-src 'self' data: https:",
    "font-src 'self'",
    "connect-src 'self' https://api.yourdomain.com",
    "frame-ancestors 'none'"
  ].join('; '),
  'X-Frame-Options': 'DENY',
  'X-Content-Type-Options': 'nosniff',
  'Referrer-Policy': 'strict-origin-when-cross-origin',
  'Permissions-Policy': 'camera=(), microphone=(), geolocation=()',
  'Strict-Transport-Security': 'max-age=31536000; includeSubDomains'
}
```

#### 🔐 Configuración de CORS
```typescript
// Configuración CORS para APIs
const corsConfig = {
  origin: [
    'https://yourdomain.com',
    'https://www.yourdomain.com',
    'https://api.yourdomain.com'
  ],
  credentials: true,
  methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
  allowedHeaders: [
    'Content-Type',
    'Authorization',
    'X-Requested-With',
    'Accept'
  ],
  exposedHeaders: ['X-Total-Count'],
  maxAge: 86400
}
```

## 📊 Optimizaciones de Performance

### ⚡ Optimizaciones de Build
- **Code Splitting**: Separación automática de chunks por rutas
- **Tree Shaking**: Eliminación de código no utilizado
- **Minificación**: Compresión de JavaScript y CSS
- **Compresión Gzip/Brotli**: Reducción del tamaño de transferencia

### 🖼️ Optimizaciones de Assets
- **Lazy Loading**: Carga diferida de imágenes y componentes
- **WebP Format**: Formato de imagen moderno y eficiente
- **Responsive Images**: Diferentes tamaños según el dispositivo
- **Icon Fonts**: Iconos vectoriales escalables

### 🚀 Optimizaciones de Runtime
- **React.memo**: Memoización de componentes
- **useMemo/useCallback**: Memoización de valores y funciones
- **Lazy Components**: Carga diferida de componentes pesados
- **Virtual Scrolling**: Para listas largas

## 🧪 Testing y Calidad

### 📝 Estrategia de Testing
```typescript
// Ejemplo de test unitario
import { render, screen } from '@testing-library/react'
import { ApiSettingsPage } from './ApiSettingsPage'

describe('ApiSettingsPage', () => {
  it('should render all AI providers', () => {
    render(<ApiSettingsPage />)
    
    expect(screen.getByText('OpenAI GPT-4')).toBeInTheDocument()
    expect(screen.getByText('Anthropic Claude')).toBeInTheDocument()
    expect(screen.getByText('Perplexity')).toBeInTheDocument()
    expect(screen.getByText('Grok')).toBeInTheDocument()
  })
})
```

### 🔍 Herramientas de Testing
- **Jest**: Framework de testing principal
- **React Testing Library**: Testing de componentes React
- **Cypress**: Testing de integración
- **Playwright**: Testing E2E
- **Lighthouse CI**: Auditoría de performance

## 📈 Monitoreo y Logging

### 📊 Métricas de Performance
```typescript
// Ejemplo de métricas de performance
export const performanceMetrics = {
  // Core Web Vitals
  LCP: 'Largest Contentful Paint',
  FID: 'First Input Delay',
  CLS: 'Cumulative Layout Shift',
  
  // Métricas personalizadas
  timeToInteractive: 0,
  bundleSize: 0,
  apiResponseTime: 0
}
```

### 🔍 Herramientas de Monitoreo
- **AWS CloudWatch**: Métricas de infraestructura
- **Sentry**: Monitoreo de errores en tiempo real
- **Google Analytics**: Análisis de usuarios
- **Lighthouse**: Auditoría de performance
- **Web Vitals**: Métricas de Core Web Vitals

## 🔄 CI/CD Pipeline

### 📋 GitHub Actions Workflow
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
        with:
          node-version: '18'
          cache: 'npm'
      - run: npm ci
      - run: npm run lint
      - run: npm run type-check
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
        with:
          aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws-region: us-east-1
      - run: aws s3 sync dist/ s3://${{ secrets.S3_BUCKET }} --delete
      - run: aws cloudfront create-invalidation --distribution-id ${{ secrets.CLOUDFRONT_ID }} --paths "/*"
```

### 🔐 Secrets Requeridos
```bash
# GitHub Secrets necesarios
AWS_ACCESS_KEY_ID=AKIA...
AWS_SECRET_ACCESS_KEY=...
S3_BUCKET=article-builder-front
CLOUDFRONT_ID=E1234567890ABCD
```

## 🚨 Troubleshooting

### ❌ Problemas Comunes

#### Build Fails
```bash
# Error: Cannot find module
npm install
npm run build

# Error: TypeScript compilation
npm run type-check
npm run lint
```

#### Runtime Errors
```bash
# Error: Module not found
npm run dev
# Verificar que todas las dependencias estén instaladas

# Error: API calls failing
# Verificar variables de entorno y configuración de CORS
```

#### Performance Issues
```bash
# Bundle size too large
npm run build -- --analyze
# Revisar imports y lazy loading

# Slow loading
# Verificar optimizaciones de imágenes y code splitting
```

### 🔧 Soluciones Rápidas

#### Limpiar Cache
```bash
# Limpiar cache de npm
npm cache clean --force

# Limpiar cache de Vite
rm -rf node_modules/.vite

# Reinstalar dependencias
rm -rf node_modules package-lock.json
npm install
```

#### Reset de Desarrollo
```bash
# Parar servidor
Ctrl+C

# Limpiar y reiniciar
npm run clean
npm run dev
```

## 📚 Recursos Adicionales

### 🔗 Enlaces Útiles
- [React Documentation](https://react.dev/)
- [Vite Documentation](https://vitejs.dev/)
- [Tailwind CSS Documentation](https://tailwindcss.com/)
- [ShadCN UI Documentation](https://ui.shadcn.com/)
- [AWS S3 Documentation](https://docs.aws.amazon.com/s3/)
- [AWS CloudFront Documentation](https://docs.aws.amazon.com/cloudfront/)

### 📖 Guías de Referencia
- [React Best Practices](https://react.dev/learn)
- [TypeScript Handbook](https://www.typescriptlang.org/docs/)
- [AWS Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/)
- [Web Performance Best Practices](https://web.dev/performance/)

---

**Última actualización**: Diciembre 2024
**Versión del documento**: 1.0.0
**Mantenido por**: Equipo de Desarrollo TamerCode
