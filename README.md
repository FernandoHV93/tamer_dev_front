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

## Buenas prácticas

- Elimina archivos `.DS_Store` antes de hacer commit.
- No dejes prints ni debugPrints en producción.
- Usa `dart format .` para mantener el código limpio.
- Documenta nuevos features en este README.

## Contacto

Para dudas o feedback, contacta a `mariobernalperez` o abre un issue en el repo.
