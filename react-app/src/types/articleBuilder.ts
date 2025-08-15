export type ArticleGeneratorGeneral = {
  language: string
  articleType: string
  articleMainKeyword: string
  articleTitle: string
  articleMetaTitle?: string
}

export type ArticleGeneratorSettings = {
  articleSize: string
  targetCountry: string
  aiModel: string
  humanizeText: string
  pointOfView: string
  toneOfVoice: string
  aiWordsRemoval?: string
  detailsToInclude?: string
  brandVoice?: {
    id: string
    brandName: string
    toneOfVoice: string
    keyValues: string[]
    targetAudience: string
    brandIdentityInsights: string
  }
}

export type ArticleMediaHub = {
  aiImages: boolean
  numberOfImages: number
  imageStyle: string
  imageSize: Record<string, number>
  youtubeVideos: boolean
  numberOfVideos: number
  layoutOption: string
  includeKeywords: boolean
  placeUnderHeadings: boolean
  additionalInstructions: string
  brandName: string
}

export type ArticleSEO = {
  keywords: string[]
}

export type ArticleStructure = {
  typeOfHook: string
  introductoryHookBrief: string
  contentOptions: Record<string, boolean | null>
}

export type ArticleDistributionsEntity = {
  sourceLinks: boolean
  citations: boolean
  internalLinking: string[]
  externalLinking: string[]
  articleSydication: Record<string, boolean | null>
}

export type ArticleBuilderEntity = {
  articleGeneratorGeneral: ArticleGeneratorGeneral
  articleSettings: ArticleGeneratorSettings
  articleMediaHub: ArticleMediaHub
  articleSEO: ArticleSEO
  articleStructure: ArticleStructure
  articleDistribution: ArticleDistributionsEntity
}

export type TextFormatDto = {
  N: boolean
  I: boolean
  U: boolean
  text: string
  aligment: string
  size: string
}

export type ArticleBodySection = {
  title: TextFormatDto
  tables: any[]
  text: TextFormatDto[]
  images: any[]
  codes: any[]
  links: any[]
  citations: any[]
}

export type ArticleDto = {
  H1: TextFormatDto
  body: ArticleBodySection[]
  score?: number
  date?: string
}


