#!/bin/bash

# AWS Deployment Script for Article Builder Frontend
# Uso: ./deploy-aws.sh [bucket-name] [region]

set -e

# Configuración
BUCKET_NAME=${1:-"article-builder-frontend"}
REGION=${2:-"us-east-1"}
DISTRIBUTION_ID=${3:-""}

echo "🚀 Iniciando despliegue a AWS..."
echo "Bucket: $BUCKET_NAME"
echo "Región: $REGION"

# 1. Verificar que AWS CLI está instalado
if ! command -v aws &> /dev/null; then
    echo "❌ AWS CLI no está instalado. Instálalo desde: https://aws.amazon.com/cli/"
    exit 1
fi

# 2. Verificar credenciales de AWS
if ! aws sts get-caller-identity &> /dev/null; then
    echo "❌ No se pueden verificar las credenciales de AWS. Ejecuta 'aws configure'"
    exit 1
fi

# 3. Limpiar build anterior
echo "🧹 Limpiando build anterior..."
rm -rf dist

# 4. Instalar dependencias
echo "📦 Instalando dependencias..."
npm ci

# 5. Ejecutar build
echo "🔨 Ejecutando build..."
npm run build

# 6. Verificar que el build fue exitoso
if [ ! -d "dist" ]; then
    echo "❌ El build falló. No se encontró el directorio 'dist'"
    exit 1
fi

# 7. Crear bucket si no existe
echo "🪣 Verificando bucket S3..."
if ! aws s3 ls "s3://$BUCKET_NAME" 2>&1 | grep -q 'NoSuchBucket'; then
    echo "✅ Bucket existe"
else
    echo "📦 Creando bucket S3..."
    aws s3 mb "s3://$BUCKET_NAME" --region "$REGION"
fi

# 8. Subir archivos a S3
echo "📤 Subiendo archivos a S3..."
aws s3 sync dist/ "s3://$BUCKET_NAME" \
    --delete \
    --cache-control "max-age=31536000" \
    --exclude "*.html" \
    --exclude "*.json"

# 9. Subir archivos HTML con cache control diferente
echo "📤 Subiendo archivos HTML..."
aws s3 sync dist/ "s3://$BUCKET_NAME" \
    --cache-control "no-cache" \
    --include "*.html" \
    --include "*.json"

# 10. Configurar website hosting
echo "🌐 Configurando website hosting..."
aws s3 website "s3://$BUCKET_NAME" \
    --index-document index.html \
    --error-document index.html

# 11. Configurar permisos públicos
echo "🔓 Configurando permisos públicos..."
aws s3api put-bucket-policy --bucket "$BUCKET_NAME" --policy '{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::'$BUCKET_NAME'/*"
        }
    ]
}'

# 12. Invalidar CloudFront si se proporciona ID
if [ ! -z "$DISTRIBUTION_ID" ]; then
    echo "🔄 Invalidando CloudFront..."
    aws cloudfront create-invalidation \
        --distribution-id "$DISTRIBUTION_ID" \
        --paths "/*"
fi

echo "✅ Despliegue completado exitosamente!"
echo "🌐 URL del sitio: http://$BUCKET_NAME.s3-website-$REGION.amazonaws.com"
echo "🔗 URL con CloudFront: https://$BUCKET_NAME.cloudfront.net (si está configurado)"
