import { useEffect, useState } from 'react'
import { useNavigate } from 'react-router-dom'
import { useRecentArticles } from '../store/recentArticles'
import ArticleCard from '../components/ArticleCard'
import { useToast } from '../context/ToastContext'
import Modal from '../components/ui/modal'

export default function AllArticlesPage() {
  const navigate = useNavigate()
  const { loadRecentArticles, articles, deleteArticle } = useRecentArticles()
  const { showToast } = useToast()
  const [pendingDeleteId, setPendingDeleteId] = useState<string | null>(null)

  useEffect(() => {
    loadRecentArticles()
  }, [loadRecentArticles])

  return (
    <div className="app-container">
      <div className="row" style={{ justifyContent: 'space-between', alignItems: 'center', marginBottom: 12 }}>
        <h2 className="section-title" style={{ margin: 0 }}>All Articles</h2>
        <button className="btn btn-primary" onClick={() => navigate('/article_builder')}>Create new article</button>
      </div>

      <div className="row" style={{ alignItems: 'flex-start' }}>
        <div className="col" style={{ flex: 1 }}>
          {articles.map((a) => (
            <ArticleCard
              key={a.id}
              title={a.article.h1.text}
              score={a.article.score}
              date={(a.article as any).date}
              wordCount={(a.article as any).wordCount}
              onOpen={() => navigate(`/article_editor_page?id=${encodeURIComponent(a.id)}`)}
              onEdit={() => navigate(`/article_editor_page?id=${encodeURIComponent(a.id)}`)}
              onDelete={() => setPendingDeleteId(a.id)}
            />
          ))}
        </div>

        <div style={{ width: 340, display: 'grid', gap: 12 }}>
          <div className="card">
            <h3 style={{ marginTop: 0 }}>Tips</h3>
            <ul style={{ margin: 0, paddingLeft: 18, color: 'var(--muted)' }}>
              <li>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</li>
              <li>Praesent commodo cursus magna, vel scelerisque nisl consectetur.</li>
              <li>Donec id elit non mi porta gravida at eget metus.</li>
              <li>Maecenas faucibus mollis interdum.</li>
              <li>Vivamus sagittis lacus vel augue laoreet rutrum faucibus.</li>
            </ul>
          </div>

          <div className="card">
            <h3 style={{ marginTop: 0 }}>How to generate articles</h3>
            <div style={{ width: '100%', height: 200 }}>
              <iframe
                src="https://www.youtube.com/embed/VIDEO_ID"
                title="How to generate articles"
                style={{ width: '100%', height: '100%', border: 0, borderRadius: 8 }}
                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
                allowFullScreen
              />
            </div>
          </div>
        </div>
      </div>

      <Modal
        open={!!pendingDeleteId}
        title="Delete article"
        description={<span>Are you sure you want to delete this article? This action cannot be undone.</span>}
        confirmText="Delete"
        cancelText="Cancel"
        onCancel={() => setPendingDeleteId(null)}
        onConfirm={() => {
          if (pendingDeleteId) {
            deleteArticle(pendingDeleteId)
            showToast('Article deleted', 'success')
            setPendingDeleteId(null)
          }
        }}
      />
    </div>
  )
}



