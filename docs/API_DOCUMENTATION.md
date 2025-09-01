# 🔌 Documentación de APIs - Article Builder Front

## 📋 Índice de APIs

### 🔧 **APIs de Configuración**
- [API Settings](#api-settings)
- [Session Management](#session-management)

### 📝 **APIs de Article Builder**
- [Article Generation](#article-generation)
- [Article Management](#article-management)

### 🎨 **APIs de Brand Voice**
- [Brand Voice Management](#brand-voice-management)
- [Content Analysis](#content-analysis)

### 🌐 **APIs de Websites**
- [Website Management](#website-management)
- [Content Management](#content-management)

### 📊 **APIs de Analysis**
- [Keyword Analysis](#keyword-analysis)
- [Content Analysis](#content-analysis-apis)

### 🗺️ **APIs de Roadmap**
- [Roadmap Management](#roadmap-management)

---

## 🔧 APIs de Configuración

### API Settings
**Servicio:** `src/services/apiSettings.ts`

Gestión de proveedores de IA y configuración de APIs.

#### Endpoints Disponibles

##### 1. **Obtener Estado de Proveedores**
```typescript
providersStatus(sessionId: string, userId: string): Promise<any>
```

**Descripción:** Obtiene el estado actual de todos los proveedores de IA configurados.

**Parámetros:**
- `sessionId`: ID de sesión del usuario
- `userId`: ID único del usuario

**Respuesta:**
```typescript
interface ProviderStatus {
  openai: {
    connected: boolean
    lastUsed?: string
    usage?: number
  }
  anthropic: {
    connected: boolean
    lastUsed?: string
    usage?: number
  }
  perplexity: {
    connected: boolean
    lastUsed?: string
    usage?: number
  }
  grok: {
    connected: boolean
    lastUsed?: string
    usage?: number
  }
}
```

**Ejemplo de Uso:**
```typescript
import * as api from '../services/apiSettings'

try {
  const status = await api.providersStatus(sessionId, userId)
  console.log('Estado de proveedores:', status)
} catch (error) {
  console.error('Error al obtener estado:', error)
}
```

##### 2. **Conectar Proveedor**
```typescript
connectProvider(
  sessionId: string, 
  userId: string, 
  apiKey: string, 
  providerName: string
): Promise<any>
```

**Descripción:** Conecta un proveedor de IA usando la clave API proporcionada.

**Parámetros:**
- `sessionId`: ID de sesión del usuario
- `userId`: ID único del usuario
- `apiKey`: Clave API del proveedor
- `providerName`: Nombre del proveedor ('openai', 'anthropic', 'perplexity', 'grok')

**Respuesta:**
```typescript
interface ConnectResponse {
  success: boolean
  message: string
  provider: string
  connectedAt: string
}
```

**Ejemplo de Uso:**
```typescript
try {
  const result = await api.connectProvider(
    sessionId, 
    userId, 
    'sk-...', 
    'openai'
  )
  
  if (result.success) {
    showToast('Proveedor conectado exitosamente', 'success')
  }
} catch (error) {
  showToast('Error al conectar proveedor', 'error')
}
```

##### 3. **Desconectar Proveedor**
```typescript
disconnectProvider(
  sessionId: string, 
  userId: string, 
  providerName: string
): Promise<any>
```

**Descripción:** Desconecta un proveedor de IA previamente conectado.

**Parámetros:**
- `sessionId`: ID de sesión del usuario
- `userId`: ID único del usuario
- `providerName`: Nombre del proveedor a desconectar

**Respuesta:**
```typescript
interface DisconnectResponse {
  success: boolean
  message: string
  provider: string
  disconnectedAt: string
}
```

---

### Session Management
**Servicio:** `src/context/SessionContext.tsx`

Gestión de sesiones de usuario y autenticación.

#### Funcionalidades Disponibles

##### 1. **Obtener Sesión Actual**
```typescript
const { sessionId, userId } = useSession()
```

**Descripción:** Hook para obtener la información de sesión actual del usuario.

**Valores Retornados:**
- `sessionId`: ID de sesión activa
- `userId`: ID del usuario autenticado

**Ejemplo de Uso:**
```typescript
import { useSession } from '../context/SessionContext'

export default function MyComponent() {
  const { sessionId, userId } = useSession()
  
  useEffect(() => {
    if (sessionId && userId) {
      // Realizar operaciones autenticadas
      loadUserData()
    }
  }, [sessionId, userId])
  
  return <div>Usuario: {userId}</div>
}
```

##### 2. **Configurar Sesión**
```typescript
const { setSession } = useSession()

setSession(sessionId: string, userId: string): void
```

**Descripción:** Establece una nueva sesión de usuario.

**Ejemplo de Uso:**
```typescript
const handleLogin = async (credentials: LoginCredentials) => {
  try {
    const response = await loginAPI(credentials)
    setSession(response.sessionId, response.userId)
    navigate('/dashboard')
  } catch (error) {
    showToast('Error en el login', 'error')
  }
}
```

##### 3. **Limpiar Sesión**
```typescript
const { clearSession } = useSession()

clearSession(): void
```

**Descripción:** Cierra la sesión actual del usuario.

**Ejemplo de Uso:**
```typescript
const handleLogout = () => {
  clearSession()
  navigate('/login')
}
```

---

## 📝 APIs de Article Builder

### Article Generation
**Servicio:** `src/services/articleBuilder.ts`

Generación de artículos usando inteligencia artificial.

#### Endpoints Disponibles

##### 1. **Guardar Formulario de Artículo**
```typescript
saveForm(
  sessionId: string, 
  userId: string, 
  model: ArticleBuilderModel
): Promise<any>
```

**Descripción:** Guarda la configuración del generador de artículos.

**Parámetros:**
- `sessionId`: ID de sesión del usuario
- `userId`: ID único del usuario
- `model`: Modelo completo del generador de artículos

**Tipos de Datos:**
```typescript
interface ArticleBuilderModel {
  articleGeneratorGeneral: ArticleGeneratorGeneral
  articleSettings: ArticleSettings
  articleMediaHub: ArticleMediaHub
  articleSEO: ArticleSEO
  articleStructure: ArticleStructure
  articleDistribution: ArticleDistribution
}

interface ArticleGeneratorGeneral {
  articleType: string
  language: string
  tone: string
  length: 'short' | 'medium' | 'long'
}

interface ArticleSettings {
  quality: 'basic' | 'standard' | 'premium'
  creativity: number // 1-10
  keywords: string[]
  exclusions: string[]
}

interface ArticleSEO {
  metaTitle: string
  metaDescription: string
  focusKeyword: string
  schemaMarkup?: string
}
```

**Ejemplo de Uso:**
```typescript
import * as api from '../services/articleBuilder'

const handleSaveForm = async () => {
  try {
    const model = {
      articleGeneratorGeneral: {
        articleType: 'blog',
        language: 'es',
        tone: 'professional',
        length: 'medium'
      },
      articleSettings: {
        quality: 'standard',
        creativity: 7,
        keywords: ['marketing digital', 'estrategia'],
        exclusions: ['spam', 'clickbait']
      },
      // ... más configuraciones
    }
    
    const result = await api.saveForm(sessionId, userId, model)
    showToast('Formulario guardado exitosamente', 'success')
  } catch (error) {
    showToast('Error al guardar formulario', 'error')
  }
}
```

##### 2. **Enviar Datos por Defecto**
```typescript
sendDefaultData(
  sessionId: string, 
  userId: string, 
  dto: ArticleBuilderDTO
): Promise<any>
```

**Descripción:** Envía la configuración del artículo para generar contenido.

**Parámetros:**
- `sessionId`: ID de sesión del usuario
- `userId`: ID único del usuario
- `dto`: DTO con la configuración del artículo

**Ejemplo de Uso:**
```typescript
const handleGenerateArticle = async () => {
  try {
    const dto = {
      // Configuración del artículo
      title: 'Guía Completa de Marketing Digital',
      description: 'Estrategias efectivas para 2024',
      keywords: ['marketing', 'digital', 'estrategia'],
      // ... más configuraciones
    }
    
    const result = await api.sendDefaultData(sessionId, userId, dto)
    showToast('Artículo enviado para generación', 'success')
  } catch (error) {
    showToast('Error al enviar artículo', 'error')
  }
}
```

##### 3. **Obtener Artículo Generado**
```typescript
fetchGeneratedArticle(
  sessionId: string, 
  userId: string
): Promise<GeneratedArticle>
```

**Descripción:** Obtiene el artículo generado por IA.

**Respuesta:**
```typescript
interface GeneratedArticle {
  id: string
  title: string
  content: string
  status: 'generating' | 'completed' | 'failed'
  createdAt: string
  updatedAt: string
  metadata: {
    wordCount: number
    readingTime: number
    language: string
    tone: string
  }
}
```

---

### Article Management
**Servicio:** `src/services/articleBuilder.ts`

Gestión de artículos existentes y generados.

#### Funcionalidades Disponibles

##### 1. **Listar Artículos**
```typescript
listArticles(sessionId: string, userId: string): Promise<Article[]>
```

##### 2. **Obtener Artículo por ID**
```typescript
getArticle(sessionId: string, userId: string, articleId: string): Promise<Article>
```

##### 3. **Actualizar Artículo**
```typescript
updateArticle(
  sessionId: string, 
  userId: string, 
  articleId: string, 
  updates: Partial<Article>
): Promise<Article>
```

##### 4. **Eliminar Artículo**
```typescript
deleteArticle(sessionId: string, userId: string, articleId: string): Promise<boolean>
```

---

## 🎨 APIs de Brand Voice

### Brand Voice Management
**Servicio:** `src/services/brandVoice.ts`

Gestión de voces de marca y configuraciones de branding.

#### Endpoints Disponibles

##### 1. **Listar Marcas**
```typescript
listBrands(sessionId: string, userId: string): Promise<BrandVoice[]>
```

**Descripción:** Obtiene todas las marcas configuradas del usuario.

**Respuesta:**
```typescript
interface BrandVoice {
  id: string
  brandName: string
  toneOfVoice: string
  keyValues: string[]
  targetAudience: string
  brandIdentityInsights: string
  createdAt: string
  updatedAt: string
}
```

##### 2. **Agregar Marca**
```typescript
addBrand(
  sessionId: string, 
  userId: string, 
  brand: Omit<BrandVoice, 'id' | 'createdAt' | 'updatedAt'>
): Promise<BrandVoice>
```

**Descripción:** Crea una nueva voz de marca.

**Ejemplo de Uso:**
```typescript
const handleAddBrand = async (brandData: BrandVoiceData) => {
  try {
    const newBrand = await api.addBrand(sessionId, userId, {
      brandName: 'Mi Empresa',
      toneOfVoice: 'Profesional y amigable',
      keyValues: ['Innovación', 'Calidad', 'Confianza'],
      targetAudience: 'Profesionales de 25-45 años',
      brandIdentityInsights: 'Empresa tecnológica enfocada en soluciones...'
    })
    
    showToast('Marca agregada exitosamente', 'success')
    return newBrand
  } catch (error) {
    showToast('Error al agregar marca', 'error')
    return null
  }
}
```

##### 3. **Actualizar Marca**
```typescript
updateBrand(
  sessionId: string, 
  userId: string, 
  brandId: string, 
  updates: Partial<BrandVoice>
): Promise<BrandVoice>
```

##### 4. **Eliminar Marca**
```typescript
deleteBrand(sessionId: string, userId: string, brandId: string): Promise<boolean>
```

---

### Content Analysis
**Servicio:** `src/services/brandVoice.ts`

Análisis de contenido existente para extraer patrones de voz de marca.

#### Endpoints Disponibles

##### 1. **Analizar Texto**
```typescript
analyzeContent(
  sessionId: string, 
  userId: string, 
  pastedText: string
): Promise<ContentAnalysisResult>
```

**Descripción:** Analiza texto pegado para extraer patrones de voz de marca.

**Parámetros:**
- `sessionId`: ID de sesión del usuario
- `userId`: ID único del usuario
- `pastedText`: Texto a analizar

**Respuesta:**
```typescript
interface ContentAnalysisResult {
  tone: string
  keyValues: string[]
  targetAudience: string
  brandIdentityInsights: string
  confidence: number
  suggestions: string[]
}
```

##### 2. **Analizar Archivo**
```typescript
analyzeFile(
  sessionId: string, 
  userId: string, 
  file: File
): Promise<ContentAnalysisResult>
```

**Descripción:** Analiza un archivo (PDF, DOC, TXT) para extraer patrones.

**Tipos de Archivo Soportados:**
- PDF (.pdf)
- Documentos de Word (.doc, .docx)
- Archivos de texto (.txt)
- Archivos de Markdown (.md)

##### 3. **Analizar Bytes de Archivo**
```typescript
analyzeFileBytes(
  sessionId: string, 
  userId: string, 
  bytes: Uint8Array, 
  fileName: string
): Promise<ContentAnalysisResult>
```

**Descripción:** Analiza contenido de archivo en formato de bytes.

---

## 🌐 APIs de Websites

### Website Management
**Servicio:** `src/services/websites.ts`

Gestión de sitios web y propiedades digitales.

#### Endpoints Disponibles

##### 1. **Cargar Sitios Web**
```typescript
loadWebsites(userId: string): Promise<WebsiteEntity[]>
```

**Descripción:** Obtiene todos los sitios web del usuario.

**Respuesta:**
```typescript
interface WebsiteEntity {
  id: string
  name: string
  url: string
  status: WebsiteStatus
  lastChecked?: string
  createdAt: string
  updatedAt: string
}

type WebsiteStatus = 'active' | 'inactive' | 'pending' | 'error'
```

##### 2. **Guardar Sitio Web**
```typescript
saveWebsite(payload: SaveWebsitePayload): Promise<WebsiteEntity>
```

**Descripción:** Crea o actualiza un sitio web.

**Payload:**
```typescript
interface SaveWebsitePayload {
  id?: string // Opcional para actualización
  name: string
  url: string
  status?: WebsiteStatus
}
```

##### 3. **Actualizar Sitio Web**
```typescript
updateWebsite(payload: UpdateWebsitePayload): Promise<WebsiteEntity>
```

##### 4. **Eliminar Sitio Web**
```typescript
deleteWebsite(websiteId: string): Promise<boolean>
```

---

### Content Management
**Servicio:** `src/services/content.ts`

Gestión de contenido asociado a sitios web.

#### Endpoints Disponibles

##### 1. **Cargar Tarjetas de Contenido**
```typescript
loadContentCardsByWebsiteId(websiteId: string): Promise<ContentCard[]>
```

**Descripción:** Obtiene todas las tarjetas de contenido de un sitio web.

**Respuesta:**
```typescript
interface ContentCard {
  id: string
  websiteId: string
  title: string
  url: string
  keyWordsScore: number
  status: 'pending' | 'in_progress' | 'done'
  createdAt: string
  updatedAt: string
}
```

##### 2. **Agregar Tarjeta de Contenido**
```typescript
addContentCard(websiteId: string, card: Omit<ContentCard, 'id' | 'createdAt' | 'updatedAt'>): Promise<ContentCard>
```

##### 3. **Actualizar Tarjeta de Contenido**
```typescript
updateContentCard(cardId: string, card: Partial<ContentCard>): Promise<ContentCard>
```

##### 4. **Eliminar Tarjeta de Contenido**
```typescript
deleteContentCard(cardId: string): Promise<boolean>
```

---

## 📊 APIs de Analysis

### Keyword Analysis
**Servicio:** `src/services/analysis.ts`

Análisis de palabras clave y optimización SEO.

#### Endpoints Disponibles

##### 1. **Análisis de Keywords**
```typescript
analysisKeywords(): Promise<KeywordAnalysisResult>
```

**Descripción:** Obtiene análisis de palabras clave disponibles.

**Respuesta:**
```typescript
interface KeywordAnalysisResult {
  headings: { H2: number; H3: number }
  searchIntent: string
  keywordDifficultyPercent: number
  keywordDifficultyLabel: string
  media: { Images: number; Videos: number }
  content: { Words: number; Paragraphs: number }
}
```

##### 2. **Análisis de Títulos**
```typescript
titleRunAnalysisFirst(): Promise<TitleAnalysisResult>
```

**Descripción:** Análisis inicial de títulos para optimización.

##### 3. **Ejecutar Análisis Completo**
```typescript
runAnalysis(
  sessionId: string, 
  userId: string, 
  mainKeyword: string, 
  isAutoMode: boolean
): Promise<CompleteAnalysisResult>
```

**Descripción:** Ejecuta un análisis completo de contenido y SEO.

---

## 🗺️ APIs de Roadmap

### Roadmap Management
**Servicio:** `src/services/roadmap.ts`

Gestión de roadmaps de contenido y estrategias.

#### Endpoints Disponibles

##### 1. **Guardar Roadmap**
```typescript
saveRoadmap(
  sessionId: string, 
  userId: string, 
  roadmapJson: string
): Promise<RoadmapResponse>
```

**Descripción:** Guarda un roadmap de contenido.

**Parámetros:**
- `sessionId`: ID de sesión del usuario
- `userId`: ID único del usuario
- `roadmapJson`: JSON string del roadmap

##### 2. **Obtener Roadmap**
```typescript
getRoadmap(sessionId: string, userId: string): Promise<RoadmapData>
```

**Descripción:** Obtiene el roadmap actual del usuario.

##### 3. **Actualizar Roadmap**
```typescript
updateRoadmap(
  sessionId: string, 
  userId: string, 
  roadmapJson: string
): Promise<RoadmapResponse>
```

---

## 🔒 Manejo de Errores

### Estructura de Errores
```typescript
interface APIError {
  message: string
  code: string
  status: number
  details?: any
}
```

### Códigos de Error Comunes
- **400**: Bad Request - Datos inválidos
- **401**: Unauthorized - Sesión expirada o inválida
- **403**: Forbidden - Sin permisos para la operación
- **404**: Not Found - Recurso no encontrado
- **429**: Too Many Requests - Límite de rate limit excedido
- **500**: Internal Server Error - Error del servidor

### Manejo de Errores en Componentes
```typescript
const handleApiCall = async () => {
  try {
    const result = await api.someEndpoint(sessionId, userId)
    // Manejar éxito
    showToast('Operación exitosa', 'success')
  } catch (error: any) {
    // Manejar error
    const errorMessage = error?.message || 'Error desconocido'
    showToast(errorMessage, 'error')
    
    // Log del error para debugging
    console.error('API Error:', error)
  }
}
```

---

## 📡 Configuración de HTTP

### Cliente HTTP Base
**Archivo:** `src/lib/http.ts`

Configuración centralizada del cliente HTTP con Axios.

#### Configuración Base
```typescript
import axios from 'axios'

const http = axios.create({
  baseURL: import.meta.env.VITE_BASE_URL || 'https://backend.tamercode.com',
  timeout: 30000,
  headers: {
    'Content-Type': 'application/json'
  }
})
```

#### Interceptores
```typescript
// Interceptor de request
http.interceptors.request.use(
  (config) => {
    // Agregar headers de sesión
    const sessionId = localStorage.getItem('sessionId')
    const userId = localStorage.getItem('userId')
    
    if (sessionId && userId) {
      config.headers['X-Session-ID'] = sessionId
      config.headers['X-User-ID'] = userId
    }
    
    return config
  },
  (error) => Promise.reject(error)
)

// Interceptor de response
http.interceptors.response.use(
  (response) => response,
  (error) => {
    // Manejar errores de autenticación
    if (error.response?.status === 401) {
      // Redirigir a login
      window.location.href = '/login'
    }
    
    return Promise.reject(error)
  }
)
```

---

## 🚀 Ejemplos de Uso

### Ejemplo Completo: Generación de Artículo
```typescript
import * as api from '../services/articleBuilder'
import { useSession } from '../context/SessionContext'
import { useToast } from '../context/ToastContext'

export default function ArticleGenerator() {
  const { sessionId, userId } = useSession()
  const { showToast } = useToast()
  const [isGenerating, setIsGenerating] = useState(false)
  
  const handleGenerateArticle = async (articleConfig: ArticleConfig) => {
    setIsGenerating(true)
    
    try {
      // 1. Guardar configuración
      await api.saveForm(sessionId, userId, articleConfig)
      
      // 2. Enviar para generación
      await api.sendDefaultData(sessionId, userId, articleConfig)
      
      // 3. Obtener artículo generado
      const article = await api.fetchGeneratedArticle(sessionId, userId)
      
      showToast('Artículo generado exitosamente', 'success')
      navigate(`/editor/${article.id}`)
      
    } catch (error: any) {
      showToast(error.message || 'Error al generar artículo', 'error')
    } finally {
      setIsGenerating(false)
    }
  }
  
  return (
    <div>
      <ArticleBuilderForm onSubmit={handleGenerateArticle} />
      {isGenerating && <LoadingSpinner />}
    </div>
  )
}
```

### Ejemplo: Gestión de Brand Voice
```typescript
import * as api from '../services/brandVoice'
import { useSession } from '../context/SessionContext'

export default function BrandVoiceManager() {
  const { sessionId, userId } = useSession()
  const [brands, setBrands] = useState<BrandVoice[]>([])
  const [loading, setLoading] = useState(false)
  
  const loadBrands = async () => {
    setLoading(true)
    try {
      const brandsList = await api.listBrands(sessionId, userId)
      setBrands(brandsList)
    } catch (error) {
      console.error('Error loading brands:', error)
    } finally {
      setLoading(false)
    }
  }
  
  const addNewBrand = async (brandData: BrandVoiceData) => {
    try {
      const newBrand = await api.addBrand(sessionId, userId, brandData)
      setBrands(prev => [...prev, newBrand])
      showToast('Marca agregada exitosamente', 'success')
    } catch (error: any) {
      showToast(error.message || 'Error al agregar marca', 'error')
    }
  }
  
  useEffect(() => {
    loadBrands()
  }, [])
  
  return (
    <div>
      <BrandVoiceForm onSubmit={addNewBrand} />
      <BrandVoiceList brands={brands} onRefresh={loadBrands} />
    </div>
  )
}
```

---

## 📚 Recursos Adicionales

### 🔗 Enlaces Útiles
- [Axios Documentation](https://axios-http.com/)
- [REST API Best Practices](https://restfulapi.net/)
- [HTTP Status Codes](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status)

### 📖 Guías de Referencia
- [API Design Guidelines](https://github.com/microsoft/api-guidelines)
- [REST API Tutorial](https://restfulapi.net/rest-api-design-tutorial-with-example/)
- [Error Handling Best Practices](https://www.baeldung.com/rest-api-error-handling-best-practices)

---

**Última actualización**: Diciembre 2024
**Versión del documento**: 1.0.0
**Mantenido por**: Equipo de Desarrollo TamerCode
