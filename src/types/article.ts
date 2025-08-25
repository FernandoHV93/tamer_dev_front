export type TextFormatDto = {
  N: boolean
  I: boolean
  U: boolean
  text: string
  aligment: string
  size: string
}

export type ArticleDto = {
  h1: TextFormatDto
  body: unknown[]
  score?: number
  wordCount?: number
  date?: string
}

export type PreviewArticle = {
  id: string
  article: ArticleDto
}


