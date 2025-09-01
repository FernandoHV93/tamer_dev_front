# 🌐 Guía de Despliegue en AWS - Article Builder Front

## 📋 Checklist de Despliegue

### ✅ **Configuración del Proyecto**
- [x] Variables de entorno configuradas
- [x] Build de producción exitoso
- [x] Optimizaciones de Vite habilitadas
- [x] Compresión de assets configurada
- [x] Lazy loading implementado

### ⚠️ **Pendiente de Resolver**
- [ ] Errores de TypeScript corregidos
- [ ] Tests unitarios implementados
- [ ] Linting configurado correctamente

### 🔧 **Configuración de AWS**
- [ ] Bucket S3 configurado para hosting estático
- [ ] CloudFront distribution configurada
- [ ] Certificado SSL configurado
- [ ] Políticas de CORS configuradas
- [ ] Redirecciones configuradas

### 🛡️ **Seguridad**
- [ ] Headers de seguridad configurados
- [ ] CSP (Content Security Policy) implementado
- [ ] HSTS habilitado
- [ ] Rate limiting configurado

---

## 🚀 Pasos de Despliegue

### 1. **Preparar Build de Producción**

#### Corregir Errores de TypeScript
```bash
# Ejecutar linting para identificar problemas
npm run lint

# Corregir errores de tipos
npm run type-check

# Construir la aplicación
npm run build
```

#### Verificar Build
```bash
# Vista previa de la build
npm run preview

# Verificar estructura de archivos
ls -la dist/
```

### 2. **Configurar AWS S3**

#### Crear Bucket
```bash
# Crear bucket S3
aws s3 mb s3://article-builder-front

# Configurar bucket para hosting estático
aws s3 website s3://article-builder-front \
  --index-document index.html \
  --error-document index.html
```

