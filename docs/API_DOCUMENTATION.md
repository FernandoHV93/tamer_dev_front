# Documentación de APIs - Article Builder Frontend

## 📋 Índice

1. [Configuración Base](#configuración-base)
2. [APIs de Autenticación](#apis-de-autenticación)
3. [APIs de Article Builder](#apis-de-article-builder)
4. [APIs de Websites](#apis-de-websites)
5. [APIs de Content](#apis-de-content)
6. [APIs de Brand Voice](#apis-de-brand-voice)
7. [APIs de Roadmap](#apis-de-roadmap)
8. [APIs de Analysis](#apis-de-analysis)
9. [APIs de API Settings](#apis-de-api-settings)
10. [Manejo de Errores](#manejo-de-errores)
11. [Ejemplos de Uso](#ejemplos-de-uso)

---

## ⚙️ Configuración Base

### Cliente HTTP (`src/lib/http.ts`)

**Descripción:** Cliente HTTP configurado con Axios para todas las comunicaciones con el backend.

**Configuración:**
```typescript
import axios from 'axios'

const BASE_URL = import.meta.env.VITE_BASE_URL ?? 'https://backend.tamercode.com'
const API_TIMEOUT = import.meta.env.VITE_API_TIMEOUT ?? 30000

export const http = axios.create({
  baseURL: BASE_URL,
  timeout: API_TIMEOUT,
  headers: {
    'Content-Type': 'application/json',
  },
})

// Interceptor para manejar errores globalmente
http.interceptors.response.use(
  (response) => response,
  (error) => {
    console.error('API Error:', error)
    return Promise.reject(error)
  }
)
```

**Funciones de utilidad:**
```typescript
// Configurar headers de sesión
export function setSessionHeaders(sessionId: string, userId: string) {
  http.defaults.headers.common['X-Session-ID'] = sessionId
  http.defaults.headers.common['X-User-ID'] = userId
}

// Limpiar headers de sesión
export function clearSessionHeaders() {
  delete http.defaults.headers.common['X-Session-ID']
  delete http.defaults.headers.common['X-User-ID']
}
```

---

## 🔐 APIs de Autenticación

### Gestión de Sesión

**Contexto de Sesión** (`src/context/SessionContext.tsx`)

```typescript
interface SessionContextType {
  sessionId: string
  userId: string
  setSession: (sessionId: string, userId: string) => void
  clearSession: () => void
  isAuthenticated: boolean
}
```

**Uso:**
```tsx
import { useSession } from '../context/SessionContext'

const { sessionId, userId, setSession, clearSession } = useSession()

// Configurar sesión
setSession('session-123', 'user-456')

// Limpiar sesión
clearSession()
```

---

## 🏗️ APIs de Article Builder

### Servicio Principal (`src/services/articleBuilder.ts`)

#### 1. **saveForm** - Guardar formulario de artículo

**Endpoint:** `POST /api/article-builder/save_form`

**Parámetros:**
```typescript
interface SaveFormParams {
  sessionId: string
  userId: string
  model: {
    articleGeneratorGeneral: ArticleGeneratorGeneral
    articleSettings: ArticleSettings
    articleMediaHub: ArticleMediaHub
    articleSEO: ArticleSEO
    articleStructure: ArticleStructure
    articleDistribution: ArticleDistribution
  }
}
```

**Respuesta:**
```typescript
interface SaveFormResponse {
  success: boolean
  message: string
  articleId?: string
}
```

**Uso:**
```typescript
import { saveForm } from '../services/articleBuilder'

const handleSave = async () => {
  try {
    const result = await saveForm(sessionId, userId, {
      articleGeneratorGeneral,
      articleSettings,
      articleMediaHub,
      articleSEO,
      articleStructure,
      articleDistribution
    })
    
    if (result.success) {
      showToast('Formulario guardado exitosamente', 'success')
    }
  } catch (error) {
    showToast('Error al guardar formulario', 'error')
  }
}
```

#### 2. **sendDefaultData** - Enviar datos por defecto

**Endpoint:** `POST /api/article-builder/send_default_data`

**Parámetros:**
```typescript
interface SendDefaultDataParams {
  sessionId: string
  userId: string
  dto: {
    // Datos del artículo por defecto
    title: string
    content: string
    settings: any
  }
}
```

**Uso:**
```typescript
import { sendDefaultData } from '../services/articleBuilder'

const handleSendDefault = async () => {
  try {
    await sendDefaultData(sessionId, userId, defaultArticleData)
    showToast('Datos enviados exitosamente', 'success')
  } catch (error) {
    showToast('Error al enviar datos', 'error')
  }
}
```

#### 3. **fetchGeneratedArticle** - Obtener artículo generado

**Endpoint:** `GET /api/article-builder/fetch_generated_article`

**Parámetros:**
```typescript
interface FetchGeneratedArticleParams {
  sessionId: string
  userId: string
}
```

**Respuesta:**
```typescript
interface GeneratedArticleResponse {
  id: string
  title: string
  content: string
  generatedAt: string
  status: 'generating' | 'completed' | 'failed'
}
```

**Uso:**
```typescript
import { fetchGeneratedArticle } from '../services/articleBuilder'

const handleFetchArticle = async () => {
  try {
    const article = await fetchGeneratedArticle(sessionId, userId)
    setGeneratedArticle(article)
  } catch (error) {
    showToast('Error al obtener artículo', 'error')
  }
}
```

---

## 🌐 APIs de Websites

### Servicio Principal (`src/services/websites.ts`)

#### 1. **loadWebsites** - Cargar sitios web

**Endpoint:** `GET /api/websites/load`

**Parámetros:**
```typescript
interface LoadWebsitesParams {
  user_id: string
}
```

**Respuesta:**
```typescript
interface WebsiteEntity {
  id: string
  name: string
  url: string
  status: 'active' | 'inactive' | 'pending'
  lastChecked?: string
  createdAt: string
  updatedAt: string
}
```

**Uso:**
```typescript
import { loadWebsites } from '../services/websites'

const handleLoadWebsites = async () => {
  try {
    const websites = await loadWebsites(userId)
    setWebsites(websites)
  } catch (error) {
    showToast('Error al cargar sitios web', 'error')
  }
}
```

#### 2. **saveWebsite** - Guardar sitio web

**Endpoint:** `POST /api/websites/save`

**Parámetros:**
```typescript
interface SaveWebsiteParams {
  name: string
  url: string
  user_id: string
}
```

**Uso:**
```typescript
import { saveWebsite } from '../services/websites'

const handleSaveWebsite = async (websiteData: Omit<WebsiteEntity, 'id'>) => {
  try {
    await saveWebsite(websiteData)
    showToast('Sitio web guardado exitosamente', 'success')
    // Recargar lista
    await handleLoadWebsites()
  } catch (error) {
    showToast('Error al guardar sitio web', 'error')
  }
}
```

#### 3. **updateWebsite** - Actualizar sitio web

**Endpoint:** `PUT /api/websites/update`

**Parámetros:**
```typescript
interface UpdateWebsiteParams {
  id: string
  name?: string
  url?: string
  status?: string
}
```

**Uso:**
```typescript
import { updateWebsite } from '../services/websites'

const handleUpdateWebsite = async (id: string, updates: Partial<WebsiteEntity>) => {
  try {
    await updateWebsite({ id, ...updates })
    showToast('Sitio web actualizado exitosamente', 'success')
    await handleLoadWebsites()
  } catch (error) {
    showToast('Error al actualizar sitio web', 'error')
  }
}
```

#### 4. **deleteWebsite** - Eliminar sitio web

**Endpoint:** `DELETE /api/websites/delete`

**Parámetros:**
```typescript
interface DeleteWebsiteParams {
  website_id: string
}
```

**Uso:**
```typescript
import { deleteWebsite } from '../services/websites'

const handleDeleteWebsite = async (websiteId: string) => {
  try {
    await deleteWebsite(websiteId)
    showToast('Sitio web eliminado exitosamente', 'success')
    await handleLoadWebsites()
  } catch (error) {
    showToast('Error al eliminar sitio web', 'error')
  }
}
```

---

## 📄 APIs de Content

### Servicio Principal (`src/services/content.ts`)

#### 1. **loadContentCardsByWebsiteId** - Cargar tarjetas de contenido

**Endpoint:** `GET /api/content/cards`

**Parámetros:**
```typescript
interface LoadContentCardsParams {
  website_id: string
}
```

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

**Uso:**
```typescript
import { loadContentCardsByWebsiteId } from '../services/content'

const handleLoadContentCards = async (websiteId: string) => {
  try {
    const cards = await loadContentCardsByWebsiteId(websiteId)
    setContentCards(cards)
  } catch (error) {
    showToast('Error al cargar tarjetas de contenido', 'error')
  }
}
```

#### 2. **addContentCard** - Agregar tarjeta de contenido

**Endpoint:** `POST /api/content/cards/add`

**Parámetros:**
```typescript
interface AddContentCardParams {
  website_id: string
  card: Omit<ContentCard, 'id' | 'createdAt' | 'updatedAt'>
}
```

**Uso:**
```typescript
import { addContentCard } from '../services/content'

const handleAddContentCard = async (websiteId: string, cardData: Omit<ContentCard, 'id'>) => {
  try {
    await addContentCard(websiteId, cardData)
    showToast('Tarjeta agregada exitosamente', 'success')
    await handleLoadContentCards(websiteId)
  } catch (error) {
    showToast('Error al agregar tarjeta', 'error')
  }
}
```

#### 3. **updateContentCard** - Actualizar tarjeta de contenido

**Endpoint:** `PUT /api/content/cards/update`

**Parámetros:**
```typescript
interface UpdateContentCardParams {
  card_id: string
  card: Partial<ContentCard>
}
```

**Uso:**
```typescript
import { updateContentCard } from '../services/content'

const handleUpdateContentCard = async (cardId: string, updates: Partial<ContentCard>) => {
  try {
    await updateContentCard(cardId, updates)
    showToast('Tarjeta actualizada exitosamente', 'success')
    await handleLoadContentCards(websiteId)
  } catch (error) {
    showToast('Error al actualizar tarjeta', 'error')
  }
}
```

#### 4. **deleteContentCard** - Eliminar tarjeta de contenido

**Endpoint:** `DELETE /api/content/cards/delete`

**Parámetros:**
```typescript
interface DeleteContentCardParams {
  card_id: string
}
```

**Uso:**
```typescript
import { deleteContentCard } from '../services/content'

const handleDeleteContentCard = async (cardId: string) => {
  try {
    await deleteContentCard(cardId)
    showToast('Tarjeta eliminada exitosamente', 'success')
    await handleLoadContentCards(websiteId)
  } catch (error) {
    showToast('Error al eliminar tarjeta', 'error')
  }
}
```

### APIs de Topics

#### 1. **loadTopicsByCardId** - Cargar temas por tarjeta

**Endpoint:** `GET /api/content/topics`

**Parámetros:**
```typescript
interface LoadTopicsParams {
  card_id: string
}
```

**Respuesta:**
```typescript
interface Topic {
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

**Uso:**
```typescript
import { loadTopicsByCardId } from '../services/content'

const handleLoadTopics = async (cardId: string) => {
  try {
    const topics = await loadTopicsByCardId(cardId)
    setTopics(topics)
  } catch (error) {
    showToast('Error al cargar temas', 'error')
  }
}
```

#### 2. **addTopic** - Agregar tema

**Endpoint:** `POST /api/content/topics/add`

**Parámetros:**
```typescript
interface AddTopicParams {
  card_id: string
  topic: Omit<Topic, 'id'>
}
```

**Uso:**
```typescript
import { addTopic } from '../services/content'

const handleAddTopic = async (cardId: string, topicData: Omit<Topic, 'id'>) => {
  try {
    await addTopic(cardId, topicData)
    showToast('Tema agregado exitosamente', 'success')
    await handleLoadTopics(cardId)
  } catch (error) {
    showToast('Error al agregar tema', 'error')
  }
}
```

#### 3. **updateTopic** - Actualizar tema

**Endpoint:** `PUT /api/content/topics/update`

**Parámetros:**
```typescript
interface UpdateTopicParams {
  topic_id: string
  topic: Partial<Topic>
}
```

**Uso:**
```typescript
import { updateTopic } from '../services/content'

const handleUpdateTopic = async (topicId: string, updates: Partial<Topic>) => {
  try {
    await updateTopic(topicId, updates)
    showToast('Tema actualizado exitosamente', 'success')
    await handleLoadTopics(cardId)
  } catch (error) {
    showToast('Error al actualizar tema', 'error')
  }
}
```

#### 4. **deleteTopic** - Eliminar tema

**Endpoint:** `DELETE /api/content/topics/delete`

**Parámetros:**
```typescript
interface DeleteTopicParams {
  topic_id: string
}
```

**Uso:**
```typescript
import { deleteTopic } from '../services/content'

const handleDeleteTopic = async (topicId: string) => {
  try {
    await deleteTopic(topicId)
    showToast('Tema eliminado exitosamente', 'success')
    await handleLoadTopics(cardId)
  } catch (error) {
    showToast('Error al eliminar tema', 'error')
  }
}
```

---

## 🎨 APIs de Brand Voice

### Servicio Principal (`src/services/brandVoice.ts`)

#### 1. **listBrands** - Listar marcas

**Endpoint:** `GET /api/brand-voice/brands`

**Parámetros:**
```typescript
interface ListBrandsParams {
  sessionId: string
  userId: string
}
```

**Respuesta:**
```typescript
interface BrandVoice {
  id: string
  brandName: string
  toneOfVoice?: string
  keyValues?: string[]
  targetAudience?: string
  brandIdentityInsights?: string
  createdAt?: string
  updatedAt?: string
}
```

**Uso:**
```typescript
import { listBrands } from '../services/brandVoice'

const handleLoadBrands = async () => {
  try {
    const brands = await listBrands(sessionId, userId)
    setBrands(brands)
  } catch (error) {
    showToast('Error al cargar marcas', 'error')
  }
}
```

#### 2. **addBrand** - Agregar marca

**Endpoint:** `POST /api/brand-voice/brands/add`

**Parámetros:**
```typescript
interface AddBrandParams {
  sessionId: string
  userId: string
  brand: Omit<BrandVoice, 'id' | 'createdAt' | 'updatedAt'>
}
```

**Uso:**
```typescript
import { addBrand } from '../services/brandVoice'

const handleAddBrand = async (brandData: Omit<BrandVoice, 'id'>) => {
  try {
    await addBrand(sessionId, userId, brandData)
    showToast('Marca agregada exitosamente', 'success')
    await handleLoadBrands()
  } catch (error) {
    showToast('Error al agregar marca', 'error')
  }
}
```

#### 3. **updateBrand** - Actualizar marca

**Endpoint:** `PUT /api/brand-voice/brands/update`

**Parámetros:**
```typescript
interface UpdateBrandParams {
  sessionId: string
  userId: string
  brandId: string
  brand: Partial<BrandVoice>
}
```

**Uso:**
```typescript
import { updateBrand } from '../services/brandVoice'

const handleUpdateBrand = async (brandId: string, updates: Partial<BrandVoice>) => {
  try {
    await updateBrand(sessionId, userId, brandId, updates)
    showToast('Marca actualizada exitosamente', 'success')
    await handleLoadBrands()
  } catch (error) {
    showToast('Error al actualizar marca', 'error')
  }
}
```

#### 4. **deleteBrand** - Eliminar marca

**Endpoint:** `DELETE /api/brand-voice/brands/delete`

**Parámetros:**
```typescript
interface DeleteBrandParams {
  sessionId: string
  userId: string
  brandId: string
}
```

**Uso:**
```typescript
import { deleteBrand } from '../services/brandVoice'

const handleDeleteBrand = async (brandId: string) => {
  try {
    await deleteBrand(sessionId, userId, brandId)
    showToast('Marca eliminada exitosamente', 'success')
    await handleLoadBrands()
  } catch (error) {
    showToast('Error al eliminar marca', 'error')
  }
}
```

### APIs de Análisis de Brand Voice

#### 1. **generateBrandVoice** - Generar voz de marca

**Endpoint:** `POST /api/brand-voice/generate`

**Parámetros:**
```typescript
interface GenerateBrandVoiceParams {
  sessionId: string
  userId: string
  wizardEntity: DeepAnalysisWizardEntity
}

interface DeepAnalysisWizardEntity {
  brandName: string
  industry: string
  targetAudience: string
  keyValues: string[]
  toneOfVoice: string
  competitors: string[]
  uniqueSellingPoints: string[]
}
```

**Uso:**
```typescript
import { generateBrandVoice } from '../services/brandVoice'

const handleGenerateBrandVoice = async (wizardData: DeepAnalysisWizardEntity) => {
  try {
    const result = await generateBrandVoice(sessionId, userId, wizardData)
    setBrandVoiceResult(result)
    showToast('Voz de marca generada exitosamente', 'success')
  } catch (error) {
    showToast('Error al generar voz de marca', 'error')
  }
}
```

#### 2. **analyzeContent** - Analizar contenido

**Endpoint:** `POST /api/brand-voice/analyze_content`

**Parámetros:**
```typescript
interface AnalyzeContentParams {
  sessionId: string
  userId: string
  pastedText: string
}
```

**Uso:**
```typescript
import { analyzeContent } from '../services/brandVoice'

const handleAnalyzeContent = async (content: string) => {
  try {
    const result = await analyzeContent(sessionId, userId, content)
    setAnalysisResult(result)
    showToast('Contenido analizado exitosamente', 'success')
  } catch (error) {
    showToast('Error al analizar contenido', 'error')
  }
}
```

#### 3. **analyzeFile** - Analizar archivo

**Endpoint:** `POST /api/brand-voice/analyze_file`

**Parámetros:**
```typescript
interface AnalyzeFileParams {
  sessionId: string
  userId: string
  file: File
}
```

**Uso:**
```typescript
import { analyzeFile } from '../services/brandVoice'

const handleAnalyzeFile = async (file: File) => {
  try {
    const result = await analyzeFile(sessionId, userId, file)
    setAnalysisResult(result)
    showToast('Archivo analizado exitosamente', 'success')
  } catch (error) {
    showToast('Error al analizar archivo', 'error')
  }
}
```

#### 4. **analyzeFileBytes** - Analizar bytes de archivo

**Endpoint:** `POST /api/brand-voice/analyze_file_bytes`

**Parámetros:**
```typescript
interface AnalyzeFileBytesParams {
  sessionId: string
  userId: string
  bytes: Uint8Array
  fileName: string
}
```

**Uso:**
```typescript
import { analyzeFileBytes } from '../services/brandVoice'

const handleAnalyzeFileBytes = async (bytes: Uint8Array, fileName: string) => {
  try {
    const result = await analyzeFileBytes(sessionId, userId, bytes, fileName)
    setAnalysisResult(result)
    showToast('Archivo analizado exitosamente', 'success')
  } catch (error) {
    showToast('Error al analizar archivo', 'error')
  }
}
```

---

## 🗺️ APIs de Roadmap

### Servicio Principal (`src/services/roadmap.ts`)

#### 1. **saveRoadmap** - Guardar roadmap

**Endpoint:** `POST /api/roadmap/new_roadmap`

**Parámetros:**
```typescript
interface SaveRoadmapParams {
  sessionId: string
  userId: string
  roadmapJson: RoadmapData
}

interface RoadmapData {
  id?: string
  title: string
  description?: string
  steps: RoadmapStep[]
  createdAt?: string
  updatedAt?: string
}

interface RoadmapStep {
  id?: string
  title: string
  description?: string
  order: number
  completed: boolean
  dueDate?: string
}
```

**Uso:**
```typescript
import { saveRoadmap } from '../services/roadmap'

const handleSaveRoadmap = async (roadmapData: RoadmapData) => {
  try {
    await saveRoadmap(sessionId, userId, roadmapData)
    showToast('Roadmap guardado exitosamente', 'success')
  } catch (error) {
    showToast('Error al guardar roadmap', 'error')
  }
}
```

#### 2. **getRoadmap** - Obtener roadmap

**Endpoint:** `GET /api/roadmap/get_roadmap`

**Parámetros:**
```typescript
interface GetRoadmapParams {
  sessionId: string
  userId: string
}
```

**Uso:**
```typescript
import { getRoadmap } from '../services/roadmap'

const handleGetRoadmap = async () => {
  try {
    const roadmap = await getRoadmap(sessionId, userId)
    setRoadmap(roadmap)
  } catch (error) {
    showToast('Error al obtener roadmap', 'error')
  }
}
```

#### 3. **updateRoadmap** - Actualizar roadmap

**Endpoint:** `POST /api/roadmap/new_roadmap` (mismo endpoint que save)

**Parámetros:**
```typescript
interface UpdateRoadmapParams {
  sessionId: string
  userId: string
  roadmapJson: RoadmapData
}
```

**Uso:**
```typescript
import { updateRoadmap } from '../services/roadmap'

const handleUpdateRoadmap = async (roadmapData: RoadmapData) => {
  try {
    await updateRoadmap(sessionId, userId, roadmapData)
    showToast('Roadmap actualizado exitosamente', 'success')
  } catch (error) {
    showToast('Error al actualizar roadmap', 'error')
  }
}
```

---

## 📊 APIs de Analysis

### Servicio Principal (`src/services/analysis.ts`)

#### 1. **analysisKeywords** - Análisis de keywords

**Endpoint:** `GET /api/analysis/keywords`

**Respuesta:**
```typescript
interface KeywordAnalysis {
  keywords: string[]
  difficulty: number
  volume: number
  competition: number
}
```

**Uso:**
```typescript
import { analysisKeywords } from '../services/analysis'

const handleAnalyzeKeywords = async () => {
  try {
    const analysis = await analysisKeywords()
    setKeywordAnalysis(analysis)
  } catch (error) {
    showToast('Error al analizar keywords', 'error')
  }
}
```

#### 2. **titleRunAnalysisFirst** - Análisis de títulos

**Endpoint:** `GET /api/analysis/titles`

**Respuesta:**
```typescript
interface TitleAnalysis {
  suggestions: string[]
  score: number
  readability: number
}
```

**Uso:**
```typescript
import { titleRunAnalysisFirst } from '../services/analysis'

const handleAnalyzeTitles = async () => {
  try {
    const analysis = await titleRunAnalysisFirst()
    setTitleAnalysis(analysis)
  } catch (error) {
    showToast('Error al analizar títulos', 'error')
  }
}
```

#### 3. **runAnalysis** - Análisis completo

**Endpoint:** `POST /api/analysis/run` (Mock actualmente)

**Parámetros:**
```typescript
interface RunAnalysisParams {
  sessionId: string
  userId: string
  mainKeyword: string
  isAutoMode: boolean
}
```

**Respuesta:**
```typescript
interface KeywordAnalysisResult {
  headings: {
    H2: number
    H3: number
  }
  searchIntent: string
  keywordDifficultyPercent: number
  keywordDifficultyLabel: string
  media: {
    Images: number
    Videos: number
  }
  content: {
    Words: number
    Paragraphs: number
  }
}
```

**Uso:**
```typescript
import { runAnalysis } from '../services/analysis'

const handleRunAnalysis = async (keyword: string, autoMode: boolean) => {
  try {
    const result = await runAnalysis(sessionId, userId, keyword, autoMode)
    setAnalysisResult(result)
    showToast('Análisis completado exitosamente', 'success')
  } catch (error) {
    showToast('Error al ejecutar análisis', 'error')
  }
}
```

---

## ⚙️ APIs de API Settings

### Servicio Principal (`src/services/apiSettings.ts`)

#### 1. **providersStatus** - Estado de proveedores

**Endpoint:** `GET /api/api_settings/providers_status`

**Parámetros:**
```typescript
interface ProvidersStatusParams {
  sessionId: string
  userId: string
}
```

**Respuesta:**
```typescript
interface ApiProviderStatus {
  [providerName: string]: boolean
}
```

**Uso:**
```typescript
import { providersStatus } from '../services/apiSettings'

const handleGetProvidersStatus = async () => {
  try {
    const status = await providersStatus(sessionId, userId)
    setProvidersStatus(status)
  } catch (error) {
    showToast('Error al obtener estado de proveedores', 'error')
  }
}
```

#### 2. **connectProvider** - Conectar proveedor

**Endpoint:** `POST /api/api_settings/connect_provider`

**Parámetros:**
```typescript
interface ConnectProviderParams {
  sessionId: string
  userId: string
  apiKey: string
  providerName: string
}
```

**Uso:**
```typescript
import { connectProvider } from '../services/apiSettings'

const handleConnectProvider = async (providerName: string, apiKey: string) => {
  try {
    await connectProvider(sessionId, userId, apiKey, providerName)
    showToast('Proveedor conectado exitosamente', 'success')
    await handleGetProvidersStatus()
  } catch (error) {
    showToast('Error al conectar proveedor', 'error')
  }
}
```

#### 3. **disconnectProvider** - Desconectar proveedor

**Endpoint:** `POST /api/api_settings/disconnect_provider`

**Parámetros:**
```typescript
interface DisconnectProviderParams {
  sessionId: string
  userId: string
  providerName: string
}
```

**Uso:**
```typescript
import { disconnectProvider } from '../services/apiSettings'

const handleDisconnectProvider = async (providerName: string) => {
  try {
    await disconnectProvider(sessionId, userId, providerName)
    showToast('Proveedor desconectado exitosamente', 'success')
    await handleGetProvidersStatus()
  } catch (error) {
    showToast('Error al desconectar proveedor', 'error')
  }
}
```

---

## ❌ Manejo de Errores

### Patrón de Manejo de Errores

Todos los servicios siguen un patrón consistente de manejo de errores:

```typescript
export async function apiCall(params: any) {
  try {
    const response = await http.get('/endpoint', { params })
    return response.data
  } catch (error: any) {
    // Log del error para debugging
    console.error('API Error:', error)
    
    // Lanzar error descriptivo
    throw new Error(`Error descriptivo: ${error.message}`)
  }
}
```

### Tipos de Errores

```typescript
interface ApiError {
  message: string
  code?: string
  details?: any
}

// Errores comunes
const ERROR_TYPES = {
  NETWORK_ERROR: 'Network error',
  AUTHENTICATION_ERROR: 'Authentication failed',
  VALIDATION_ERROR: 'Validation failed',
  SERVER_ERROR: 'Server error',
  NOT_FOUND: 'Resource not found'
}
```

### Manejo en Componentes

```typescript
const handleApiCall = async () => {
  setIsLoading(true)
  setError(null)
  
  try {
    const data = await apiCall(params)
    setData(data)
    showToast('Operación exitosa', 'success')
  } catch (error: any) {
    setError(error.message)
    showToast(error.message, 'error')
  } finally {
    setIsLoading(false)
  }
}
```

---

## 💡 Ejemplos de Uso

### Ejemplo Completo: Gestión de Websites

```typescript
import { useState, useEffect } from 'react'
import { useSession } from '../context/SessionContext'
import { loadWebsites, saveWebsite, updateWebsite, deleteWebsite } from '../services/websites'
import { showToast } from '../context/ToastContext'

export default function WebsitesManager() {
  const { sessionId, userId } = useSession()
  const [websites, setWebsites] = useState<WebsiteEntity[]>([])
  const [isLoading, setIsLoading] = useState(false)
  const [error, setError] = useState<string | null>(null)

  // Cargar websites al montar el componente
  useEffect(() => {
    handleLoadWebsites()
  }, [])

  const handleLoadWebsites = async () => {
    setIsLoading(true)
    setError(null)
    
    try {
      const data = await loadWebsites(userId)
      setWebsites(data)
    } catch (error: any) {
      setError(error.message)
      showToast('Error al cargar sitios web', 'error')
    } finally {
      setIsLoading(false)
    }
  }

  const handleAddWebsite = async (websiteData: Omit<WebsiteEntity, 'id'>) => {
    try {
      await saveWebsite(websiteData)
      showToast('Sitio web agregado exitosamente', 'success')
      await handleLoadWebsites() // Recargar lista
    } catch (error: any) {
      showToast('Error al agregar sitio web', 'error')
    }
  }

  const handleUpdateWebsite = async (id: string, updates: Partial<WebsiteEntity>) => {
    try {
      await updateWebsite({ id, ...updates })
      showToast('Sitio web actualizado exitosamente', 'success')
      await handleLoadWebsites() // Recargar lista
    } catch (error: any) {
      showToast('Error al actualizar sitio web', 'error')
    }
  }

  const handleDeleteWebsite = async (websiteId: string) => {
    if (!confirm('¿Estás seguro de que quieres eliminar este sitio web?')) {
      return
    }
    
    try {
      await deleteWebsite(websiteId)
      showToast('Sitio web eliminado exitosamente', 'success')
      await handleLoadWebsites() // Recargar lista
    } catch (error: any) {
      showToast('Error al eliminar sitio web', 'error')
    }
  }

  if (isLoading) {
    return <div>Cargando...</div>
  }

  if (error) {
    return <div>Error: {error}</div>
  }

  return (
    <div>
      <h1>Gestión de Sitios Web</h1>
      <button onClick={() => handleAddWebsite({ name: 'Nuevo sitio', url: 'https://example.com' })}>
        Agregar Sitio
      </button>
      
      {websites.map(website => (
        <div key={website.id}>
          <h3>{website.name}</h3>
          <p>{website.url}</p>
          <button onClick={() => handleUpdateWebsite(website.id, { name: 'Nombre actualizado' })}>
            Editar
          </button>
          <button onClick={() => handleDeleteWebsite(website.id)}>
            Eliminar
          </button>
        </div>
      ))}
    </div>
  )
}
```

### Ejemplo: Hook Personalizado para APIs

```typescript
import { useState, useCallback } from 'react'
import { useSession } from '../context/SessionContext'
import { showToast } from '../context/ToastContext'

export function useApiCall<T, P = any>(
  apiFunction: (sessionId: string, userId: string, params?: P) => Promise<T>
) {
  const { sessionId, userId } = useSession()
  const [data, setData] = useState<T | null>(null)
  const [isLoading, setIsLoading] = useState(false)
  const [error, setError] = useState<string | null>(null)

  const execute = useCallback(async (params?: P) => {
    setIsLoading(true)
    setError(null)
    
    try {
      const result = await apiFunction(sessionId, userId, params)
      setData(result)
      return result
    } catch (error: any) {
      setError(error.message)
      showToast(error.message, 'error')
      throw error
    } finally {
      setIsLoading(false)
    }
  }, [sessionId, userId, apiFunction])

  return {
    data,
    isLoading,
    error,
    execute,
    setData,
    setError
  }
}

// Uso del hook
export function useWebsites() {
  return useApiCall(loadWebsites)
}

export function useBrandVoice() {
  return useApiCall(listBrands)
}
```

---

## 📚 Recursos Adicionales

### Documentación de Axios
- [Axios Documentation](https://axios-http.com/docs/intro)
- [Axios Interceptors](https://axios-http.com/docs/interceptors)
- [Axios Error Handling](https://axios-http.com/docs/handling_errors)

### Herramientas de Testing
- [MSW (Mock Service Worker)](https://mswjs.io/) - Para mockear APIs
- [Axios Mock Adapter](https://github.com/ctimmerm/axios-mock-adapter) - Para testing

### Guías de Mejores Prácticas
- [REST API Best Practices](https://restfulapi.net/)
- [HTTP Status Codes](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status)

---

*Última actualización: Diciembre 2024*
*Versión del documento: 1.0*
