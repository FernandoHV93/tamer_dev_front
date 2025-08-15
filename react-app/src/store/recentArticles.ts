import { create } from 'zustand'
import type { PreviewArticle } from '../types/article'
import { sendDefaultData, fetchGeneratedArticle } from '../services/articleBuilder'

type State = {
  articles: PreviewArticle[]
  isGenerating: boolean
  generatingArticleTitle?: string | null
  generatingError?: string | null
}

type Actions = {
  loadRecentArticles: () => Promise<void>
  startGeneratingArticle: (title: string) => void
  setError: (message: string | null) => void
  generateArticle: (title: string, sessionId: string, userId: string) => Promise<void>
  addArticle: (title: string) => void
}

export const useRecentArticles = create<State & Actions>((set) => ({
  articles: [],
  isGenerating: false,
  generatingArticleTitle: null,
  generatingError: null,

  async loadRecentArticles() {
    const demo: PreviewArticle[] = [
      {
        id: '1',
        article: {
          h1: {
            N: false,
            I: false,
            U: false,
            text: 'Brickell Location Guide: Digital Marketing & SEO Services',
            aligment: '',
            size: '',
          },
          body: [],
          score: 69,
          date: new Date(2024, 4, 6, 14, 47).toISOString(),
        },
      },
      {
        id: '2',
        article: {
          h1: {
            N: false,
            I: false,
            U: false,
            text: 'SEO vs Social Media: Which one is better for my business?',
            aligment: '',
            size: '',
          },
          body: [],
          score: 81,
          date: new Date(2024, 3, 9, 23, 48).toISOString(),
        },
      },
    ]
    set({ articles: demo })
  },

  startGeneratingArticle(title: string) {
    set({ isGenerating: true, generatingArticleTitle: title, generatingError: null })
    // Simular finalización
    setTimeout(() => {
      set({ isGenerating: false, generatingArticleTitle: null })
    }, 1500)
  },

  setError(message) {
    set({ generatingError: message })
  },

  async generateArticle(title: string, sessionId: string, userId: string) {
    set({ isGenerating: true, generatingArticleTitle: title, generatingError: null })
    try {
      // Enviar DTO por defecto como en Flutter
      const defaultDto: any = {
        H1: { N: true, I: false, U: false, text: title ?? '', aligment: 'center', size: 'H1' },
        body: [],
      }
      await sendDefaultData(sessionId, userId, defaultDto)
      const dto = await fetchGeneratedArticle(sessionId, userId)
      const newArticle: PreviewArticle = {
        id: String(Date.now()),
        article: {
          h1: {
            N: !!dto.H1?.N,
            I: !!dto.H1?.I,
            U: !!dto.H1?.U,
            text: dto.H1?.text ?? title ?? '',
            aligment: dto.H1?.aligment ?? 'left',
            size: dto.H1?.size ?? 'H1',
          },
          body: dto.body ?? [],
          score: dto.score,
          date: dto.date,
        } as any,
      }
      set((s) => ({ articles: [newArticle, ...s.articles], isGenerating: false, generatingArticleTitle: null }))
    } catch (e: any) {
      set({ isGenerating: false, generatingError: e?.message ?? String(e) })
    }
  },

  addArticle(title: string) {
    const newArticle: PreviewArticle = {
      id: String(Date.now()),
      article: {
        h1: {
          N: true,
          I: false,
          U: false,
          text: title,
          aligment: 'center',
          size: 'H1',
        },
        body: [],
        score: 0,
        date: new Date().toISOString(),
      } as any,
    }
    set((s) => ({ articles: [newArticle, ...s.articles] }))
  },
}))


