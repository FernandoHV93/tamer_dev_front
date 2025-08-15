import { useEffect, useState } from 'react'
import { useNavigate } from 'react-router-dom'
import FeatureButton from '../components/FeatureButton'
import { useRecentArticles } from '../store/recentArticles'
import { useSession } from '../context/SessionContext'

export default function HomePage() {
  const navigate = useNavigate()
  const { loadRecentArticles, articles, isGenerating, generatingArticleTitle, generatingError, generateArticle } = useRecentArticles()
  const { sessionId, userId } = useSession()
  const [title, setTitle] = useState('')

  useEffect(() => {
    loadRecentArticles()
  }, [loadRecentArticles])

  return (
    <div style={{ padding: 24 }}>
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
        <h2 style={{ color: 'white' }}>Last Articles</h2>
        <div style={{ display: 'flex', gap: 8, marginBottom: 12 }}>
          <input placeholder="Article title" value={title} onChange={(e) => setTitle(e.target.value)} />
          <button disabled={!title || isGenerating} onClick={() => generateArticle(title, sessionId, userId)}>Generate</button>
        </div>
        {isGenerating && (
          <div style={{ background: '#2563EB', padding: 16, borderRadius: 12 }}>
            <span style={{ color: 'white' }}>Generating article: "{generatingArticleTitle ?? ''}"</span>
          </div>
        )}
        {generatingError && (
          <div style={{ background: 'red', padding: 16, borderRadius: 12 }}>
            <span style={{ color: 'white' }}>{generatingError}</span>
          </div>
        )}
        <ul>
          {articles.map((a) => (
            <li key={a.id} style={{ color: 'white', marginBottom: 8 }}>{a.article.h1.text}</li>
          ))}
        </ul>
      </div>
    </div>
  )
}


