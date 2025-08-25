import { http, setSessionHeaders } from '../lib/http'
import type { ContentCard, Topic } from '../types/content'

export async function loadContentCardsByWebsiteId(websiteId: string): Promise<ContentCard[]> {
  try {
    const res = await http.get(`/api/websites/${websiteId}/content-cards`)
    const data = res.data
    const list = Array.isArray(data) ? data : data?.['content-cards'] ?? []
    return list
  } catch (error: any) {
    throw new Error(`Error loading content cards: ${error.message}`)
  }
}

export async function addContentCard(websiteId: string, card: Omit<ContentCard, 'id' | 'websiteId'>, sessionId?: string, userId?: string) {
  try {
    if (sessionId && userId) setSessionHeaders(sessionId, userId)
    await http.post(`/api/websites/${websiteId}/content-cards`, card)
  } catch (error: any) {
    throw new Error(`Error creating content card: ${error.message}`)
  }
}

export async function updateContentCard(cardId: string, card: Partial<ContentCard>, sessionId?: string, userId?: string) {
  try {
    if (sessionId && userId) setSessionHeaders(sessionId, userId)
    await http.put(`/api/content-cards/${cardId}`, card)
  } catch (error: any) {
    throw new Error(`Error updating content card: ${error.message}`)
  }
}

export async function deleteContentCard(cardId: string, sessionId?: string, userId?: string) {
  try {
    if (sessionId && userId) setSessionHeaders(sessionId, userId)
    await http.delete(`/api/content-cards/${cardId}`)
  } catch (error: any) {
    throw new Error(`Error deleting content card: ${error.message}`)
  }
}

export async function loadTopicsByCardId(cardId: string): Promise<Topic[]> {
  try {
    const res = await http.get(`/api/content-cards/${cardId}/topics`)
    const data = res.data
    const list = Array.isArray(data) ? data : data?.topics ?? []
    return list
  } catch (error: any) {
    throw new Error(`Error loading topics: ${error.message}`)
  }
}

export async function addTopic(cardId: string, topic: Omit<Topic, 'id' | 'cardId'>, sessionId?: string, userId?: string) {
  try {
    if (sessionId && userId) setSessionHeaders(sessionId, userId)
    await http.post(`/api/content-cards/${cardId}/topics`, topic)
  } catch (error: any) {
    throw new Error(`Error creating topic: ${error.message}`)
  }
}

export async function updateTopic(topicId: string, topic: Partial<Topic>, sessionId?: string, userId?: string) {
  try {
    if (sessionId && userId) setSessionHeaders(sessionId, userId)
    await http.put(`/api/topics/${topicId}`, topic)
  } catch (error: any) {
    throw new Error(`Error updating topic: ${error.message}`)
  }
}

export async function deleteTopic(topicId: string, sessionId?: string, userId?: string) {
  try {
    if (sessionId && userId) setSessionHeaders(sessionId, userId)
    await http.delete(`/api/content-cards/${topicId}/topics`)
  } catch (error: any) {
    throw new Error(`Error deleting topic: ${error.message}`)
  }
}


