import { http, setSessionHeaders } from '../lib/http'
import type { WebsiteEntity } from '../types/website'

export async function loadWebsites(userId: string): Promise<WebsiteEntity[]> {
  try {
    // backend espera user_id en query
    const res = await http.get('/api/websites/load', { params: { user_id: userId } })
    const data = res.data
    const list = Array.isArray(data) ? data : data?.websites ?? []
    return list
  } catch (error: any) {
    throw new Error(`Failed to load websites: ${error.message}`)
  }
}

export async function saveWebsite(payload: { sessionId: string; userId: string; website: Omit<WebsiteEntity, 'id'> }): Promise<WebsiteEntity> {
  try {
    const { sessionId, userId, website } = payload
    const body = {
      sessionID: sessionId,
      userId,
      name: website.name,
      url: website.url,
      status: website.status.toLowerCase(),
    }
    setSessionHeaders(sessionId, userId)
    const res = await http.post('/api/websites', body)
    const data = res.data
    return (data?.website ?? data) as WebsiteEntity
  } catch (error: any) {
    throw new Error(`Failed to save website: ${error.message}`)
  }
}

export async function updateWebsite(payload: { websiteId: string; website: Partial<WebsiteEntity> }) {
  try {
    const { websiteId, website } = payload
    await http.put(`/api/websites/${websiteId}`, website)
  } catch (error: any) {
    throw new Error(`Failed to update website: ${error.message}`)
  }
}

export async function deleteWebsite(websiteId: string) {
  try {
    await http.delete(`/api/websites/${websiteId}`)
  } catch (error: any) {
    throw new Error(`Failed to delete website: ${error.message}`)
  }
}


