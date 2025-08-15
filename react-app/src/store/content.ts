import { create } from 'zustand'
import type { ContentCard, Topic } from '../types/content'
import type { InspectedWebsite } from '../types/performance'
import type { WebsiteEntity } from '../types/website'
import * as api from '../services/content'
import * as perf from '../services/performance'

type State = {
  cards: ContentCard[]
  topicsByCardId: Record<string, Topic[]>
  selectedWebsiteId?: string | null
  selectedCardId?: string | null
  inspected?: InspectedWebsite | null
  isLoading: boolean
  error?: string | null
}

type Actions = {
  loadCards: (websiteId: string) => Promise<void>
  selectCard: (cardId: string | null) => void
  loadTopics: (cardId: string) => Promise<void>
  inspectWebsite: (website: WebsiteEntity) => Promise<void>
  addTopic: (cardId: string, topic: Omit<Topic, 'id' | 'cardId'>) => Promise<void>
  updateTopic: (topicId: string, topic: Partial<Topic>) => Promise<void>
  deleteTopic: (cardId: string, topicId: string) => Promise<void>
}

export const useContent = create<State & Actions>((set, get) => ({
  cards: [],
  topicsByCardId: {},
  selectedWebsiteId: null,
  selectedCardId: null,
  isLoading: false,
  error: null,

  async loadCards(websiteId) {
    set({ isLoading: true, error: null, selectedWebsiteId: websiteId })
    try {
      const list = await api.loadContentCardsByWebsiteId(websiteId)
      set({ cards: list, isLoading: false })
    } catch (e: any) {
      set({ isLoading: false, error: e?.message ?? String(e) })
    }
  },

  selectCard(cardId) {
    set({ selectedCardId: cardId })
  },

  async loadTopics(cardId) {
    set({ isLoading: true, error: null })
    try {
      const list = await api.loadTopicsByCardId(cardId)
      set({ topicsByCardId: { ...get().topicsByCardId, [cardId]: list }, isLoading: false })
    } catch (e: any) {
      set({ isLoading: false, error: e?.message ?? String(e) })
    }
  },

  async inspectWebsite(website) {
    set({ isLoading: true, error: null })
    try {
      const data = await perf.inspectWebsite(website)
      set({ inspected: data, isLoading: false })
    } catch (e: any) {
      set({ isLoading: false, error: e?.message ?? String(e) })
    }
  },

  async addTopic(cardId, topic) {
    set({ isLoading: true, error: null })
    try {
      await api.addTopic(cardId, topic)
      await get().loadTopics(cardId)
    } catch (e: any) {
      set({ isLoading: false, error: e?.message ?? String(e) })
      return
    }
    set({ isLoading: false })
  },

  async updateTopic(topicId, topic) {
    set({ isLoading: true, error: null })
    try {
      await api.updateTopic(topicId, topic)
      const cardId = get().selectedCardId
      if (cardId) await get().loadTopics(cardId)
    } catch (e: any) {
      set({ isLoading: false, error: e?.message ?? String(e) })
      return
    }
    set({ isLoading: false })
  },

  async deleteTopic(cardId, topicId) {
    set({ isLoading: true, error: null })
    try {
      await api.deleteTopic(topicId)
      await get().loadTopics(cardId)
    } catch (e: any) {
      set({ isLoading: false, error: e?.message ?? String(e) })
      return
    }
    set({ isLoading: false })
  },
}))


