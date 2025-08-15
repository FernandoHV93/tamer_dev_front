import axios from 'axios'

const BASE_URL = import.meta.env.VITE_BASE_URL ?? 'https://backend.tamercode.com'

export const http = axios.create({
  baseURL: BASE_URL,
})


