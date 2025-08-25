import { http } from '../lib/http'
import type { ArticleBuilderEntity, ArticleDto } from '../types/articleBuilder'
import { toast } from '../context/ToastContext'  // 👈 importamos el helper

export async function saveForm(sessionId: string, userId: string, model: ArticleBuilderEntity): Promise<void> {
  try {
    const payload = { userID: userId, sessionID: sessionId, ...toBackendPayload(model) }
    await http.post('/article_generator', payload)
    toast("Artículo guardado correctamente ✅", "success")
  } catch (err: any) {
    const errorMessage = `Error al guardar artículo: ${err.message || err}`
    toast(errorMessage, "error")
    throw new Error(errorMessage)
  }
}

export async function sendDefaultData(sessionId: string, userId: string, dto: ArticleDto): Promise<void> {
  try {
    const payload = { userID: userId, sessionID: sessionId, ...dto }
    await http.post('/component_article_format', payload)
    toast("Datos predeterminados enviados ✅", "success")
  } catch (err: any) {
    const errorMessage = `Error al enviar artículo: ${err.message || err}`
    toast(errorMessage, "error")
    throw new Error(errorMessage)
  }
}

export async function fetchGeneratedArticle(sessionId: string, userId: string): Promise<ArticleDto> {
  try {
    const res = await http.post('/run_generator', { sessionID: sessionId, userID: userId })
    toast("Artículo generado correctamente 🎉", "success")
    return res.data as ArticleDto
  } catch (err: any) {
    const errorMessage = `Error al generar artículo: ${err.message || err}`
    toast(errorMessage, "error")
    throw new Error(errorMessage)
  }
}

function toBackendPayload(model: ArticleBuilderEntity) {
  return {
    articleGeneratorGeneral: model.articleGeneratorGeneral,
    articleGeneratorSettings: model.articleSettings,
    articleMediaHub: model.articleMediaHub,
    articleSEO: model.articleSEO,
    articleStructure: model.articleStructure,
    articleConnectToWeb: {
      sourceLinks: model.articleDistribution.sourceLinks,
      citationLinks: model.articleDistribution.citations,
      internalLinks: model.articleDistribution.internalLinking,
      externalLinks: model.articleDistribution.externalLinking,
    },
    articleSyndication: model.articleDistribution.articleSydication,
  }
}


