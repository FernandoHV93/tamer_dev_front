// API Response types
export interface ApiResponse<T = any> {
  data: T
  error?: string
  message?: string
}

// Brand Voice types
export interface BrandVoice {
  id: string
  brandName: string
  toneOfVoice?: string
  keyValues?: string[]
  targetAudience?: string
  brandIdentityInsights?: string
  createdAt?: string
  updatedAt?: string
}

export interface DeepAnalysisWizardEntity {
  brandName: string
  industry: string
  targetAudience: string
  keyValues: string[]
  toneOfVoice: string
  competitors: string[]
  uniqueSellingPoints: string[]
}

// Keyword Analysis types
export interface KeywordAnalysisResult {
  headings: {
    H2: number
    H3: number
  }
  searchIntent: string
  keywordDifficultyPercent: number
  keywordDifficultyLabel: string
  media: {
    Images: number
    Videos: number
  }
  content: {
    Words: number
    Paragraphs: number
  }
}

// Roadmap types
export interface RoadmapData {
  id?: string
  title: string
  description?: string
  steps: RoadmapStep[]
  createdAt?: string
  updatedAt?: string
}

export interface RoadmapStep {
  id?: string
  title: string
  description?: string
  order: number
  completed: boolean
  dueDate?: string
}

// API Settings types
export interface ApiProvider {
  name: string
  connected: boolean
  apiKey?: string
}

export interface ApiProviderStatus {
  [providerName: string]: boolean
}

// Error types
export interface ApiError {
  message: string
  code?: string
  details?: any
}
