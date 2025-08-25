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
  const [activeAlignment, setActiveAlignment] = useState('center')
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
    <div style={{ 
      minHeight: '100vh', 
      background: 'var(--bg)', 
      color: 'var(--text)',
      display: 'flex',
      flexDirection: 'column'
    }}>
      {/* Top Bar */}
      <div style={{
        display: 'flex',
        justifyContent: 'space-between',
        alignItems: 'center',
        padding: '16px 24px',
        borderBottom: '1px solid var(--border)',
        background: 'var(--panel)'
      }}>
        {/* Left side buttons */}
        <div style={{ display: 'flex', gap: '12px' }}>
          <button
            style={{
              padding: '8px 16px',
              background: 'var(--panel-contrast)',
              border: '1px solid var(--border)',
              borderRadius: '8px',
              color: 'var(--text)',
              cursor: 'pointer',
              fontSize: '14px',
              display: 'flex',
              alignItems: 'center',
              gap: '6px'
            }}
            onClick={() => {
              const blob = new Blob([html], { type: 'text/html;charset=utf-8' })
              const a = document.createElement('a')
              a.href = URL.createObjectURL(blob)
              a.download = 'article.html'
              a.click()
              URL.revokeObjectURL(a.href)
            }}
          >
            ⬇️ Download
          </button>
          <button
            style={{
              padding: '8px 16px',
              background: 'var(--panel-contrast)',
              border: '1px solid var(--border)',
              borderRadius: '8px',
              color: 'var(--text)',
              cursor: 'pointer',
              fontSize: '14px',
              display: 'flex',
              alignItems: 'center',
              gap: '6px'
            }}
            onClick={() => {
              try {
                navigator.clipboard.writeText(html)
                showToast('HTML copied to clipboard', 'success')
              } catch {}
            }}
          >
            📦 Export
          </button>
        </div>

        {/* Right side buttons */}
        <div style={{ display: 'flex', gap: '12px' }}>
          <button
            style={{
              padding: '8px 16px',
              background: '#3b82f6',
              border: 'none',
              borderRadius: '8px',
              color: 'white',
              cursor: 'pointer',
              fontSize: '14px',
              fontWeight: '600',
              display: 'flex',
              alignItems: 'center',
              gap: '6px'
            }}
            onClick={async () => {
              const title = extractTitleFromHtml(html) || 'Untitled'
              setLoading(true)
              setError(null)
              try {
                await sendDefaultData(sessionId, userId, { H1: { N: true, I: false, U: false, text: title, aligment: 'center', size: 'H1' }, body: [] } as any)
                showToast('Article published', 'success')
                addArticle(title)
                navigate('/home_page')
              } catch (e: any) {
                setError(e?.message ?? String(e))
              } finally {
                setLoading(false)
              }
            }}
          >
            👍 Publish
          </button>
          <button
            style={{
              padding: '8px 16px',
              background: '#f59e0b',
              border: 'none',
              borderRadius: '8px',
              color: 'white',
              cursor: 'pointer',
              fontSize: '14px',
              fontWeight: '600',
              display: 'flex',
              alignItems: 'center',
              gap: '6px'
            }}
            onClick={() => { 
              try { 
                localStorage.setItem('editor_draft', html); 
                showToast('Draft saved', 'success') 
              } catch {} 
            }}
          >
            💾 Save Draft
          </button>
          <button
            style={{
              padding: '8px 16px',
              background: '#16a34a',
              border: 'none',
              borderRadius: '8px',
              color: 'white',
              cursor: 'pointer',
              fontSize: '14px',
              fontWeight: '600',
              display: 'flex',
              alignItems: 'center',
              gap: '6px'
            }}
            onClick={() => navigate('/home_page')}
          >
            ✅ Done
          </button>
        </div>
      </div>

      {/* Main Content */}
      <div style={{ 
        flex: 1, 
        padding: '24px',
        display: 'flex',
        flexDirection: 'column',
        gap: '24px'
      }}>
        {/* Title and Description */}
        <div style={{ textAlign: 'center' }}>
          <h1 style={{ 
            margin: 0, 
            marginBottom: '12px',
            color: '#3b82f6',
            fontSize: '32px',
            fontWeight: '700'
          }}>
            Article Editor
          </h1>
          <p style={{
            margin: 0,
            color: 'var(--muted)',
            fontSize: '16px',
            lineHeight: '1.5',
            maxWidth: '600px',
            margin: '0 auto'
          }}>
            Create stunning articles with our powerful editor. Optimize your content with integrated SEO tools and real-time formatting options.
          </p>
        </div>

        {/* SEO Settings Section */}
        <div style={{
          background: 'var(--panel)',
          border: '1px solid var(--border)',
          borderRadius: '8px',
          overflow: 'hidden'
        }}>
          <div
            style={{
              padding: '16px 20px',
              background: 'var(--panel-contrast)',
              cursor: 'pointer',
              display: 'flex',
              justifyContent: 'space-between',
              alignItems: 'center',
              borderBottom: '1px solid var(--border)'
            }}
          >
            <span style={{
              fontSize: '16px',
              fontWeight: '600',
              color: 'var(--text)'
            }}>
              SEO Settings
            </span>
            <span style={{
              fontSize: '14px',
              color: 'var(--muted)'
            }}>
              ▼
            </span>
          </div>
        </div>

        {/* Editor Toolbar */}
        <div style={{
          background: 'var(--panel)',
          border: '1px solid var(--border)',
          borderRadius: '8px',
          padding: '12px 16px',
          display: 'flex',
          alignItems: 'center',
          gap: '16px',
          flexWrap: 'wrap'
        }}>
          {/* Font Size */}
          <select style={{
            background: 'var(--panel-contrast)',
            border: '1px solid var(--border)',
            borderRadius: '6px',
            padding: '6px 12px',
            color: 'var(--text)',
            fontSize: '14px'
          }}>
            <option>Font size</option>
            <option>12px</option>
            <option>14px</option>
            <option>16px</option>
            <option>18px</option>
            <option>20px</option>
          </select>

          <div style={{ width: '1px', height: '24px', background: 'var(--border)' }} />

          {/* Text Formatting */}
          <button style={{ padding: '8px', background: 'var(--panel-contrast)', border: '1px solid var(--border)', borderRadius: '4px', color: 'var(--text)', cursor: 'pointer', fontWeight: 'bold' }}>B</button>
          <button style={{ padding: '8px', background: 'var(--panel-contrast)', border: '1px solid var(--border)', borderRadius: '4px', color: 'var(--text)', cursor: 'pointer', fontStyle: 'italic' }}>I</button>
          <button style={{ padding: '8px', background: 'var(--panel-contrast)', border: '1px solid var(--border)', borderRadius: '4px', color: 'var(--text)', cursor: 'pointer', textDecoration: 'underline' }}>U</button>
          <button style={{ padding: '8px', background: 'var(--panel-contrast)', border: '1px solid var(--border)', borderRadius: '4px', color: 'var(--text)', cursor: 'pointer', textDecoration: 'line-through' }}>S</button>

          <div style={{ width: '1px', height: '24px', background: 'var(--border)' }} />

          {/* Code */}
          <button style={{ padding: '8px', background: 'var(--panel-contrast)', border: '1px solid var(--border)', borderRadius: '4px', color: 'var(--text)', cursor: 'pointer', fontSize: '12px' }}>&lt;&gt;</button>

          <div style={{ width: '1px', height: '24px', background: 'var(--border)' }} />

          {/* Alignment */}
          <div style={{ position: 'relative' }}>
            <button 
              style={{ 
                padding: '8px', 
                background: activeAlignment === 'left' ? 'var(--primary)' : 'var(--panel-contrast)', 
                border: '1px solid var(--border)', 
                borderRadius: '4px', 
                color: activeAlignment === 'left' ? 'white' : 'var(--text)', 
                cursor: 'pointer' 
              }}
              onClick={() => setActiveAlignment('left')}
            >
              ⫷
            </button>
          </div>
          <div style={{ position: 'relative' }}>
            <button 
              style={{ 
                padding: '8px', 
                background: activeAlignment === 'center' ? 'var(--primary)' : 'var(--panel-contrast)', 
                border: '1px solid var(--border)', 
                borderRadius: '4px', 
                color: activeAlignment === 'center' ? 'white' : 'var(--text)', 
                cursor: 'pointer' 
              }}
              onClick={() => setActiveAlignment('center')}
            >
              ⫸
            </button>
            {activeAlignment === 'center' && (
              <div style={{
                position: 'absolute',
                bottom: '100%',
                left: '50%',
                transform: 'translateX(-50%)',
                background: 'var(--panel)',
                border: '1px solid var(--border)',
                borderRadius: '4px',
                padding: '4px 8px',
                fontSize: '12px',
                color: 'var(--text)',
                whiteSpace: 'nowrap',
                marginBottom: '4px'
              }}>
                Align center
              </div>
            )}
          </div>
          <div style={{ position: 'relative' }}>
            <button 
              style={{ 
                padding: '8px', 
                background: activeAlignment === 'right' ? 'var(--primary)' : 'var(--panel-contrast)', 
                border: '1px solid var(--border)', 
                borderRadius: '4px', 
                color: activeAlignment === 'right' ? 'white' : 'var(--text)', 
                cursor: 'pointer' 
              }}
              onClick={() => setActiveAlignment('right')}
            >
              ⫹
            </button>
          </div>

          <div style={{ width: '1px', height: '24px', background: 'var(--border)' }} />

          {/* Paragraph Style */}
          <select style={{
            background: 'var(--panel-contrast)',
            border: '1px solid var(--border)',
            borderRadius: '6px',
            padding: '6px 12px',
            color: 'var(--text)',
            fontSize: '14px'
          }}>
            <option>Normal</option>
            <option>Heading 1</option>
            <option>Heading 2</option>
            <option>Heading 3</option>
            <option>Quote</option>
          </select>

          <div style={{ width: '1px', height: '24px', background: 'var(--border)' }} />

          {/* Lists */}
          <button style={{ padding: '8px', background: 'var(--panel-contrast)', border: '1px solid var(--border)', borderRadius: '4px', color: 'var(--text)', cursor: 'pointer', fontSize: '14px' }}>☰ •</button>
          <button style={{ padding: '8px', background: 'var(--panel-contrast)', border: '1px solid var(--border)', borderRadius: '4px', color: 'var(--text)', cursor: 'pointer', fontSize: '14px' }}>☰ 1.</button>

          <div style={{ width: '1px', height: '24px', background: 'var(--border)' }} />

          {/* Quote and Link */}
          <button style={{ padding: '8px', background: 'var(--panel-contrast)', border: '1px solid var(--border)', borderRadius: '4px', color: 'var(--text)', cursor: 'pointer' }}>"</button>
          <button style={{ padding: '8px', background: 'var(--panel-contrast)', border: '1px solid var(--border)', borderRadius: '4px', color: 'var(--text)', cursor: 'pointer' }}>🔗</button>
        </div>

        {/* Content Editing Area */}
        <div style={{
          flex: 1,
          background: 'var(--panel)',
          border: '1px solid var(--border)',
          borderRadius: '8px',
          minHeight: '500px',
          padding: '20px'
        }}>
          <ArticleEditor html={html} onChange={setHtml} />
        </div>
      </div>
    </div>
  )
}


