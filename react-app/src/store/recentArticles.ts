import { create } from 'zustand'
import type { PreviewArticle } from '../types/article'

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
}))


