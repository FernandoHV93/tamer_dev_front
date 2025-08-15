import { create } from 'zustand'
import type { WebsiteEntity } from '../types/website'
import * as api from '../services/websites'

type State = {
  websites: WebsiteEntity[]
  selectedWebsiteId?: string | null
  isLoading: boolean
  error?: string | null
}

type Actions = {
  load: (userId: string) => Promise<void>
  select: (id: string) => void
  add: (sessionId: string, userId: string, website: Omit<WebsiteEntity, 'id'>) => Promise<void>
  edit: (websiteId: string, website: Partial<WebsiteEntity>) => Promise<void>
  remove: (websiteId: string) => Promise<void>
}

export const useWebsites = create<State & Actions>((set, get) => ({
  websites: [],
  selectedWebsiteId: null,
  isLoading: false,
  error: null,

  async load(userId) {
    set({ isLoading: true, error: null })
    try {
      const list = await api.loadWebsites(userId)
      set({ websites: list, isLoading: false, selectedWebsiteId: list[0]?.id ?? null })
    } catch (e: any) {
      set({ isLoading: false, error: e?.message ?? String(e) })
    }
  },

  select(id) {
    set({ selectedWebsiteId: id })
  },

  async add(sessionId, userId, website) {
    set({ isLoading: true, error: null })
    try {
      await api.saveWebsite({ sessionId, userId, website })
      await get().load(userId)
    } catch (e: any) {
      set({ isLoading: false, error: e?.message ?? String(e) })
      return
    }
    set({ isLoading: false })
  },

  async edit(websiteId, website) {
    set({ isLoading: true, error: null })
    try {
      await api.updateWebsite({ websiteId, website })
      const userId = ''
      await get().load(userId)
    } catch (e: any) {
      set({ isLoading: false, error: e?.message ?? String(e) })
      return
    }
    set({ isLoading: false })
  },

  async remove(websiteId) {
    set({ isLoading: true, error: null })
    try {
      await api.deleteWebsite(websiteId)
      const userId = ''
      await get().load(userId)
    } catch (e: any) {
      set({ isLoading: false, error: e?.message ?? String(e) })
      return
    }
    set({ isLoading: false })
  },
}))


