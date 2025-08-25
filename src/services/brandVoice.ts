import { http, setSessionHeaders } from '../lib/http'

import type { BrandVoice, DeepAnalysisWizardEntity } from '../types/api'

export type Brand = BrandVoice

export async function listBrands(sessionId: string, userId: string): Promise<Brand[]> {
  try {
    setSessionHeaders(sessionId, userId)
    const res = await http.get('/api/brand-voice')
    const data = res.data
    return Array.isArray(data) ? data : data?.brands ?? []
  } catch (error: any) {
    throw new Error(`Error loading brands: ${error.message}`)
  }
}

export async function addBrand(sessionId: string, userId: string, brand: Partial<Brand>): Promise<Brand> {
  try {
    setSessionHeaders(sessionId, userId)
    const res = await http.post('/api/brand-voice', brand)
    return res.data as Brand
  } catch (error: any) {
    throw new Error(`Error adding brand: ${error.message}`)
  }
}

export async function updateBrand(sessionId: string, userId: string, brandId: string, brand: Partial<Brand>) {
  try {
    setSessionHeaders(sessionId, userId)
    await http.put(`/api/brand-voice/${brandId}`, brand)
  } catch (error: any) {
    throw new Error(`Error updating brand: ${error.message}`)
  }
}

export async function deleteBrand(sessionId: string, userId: string, brandId: string) {
  try {
    setSessionHeaders(sessionId, userId)
    await http.delete(`/api/brand-voice/${brandId}`)
  } catch (error: any) {
    throw new Error(`Error deleting brand: ${error.message}`)
  }
}

export async function generateBrandVoice(sessionId: string, userId: string, wizardEntity: DeepAnalysisWizardEntity) {
  try {
    setSessionHeaders(sessionId, userId)
    const payload = {
      sessionID: sessionId,
      userID: userId,
      ...wizardEntity,
    }
    const res = await http.post('/api/brand-voice/generate', payload)
    return res.data
  } catch (error: any) {
    throw new Error(`Error generating brand voice: ${error.message}`)
  }
}

export async function analyzeContent(sessionId: string, userId: string, pastedText: string) {
  try {
    setSessionHeaders(sessionId, userId)
    const payload = {
      sessionID: sessionId,
      userID: userId,
      pastedText,
    }
    const res = await http.post('/api/brand-voice/analyze_content', payload)
    return res.data
  } catch (error: any) {
    throw new Error(`Error analyzing content: ${error.message}`)
  }
}

export async function analyzeFile(sessionId: string, userId: string, file: File) {
  try {
    setSessionHeaders(sessionId, userId)
    const form = new FormData()
    form.append('file', file)
    const res = await http.post('/api/brand-voice/analyze_file', form)
    return res.data
  } catch (error: any) {
    throw new Error(`Error analyzing file: ${error.message}`)
  }
}

export async function analyzeFileBytes(sessionId: string, userId: string, bytes: Uint8Array, fileName: string) {
  try {
    setSessionHeaders(sessionId, userId)
    const form = new FormData()
    form.append('sessionID', sessionId)
    form.append('userID', userId)
    form.append('fileName', fileName)
    form.append('file', new Blob([bytes]), fileName)
    const res = await http.post('/api/brand-voice/analyze_file_bytes', form)
    return res.data
  } catch (error: any) {
    throw new Error(`Error analyzing file bytes: ${error.message}`)
  }
}


