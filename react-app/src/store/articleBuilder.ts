import { create } from 'zustand'
import type { ArticleBuilderEntity } from '../types/articleBuilder'
import * as api from '../services/articleBuilder'

const defaultModel: ArticleBuilderEntity = {
  articleGeneratorGeneral: {
    language: 'English',
    articleType: 'Blog',
    articleMainKeyword: '',
    articleTitle: '',
    articleMetaTitle: '',
  },
  articleSettings: {
    articleSize: 'Medium',
    targetCountry: 'USA',
    aiModel: 'gpt-4o',
    humanizeText: 'No',
    pointOfView: 'Third Person',
    toneOfVoice: 'Neutral',
    aiWordsRemoval: 'No AI Words Removal',
    detailsToInclude: '',
    brandVoice: {
      id: '',
      brandName: 'Brand Voice',
      toneOfVoice: '',
      keyValues: [],
      targetAudience: '',
      brandIdentityInsights: '',
    },
  },
  articleMediaHub: {
    aiImages: false,
    numberOfImages: 0,
    imageStyle: 'Realistic',
    imageSize: { width: 1024, height: 1024 },
    youtubeVideos: false,
    numberOfVideos: 0,
    layoutOption: 'Classic',
    includeKeywords: false,
    placeUnderHeadings: false,
    additionalInstructions: '',
    brandName: '',
  },
  articleSEO: {
    keywords: [],
  },
  articleStructure: {
    typeOfHook: 'Question',
    introductoryHookBrief: '',
    contentOptions: {
      Conclusion: false,
      Tables: false,
      Heading3: false,
      Lists: false,
      Italics: false,
      Quotes: false,
      KeyTakeaways: false,
      FAQS: false,
      Bold: false,
      Stats: false,
      RealPeopleOpinion: false,
    },
  },
  articleDistribution: {
    sourceLinks: false,
    citations: false,
    internalLinking: [],
    externalLinking: [],
    articleSydication: {},
  },
}

type State = {
  model: ArticleBuilderEntity
  isSaving: boolean
  isGenerating: boolean
  error?: string | null
}

type Actions = {
  setGeneral: (partial: Partial<ArticleBuilderEntity['articleGeneratorGeneral']>) => void
  saveForm: (sessionId: string, userId: string) => Promise<void>
  generate: (sessionId: string, userId: string) => Promise<void>
}

export const useArticleBuilder = create<State & Actions>((set, get) => ({
  model: defaultModel,
  isSaving: false,
  isGenerating: false,
  error: null,

  setGeneral(partial) {
    set({
      model: {
        ...get().model,
        articleGeneratorGeneral: { ...get().model.articleGeneratorGeneral, ...partial },
      },
    })
  },

  async saveForm(sessionId, userId) {
    set({ isSaving: true, error: null })
    try {
      await api.saveForm(sessionId, userId, get().model)
      set({ isSaving: false })
    } catch (e: any) {
      set({ isSaving: false, error: e?.message ?? String(e) })
    }
  },

  async generate(sessionId, userId) {
    set({ isGenerating: true, error: null })
    try {
      await api.fetchGeneratedArticle(sessionId, userId)
      set({ isGenerating: false })
    } catch (e: any) {
      set({ isGenerating: false, error: e?.message ?? String(e) })
    }
  },
}))


