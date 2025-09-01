# 🧩 Documentación de Componentes - Article Builder Front

## 📋 Índice de Componentes

### 🎨 **Componentes UI Base**
- [Button](#button)
- [Card](#card)
- [Input](#input)
- [Badge](#badge)
- [Modal](#modal)
- [Select](#select)

### 🚀 **Componentes de Brand Voice**
- [DeepWizard](#deepwizard)
- [ContentAnalysis](#contentanalysis)
- [BrandVoicePreview](#brandvoicepreview)
- [ChooseMethod](#choosemethod)
- [WizardStep](#wizardstep)

### 📝 **Componentes de Article Builder**
- [GeneratorSection](#generatorsection)
- [SettingsSection](#settingssection)
- [StructureSection](#structuresection)
- [SEOSection](#seosection)
- [MediaHubSection](#mediahubsection)

### 🔧 **Componentes de Utilidad**
- [FeatureButton](#featurebutton)
- [ArticleCard](#articlecard)
- [Navbar](#navbar)
- [Toast](#toast)

---

## 🎨 Componentes UI Base

### Button
**Archivo:** `src/components/ui/button.tsx`

Componente de botón reutilizable con múltiples variantes y tamaños.

#### Props
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

#### Variantes Disponibles
- **default**: Botón principal azul
- **destructive**: Botón rojo para acciones destructivas
- **outline**: Botón con borde
- **secondary**: Botón secundario gris
- **ghost**: Botón transparente
- **link**: Botón que parece un enlace

#### Ejemplo de Uso
```tsx
import { Button } from '../components/ui/button'

export default function Example() {
  return (
    <div className="space-y-4">
      <Button onClick={() => console.log('Clicked!')}>
        Botón Principal
      </Button>
      
      <Button variant="outline" size="sm">
        Botón Pequeño
      </Button>
      
      <Button variant="destructive" disabled>
        Eliminar
      </Button>
    </div>
  )
}
```

---

### Card
**Archivo:** `src/components/ui/card.tsx`

Componente de tarjeta para agrupar contenido relacionado.

#### Props
```typescript
interface CardProps {
  children: React.ReactNode
  className?: string
}

interface CardHeaderProps {
  children: React.ReactNode
  className?: string
}

interface CardTitleProps {
  children: React.ReactNode
  className?: string
}

interface CardContentProps {
  children: React.ReactNode
  className?: string
}
```

#### Ejemplo de Uso
```tsx
import { Card, CardHeader, CardTitle, CardContent } from '../components/ui/card'

export default function Example() {
  return (
    <Card className="w-full max-w-md">
      <CardHeader>
        <CardTitle>Título de la Tarjeta</CardTitle>
      </CardHeader>
      <CardContent>
        <p>Contenido de la tarjeta...</p>
      </CardContent>
    </Card>
  )
}
```

---

### Input
**Archivo:** `src/components/ui/input.tsx`

Campo de entrada de texto con estilos consistentes.

#### Props
```typescript
interface InputProps {
  type?: string
  placeholder?: string
  value?: string
  onChange?: (e: React.ChangeEvent<HTMLInputElement>) => void
  disabled?: boolean
  className?: string
}
```

#### Ejemplo de Uso
```tsx
import { Input } from '../components/ui/input'

export default function Example() {
  const [value, setValue] = useState('')
  
  return (
    <Input
      type="text"
      placeholder="Escribe algo..."
      value={value}
      onChange={(e) => setValue(e.target.value)}
      className="w-full"
    />
  )
}
```

---

### Badge
**Archivo:** `src/components/ui/badge.tsx`

Etiqueta pequeña para mostrar estados o categorías.

#### Props
```typescript
interface BadgeProps {
  children: React.ReactNode
  className?: string
}
```

#### Ejemplo de Uso
```tsx
import { Badge } from '../components/ui/badge'

export default function Example() {
  return (
    <div className="space-x-2">
      <Badge>Nuevo</Badge>
      <Badge className="bg-green-600">Activo</Badge>
      <Badge className="bg-red-600">Error</Badge>
    </div>
  )
}
```

---

## 🚀 Componentes de Brand Voice

### DeepWizard
**Archivo:** `src/components/brandVoice/DeepWizard.tsx`

Asistente principal para la configuración de voz de marca.

#### Props
```typescript
interface DeepWizardProps {
  sessionId: string
  userId: string
  showToast: (message: string, type: string) => void
}
```

#### Funcionalidades
- **Navegación por pasos**: Progreso visual del asistente
- **Validación de datos**: Verificación de campos requeridos
- **Persistencia de estado**: Guardado automático del progreso
- **Transiciones animadas**: Cambios suaves entre pasos

#### Ejemplo de Uso
```tsx
import DeepWizard from '../components/brandVoice/DeepWizard'

export default function BrandVoicePage() {
  const { sessionId, userId } = useSession()
  const { showToast } = useToast()
  
  return (
    <DeepWizard
      sessionId={sessionId}
      userId={userId}
      showToast={showToast}
    />
  )
}
```

---

### ContentAnalysis
**Archivo:** `src/components/brandVoice/ContentAnalysis.tsx`

Componente para analizar contenido existente y extraer patrones de voz de marca.

#### Props
```typescript
interface ContentAnalysisProps {
  sessionId: string
  userId: string
  showToast: (message: string, type: string) => void
}
```

#### Funcionalidades
- **Análisis de texto**: Procesamiento de contenido pegado
- **Análisis de archivos**: Soporte para PDF, DOC, TXT
- **Extracción de patrones**: Identificación de tono y estilo
- **Recomendaciones**: Sugerencias basadas en el análisis

#### Ejemplo de Uso
```tsx
import ContentAnalysis from '../components/brandVoice/ContentAnalysis'

export default function AnalysisPage() {
  return (
    <ContentAnalysis
      sessionId={sessionId}
      userId={userId}
      showToast={showToast}
    />
  )
}
```

---

### BrandVoicePreview
**Archivo:** `src/components/brandVoice/BrandVoicePreview.tsx`

Vista previa de la voz de marca configurada.

#### Props
```typescript
interface BrandVoicePreviewProps {
  onAddBrand: (brandData: BrandVoiceData) => Promise<boolean>
  isLoading: boolean
}
```

#### Funcionalidades
- **Vista previa en tiempo real**: Actualización automática de cambios
- **Formulario de configuración**: Campos para personalizar la voz
- **Validación de datos**: Verificación antes de guardar
- **Integración con API**: Guardado en el backend

---

### ChooseMethod
**Archivo:** `src/components/brandVoice/ChooseMethod.tsx`

Selector de método para configurar la voz de marca.

#### Props
```typescript
interface ChooseMethodProps {
  method: 'deep' | 'analysis' | null
  setMethod: (method: 'deep' | 'analysis' | null) => void
}
```

#### Métodos Disponibles
- **Deep**: Proceso completo paso a paso
- **Analysis**: Análisis de contenido existente

---

### WizardStep
**Archivo:** `src/components/brandVoice/WizardStep.tsx`

Paso individual del asistente de voz de marca.

#### Props
```typescript
interface WizardStepProps {
  step: WizardStep
  data: WizardData
  onDataChange: (data: Partial<WizardData>) => void
  onNext: () => void
  onPrevious: () => void
  isFirst: boolean
  isLast: boolean
}
```

---

## 📝 Componentes de Article Builder

### GeneratorSection
**Archivo:** `src/components/articleBuilder/GeneratorSection.tsx`

Sección para configurar parámetros generales del generador de artículos.

#### Funcionalidades
- **Tipo de artículo**: Selección de categoría
- **Idioma**: Configuración de idioma de salida
- **Longitud**: Definición de extensión del artículo
- **Tono**: Selección del tono de escritura

#### Ejemplo de Uso
```tsx
import GeneratorSection from '../components/articleBuilder/GeneratorSection'

export default function ArticleBuilderPage() {
  const [generalConfig, setGeneralConfig] = useState({
    articleType: 'blog',
    language: 'es',
    length: 'medium',
    tone: 'professional'
  })
  
  return (
    <GeneratorSection
      config={generalConfig}
      onChange={setGeneralConfig}
    />
  )
}
```

---

### SettingsSection
**Archivo:** `src/components/articleBuilder/SettingsSection.tsx`

Configuración avanzada de parámetros del artículo.

#### Funcionalidades
- **Calidad**: Nivel de detalle y complejidad
- **Creatividad**: Balance entre originalidad y precisión
- **Keywords**: Palabras clave a incluir
- **Exclusiones**: Términos a evitar

---

### StructureSection
**Archivo:** `src/components/articleBuilder/StructureSection.tsx`

Definición de la estructura del artículo.

#### Funcionalidades
- **Secciones**: Definición de headings principales
- **Subsecciones**: Organización jerárquica
- **Orden**: Secuencia de las secciones
- **Longitud por sección**: Distribución del contenido

---

### SEOSection
**Archivo:** `src/components/articleBuilder/SEOSection.tsx`

Configuración SEO del artículo.

#### Funcionalidades
- **Meta título**: Título optimizado para SEO
- **Meta descripción**: Descripción atractiva
- **Keywords**: Palabras clave principales
- **Schema markup**: Estructura de datos

---

### MediaHubSection
**Archivo:** `src/components/articleBuilder/MediaHubSection.tsx`

Gestión de medios para el artículo.

#### Funcionalidades
- **Imágenes**: Selección y configuración
- **Videos**: Integración de contenido multimedia
- **Infografías**: Creación de elementos visuales
- **Optimización**: Compresión y formatos

---

## 🔧 Componentes de Utilidad

### FeatureButton
**Archivo:** `src/components/FeatureButton.tsx`

Botón de característica con icono y descripción.

#### Props
```typescript
interface FeatureButtonProps {
  icon: React.ReactNode
  title: string
  description: string
  onClick: () => void
  variant?: 'default' | 'outline'
}
```

#### Ejemplo de Uso
```tsx
import { FeatureButton } from '../components/FeatureButton'
import { BookOpen, FileText, Settings } from 'lucide-react'

export default function HomePage() {
  return (
    <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
      <FeatureButton
        icon={<BookOpen className="w-8 h-8" />}
        title="Generar Artículo"
        description="Crea contenido único con IA"
        onClick={() => navigate('/article-builder')}
      />
      
      <FeatureButton
        icon={<FileText className="w-8 h-8" />}
        title="Editor"
        description="Edita y formatea tu contenido"
        onClick={() => navigate('/editor')}
      />
      
      <FeatureButton
        icon={<Settings className="w-8 h-8" />}
        title="Configuración"
        description="Gestiona tus preferencias"
        onClick={() => navigate('/settings')}
      />
    </div>
  )
}
```

---

### ArticleCard
**Archivo:** `src/components/ArticleCard.tsx`

Tarjeta para mostrar información de un artículo.

#### Props
```typescript
interface ArticleCardProps {
  article: Article
  onEdit?: (article: Article) => void
  onDelete?: (id: string) => void
  onView?: (article: Article) => void
}
```

#### Funcionalidades
- **Vista previa**: Extracto del contenido
- **Metadatos**: Fecha, autor, estado
- **Acciones**: Editar, eliminar, ver
- **Estados**: Borrador, publicado, archivado

---

### Navbar
**Archivo:** `src/components/Navbar.tsx`

Barra de navegación principal de la aplicación.

#### Funcionalidades
- **Logo**: Branding de la aplicación
- **Navegación**: Enlaces a páginas principales
- **Usuario**: Información de sesión
- **Notificaciones**: Sistema de alertas
- **Búsqueda**: Búsqueda global

---

### Toast
**Archivo:** `src/components/ui/toast.tsx`

Sistema de notificaciones toast.

#### Props
```typescript
interface ToastProps {
  message: string
  type: 'success' | 'error' | 'warning' | 'info'
  duration?: number
  onClose?: () => void
}
```

#### Tipos de Toast
- **success**: Verde para operaciones exitosas
- **error**: Rojo para errores
- **warning**: Amarillo para advertencias
- **info**: Azul para información

---

## 🎯 Guía de Uso de Componentes

### 📋 Mejores Prácticas

#### 1. **Composición de Componentes**
```tsx
// ✅ Bueno: Componente compuesto
<Card>
  <CardHeader>
    <CardTitle>Título</CardTitle>
  </CardHeader>
  <CardContent>
    <p>Contenido</p>
  </CardContent>
</Card>

// ❌ Malo: Componente monolítico
<div className="card">
  <div className="card-header">
    <h3 className="card-title">Título</h3>
  </div>
  <div className="card-content">
    <p>Contenido</p>
  </div>
</div>
```

#### 2. **Props Destructuring**
```tsx
// ✅ Bueno: Destructuring en parámetros
export default function Component({ title, children, className }: ComponentProps) {
  return <div className={className}>{children}</div>
}

// ❌ Malo: Acceso directo a props
export default function Component(props: ComponentProps) {
  return <div className={props.className}>{props.children}</div>
}
```

#### 3. **Manejo de Estados**
```tsx
// ✅ Bueno: Estado local cuando es necesario
const [isOpen, setIsOpen] = useState(false)

// ✅ Bueno: Estado global para datos compartidos
const { user } = useSession()

// ❌ Malo: Estado global para todo
const { isOpen, setIsOpen } = useGlobalStore()
```

### 🔧 Personalización de Componentes

#### 1. **Extensión de Props**
```tsx
interface ExtendedButtonProps extends ButtonProps {
  loading?: boolean
  icon?: React.ReactNode
}

export function ExtendedButton({ loading, icon, children, ...props }: ExtendedButtonProps) {
  return (
    <Button {...props} disabled={loading}>
      {loading && <Spinner className="w-4 h-4 mr-2" />}
      {icon && <span className="mr-2">{icon}</span>}
      {children}
    </Button>
  )
}
```

#### 2. **Composición de Variantes**
```tsx
const buttonVariants = cva(
  "inline-flex items-center justify-center rounded-md text-sm font-medium transition-colors",
  {
    variants: {
      variant: {
        default: "bg-primary text-primary-foreground hover:bg-primary/90",
        destructive: "bg-destructive text-destructive-foreground hover:bg-destructive/90",
        outline: "border border-input bg-background hover:bg-accent hover:text-accent-foreground",
        secondary: "bg-secondary text-secondary-foreground hover:bg-secondary/80",
        ghost: "hover:bg-accent hover:text-accent-foreground",
        link: "text-primary underline-offset-4 hover:underline",
      },
      size: {
        default: "h-10 px-4 py-2",
        sm: "h-9 rounded-md px-3",
        lg: "h-11 rounded-md px-8",
        icon: "h-10 w-10",
      },
    },
    defaultVariants: {
      variant: "default",
      size: "default",
    },
  }
)
```

### 🚨 Troubleshooting de Componentes

#### 1. **Componente no se renderiza**
```tsx
// ✅ Verificar imports
import { Button } from '../components/ui/button'

// ✅ Verificar props requeridas
<Button>Texto del botón</Button>

// ✅ Verificar contexto de React
const Component = () => {
  return <Button>Texto</Button>
}
```

#### 2. **Estilos no se aplican**
```tsx
// ✅ Verificar clases de Tailwind
<Button className="bg-blue-500 hover:bg-blue-600">

// ✅ Verificar CSS modules si se usan
import styles from './Component.module.css'
<Button className={styles.customButton}>

// ✅ Verificar CSS-in-JS si se usan
<Button style={{ backgroundColor: 'blue' }}>
```

#### 3. **Props no se pasan correctamente**
```tsx
// ✅ Verificar interface de props
interface ButtonProps {
  onClick?: () => void
  disabled?: boolean
}

// ✅ Verificar uso de props
<Button onClick={() => console.log('clicked')} disabled={false}>

// ✅ Verificar default props
const Button = ({ onClick = () => {}, disabled = false }: ButtonProps) => {
  return <button onClick={onClick} disabled={disabled} />
}
```

---

## 📚 Recursos Adicionales

### 🔗 Enlaces Útiles
- [React Component Patterns](https://react.dev/learn)
- [ShadCN UI Components](https://ui.shadcn.com/)
- [Tailwind CSS Utilities](https://tailwindcss.com/docs)
- [TypeScript Interfaces](https://www.typescriptlang.org/docs/)

### 📖 Guías de Referencia
- [React Best Practices](https://react.dev/learn)
- [Component Design Patterns](https://reactpatterns.com/)
- [Accessibility Guidelines](https://www.w3.org/WAI/WCAG21/quickref/)

---

**Última actualización**: Diciembre 2024
**Versión del documento**: 1.0.0
**Mantenido por**: Equipo de Desarrollo TamerCode
