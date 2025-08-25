# Documentación Técnica - Article Builder Frontend

## 📋 Índice

1. [Arquitectura del Proyecto](#arquitectura-del-proyecto)
2. [Tecnologías Utilizadas](#tecnologías-utilizadas)
3. [Estructura de Directorios](#estructura-de-directorios)
4. [Configuración del Proyecto](#configuración-del-proyecto)
5. [APIs y Servicios](#apis-y-servicios)
6. [Estado Global](#estado-global)
7. [Componentes](#componentes)
8. [Páginas](#páginas)
9. [Tipos TypeScript](#tipos-typescript)
10. [Configuración de Build](#configuración-de-build)
11. [Scripts Disponibles](#scripts-disponibles)
12. [Variables de Entorno](#variables-de-entorno)
13. [Guía de Desarrollo](#guía-de-desarrollo)
14. [Troubleshooting](#troubleshooting)

---

## 🏗️ Arquitectura del Proyecto

### Patrón de Arquitectura
El proyecto sigue una arquitectura **modular** basada en **Clean Architecture** con separación clara de responsabilidades:

```
┌─────────────────────────────────────────────────────────────┐
│                    PRESENTATION LAYER                       │
│  ┌─────────────┐ ┌─────────────┐ ┌─────────────┐           │
│  │   Pages     │ │ Components  │ │   Context   │           │
│  └─────────────┘ └─────────────┘ └─────────────┘           │
└─────────────────────────────────────────────────────────────┘
┌─────────────────────────────────────────────────────────────┐
│                     DOMAIN LAYER                            │
│  ┌─────────────┐ ┌─────────────┐ ┌─────────────┐           │
│  │   Store     │ │   Types     │ │   Utils     │           │
│  └─────────────┘ └─────────────┘ └─────────────┘           │
└─────────────────────────────────────────────────────────────┘
┌─────────────────────────────────────────────────────────────┐
│                   INFRASTRUCTURE LAYER                      │
│  ┌─────────────┐ ┌─────────────┐ ┌─────────────┐           │
│  │  Services   │ │     HTTP    │ │   Config    │           │
│  └─────────────┘ └─────────────┘ └─────────────┘           │
└─────────────────────────────────────────────────────────────┘
```

### Flujo de Datos
1. **UI Components** → **Pages** → **Store/Context**
2. **Store/Context** → **Services** → **HTTP Client**
3. **HTTP Client** → **Backend API**
4. **Response** → **Services** → **Store** → **UI**

---

## 🛠️ Tecnologías Utilizadas

### Core Technologies
- **React 18** - Framework de UI
- **TypeScript 5.x** - Tipado estático
- **Vite 7.x** - Build tool y dev server
- **Tailwind CSS 3.x** - Framework de estilos

### State Management
- **Zustand** - Estado global (store/)
- **React Context** - Estado de sesión y notificaciones

### HTTP & API
- **Axios** - Cliente HTTP
- **React Router** - Navegación

### Development Tools
- **ESLint** - Linting de código
- **PostCSS** - Procesamiento de CSS
- **React Resizable Panels** - Componentes redimensionables

### Build & Deployment
- **Vite** - Bundling y optimización
- **TypeScript Compiler** - Compilación de tipos

---

## 📁 Estructura de Directorios

```
article-builder-front/
├── 📁 src/                          # Código fuente principal
│   ├── 📁 components/               # Componentes reutilizables
│   │   ├── 📁 articleBuilder/       # Componentes del constructor de artículos
│   │   ├── 📁 editor/              # Componentes del editor
│   │   └── 📁 ui/                  # Componentes de UI básicos
│   ├── 📁 context/                 # Contextos de React
│   ├── 📁 lib/                     # Utilidades y configuración
│   ├── 📁 pages/                   # Páginas de la aplicación
│   ├── 📁 services/                # Servicios de API
│   ├── 📁 store/                   # Estado global (Zustand)
│   ├── 📁 styles/                  # Estilos globales
│   └── 📁 types/                   # Tipos TypeScript
├── 📁 public/                      # Archivos públicos
├── 📁 build/                       # Build de producción
├── 📁 node_modules/                # Dependencias
├── 📄 package.json                 # Configuración de npm
├── 📄 vite.config.ts              # Configuración de Vite
├── 📄 tailwind.config.js          # Configuración de Tailwind
├── 📄 tsconfig.json               # Configuración de TypeScript
└── 📄 README.md                   # Documentación principal
```

---

## ⚙️ Configuración del Proyecto

### TypeScript Configuration
```json
// tsconfig.app.json
{
  "compilerOptions": {
    "target": "ES2022",
    "lib": ["ES2022", "DOM", "DOM.Iterable"],
    "module": "ESNext",
    "moduleResolution": "bundler",
    "jsx": "react-jsx",
    "strict": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true
  },
  "include": ["src"]
}
```

### Vite Configuration
```typescript
// vite.config.ts
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  plugins: [react()],
  server: {
    port: 5173,
    host: true
  },
  build: {
    outDir: 'dist',
    sourcemap: true
  }
})
```

### Tailwind Configuration
```javascript
// tailwind.config.js
/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      colors: {
        // Custom color palette
      }
    },
  },
  plugins: [],
}
```

---

## 🔌 APIs y Servicios

### Estructura de Servicios
Todos los servicios siguen un patrón consistente:

```typescript
// Ejemplo: src/services/websites.ts
import { http, setSessionHeaders } from '../lib/http'
import type { WebsiteEntity } from '../types/website'

export async function loadWebsites(userId: string): Promise<WebsiteEntity[]> {
  try {
    const res = await http.get('/api/websites/load', { 
      params: { user_id: userId } 
    })
    const data = res.data
    const list = Array.isArray(data) ? data : data?.websites ?? []
    return list
  } catch (error: any) {
    throw new Error(`Failed to load websites: ${error.message}`)
  }
}
```

### Servicios Disponibles

#### 1. **API Settings** (`src/services/apiSettings.ts`)
- `providersStatus(sessionId, userId)` - Estado de proveedores
- `connectProvider(sessionId, userId, apiKey, providerName)` - Conectar proveedor
- `disconnectProvider(sessionId, userId, providerName)` - Desconectar proveedor

#### 2. **Websites** (`src/services/websites.ts`)
- `loadWebsites(userId)` - Cargar sitios web
- `saveWebsite(payload)` - Guardar sitio web
- `updateWebsite(payload)` - Actualizar sitio web
- `deleteWebsite(websiteId)` - Eliminar sitio web

#### 3. **Content** (`src/services/content.ts`)
- `loadContentCardsByWebsiteId(websiteId)` - Cargar tarjetas de contenido
- `addContentCard(websiteId, card)` - Agregar tarjeta
- `updateContentCard(cardId, card)` - Actualizar tarjeta
- `deleteContentCard(cardId)` - Eliminar tarjeta
- `loadTopicsByCardId(cardId)` - Cargar temas
- `addTopic(cardId, topic)` - Agregar tema
- `updateTopic(topicId, topic)` - Actualizar tema
- `deleteTopic(topicId)` - Eliminar tema

#### 4. **Brand Voice** (`src/services/brandVoice.ts`)
- `listBrands(sessionId, userId)` - Listar marcas
- `addBrand(sessionId, userId, brand)` - Agregar marca
- `updateBrand(sessionId, userId, brandId, brand)` - Actualizar marca
- `deleteBrand(sessionId, userId, brandId)` - Eliminar marca
- `generateBrandVoice(sessionId, userId, wizardEntity)` - Generar voz de marca
- `analyzeContent(sessionId, userId, pastedText)` - Analizar contenido
- `analyzeFile(sessionId, userId, file)` - Analizar archivo
- `analyzeFileBytes(sessionId, userId, bytes, fileName)` - Analizar bytes de archivo

#### 5. **Article Builder** (`src/services/articleBuilder.ts`)
- `saveForm(sessionId, userId, model)` - Guardar formulario
- `sendDefaultData(sessionId, userId, dto)` - Enviar datos por defecto
- `fetchGeneratedArticle(sessionId, userId)` - Obtener artículo generado

#### 6. **Roadmap** (`src/services/roadmap.ts`)
- `saveRoadmap(sessionId, userId, roadmapJson)` - Guardar roadmap
- `getRoadmap(sessionId, userId)` - Obtener roadmap
- `updateRoadmap(sessionId, userId, roadmapJson)` - Actualizar roadmap

#### 7. **Analysis** (`src/services/analysis.ts`)
- `analysisKeywords()` - Análisis de keywords
- `titleRunAnalysisFirst()` - Análisis de títulos
- `runAnalysis(sessionId, userId, mainKeyword, isAutoMode)` - Análisis completo

---

## 🗃️ Estado Global

### Zustand Stores

#### 1. **Article Builder Store** (`src/store/articleBuilder.ts`)
```typescript
interface ArticleBuilderStore {
  // Estado del constructor de artículos
  articleGeneratorGeneral: ArticleGeneratorGeneral
  articleSettings: ArticleSettings
  articleMediaHub: ArticleMediaHub
  articleSEO: ArticleSEO
  articleStructure: ArticleStructure
  articleDistribution: ArticleDistribution
  
  // Acciones
  setArticleGeneratorGeneral: (data: ArticleGeneratorGeneral) => void
  setArticleSettings: (data: ArticleSettings) => void
  // ... más acciones
}
```

#### 2. **Content Store** (`src/store/content.ts`)
```typescript
interface ContentStore {
  // Estado de contenido
  websites: WebsiteEntity[]
  selectedWebsiteId: string | null
  contentCards: ContentCard[]
  topics: Topic[]
  
  // Acciones
  setWebsites: (websites: WebsiteEntity[]) => void
  setSelectedWebsiteId: (id: string) => void
  // ... más acciones
}
```

#### 3. **Recent Articles Store** (`src/store/recentArticles.ts`)
```typescript
interface RecentArticlesStore {
  articles: Article[]
  addArticle: (article: Article) => void
  removeArticle: (id: string) => void
  clearArticles: () => void
}
```

#### 4. **Websites Store** (`src/store/websites.ts`)
```typescript
interface WebsitesStore {
  websites: WebsiteEntity[]
  isLoading: boolean
  error: string | null
  selectedWebsiteId: string | null
  
  // Acciones
  load: () => Promise<void>
  add: (website: Omit<WebsiteEntity, 'id'>) => Promise<void>
  edit: (id: string, website: Partial<WebsiteEntity>) => Promise<void>
  remove: (id: string) => Promise<void>
}
```

### React Context

#### 1. **Session Context** (`src/context/SessionContext.tsx`)
```typescript
interface SessionContextType {
  sessionId: string
  userId: string
  setSession: (sessionId: string, userId: string) => void
  clearSession: () => void
}
```

#### 2. **Toast Context** (`src/context/ToastContext.tsx`)
```typescript
interface ToastContextType {
  showToast: (message: string, type: 'success' | 'error' | 'warning') => void
}
```

---

## 🧩 Componentes

### Componentes de UI Base (`src/components/ui/`)

#### 1. **Button** (`src/components/ui/button.tsx`)
```typescript
interface ButtonProps {
  variant?: 'default' | 'destructive' | 'outline' | 'secondary' | 'ghost' | 'link'
  size?: 'default' | 'sm' | 'lg' | 'icon'
  children: React.ReactNode
  onClick?: () => void
  disabled?: boolean
}
```

#### 2. **Input** (`src/components/ui/input.tsx`)
```typescript
interface InputProps {
  type?: string
  placeholder?: string
  value?: string
  onChange?: (e: React.ChangeEvent<HTMLInputElement>) => void
  disabled?: boolean
}
```

#### 3. **Modal** (`src/components/ui/modal.tsx`)
```typescript
interface ModalProps {
  isOpen: boolean
  onClose: () => void
  title?: string
  children: React.ReactNode
}
```

#### 4. **Select** (`src/components/ui/select.tsx`)
```typescript
interface SelectProps {
  value?: string
  onValueChange?: (value: string) => void
  children: React.ReactNode
}
```

### Componentes de Article Builder (`src/components/articleBuilder/`)

#### 1. **GeneratorSection** (`src/components/articleBuilder/GeneratorSection.tsx`)
- Configuración general del generador de artículos
- Selección de tipo de artículo
- Configuración de idioma

#### 2. **SettingsSection** (`src/components/articleBuilder/SettingsSection.tsx`)
- Configuración de parámetros del artículo
- Ajustes de calidad y longitud

#### 3. **StructureSection** (`src/components/articleBuilder/StructureSection.tsx`)
- Configuración de estructura del artículo
- Definición de secciones y headings

#### 4. **SEOSection** (`src/components/articleBuilder/SEOSection.tsx`)
- Configuración SEO
- Keywords y metadatos

#### 5. **MediaHubSection** (`src/components/articleBuilder/MediaHubSection.tsx`)
- Configuración de medios
- Imágenes y videos

#### 6. **DistributionSection** (`src/components/articleBuilder/DistributionSection.tsx`)
- Configuración de distribución
- Enlaces y citaciones

### Componentes de Editor (`src/components/editor/`)

#### 1. **ArticleEditor** (`src/components/editor/ArticleEditor.tsx`)
- Editor principal de artículos
- Herramientas de formato
- Vista previa en tiempo real

---

## 📄 Páginas

### 1. **HomePage** (`src/pages/HomePage.tsx`)
- Página principal
- Dashboard con estadísticas
- Acceso rápido a funcionalidades

### 2. **ArticleBuilderPage** (`src/pages/ArticleBuilderPage.tsx`)
- Constructor de artículos
- Formularios de configuración
- Generación con IA

### 3. **ArticleEditorPage** (`src/pages/ArticleEditorPage.tsx`)
- Editor de artículos
- Herramientas de formato
- Guardado y publicación

### 4. **WebsitesPage** (`src/pages/WebsitesPage.tsx`)
- Gestión de sitios web
- CRUD de websites
- Estadísticas de sitios

### 5. **ContentPage** (`src/pages/ContentPage.tsx`)
- Gestión de contenido
- Tarjetas de contenido
- Temas y keywords

### 6. **BrandVoicePage** (`src/pages/BrandVoicePage.tsx`)
- Gestión de voz de marca
- Análisis de contenido
- Generación de brand voice

### 7. **RoadmapPage** (`src/pages/RoadmapPage.tsx`)
- Planificación de contenido
- Gestión de roadmaps
- Herramientas de colaboración

### 8. **ApiSettingsPage** (`src/pages/ApiSettingsPage.tsx`)
- Configuración de APIs
- Gestión de proveedores
- Configuración de claves

---

## 📝 Tipos TypeScript

### Tipos de API (`src/types/api.ts`)
```typescript
// Brand Voice types
export interface BrandVoice {
  id: string
  brandName: string
  toneOfVoice?: string
  keyValues?: string[]
  targetAudience?: string
  brandIdentityInsights?: string
}

// Keyword Analysis types
export interface KeywordAnalysisResult {
  headings: { H2: number; H3: number }
  searchIntent: string
  keywordDifficultyPercent: number
  keywordDifficultyLabel: string
  media: { Images: number; Videos: number }
  content: { Words: number; Paragraphs: number }
}

// Roadmap types
export interface RoadmapData {
  id?: string
  title: string
  description?: string
  steps: RoadmapStep[]
}
```

### Tipos de Entidades

#### 1. **Article Types** (`src/types/article.ts`)
```typescript
export interface Article {
  id: string
  title: string
  content: string
  createdAt: string
  updatedAt: string
}
```

#### 2. **Website Types** (`src/types/website.ts`)
```typescript
export interface WebsiteEntity {
  id: string
  name: string
  url: string
  status: WebsiteStatus
  lastChecked?: string
}
```

#### 3. **Content Types** (`src/types/content.ts`)
```typescript
export interface ContentCard {
  id: string
  websiteId: string
  title: string
  url: string
  keyWordsScore: number
  status: 'pending' | 'in_progress' | 'done'
}

export interface Topic {
  id: string
  cardId: string
  keyWord?: string
  kd?: string
  categories?: string
  tags?: string
  date?: string
  score?: string
  words?: string
  schemas?: string
  status: 'pending' | 'in_progress' | 'done'
  position?: number
  volume?: number
}
```

---

## 🔧 Configuración de Build

### Vite Build Configuration
```typescript
// vite.config.ts
export default defineConfig({
  plugins: [react()],
  build: {
    outDir: 'dist',
    sourcemap: true,
    rollupOptions: {
      output: {
        manualChunks: {
          vendor: ['react', 'react-dom'],
          utils: ['axios', 'zustand']
        }
      }
    }
  }
})
```

### TypeScript Build
```json
// tsconfig.json
{
  "compilerOptions": {
    "target": "ES2022",
    "lib": ["ES2022", "DOM", "DOM.Iterable"],
    "module": "ESNext",
    "moduleResolution": "bundler",
    "jsx": "react-jsx",
    "strict": true,
    "noEmit": true
  },
  "include": ["src"],
  "references": [
    { "path": "./tsconfig.node.json" }
  ]
}
```

---

## 📜 Scripts Disponibles

### Scripts de Desarrollo
```json
{
  "scripts": {
    "dev": "vite",
    "build": "tsc -b && vite build",
    "preview": "vite preview",
    "lint": "eslint . --ext ts,tsx --report-unused-disable-directives --max-warnings 0"
  }
}
```

### Comandos Útiles
```bash
# Desarrollo
npm run dev          # Iniciar servidor de desarrollo
npm run build        # Construir para producción
npm run preview      # Vista previa de producción
npm run lint         # Linting del código

# Instalación
npm install          # Instalar dependencias
npm ci               # Instalación limpia

# TypeScript
npx tsc --noEmit     # Verificar tipos sin compilar
npx tsc --build      # Compilar TypeScript
```

---

## 🌍 Variables de Entorno

### Archivo de Configuración
```env
# .env
VITE_BASE_URL=https://backend.tamercode.com
VITE_API_TIMEOUT=30000
VITE_APP_NAME=Article Builder
```

### Uso en el Código
```typescript
// src/lib/http.ts
const BASE_URL = import.meta.env.VITE_BASE_URL ?? 'https://backend.tamercode.com'
const API_TIMEOUT = import.meta.env.VITE_API_TIMEOUT ?? 30000
```

### Variables Disponibles
- `VITE_BASE_URL` - URL base del backend
- `VITE_API_TIMEOUT` - Timeout para requests HTTP
- `VITE_APP_NAME` - Nombre de la aplicación

---

## 🚀 Guía de Desarrollo

### Configuración Inicial
1. **Clonar el repositorio**
   ```bash
   git clone <repository-url>
   cd article-builder-front
   ```

2. **Instalar dependencias**
   ```bash
   npm install
   ```

3. **Configurar variables de entorno**
   ```bash
   cp ENV_EXAMPLE.txt .env
   # Editar .env con la configuración necesaria
   ```

4. **Iniciar desarrollo**
   ```bash
   npm run dev
   ```

### Flujo de Desarrollo
1. **Crear feature branch**
   ```bash
   git checkout -b feature/nueva-funcionalidad
   ```

2. **Desarrollar funcionalidad**
   - Crear componentes en `src/components/`
   - Crear páginas en `src/pages/`
   - Agregar servicios en `src/services/`
   - Definir tipos en `src/types/`

3. **Testing**
   ```bash
   npm run lint        # Verificar código
   npm run build       # Verificar build
   ```

4. **Commit y Push**
   ```bash
   git add .
   git commit -m "feat: nueva funcionalidad"
   git push origin feature/nueva-funcionalidad
   ```

### Convenciones de Código

#### Nomenclatura
- **Componentes:** PascalCase (`ArticleBuilder.tsx`)
- **Funciones:** camelCase (`loadWebsites`)
- **Constantes:** UPPER_SNAKE_CASE (`API_BASE_URL`)
- **Tipos:** PascalCase (`WebsiteEntity`)
- **Archivos:** kebab-case (`article-builder.ts`)

#### Estructura de Componentes
```typescript
// 1. Imports
import React from 'react'
import { useStore } from '../store/store'

// 2. Types
interface ComponentProps {
  title: string
  onAction: () => void
}

// 3. Component
export default function Component({ title, onAction }: ComponentProps) {
  // 4. Hooks
  const [state, setState] = useState()
  
  // 5. Handlers
  const handleClick = () => {
    onAction()
  }
  
  // 6. Render
  return (
    <div>
      <h1>{title}</h1>
      <button onClick={handleClick}>Action</button>
    </div>
  )
}
```

#### Manejo de Errores
```typescript
// En servicios
export async function apiCall() {
  try {
    const response = await http.get('/endpoint')
    return response.data
  } catch (error: any) {
    throw new Error(`Error descriptivo: ${error.message}`)
  }
}

// En componentes
const handleApiCall = async () => {
  try {
    const data = await apiCall()
    // Manejar éxito
  } catch (error: any) {
    showToast(error.message, 'error')
  }
}
```

---

## 🔧 Troubleshooting

### Problemas Comunes

#### 1. **Errores de TypeScript**
```bash
# Verificar configuración
npx tsc --noEmit

# Limpiar cache
rm -rf node_modules/.cache
npm run build
```

#### 2. **Errores de Build**
```bash
# Limpiar build
rm -rf dist
rm -rf node_modules/.vite

# Reinstalar dependencias
rm -rf node_modules
npm install
```

#### 3. **Errores de API**
```bash
# Verificar variables de entorno
cat .env

# Verificar conectividad
curl https://backend.tamercode.com/health
```

#### 4. **Problemas de Dependencias**
```bash
# Limpiar cache de npm
npm cache clean --force

# Reinstalar dependencias
rm -rf node_modules package-lock.json
npm install
```

### Logs y Debugging

#### 1. **Logs de Desarrollo**
```typescript
// En desarrollo
console.log('Debug info:', data)

// En producción
if (import.meta.env.DEV) {
  console.log('Debug info:', data)
}
```

#### 2. **Error Boundaries**
```typescript
// src/components/ErrorBoundary.tsx
class ErrorBoundary extends React.Component {
  componentDidCatch(error: Error, errorInfo: React.ErrorInfo) {
    console.error('Error caught by boundary:', error, errorInfo)
  }
  
  render() {
    if (this.state.hasError) {
      return <div>Something went wrong.</div>
    }
    return this.props.children
  }
}
```

### Performance

#### 1. **Lazy Loading**
```typescript
// src/App.tsx
const ArticleBuilderPage = lazy(() => import('./pages/ArticleBuilderPage'))
const BrandVoicePage = lazy(() => import('./pages/BrandVoicePage'))

// En rutas
<Suspense fallback={<LoadingSpinner />}>
  <Route path="/article-builder" element={<ArticleBuilderPage />} />
</Suspense>
```

#### 2. **Memoización**
```typescript
// Componentes costosos
const ExpensiveComponent = memo(({ data }: Props) => {
  return <div>{/* Renderizado costoso */}</div>
})

// Cálculos costosos
const expensiveValue = useMemo(() => {
  return heavyCalculation(data)
}, [data])
```

---

## 📚 Recursos Adicionales

### Documentación Oficial
- [React Documentation](https://react.dev/)
- [TypeScript Handbook](https://www.typescriptlang.org/docs/)
- [Vite Documentation](https://vitejs.dev/)
- [Tailwind CSS Documentation](https://tailwindcss.com/docs)
- [Zustand Documentation](https://github.com/pmndrs/zustand)

### Herramientas de Desarrollo
- [React Developer Tools](https://chrome.google.com/webstore/detail/react-developer-tools)
- [TypeScript Playground](https://www.typescriptlang.org/play)
- [Vite Inspector](https://github.com/vitejs/vite-plugin-inspect)

### Guías de Estilo
- [React Style Guide](https://github.com/airbnb/javascript/tree/master/react)
- [TypeScript Style Guide](https://github.com/microsoft/TypeScript/wiki/Coding-guidelines)

---

## 📞 Soporte

### Contacto del Equipo
- **Desarrollo:** Equipo de desarrollo
- **Documentación:** Mantenida por el equipo técnico
- **Issues:** Reportar en GitHub Issues

### Contribución
1. Fork el proyecto
2. Crear feature branch
3. Desarrollar funcionalidad
4. Agregar tests
5. Crear Pull Request

---

*Última actualización: Diciembre 2024*
*Versión del documento: 1.0*
