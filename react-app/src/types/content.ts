export type ContentCardStatus = 'done' | 'no_done' | 'in_progress'

export type ContentCard = {
  id: string
  websiteId: string
  title: string
  url?: string | null
  keyWordsScore: number
  status: ContentCardStatus
}

export type TopicStatus = 'covered' | 'draft' | 'initiated'

export type Topic = {
  id: string
  cardId: string
  keyWord: string
  kd?: string | null
  categories?: string | null
  date: string
  tags?: string | null
  score?: string | null
  words?: string | null
  schemas?: string | null
  status: TopicStatus
  position?: number | null
  volume?: number | null
}


