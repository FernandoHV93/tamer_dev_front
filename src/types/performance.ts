import type { WebsiteEntity } from './website'
import type { ContentCard } from './content'

export type InspectedWebsite = {
  website: WebsiteEntity
  contentCards: ContentCard[]
  top3Keywords: number
  top10Keywords: number
  top100Keywords: number
  top3Delta: number
  top10Delta: number
  top100Delta: number
}


