# Article Builder Frontend

Una aplicación web moderna para la generación y gestión de artículos con análisis de contenido, brand voice y optimización SEO.

## 🚀 Tecnologías

- **React 18** - Framework de UI
- **TypeScript** - Tipado estático
- **Vite** - Build tool y dev server
- **Tailwind CSS** - Framework de estilos
- **Axios** - Cliente HTTP
- **React Router** - Navegación
- **Context API** - Estado global

## 📋 Funcionalidades

### ✅ APIs Implementadas

- **API Settings** - Gestión de proveedores de IA
- **Websites** - CRUD completo de sitios web
- **Content Cards** - Gestión de tarjetas de contenido
- **Topics** - Gestión de temas y keywords
- **Brand Voice** - Análisis y generación de voz de marca
- **Article Builder** - Generación de artículos con IA
- **Roadmap** - Planificación de contenido
- **Analysis** - Análisis de keywords y SEO

### 🔧 Características Técnicas

- Manejo robusto de errores
- Headers de sesión consistentes
- Tipos TypeScript completos
- Estructura de datos consistente
- URLs y endpoints correctos

## 🛠️ Instalación

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
# Editar .env con la URL del backend
```

4. **Ejecutar en desarrollo**
```bash
npm run dev
```

5. **Construir para producción**
```bash
npm run build
```

## 📁 Estructura del Proyecto

```
src/
├── components/          # Componentes reutilizables
│   ├── articleBuilder/  # Componentes del constructor de artículos
│   ├── editor/         # Componentes del editor
│   ├── ui/             # Componentes de UI básicos
│   └── ...
├── context/            # Contextos de React
│   ├── SessionContext.tsx
│   └── ToastContext.tsx
├── lib/                # Utilidades y configuración
│   ├── http.ts         # Cliente HTTP configurado
│   └── ...
├── pages/              # Páginas de la aplicación
├── services/           # Servicios de API
│   ├── apiSettings.ts
│   ├── articleBuilder.ts
│   ├── brandVoice.ts
│   ├── content.ts
│   ├── websites.ts
│   └── ...
├── store/              # Estado global (Zustand)
├── styles/             # Estilos globales
└── types/              # Tipos TypeScript
    └── api.ts          # Tipos de API centralizados
```

## 🔌 APIs y Endpoints

Todas las APIs están documentadas en `API_IMPLEMENTATION.md` con:
- Endpoints completos
- Parámetros requeridos
- Ejemplos de uso
- Manejo de errores

## 🚀 Scripts Disponibles

- `npm run dev` - Servidor de desarrollo
- `npm run build` - Construcción para producción
- `npm run preview` - Vista previa de producción
- `npm run lint` - Linting del código

## 📝 Variables de Entorno

```env
VITE_BASE_URL=https://backend.tamercode.com
```

## 🤝 Contribución

1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## 📄 Licencia

Este proyecto está bajo la Licencia MIT - ver el archivo [LICENSE](LICENSE) para detalles.

## 🆘 Soporte

Para soporte técnico o preguntas, contacta al equipo de desarrollo.
