import { useEffect, useState } from 'react'
import { useNavigate } from 'react-router-dom'
import FeatureButton from '../components/FeatureButton'
import { useRecentArticles } from '../store/recentArticles'
import ArticleCard from '../components/ArticleCard'
import { useToast } from '../context/ToastContext'
import Modal from '../components/ui/modal'

export default function HomePage() {
  const navigate = useNavigate()
  const { loadRecentArticles, articles, deleteArticle } = useRecentArticles()
  const { showToast } = useToast()
  const [pendingDeleteId, setPendingDeleteId] = useState<string | null>(null)

  useEffect(() => {
    loadRecentArticles()
  }, [loadRecentArticles])

  return (
    <div className="app-container">
      <FeatureButton
        iconPath="/assets/images/icons/search.svg"
        title="Content Management"
        description="Manage content cards and topics for your websites. Organize your content strategy."
        badgeText="Content Strategy"
        onClick={() => navigate('/content_page')}
      />
      <FeatureButton
        iconPath="/assets/images/icons/pen-tool.svg"
        title="Article Builder"
        description="Create the perfect article using only the title. Generate and publish it in 1 click."
        badgeText="Lightning-Fast"
        onClick={() => navigate('/article_builder')}
      />
      <FeatureButton
        iconPath="/assets/images/icons/worldwide.svg"
        title="Websites"
        description="Manage and organize all your websites in one centralized dashboard."
        badgeText="Management"
        onClick={() => navigate('/websites_page')}
      />
      <FeatureButton
        iconPath="/assets/images/icons/network.svg"
        title="Roadmap"
        description="Visualiza y organiza tu hoja de ruta de proyectos de manera interactiva."
        badgeText="Planning"
        onClick={() => navigate('/roadmap_page')}
      />
      <FeatureButton
        iconPath="/assets/images/icons/edit.svg"
        title="Article Editor"
        description="Fine-tune and perfect your articles with advanced editing tools."
        badgeText="Advanced"
        onClick={() => navigate('/article_editor_page')}
      />
      <FeatureButton
        iconPath="/assets/images/icons/target.svg"
        title="Brand Voice"
        description="Maintain consistent brand voice across all your content and communications."
        badgeText="Consistency"
        onClick={() => navigate('/brand_voice')}
      />
      <FeatureButton
        iconPath="/assets/images/icons/settings.svg"
        title="API Settings"
        description="Configure API connections and manage integrations with external services."
        badgeText="Configuration"
        onClick={() => navigate('/api_settings')}
      />
      <div style={{ marginTop: 32 }}>
        <div className="row" style={{ justifyContent: 'space-between', alignItems: 'center', marginBottom: 12 }}>
          <h2 className="section-title" style={{ margin: 0 }}>Last Articles</h2>
          <button className="btn btn-primary" onClick={() => navigate('/all_articles')}>See all articles</button>
        </div>
        {/* Input + Generate removed as requested */}
        <div className="col">
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
    </div>
  )
}


