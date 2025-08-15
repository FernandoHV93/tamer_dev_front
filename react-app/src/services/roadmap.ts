import { http } from '../lib/http'

export async function saveRoadmap(payload: any) {
  const res = await http.post('/save_roadmap', payload)
  return res.data
}

export async function getRoadmap() {
  const res = await http.get('/get_roadmap')
  return res.data
}


