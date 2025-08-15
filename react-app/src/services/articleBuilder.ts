import { http } from '../lib/http'
import type { ArticleBuilderEntity, ArticleDto } from '../types/articleBuilder'

export async function saveForm(sessionId: string, userId: string, model: ArticleBuilderEntity): Promise<void> {
  const payload = { userID: userId, sessionID: sessionId, ...toBackendPayload(model) }
  await http.post('/article_generator', payload)
}

export async function sendDefaultData(sessionId: string, userId: string, dto: ArticleDto): Promise<void> {
  const payload = { userID: userId, sessionID: sessionId, ...dto }
  await http.post('/component_article_format', payload)
}

export async function fetchGeneratedArticle(sessionId: string, userId: string): Promise<ArticleDto> {
  const res = await http.post('/run_generator', { sessionID: sessionId, userID: userId })
  return res.data as ArticleDto
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