#### Configurar Política de Bucket
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::article-builder-front/*"
    }
  ]
}
```

#### Configurar CORS
```json
[
  {
    "AllowedHeaders": ["*"],
    "AllowedMethods": ["GET"],
    "AllowedOrigins": ["*"],
    "ExposeHeaders": []
  }
]
```

### 3. **Configurar CloudFront**

#### Crear Distribución
```bash
# Crear distribución CloudFront
aws cloudfront create-distribution \
  --origin-domain-name article-builder-front.s3.amazonaws.com \
  --default-root-object index.html
```

#### Configuración Recomendada
```json
{
  "Origins": {
    "S3Origin": {
      "DomainName": "article-builder-front.s3.amazonaws.com",
      "OriginPath": "",
      "S3OriginConfig": {
        "OriginAccessIdentity": ""
      }
    }
  },
  "DefaultCacheBehavior": {
    "TargetOriginId": "S3Origin",
    "ViewerProtocolPolicy": "redirect-to-https",
    "Compress": true,
    "CachePolicyId": "4135ea2d-6df8-44a3-9df3-4b5a84be39ad",
    "OriginRequestPolicyId": "88a5eaf4-2fd4-4709-b370-b4c650ea3fcf"
  },
  "Enabled": true,
  "Comment": "Article Builder Front Distribution",
  "PriceClass": "PriceClass_100"
}
```

### 4. **Configurar SSL/TLS**

#### Certificado ACM
```bash
# Solicitar certificado SSL
aws acm request-certificate \
  --domain-name yourdomain.com \
  --subject-alternative-names "*.yourdomain.com" \
  --validation-method DNS
```

#### Validar Certificado
- Agregar registros CNAME en Route 53
- Esperar validación (puede tomar hasta 24 horas)
- Verificar estado en consola de ACM

### 5. **Desplegar Contenido**

#### Sincronizar con S3
```bash
# Sincronizar build con S3
aws s3 sync dist/ s3://article-builder-front --delete

# Verificar sincronización
aws s3 ls s3://article-builder-front --recursive
```

#### Invalidar Caché de CloudFront
```bash
# Invalidar caché
aws cloudfront create-invalidation \
  --distribution-id <DISTRIBUTION_ID> \
  --paths "/*"
```

---

## 🔧 Configuración de Seguridad

### 🛡️ Headers de Seguridad

#### Configuración en CloudFront
```json
{
  "CustomHeaders": [
    {
      "HeaderName": "X-Frame-Options",
      "HeaderValue": "DENY"
    },
    {
      "HeaderName": "X-Content-Type-Options",
      "HeaderValue": "nosniff"
    },
    {
      "HeaderName": "Referrer-Policy",
      "HeaderValue": "strict-origin-when-cross-origin"
    },
    {
      "HeaderName": "Permissions-Policy",
      "HeaderValue": "camera=(), microphone=(), geolocation=()"
    }
  ]
}
```

#### Content Security Policy
```json
{
  "HeaderName": "Content-Security-Policy",
  "HeaderValue": "default-src 'self'; script-src 'self' 'unsafe-inline' 'unsafe-eval'; style-src 'self' 'unsafe-inline'; img-src 'self' data: https:; font-src 'self'; connect-src 'self' https://api.yourdomain.com; frame-ancestors 'none';"
}
```

### 🔐 Configuración de CORS

#### Política de CORS para APIs
```json
{
  "AllowedOrigins": [
    "https://yourdomain.com",
    "https://www.yourdomain.com"
  ],
  "AllowedMethods": ["GET", "POST", "PUT", "DELETE", "OPTIONS"],
  "AllowedHeaders": [
    "Content-Type",
    "Authorization",
    "X-Requested-With"
  ],
  "ExposeHeaders": ["X-Total-Count"],
  "MaxAgeSeconds": 86400
}
```

---

## 📊 Monitoreo y Logging

### 📈 Métricas de CloudWatch

#### Métricas Recomendadas
- **Requests**: Número total de requests
- **Bytes Downloaded**: Bytes transferidos
- **4xx Errors**: Errores de cliente
- **5xx Errors**: Errores de servidor
- **Cache Hit Rate**: Tasa de aciertos en caché

#### Configuración de Alarmas
```bash
# Alarma para errores 5xx
aws cloudwatch put-metric-alarm \
  --alarm-name "ArticleBuilder-5xxErrors" \
  --alarm-description "Alarma para errores 5xx" \
  --metric-name "5xxError" \
  --namespace "AWS/CloudFront" \
  --statistic "Sum" \
  --period 300 \
  --evaluation-periods 2 \
  --threshold 10 \
  --comparison-operator "GreaterThanThreshold"
```

### 🔍 Logging de Acceso

#### Habilitar Logs de S3
```bash
# Configurar logging de S3
aws s3api put-bucket-logging \
  --bucket article-builder-front \
  --bucket-logging-status '{
    "LoggingEnabled": {
      "TargetBucket": "article-builder-logs",
      "TargetPrefix": "access-logs/"
    }
  }'
```

#### Habilitar Logs de CloudFront
```bash
# Configurar logging de CloudFront
aws cloudfront update-distribution \
  --id <DISTRIBUTION_ID> \
  --distribution-config '{
    "Logging": {
      "Enabled": true,
      "IncludeCookies": false,
      "Bucket": "article-builder-logs.s3.amazonaws.com",
      "Prefix": "cloudfront-logs/"
    }
  }'
```

---

## 🔄 CI/CD Pipeline

### 📋 GitHub Actions Workflow

#### Archivo de Configuración
```yaml
# .github/workflows/deploy.yml
name: Deploy to AWS
on:
  push:
    branches: [main, master]
  pull_request:
    branches: [main, master]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: '18'
          cache: 'npm'
      - run: npm ci
      - run: npm run lint
      - run: npm run type-check
      - run: npm run test
      - run: npm run build

  deploy:
    needs: test
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/main'
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
      - run: npm ci
      - run: npm run build
      - uses: aws-actions/configure-aws-credentials@v1
        with:
          aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws-region: us-east-1
      - run: aws s3 sync dist/ s3://${{ secrets.S3_BUCKET }} --delete
      - run: aws cloudfront create-invalidation --distribution-id ${{ secrets.CLOUDFRONT_ID }} --paths "/*"
```

#### Secrets Requeridos
```bash
# GitHub Secrets necesarios
AWS_ACCESS_KEY_ID=AKIA...
AWS_SECRET_ACCESS_KEY=...
S3_BUCKET=article-builder-front
CLOUDFRONT_ID=E1234567890ABCD
```

---

## 🚨 Troubleshooting

### ❌ Problemas Comunes

#### Build Fails
```bash
# Error: TypeScript compilation
npm run type-check
npm run lint

# Error: Dependencies
npm ci
rm -rf node_modules package-lock.json
npm install
```

#### S3 Sync Issues
```bash
# Verificar permisos
aws s3 ls s3://article-builder-front

# Verificar configuración del bucket
aws s3api get-bucket-website --bucket article-builder-front
```

#### CloudFront Issues
```bash
# Verificar distribución
aws cloudfront get-distribution --id <DISTRIBUTION_ID>

# Verificar estado
aws cloudfront get-distribution-config --id <DISTRIBUTION_ID>
```

### 🔧 Soluciones Rápidas

#### Limpiar Cache
```bash
# Invalidar caché de CloudFront
aws cloudfront create-invalidation \
  --distribution-id <DISTRIBUTION_ID> \
  --paths "/*"
```

#### Revertir Despliegue
```bash
# Revertir a versión anterior
aws s3 sync s3://article-builder-front-backup/ s3://article-builder-front --delete
```

---

## 📚 Recursos Adicionales

### 🔗 Enlaces Útiles
- [AWS S3 Documentation](https://docs.aws.amazon.com/s3/)
- [AWS CloudFront Documentation](https://docs.aws.amazon.com/cloudfront/)
- [AWS CLI Documentation](https://docs.aws.amazon.com/cli/)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)

### 📖 Guías de Referencia
- [AWS Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/)
- [Static Website Hosting on AWS](https://aws.amazon.com/getting-started/hands-on/host-static-website/)
- [CloudFront Best Practices](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/best-practices.html)

---

## 📞 Soporte

### 👥 Equipo de DevOps
- **DevOps Lead**: [Contacto]
- **AWS Administrator**: [Contacto]
- **Security Engineer**: [Contacto]

### 🆘 Escalación
1. **Nivel 1**: Equipo de desarrollo
2. **Nivel 2**: DevOps team
3. **Nivel 3**: AWS Support (si es necesario)

---

**Última actualización**: Diciembre 2024
**Versión del documento**: 1.0.0
**Mantenido por**: Equipo de DevOps TamerCode
