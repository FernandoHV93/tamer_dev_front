const express = require('express')
const cors = require('cors')
const multer = require('multer')
const { nanoid } = require('nanoid')
const app = express()
const upload = multer()

app.use(cors())
app.use(express.json())

// in-memory DB
const db = {
  brands: [],
  websites: [],
  contentCards: {}, // websiteId -> cards
  topics: {}, // cardId -> topics
  roadmap: { items: [] },
}

// Health
app.get('/health', (_, res) => res.json({ ok: true }))

// Websites
app.get('/api/websites/load', (req, res) => {
  const result = db.websites
  res.json({ websites: result })
})

app.post('/api/websites', (req, res) => {
  const { name, url, status } = req.body
  const site = { id: nanoid(), name, url, status: status || 'Active', lastChecked: new Date().toISOString() }
  db.websites.push(site)
  res.json(site)
})

app.put('/api/websites/:id', (req, res) => {
  const { id } = req.params
  const idx = db.websites.findIndex((w) => w.id === id)
  if (idx === -1) return res.status(404).json({ error: 'not found' })
  db.websites[idx] = { ...db.websites[idx], ...req.body }
  res.json(db.websites[idx])
})

app.delete('/api/websites/:id', (req, res) => {
  const { id } = req.params
  db.websites = db.websites.filter((w) => w.id !== id)
  res.json({ ok: true })
})

// Content cards
app.get('/api/websites/:websiteId/content-cards', (req, res) => {
  const items = db.contentCards[req.params.websiteId] || []
  res.json({ 'content-cards': items })
})

app.post('/api/websites/:websiteId/content-cards', (req, res) => {
  const { websiteId } = req.params
  const { title, url, keyWordsScore, status } = req.body
  const card = { id: nanoid(), websiteId, title, url, keyWordsScore, status }
  db.contentCards[websiteId] = [...(db.contentCards[websiteId] || []), card]
  res.json(card)
})

app.put('/api/content-cards/:id', (req, res) => {
  const { id } = req.params
  for (const websiteId of Object.keys(db.contentCards)) {
    const arr = db.contentCards[websiteId]
    const idx = arr.findIndex((c) => c.id === id)
    if (idx !== -1) {
      arr[idx] = { ...arr[idx], ...req.body }
      return res.json(arr[idx])
    }
  }
  res.status(404).json({ error: 'not found' })
})

app.delete('/api/content-cards/:id', (req, res) => {
  const { id } = req.params
  for (const websiteId of Object.keys(db.contentCards)) {
    db.contentCards[websiteId] = db.contentCards[websiteId].filter((c) => c.id !== id)
  }
  res.json({ ok: true })
})

// Topics
app.get('/api/content-cards/:cardId/topics', (req, res) => {
  const items = db.topics[req.params.cardId] || []
  res.json({ topics: items })
})

app.post('/api/content-cards/:cardId/topics', (req, res) => {
  const { cardId } = req.params
  const topic = { id: nanoid(), cardId, ...req.body }
  db.topics[cardId] = [...(db.topics[cardId] || []), topic]
  res.json(topic)
})

app.put('/api/topics/:id', (req, res) => {
  const { id } = req.params
  for (const cardId of Object.keys(db.topics)) {
    const arr = db.topics[cardId]
    const idx = arr.findIndex((t) => t.id === id)
    if (idx !== -1) {
      arr[idx] = { ...arr[idx], ...req.body }
      return res.json(arr[idx])
    }
  }
  res.status(404).json({ error: 'not found' })
})

app.delete('/api/content-cards/:topicId/topics', (req, res) => {
  const { topicId } = req.params
  for (const cardId of Object.keys(db.topics)) {
    db.topics[cardId] = db.topics[cardId].filter((t) => t.id !== topicId)
  }
  res.json({ ok: true })
})

// Article generator
app.post('/component_article_format', (req, res) => {
  res.json({ ok: true })
})

app.post('/run_generator', (req, res) => {
  const dto = {
    H1: { N: true, I: false, U: false, text: 'Generated Article', aligment: 'center', size: 'H1' },
    body: [],
    score: 70,
    date: new Date().toISOString(),
  }
  res.json(dto)
})

app.post('/article_generator', (req, res) => {
  res.json({ ok: true })
})

// Brand voice
app.get('/api/brand-voice', (req, res) => {
  res.json({ brands: db.brands })
})

app.post('/api/brand-voice', (req, res) => {
  const { brandName } = req.body
  const brand = { id: nanoid(), brandName }
  db.brands.push(brand)
  res.json(brand)
})

app.put('/api/brand-voice/:id', (req, res) => {
  const { id } = req.params
  const idx = db.brands.findIndex((b) => b.id === id)
  if (idx === -1) return res.status(404).json({ error: 'not found' })
  db.brands[idx] = { ...db.brands[idx], ...req.body }
  res.json(db.brands[idx])
})

app.delete('/api/brand-voice/:id', (req, res) => {
  const { id } = req.params
  db.brands = db.brands.filter((b) => b.id !== id)
  res.json({ ok: true })
})

app.post('/api/brand-voice/generate', (req, res) => {
  res.json({ ok: true, generated: true })
})

app.post('/api/brand-voice/analyze_content', (req, res) => {
  res.json({ ok: true, analysis: { score: 80 } })
})

app.post('/api/brand-voice/analyze_file', upload.single('file'), (req, res) => {
  res.json({ ok: true, file: req.file?.originalname })
})

// API settings
app.get('/api_settings/providers_status', (req, res) => {
  res.json({ providers: { openai: 'disconnected' } })
})
app.post('/api_settings/connect_provider', (req, res) => {
  res.json({ ok: true })
})
app.post('/api_settings/disconnect_provider', (req, res) => {
  res.json({ ok: true })
})

// Analysis
app.get('/analysis_keywords', (req, res) => {
  res.json({ keywords: ['seo', 'marketing'] })
})
app.get('/title_run_analysis_first', (req, res) => {
  res.json({ ok: true })
})

// Roadmap
app.get('/get_roadmap', (req, res) => {
  res.json(db.roadmap)
})
app.post('/save_roadmap', (req, res) => {
  db.roadmap = req.body
  res.json({ ok: true })
})

const port = process.env.PORT || 4000
app.listen(port, () => console.log(`Mock backend running on http://localhost:${port}`))


