import { http, setSessionHeaders } from '../lib/http'

export type Brand = {
  id: string
  brandName: string
  toneOfVoice?: string
  keyValues?: string[]
  targetAudience?: string
  brandIdentityInsights?: string
}

export async function listBrands(sessionId: string, userId: string): Promise<Brand[]> {
  setSessionHeaders(sessionId, userId)
  const res = await http.get('/api/brand-voice')
  const data = res.data
  return Array.isArray(data) ? data : data?.brands ?? []
}

export async function addBrand(sessionId: string, userId: string, brand: Partial<Brand>): Promise<Brand> {
  setSessionHeaders(sessionId, userId)
  const res = await http.post('/api/brand-voice', brand)
  return res.data as Brand
}

export async function updateBrand(sessionId: string, userId: string, brandId: string, brand: Partial<Brand>) {
  setSessionHeaders(sessionId, userId)
  await http.put(`/api/brand-voice/${brandId}`, brand)
}

export async function deleteBrand(sessionId: string, userId: string, brandId: string) {
  setSessionHeaders(sessionId, userId)
  await http.delete(`/api/brand-voice/${brandId}`)
}

export async function generateBrandVoice(sessionId: string, userId: string, payload: any) {
  setSessionHeaders(sessionId, userId)
  const res = await http.post('/api/brand-voice/generate', payload)
  return res.data
}

export async function analyzeContent(sessionId: string, userId: string, payload: any) {
  setSessionHeaders(sessionId, userId)
  const res = await http.post('/api/brand-voice/analyze_content', payload)
  return res.data
}

export async function analyzeFile(sessionId: string, userId: string, file: File) {
  setSessionHeaders(sessionId, userId)
  const form = new FormData()
  form.append('file', file)
  const res = await http.post('/api/brand-voice/analyze_file', form)
  return res.data
}


