# IA Web Front

Proyecto Flutter para la edición, generación y gestión de artículos con arquitectura limpia (Clean Architecture).

## Estructura del Proyecto

```
lib/
  core/                # Utilidades, providers, rutas y constantes globales
  features/
    article_editor/    # Editor de artículos (Quill, SEO, Toolbar, Render)
    article_builder/   # Generador de artículos (formularios, lógica de IA)
    brand_voice/       # Gestión y análisis de voz de marca
    content/           # Visualización y gestión de contenido
    home/              # Pantalla principal y recientes
    roadmap/           # Roadmap de funcionalidades y feedback
    websites/          # Gestión de sitios web
    api_settings/      # Configuración de APIs externas
  main.dart            # Entry point y setup de providers
```

## Features principales

- **Editor de artículos**: Edición rica con Quill, bloques de código, citas, tablas, imágenes y SEO.
- **Generador de artículos**: Formularios inteligentes para IA, selección de tono, longitud, estructura, etc.
- **Brand Voice**: Análisis profundo y wizard para definir la voz de marca.
- **Content**: Visualización, tarjetas y gestión de artículos generados.
- **Home**: Acceso rápido a artículos recientes y navegación principal.
- **Roadmap**: Feedback y sugerencias de usuarios.
- **Websites**: Gestión de sitios y performance.
- **API Settings**: Configuración de proveedores externos de IA.

## Arquitectura

- **Clean Architecture**: Separación en `data/`, `domain/`, `presentation/` en cada feature.
- **Providers**: Uso de `Provider` para gestión de estado y dependencias.
- **Modularidad**: Cada feature es independiente y escalable.

## Cómo correr el proyecto

1. Instala dependencias:
   ```bash
   flutter pub get
   ```
2. Corre la app:
   ```bash
   flutter run -d chrome # o el dispositivo que prefieras
   ```

---

## React migration (rama `traslado-a-react`)

Se ha creado una versión React (Vite + React + TypeScript) en `react-app/` dentro de esta rama.

### Requisitos

- Node 18+ (probado con Node 22.17) y npm

### Variables de entorno

Crear `react-app/.env.local` (si no existe) con:

```
VITE_BASE_URL=https://backend.tamercode.com
```

La app usa headers `sessionID` y `userID` (se gestionan desde un contexto de sesión) y `VITE_BASE_URL` para el backend.

### Ejecutar en desarrollo

```
cd react-app
npm i
npm run dev
```

Abrir `http://localhost:5173`.

### Build y preview

```
cd react-app
npm run build
npm run preview
```

### Estructura clave React

- `src/pages/*`: páginas principales (`Home`, `Content`, `Websites`, `ArticleBuilder`, `ArticleEditor`, etc.)
- `src/store/*`: Zustand stores (artículos, content, websites, builder, etc.)
- `src/services/*`: servicios HTTP (axios) contra el backend
- `src/context/*`: `SessionProvider` (gestiona `sessionId/userId`) y `ToastProvider` (toasts)
- `src/styles/theme.css`: tema oscuro y utilitarios de UI

### Notas

- Home: generar artículo (default DTO) y abrirlo en el editor. Tarjetas responsivas.
- Editor: Quill inicializado manualmente; Copy/Download HTML; borrador en localStorage; “Save Article” simula guardado y vuelve a Home.
- Websites/Content: CRUD básico conectado a endpoints reales con headers de sesión.
- Toasts globales para feedback.

### Mock backend y arranque conjunto

- Mock backend en `mock-backend/` (Express) para probar APIs.
- Scripts en la raíz para levantar mock y web:

```
# en la raíz del repo
npm run dev   # levanta mock-backend (puerto 4000) y vite (5173)
```

Configura `react-app/.env.local` a `VITE_BASE_URL=http://localhost:4000` para usar el mock.

### Flutter web (existente)

```
./.flutter-sdk/bin/flutter build web --release
python3 -m http.server 8080 -d build/web
```
