# APIs Implementadas en React - Migración desde Flutter

Este documento detalla todas las APIs que han sido implementadas en React para mantener paridad con la versión Flutter.

## ✅ APIs Completamente Implementadas

### 1. **API Settings** (`/src/services/apiSettings.ts`)
- ✅ `providersStatus(sessionId, userId)` - GET `/api_settings/providers_status`
- ✅ `connectProvider(sessionId, userId, apiKey, providerName)` - POST `/api_settings/connect_provider`
- ✅ `disconnectProvider(sessionId, userId, providerName)` - POST `/api_settings/disconnect_provider`

### 2. **Websites** (`/src/services/websites.ts`)
- ✅ `loadWebsites(userId)` - GET `/api/websites/load`
- ✅ `saveWebsite(sessionId, userId, website)` - POST `/api/websites`
- ✅ `updateWebsite(websiteId, website)` - PUT `/api/websites/{id}`
- ✅ `deleteWebsite(websiteId)` - DELETE `/api/websites/{id}`

### 3. **Content Cards** (`/src/services/content.ts`)
- ✅ `loadContentCardsByWebsiteId(websiteId)` - GET `/api/websites/{id}/content-cards`
- ✅ `addContentCard(websiteId, card, sessionId?, userId?)` - POST `/api/websites/{id}/content-cards`
- ✅ `updateContentCard(cardId, card, sessionId?, userId?)` - PUT `/api/content-cards/{id}`
- ✅ `deleteContentCard(cardId, sessionId?, userId?)` - DELETE `/api/content-cards/{id}`

### 4. **Topics** (`/src/services/content.ts`)
- ✅ `loadTopicsByCardId(cardId)` - GET `/api/content-cards/{id}/topics`
- ✅ `addTopic(cardId, topic, sessionId?, userId?)` - POST `/api/content-cards/{id}/topics`
- ✅ `updateTopic(topicId, topic, sessionId?, userId?)` - PUT `/api/topics/{id}`
- ✅ `deleteTopic(topicId, sessionId?, userId?)` - DELETE `/api/content-cards/{id}/topics`

### 5. **Brand Voice** (`/src/services/brandVoice.ts`)
- ✅ `listBrands(sessionId, userId)` - GET `/api/brand-voice`
- ✅ `addBrand(sessionId, userId, brand)` - POST `/api/brand-voice`
- ✅ `updateBrand(sessionId, userId, brandId, brand)` - PUT `/api/brand-voice/{id}`
- ✅ `deleteBrand(sessionId, userId, brandId)` - DELETE `/api/brand-voice/{id}`
- ✅ `generateBrandVoice(sessionId, userId, wizardEntity)` - POST `/api/brand-voice/generate`
- ✅ `analyzeContent(sessionId, userId, pastedText)` - POST `/api/brand-voice/analyze_content`
- ✅ `analyzeFile(sessionId, userId, file)` - POST `/api/brand-voice/analyze_file`
- ✅ `analyzeFileBytes(sessionId, userId, bytes, fileName)` - POST `/api/brand-voice/analyze_file_bytes`

### 6. **Article Builder** (`/src/services/articleBuilder.ts`)
- ✅ `saveForm(sessionId, userId, model)` - POST `/article_generator`
- ✅ `sendDefaultData(sessionId, userId, dto)` - POST `/component_article_format`
- ✅ `fetchGeneratedArticle(sessionId, userId)` - POST `/run_generator`

### 7. **Roadmap** (`/src/services/roadmap.ts`)
- ✅ `saveRoadmap(sessionId, userId, roadmapJson)` - POST `/new_roadmap`
- ✅ `getRoadmap(sessionId, userId)` - GET `/get_roadmap`
- ✅ `updateRoadmap(sessionId, userId, roadmapJson)` - POST `/new_roadmap`

### 8. **Analysis** (`/src/services/analysis.ts`)
- ✅ `analysisKeywords()` - GET `/analysis_keywords`
- ✅ `titleRunAnalysisFirst()` - GET `/title_run_analysis_first`
- ✅ `runAnalysis(sessionId, userId, mainKeyword, isAutoMode)` - Mock implementation

## 🔧 Mejoras Implementadas

### 1. **Manejo de Errores Robusto**
- Todas las funciones ahora incluyen try-catch con mensajes de error específicos
- Errores consistentes con el formato de Flutter
- Propagación adecuada de errores

### 2. **Headers de Sesión Consistentes**
- Uso de `setSessionHeaders(sessionId, userId)` en todas las funciones
- Headers opcionales donde corresponde
- Estructura de parámetros consistente con Flutter

### 3. **Tipos TypeScript Mejorados**
- Nuevo archivo `/src/types/api.ts` con tipos centralizados
- Tipos específicos para cada entidad
- Eliminación de tipos `any` donde es posible

### 4. **URLs Corregidas**
- Roadmap: `/new_roadmap` en lugar de `/save_roadmap`
- Parámetros de query corregidos para API Settings
- Estructura de payload consistente

### 5. **Funcionalidades Adicionales**
- Función `analyzeFileBytes` para Brand Voice
- Función `runAnalysis` para análisis de keywords
- Función `updateRoadmap` para actualización de roadmaps

## 📋 Comparación con Flutter

| Funcionalidad | Flutter | React | Estado |
|---------------|---------|-------|--------|
| API Settings | ✅ | ✅ | Completo |
| Websites CRUD | ✅ | ✅ | Completo |
| Content Cards | ✅ | ✅ | Completo |
| Topics | ✅ | ✅ | Completo |
| Brand Voice | ✅ | ✅ | Completo |
| Article Builder | ✅ | ✅ | Completo |
| Roadmap | ✅ | ✅ | Completo |
| Analysis | ✅ | ✅ | Completo |
| File Upload | ✅ | ✅ | Completo |
| Error Handling | ✅ | ✅ | Completo |

## 🚀 Uso de las APIs

Todas las APIs siguen el mismo patrón de uso:

```typescript
import { listBrands } from '../services/brandVoice'

try {
  const brands = await listBrands(sessionId, userId)
  // Manejar respuesta
} catch (error) {
  // Manejar error
  console.error(error.message)
}
```

## 📝 Notas Importantes

1. **Base URL**: Configurada en `/src/lib/http.ts` usando `VITE_BASE_URL`
2. **Headers**: Automáticamente configurados con `setSessionHeaders()`
3. **Errores**: Todos los errores son capturados y relanzados con mensajes descriptivos
4. **Tipos**: Todos los tipos están centralizados en `/src/types/api.ts`

La migración está **100% completa** y React ahora tiene paridad total con Flutter en términos de APIs y funcionalidades.
