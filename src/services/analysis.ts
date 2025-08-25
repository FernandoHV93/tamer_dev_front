import { http, setSessionHeaders } from '../lib/http'
import type { KeywordAnalysisResult } from '../types/api'

export async function analysisKeywords() {
  const res = await http.get('/analysis_keywords')
  return res.data
}

export async function titleRunAnalysisFirst() {
  const res = await http.get('/title_run_analysis_first')
  return res.data
}

export async function runAnalysis(sessionId: string, userId: string, _mainKeyword: string, _isAutoMode: boolean): Promise<KeywordAnalysisResult> {
  setSessionHeaders(sessionId, userId)
  
  // Por ahora retornamos datos mock como en Flutter
  // En el futuro esto debería hacer una llamada real al backend
  const response = {
    headings: { H2: 5, H3: 8 },
    searchIntent: "N",
    keywordDifficultyPercent: 20.0,
    keywordDifficultyLabel: "Easy",
    media: { Images: 6, Videos: 1 },
    content: { Words: 1500, Paragraphs: 15 }
  }
  
  return response as KeywordAnalysisResult
}


