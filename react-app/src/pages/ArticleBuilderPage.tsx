import { useArticleBuilder } from '../store/articleBuilder'
import SettingsSection from '../components/articleBuilder/SettingsSection'
import MediaHubSection from '../components/articleBuilder/MediaHubSection'
import SEOSection from '../components/articleBuilder/SEOSection'
import StructureSection from '../components/articleBuilder/StructureSection'
import DistributionSection from '../components/articleBuilder/DistributionSection'

export default function ArticleBuilderPage() {
  const { model, setGeneral, saveForm, generate, isSaving, isGenerating, error } = useArticleBuilder()

  const sessionId = 'Mayo8.com'
  const userId = 'Mayo8.com'

  return (
    <div style={{ padding: 24, display: 'grid', gap: 16 }}>
      <h1>Article Builder</h1>
      {error && <div style={{ color: 'red' }}>{error}</div>}

      <div style={{ display: 'grid', gap: 12, maxWidth: 720 }}>
        <label>
          <div>Language</div>
          <input
            value={model.articleGeneratorGeneral.language}
            onChange={(e) => setGeneral({ language: e.target.value })}
          />
        </label>
        <label>
          <div>Article Type</div>
          <input
            value={model.articleGeneratorGeneral.articleType}
            onChange={(e) => setGeneral({ articleType: e.target.value })}
          />
        </label>
        <label>
          <div>Main Keyword</div>
          <input
            value={model.articleGeneratorGeneral.articleMainKeyword}
            onChange={(e) => setGeneral({ articleMainKeyword: e.target.value })}
          />
        </label>
        <label>
          <div>Title</div>
          <input
            value={model.articleGeneratorGeneral.articleTitle}
            onChange={(e) => setGeneral({ articleTitle: e.target.value })}
          />
        </label>
      </div>

      <div style={{ display: 'flex', gap: 12 }}>
        <button disabled={isSaving} onClick={() => saveForm(sessionId, userId)}>
          {isSaving ? 'Saving…' : 'Save Form'}
        </button>
        <button disabled={isGenerating} onClick={() => generate(sessionId, userId)}>
          {isGenerating ? 'Generating…' : 'Generate Article'}
        </button>
      </div>
      <div style={{ display: 'grid', gap: 24, marginTop: 16 }}>
        <SettingsSection />
        <MediaHubSection />
        <SEOSection />
        <StructureSection />
        <DistributionSection />
      </div>
    </div>
  )
}


