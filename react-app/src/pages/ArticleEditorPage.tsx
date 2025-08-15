import { useMemo, useState, useEffect } from 'react'
import ArticleEditor from '../components/editor/ArticleEditor'
import { articleDtoToHtml } from '../lib/articleDtoToHtml'
import { fetchGeneratedArticle, sendDefaultData } from '../services/articleBuilder'
import { useSession } from '../context/SessionContext'
import { useToast } from '../context/ToastContext'
import { useSearchParams, useNavigate } from 'react-router-dom'
import { extractTitleFromHtml } from '../lib/htmlUtils'
import { useRecentArticles } from '../store/recentArticles'

export default function ArticleEditorPage() {
  // Placeholder de un ArticleDto mínimo
  const dto = useMemo(() => ({
    H1: { text: 'Article Title', N: true, I: false, U: false, aligment: 'center', size: 'H1' },
    body: [
      { title: { text: 'Section 1', N: true, I: false, U: false, aligment: 'left', size: 'H2' }, text: [{ text: 'Lorem ipsum dolor sit amet.', N: false, I: false, U: false, aligment: 'left', size: 'body' }], images: [], codes: [], links: [], citations: [] },
    ],
  }), [])

  const [html, setHtml] = useState(articleDtoToHtml(dto))
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState<string | null>(null)
  const { sessionId, userId } = useSession()
  const { showToast } = useToast()
  const [searchParams] = useSearchParams()
  const navigate = useNavigate()
  const { addArticle } = useRecentArticles()

  // Load article by id from Home store if present
  useEffect(() => {
    const id = searchParams.get('id')
    if (!id) return
    try {
      const state = (useRecentArticles as any).getState?.()
      if (state?.articles) {
        const found = state.articles.find((a: any) => a.id === id)
        if (found?.article) {
          setHtml(articleDtoToHtml(found.article))
        }
      }
    } catch {}
  }, [searchParams])

  // Load draft if present
  useEffect(() => {
    try {
      const draft = localStorage.getItem('editor_draft')
      if (draft) setHtml(draft)
    } catch {}
  }, [])

  return (
    <div style={{ padding: 24, display: 'grid', gap: 12 }}>
      <h1>Article Editor</h1>
      {error && <div style={{ color: 'red' }}>{error}</div>}
      <div style={{ display: 'flex', gap: 12 }}>
        <button
          disabled={loading}
          onClick={async () => {
            setLoading(true)
            setError(null)
            try {
              const data = await fetchGeneratedArticle(sessionId, userId)
              setHtml(articleDtoToHtml(data))
            } catch (e: any) {
              setError(e?.message ?? String(e))
            } finally {
              setLoading(false)
            }
          }}
        >
          {loading ? 'Loading…' : 'Load Generated Article'}
        </button>
        <button
          disabled={loading}
          onClick={async () => {
            setLoading(true)
            setError(null)
            try {
              const defaultDto = {
                H1: { N: true, I: false, U: false, text: '', aligment: 'center', size: 'H1' },
                body: [],
              }
              await sendDefaultData(sessionId, userId, defaultDto as any)
            } catch (e: any) {
              setError(e?.message ?? String(e))
            } finally {
              setLoading(false)
            }
          }}
        >
          Send Default Data
        </button>
        <button
          onClick={() => {
            try {
              navigator.clipboard.writeText(html)
            } catch {}
          }}
        >
          Copy HTML
        </button>
        <button
          onClick={() => {
            const blob = new Blob([html], { type: 'text/html;charset=utf-8' })
            const a = document.createElement('a')
            a.href = URL.createObjectURL(blob)
            a.download = 'article.html'
            a.click()
            URL.revokeObjectURL(a.href)
          }}
        >
          Download HTML
        </button>
        <button
          className="btn btn-primary"
          onClick={async () => {
            // simulate save to backend by reusing sendDefaultData with H1 from editor
            const title = extractTitleFromHtml(html) || 'Untitled'
            setLoading(true)
            setError(null)
            try {
              await sendDefaultData(sessionId, userId, { H1: { N: true, I: false, U: false, text: title, aligment: 'center', size: 'H1' }, body: [] } as any)
              showToast('Article saved', 'success')
              addArticle(title)
              navigate('/home_page')
            } catch (e: any) {
              setError(e?.message ?? String(e))
            } finally {
              setLoading(false)
            }
          }}
        >
          Save Article
        </button>
        <button
          onClick={() => { try { localStorage.setItem('editor_draft', html); showToast('Draft saved', 'success') } catch {} }}
        >
          Save Draft
        </button>
        <button
          onClick={() => { try { localStorage.removeItem('editor_draft'); showToast('Draft cleared', 'success') } catch {} }}
        >
          Clear Draft
        </button>
      </div>
      <ArticleEditor html={html} onChange={setHtml} />
    </div>
  )
}


