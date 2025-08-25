import { http } from '../lib/http'

export async function analysisKeywords() {
  const res = await http.get('/analysis_keywords')
  return res.data
}

export async function titleRunAnalysisFirst() {
  const res = await http.get('/title_run_analysis_first')
  return res.data
}


