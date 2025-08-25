# Documentación de Componentes - Article Builder Frontend

## 📋 Índice

1. [Componentes de UI Base](#componentes-de-ui-base)
2. [Componentes de Article Builder](#componentes-de-article-builder)
3. [Componentes de Editor](#componentes-de-editor)
4. [Componentes de Navegación](#componentes-de-navegación)
5. [Componentes de Utilidad](#componentes-de-utilidad)

---

## 🧩 Componentes de UI Base

### Button (`src/components/ui/button.tsx`)

**Descripción:** Componente de botón reutilizable con múltiples variantes y tamaños.

**Props:**
```typescript
interface ButtonProps {
  variant?: 'default' | 'destructive' | 'outline' | 'secondary' | 'ghost' | 'link'
  size?: 'default' | 'sm' | 'lg' | 'icon'
  children: React.ReactNode
  onClick?: () => void
  disabled?: boolean
  className?: string
}
```

**Uso:**
```tsx
import { Button } from '../ui/button'

<Button variant="primary" onClick={handleClick}>
  Guardar
</Button>

<Button variant="destructive" size="sm">
  Eliminar
</Button>
```

**Variantes:**
- `default` - Botón principal (azul)
- `destructive` - Botón de peligro (rojo)
- `outline` - Botón con borde
- `secondary` - Botón secundario (gris)
- `ghost` - Botón transparente
- `link` - Botón como enlace

**Tamaños:**
- `default` - Tamaño normal
- `sm` - Pequeño
- `lg` - Grande
- `icon` - Para iconos

---

### Input (`src/components/ui/input.tsx`)

**Descripción:** Componente de entrada de texto con estilos consistentes.

**Props:**
```typescript
interface InputProps {
  type?: string
  placeholder?: string
  value?: string
  onChange?: (e: React.ChangeEvent<HTMLInputElement>) => void
  disabled?: boolean
  className?: string
  required?: boolean
}
```

**Uso:**
```tsx
import { Input } from '../ui/input'

<Input 
  type="text"
  placeholder="Ingresa tu nombre"
  value={name}
  onChange={(e) => setName(e.target.value)}
/>
```

---

### Modal (`src/components/ui/modal.tsx`)

**Descripción:** Componente modal reutilizable para diálogos y overlays.

**Props:**
```typescript
interface ModalProps {
  isOpen: boolean
  onClose: () => void
  title?: string
  children: React.ReactNode
  size?: 'sm' | 'md' | 'lg' | 'xl'
}
```

**Uso:**
```tsx
import { Modal } from '../ui/modal'

<Modal isOpen={showModal} onClose={() => setShowModal(false)} title="Confirmar">
  <p>¿Estás seguro de que quieres eliminar este elemento?</p>
  <div className="flex gap-2">
    <Button onClick={handleConfirm}>Confirmar</Button>
    <Button variant="outline" onClick={() => setShowModal(false)}>Cancelar</Button>
  </div>
</Modal>
```

---

### Select (`src/components/ui/select.tsx`)

**Descripción:** Componente de selección con opciones desplegables.

**Props:**
```typescript
interface SelectProps {
  value?: string
  onValueChange?: (value: string) => void
  children: React.ReactNode
  placeholder?: string
  disabled?: boolean
}
```

**Uso:**
```tsx
import { Select, SelectTrigger, SelectValue, SelectContent, SelectItem } from '../ui/select'

<Select value={selectedValue} onValueChange={setSelectedValue}>
  <SelectTrigger>
    <SelectValue placeholder="Selecciona una opción" />
  </SelectTrigger>
  <SelectContent>
    <SelectItem value="option1">Opción 1</SelectItem>
    <SelectItem value="option2">Opción 2</SelectItem>
  </SelectContent>
</Select>
```

---

### Card (`src/components/ui/card.tsx`)

**Descripción:** Componente de tarjeta para contener contenido.

**Props:**
```typescript
interface CardProps {
  children: React.ReactNode
  className?: string
  onClick?: () => void
}
```

**Uso:**
```tsx
import { Card, CardHeader, CardContent, CardFooter } from '../ui/card'

<Card>
  <CardHeader>
    <h3>Título de la tarjeta</h3>
  </CardHeader>
  <CardContent>
    <p>Contenido de la tarjeta</p>
  </CardContent>
  <CardFooter>
    <Button>Acción</Button>
  </CardFooter>
</Card>
```

---

### Badge (`src/components/ui/badge.tsx`)

**Descripción:** Componente de etiqueta para mostrar estados o categorías.

**Props:**
```typescript
interface BadgeProps {
  children: React.ReactNode
  variant?: 'default' | 'secondary' | 'destructive' | 'outline'
  className?: string
}
```

**Uso:**
```tsx
import { Badge } from '../ui/badge'

<Badge variant="default">Nuevo</Badge>
<Badge variant="destructive">Error</Badge>
<Badge variant="outline">Borrador</Badge>
```

---

### Resizable (`src/components/ui/resizable.tsx`)

**Descripción:** Componente para paneles redimensionables.

**Props:**
```typescript
interface ResizableProps {
  children: React.ReactNode
  defaultSize?: number
  minSize?: number
  maxSize?: number
  direction?: 'horizontal' | 'vertical'
}
```

**Uso:**
```tsx
import { ResizablePanel, ResizableHandle, ResizableGroup } from '../ui/resizable'

<ResizableGroup direction="horizontal">
  <ResizablePanel defaultSize={50}>
    <div>Panel izquierdo</div>
  </ResizablePanel>
  <ResizableHandle />
  <ResizablePanel defaultSize={50}>
    <div>Panel derecho</div>
  </ResizablePanel>
</ResizableGroup>
```

---

## 🏗️ Componentes de Article Builder

### GeneratorSection (`src/components/articleBuilder/GeneratorSection.tsx`)

**Descripción:** Sección principal del generador de artículos con configuración general.

**Funcionalidades:**
- Selección de tipo de artículo
- Configuración de idioma
- Parámetros generales de generación

**Estado:**
```typescript
interface GeneratorState {
  articleType: string
  language: string
  tone: string
  length: 'short' | 'medium' | 'long'
}
```

**Uso:**
```tsx
<GeneratorSection 
  onConfigChange={handleConfigChange}
  initialConfig={defaultConfig}
/>
```

---

### SettingsSection (`src/components/articleBuilder/SettingsSection.tsx`)

**Descripción:** Configuración avanzada de parámetros del artículo.

**Funcionalidades:**
- Configuración de calidad
- Parámetros de longitud
- Ajustes de creatividad
- Configuración de estructura

**Props:**
```typescript
interface SettingsSectionProps {
  settings: ArticleSettings
  onSettingsChange: (settings: ArticleSettings) => void
}
```

**Uso:**
```tsx
<SettingsSection 
  settings={articleSettings}
  onSettingsChange={setArticleSettings}
/>
```

---

### StructureSection (`src/components/articleBuilder/StructureSection.tsx`)

**Descripción:** Configuración de la estructura del artículo.

**Funcionalidades:**
- Definición de secciones
- Configuración de headings
- Estructura de contenido
- Organización de ideas

**Props:**
```typescript
interface StructureSectionProps {
  structure: ArticleStructure
  onStructureChange: (structure: ArticleStructure) => void
}
```

**Uso:**
```tsx
<StructureSection 
  structure={articleStructure}
  onStructureChange={setArticleStructure}
/>
```

---

### SEOSection (`src/components/articleBuilder/SEOSection.tsx`)

**Descripción:** Configuración SEO del artículo.

**Funcionalidades:**
- Keywords principales
- Metadatos
- Optimización SEO
- Análisis de keywords

**Props:**
```typescript
interface SEOSectionProps {
  seoConfig: ArticleSEO
  onSEOChange: (seo: ArticleSEO) => void
}
```

**Uso:**
```tsx
<SEOSection 
  seoConfig={articleSEO}
  onSEOChange={setArticleSEO}
/>
```

---

### MediaHubSection (`src/components/articleBuilder/MediaHubSection.tsx`)

**Descripción:** Configuración de medios para el artículo.

**Funcionalidades:**
- Configuración de imágenes
- Configuración de videos
- Medios embebidos
- Optimización de medios

**Props:**
```typescript
interface MediaHubSectionProps {
  mediaConfig: ArticleMediaHub
  onMediaChange: (media: ArticleMediaHub) => void
}
```

**Uso:**
```tsx
<MediaHubSection 
  mediaConfig={articleMedia}
  onMediaChange={setArticleMedia}
/>
```

---

### DistributionSection (`src/components/articleBuilder/DistributionSection.tsx`)

**Descripción:** Configuración de distribución del artículo.

**Funcionalidades:**
- Enlaces de fuentes
- Enlaces de citación
- Enlaces internos
- Enlaces externos
- Sindicación de contenido

**Props:**
```typescript
interface DistributionSectionProps {
  distribution: ArticleDistribution
  onDistributionChange: (distribution: ArticleDistribution) => void
}
```

**Uso:**
```tsx
<DistributionSection 
  distribution={articleDistribution}
  onDistributionChange={setArticleDistribution}
/>
```

---

## ✏️ Componentes de Editor

### ArticleEditor (`src/components/editor/ArticleEditor.tsx`)

**Descripción:** Editor principal de artículos con herramientas de formato.

**Funcionalidades:**
- Editor de texto rico
- Herramientas de formato
- Vista previa en tiempo real
- Guardado automático
- Exportación de contenido

**Props:**
```typescript
interface ArticleEditorProps {
  content: string
  onContentChange: (content: string) => void
  onSave?: () => void
  onPublish?: () => void
  readOnly?: boolean
}
```

**Uso:**
```tsx
<ArticleEditor 
  content={articleContent}
  onContentChange={setArticleContent}
  onSave={handleSave}
  onPublish={handlePublish}
/>
```

**Herramientas disponibles:**
- **Formato de texto:** Negrita, cursiva, subrayado, tachado
- **Encabezados:** H1, H2, H3, H4, H5, H6
- **Alineación:** Izquierda, centro, derecha, justificado
- **Listas:** Numeradas y con viñetas
- **Enlaces:** Inserción y edición de enlaces
- **Imágenes:** Inserción de imágenes
- **Tablas:** Creación y edición de tablas
- **Código:** Bloques de código inline y de bloque

---

## 🧭 Componentes de Navegación

### Navbar (`src/components/Navbar.tsx`)

**Descripción:** Barra de navegación principal de la aplicación.

**Funcionalidades:**
- Navegación entre páginas
- Menú de usuario
- Notificaciones
- Búsqueda global

**Props:**
```typescript
interface NavbarProps {
  currentPage?: string
  onPageChange?: (page: string) => void
  user?: User
  notifications?: Notification[]
}
```

**Uso:**
```tsx
<Navbar 
  currentPage={currentPage}
  onPageChange={setCurrentPage}
  user={currentUser}
  notifications={userNotifications}
/>
```

**Elementos del navbar:**
- Logo de la aplicación
- Menú de navegación principal
- Barra de búsqueda
- Notificaciones
- Perfil de usuario
- Menú desplegable de configuración

---

### FeatureButton (`src/components/FeatureButton.tsx`)

**Descripción:** Botón de acceso rápido a funcionalidades principales.

**Props:**
```typescript
interface FeatureButtonProps {
  title: string
  description: string
  icon: React.ReactNode
  onClick: () => void
  variant?: 'default' | 'primary' | 'secondary'
  disabled?: boolean
}
```

**Uso:**
```tsx
<FeatureButton 
  title="Article Builder"
  description="Genera artículos con IA"
  icon={<ArticleIcon />}
  onClick={() => navigate('/article-builder')}
  variant="primary"
/>
```

---

### ArticleCard (`src/components/ArticleCard.tsx`)

**Descripción:** Tarjeta para mostrar información de artículos.

**Props:**
```typescript
interface ArticleCardProps {
  article: Article
  onEdit?: (article: Article) => void
  onDelete?: (article: Article) => void
  onView?: (article: Article) => void
  showActions?: boolean
}
```

**Uso:**
```tsx
<ArticleCard 
  article={article}
  onEdit={handleEdit}
  onDelete={handleDelete}
  onView={handleView}
  showActions={true}
/>
```

**Información mostrada:**
- Título del artículo
- Fecha de creación
- Estado del artículo
- Estadísticas básicas
- Acciones rápidas

---

## 🛠️ Componentes de Utilidad

### LoadingSpinner (`src/components/ui/LoadingSpinner.tsx`)

**Descripción:** Componente de carga con animación.

**Props:**
```typescript
interface LoadingSpinnerProps {
  size?: 'sm' | 'md' | 'lg'
  color?: string
  text?: string
}
```

**Uso:**
```tsx
<LoadingSpinner size="md" text="Cargando..." />
```

---

### ErrorBoundary (`src/components/ui/ErrorBoundary.tsx`)

**Descripción:** Componente para capturar errores de React.

**Props:**
```typescript
interface ErrorBoundaryProps {
  children: React.ReactNode
  fallback?: React.ComponentType<{ error: Error }>
}
```

**Uso:**
```tsx
<ErrorBoundary fallback={ErrorFallback}>
  <ComponentThatMightError />
</ErrorBoundary>
```

---

### Toast (`src/components/ui/Toast.tsx`)

**Descripción:** Componente para mostrar notificaciones temporales.

**Props:**
```typescript
interface ToastProps {
  message: string
  type: 'success' | 'error' | 'warning' | 'info'
  duration?: number
  onClose?: () => void
}
```

**Uso:**
```tsx
<Toast 
  message="Artículo guardado exitosamente"
  type="success"
  duration={3000}
/>
```

---

## 📋 Guía de Uso de Componentes

### Convenciones de Nomenclatura

1. **Componentes:** PascalCase
   ```tsx
   // ✅ Correcto
   <ArticleBuilder />
   <UserProfile />
   
   // ❌ Incorrecto
   <articleBuilder />
   <user-profile />
   ```

2. **Props:** camelCase
   ```tsx
   // ✅ Correcto
   <Button onClick={handleClick} isDisabled={true} />
   
   // ❌ Incorrecto
   <Button on_click={handleClick} is_disabled={true} />
   ```

3. **Eventos:** camelCase con prefijo "on"
   ```tsx
   // ✅ Correcto
   <Button onClick={handleClick} onChange={handleChange} />
   
   // ❌ Incorrecto
   <Button click={handleClick} change={handleChange} />
   ```

### Estructura de Componentes

```tsx
// 1. Imports
import React from 'react'
import { useStore } from '../store/store'

// 2. Types
interface ComponentProps {
  title: string
  onAction: () => void
  optional?: boolean
}

// 3. Component
export default function Component({ title, onAction, optional = false }: ComponentProps) {
  // 4. Hooks
  const [state, setState] = useState()
  const store = useStore()
  
  // 5. Handlers
  const handleClick = () => {
    onAction()
  }
  
  // 6. Effects
  useEffect(() => {
    // Side effects
  }, [])
  
  // 7. Render
  return (
    <div className="component">
      <h1>{title}</h1>
      <button onClick={handleClick}>Action</button>
    </div>
  )
}
```

### Manejo de Estados

```tsx
// Estados locales
const [isLoading, setIsLoading] = useState(false)
const [error, setError] = useState<string | null>(null)
const [data, setData] = useState<DataType | null>(null)

// Estados globales (Zustand)
const { user, setUser } = useUserStore()
const { articles, addArticle } = useArticleStore()

// Estados de formulario
const [formData, setFormData] = useState({
  title: '',
  content: '',
  category: ''
})
```

### Manejo de Eventos

```tsx
// Eventos básicos
const handleClick = () => {
  console.log('Clicked!')
}

const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
  setValue(e.target.value)
}

// Eventos con parámetros
const handleItemClick = (itemId: string) => {
  console.log('Item clicked:', itemId)
}

// Eventos asíncronos
const handleSubmit = async (e: React.FormEvent) => {
  e.preventDefault()
  setIsLoading(true)
  
  try {
    await submitData(formData)
    showToast('Success!', 'success')
  } catch (error) {
    showToast('Error!', 'error')
  } finally {
    setIsLoading(false)
  }
}
```

### Estilos y CSS

```tsx
// Tailwind CSS (recomendado)
<div className="flex items-center justify-between p-4 bg-white rounded-lg shadow-md">
  <h2 className="text-xl font-semibold text-gray-800">Título</h2>
  <button className="px-4 py-2 bg-blue-500 text-white rounded hover:bg-blue-600">
    Acción
  </button>
</div>

// CSS Modules (alternativa)
import styles from './Component.module.css'

<div className={styles.container}>
  <h2 className={styles.title}>Título</h2>
  <button className={styles.button}>Acción</button>
</div>

// Styled Components (alternativa)
import styled from 'styled-components'

const Container = styled.div`
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 1rem;
  background: white;
  border-radius: 0.5rem;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
`
```

### Testing de Componentes

```tsx
// Ejemplo de test con React Testing Library
import { render, screen, fireEvent } from '@testing-library/react'
import Component from './Component'

describe('Component', () => {
  it('renders correctly', () => {
    render(<Component title="Test" onAction={jest.fn()} />)
    expect(screen.getByText('Test')).toBeInTheDocument()
  })
  
  it('calls onAction when button is clicked', () => {
    const mockAction = jest.fn()
    render(<Component title="Test" onAction={mockAction} />)
    
    fireEvent.click(screen.getByRole('button'))
    expect(mockAction).toHaveBeenCalledTimes(1)
  })
})
```

---

## 🔧 Troubleshooting de Componentes

### Problemas Comunes

#### 1. **Componente no se renderiza**
```tsx
// Verificar imports
import React from 'react' // Necesario para JSX

// Verificar export
export default function Component() {
  return <div>Content</div>
}
```

#### 2. **Props no se pasan correctamente**
```tsx
// Verificar tipos
interface Props {
  title: string
  onAction: () => void
}

// Verificar uso
<Component title="Test" onAction={() => {}} />
```

#### 3. **Estados no se actualizan**
```tsx
// Verificar setter
const [value, setValue] = useState('')
setValue('new value') // ✅ Correcto

// Verificar dependencias en useEffect
useEffect(() => {
  // Effect
}, [dependency]) // ✅ Incluir dependencias
```

#### 4. **Eventos no funcionan**
```tsx
// Verificar binding
<button onClick={handleClick}>Click</button> // ✅ Correcto
<button onClick={() => handleClick()}>Click</button> // ✅ También correcto

// Verificar preventDefault
const handleSubmit = (e: React.FormEvent) => {
  e.preventDefault() // ✅ Para formularios
  // Lógica
}
```

### Performance

#### 1. **Memoización de componentes**
```tsx
import React, { memo } from 'react'

const ExpensiveComponent = memo(({ data }: Props) => {
  return <div>{/* Renderizado costoso */}</div>
})
```

#### 2. **Memoización de callbacks**
```tsx
import React, { useCallback } from 'react'

const Component = ({ onAction }: Props) => {
  const handleClick = useCallback(() => {
    onAction()
  }, [onAction])
  
  return <button onClick={handleClick}>Click</button>
}
```

#### 3. **Memoización de valores**
```tsx
import React, { useMemo } from 'react'

const Component = ({ data }: Props) => {
  const expensiveValue = useMemo(() => {
    return heavyCalculation(data)
  }, [data])
  
  return <div>{expensiveValue}</div>
}
```

---

## 📚 Recursos Adicionales

### Documentación de React
- [React Components](https://react.dev/learn/your-first-component)
- [React Hooks](https://react.dev/reference/react)
- [React Testing](https://testing-library.com/docs/react-testing-library/intro/)

### Herramientas de Desarrollo
- [React Developer Tools](https://chrome.google.com/webstore/detail/react-developer-tools)
- [Storybook](https://storybook.js.org/) - Para documentar componentes
- [React Hook Form](https://react-hook-form.com/) - Para formularios

### Guías de Estilo
- [React Style Guide](https://github.com/airbnb/javascript/tree/master/react)
- [Component Design Patterns](https://reactpatterns.com/)

---

*Última actualización: Diciembre 2024*
*Versión del documento: 1.0*
