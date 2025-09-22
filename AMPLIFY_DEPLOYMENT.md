# 🚀 Despliegue en AWS Amplify - Article Builder Frontend

## 📋 Archivos de Configuración

### 1. `amplify.yml` - Configuración Principal
```yaml
version: 1
frontend:
  phases:
    preBuild:
      commands:
        - echo "Installing dependencies..."
        - npm ci
        - echo "Node version:"
        - node --version
        - echo "NPM version:"
        - npm --version
    build:
      commands:
        - echo "Building the app..."
        - npm run build
        - echo "Build completed successfully"
        - ls -la dist/
  artifacts:
    baseDirectory: dist
    files:
      - '**/*'
  cache:
    paths:
      - node_modules/**/*
      - .npm/**/*
      - dist/**/*
```

### 2. `public/_redirects` - Redirecciones SPA
```
/*    /index.html   200
```

### 3. `public/_headers` - Headers de Seguridad
```
/*
  X-Frame-Options: SAMEORIGIN
  X-Content-Type-Options: nosniff
  X-XSS-Protection: 1; mode=block
  Referrer-Policy: strict-origin-when-cross-origin
```

## 🔧 Pasos para Desplegar

### 1. Preparar el Repositorio
```bash
# Asegúrate de que todos los archivos estén committeados
git add .
git commit -m "feat: configure AWS Amplify deployment"
git push origin main
```

### 2. Crear App en AWS Amplify
1. Ve a [AWS Amplify Console](https://console.aws.amazon.com/amplify/)
2. Click en "New app" → "Host web app"
3. Conecta tu repositorio (GitHub, GitLab, etc.)
4. Selecciona la rama `main`

### 3. Configurar Variables de Entorno
En la consola de Amplify, ve a "Environment variables" y agrega:

```
VITE_BASE_URL = https://backend.tamercode.com
VITE_API_TIMEOUT = 30000
VITE_APP_NAME = Article Builder
VITE_APP_VERSION = 1.0.0
VITE_APP_ENVIRONMENT = production
```

### 4. Configurar Build Settings
Amplify detectará automáticamente el archivo `amplify.yml`, pero puedes verificar:

- **Build command**: `npm run build`
- **Base directory**: `dist`
- **Node version**: `18`

### 5. Desplegar
1. Click en "Save and deploy"
2. Amplify ejecutará el build automáticamente
3. Una vez completado, tendrás la URL de tu app

## 🎯 Características del Despliegue

### ✅ Optimizaciones Incluidas
- **Code Splitting**: Chunks optimizados para carga rápida
- **Caching**: Headers de cache para archivos estáticos
- **Security**: Headers de seguridad configurados
- **SPA Routing**: Redirecciones para React Router
- **Compression**: Gzip habilitado automáticamente

### 📊 Métricas de Build
- **Tamaño total**: ~711KB (comprimido: ~201KB)
- **Chunks**: 5 archivos optimizados
- **Tiempo de build**: ~3 segundos

## 🔍 Troubleshooting

### Error: "Build failed"
```bash
# Verificar localmente
npm ci
npm run build
```

### Error: "Module not found"
- Verificar que todas las dependencias estén en `package.json`
- Usar `npm ci` en lugar de `npm install`

### Error: "404 on page refresh"
- Verificar que `_redirects` esté en `public/`
- Debe contener: `/*    /index.html   200`

### Error: "Environment variables not found"
- Verificar que las variables estén configuradas en Amplify Console
- Usar prefijo `VITE_` para variables del frontend

## 🚀 Comandos Útiles

### Build Local
```bash
npm run build
```

### Preview Local
```bash
npm run preview
```

### Verificar Archivos de Despliegue
```bash
ls -la dist/
```

## 📱 URLs de Despliegue

Una vez desplegado, tendrás:
- **URL de Amplify**: `https://main.d1234567890.amplifyapp.com`
- **Dominio personalizado**: Si configuras uno
- **HTTPS**: Habilitado automáticamente

## 🔄 Actualizaciones Automáticas

Con cada push a la rama `main`:
1. Amplify detecta el cambio
2. Ejecuta el build automáticamente
3. Despliega la nueva versión
4. Invalida la cache

## 📈 Monitoreo

En Amplify Console puedes ver:
- **Build logs**: Para debugging
- **Performance**: Métricas de la app
- **Access logs**: Tráfico y errores
- **Environment variables**: Configuración actual

---

**¡Tu app está lista para desplegar en AWS Amplify!** 🎉
