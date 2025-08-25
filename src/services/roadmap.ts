import { http, setSessionHeaders } from '../lib/http'

export async function saveRoadmap(sessionId: string, userId: string, roadmapJson: any) {
  setSessionHeaders(sessionId, userId)
  const payload = {
    sessionID: sessionId,
    userID: userId,
    ...roadmapJson,
  }
  const res = await http.post('/new_roadmap', payload)
  return res.data
}

export async function getRoadmap(sessionId: string, userId: string) {
  setSessionHeaders(sessionId, userId)
  const res = await http.get('/get_roadmap', {
    params: {
      sessionID: sessionId,
      userID: userId,
    }
  })
  return res.data
}

export async function updateRoadmap(sessionId: string, userId: string, roadmapJson: any) {
  setSessionHeaders(sessionId, userId)
  const payload = {
    sessionID: sessionId,
    userID: userId,
    ...roadmapJson,
  }
  const res = await http.post('/new_roadmap', payload)
  return res.data
}


