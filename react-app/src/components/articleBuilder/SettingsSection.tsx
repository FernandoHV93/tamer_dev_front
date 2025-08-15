import { useArticleBuilder } from '../../store/articleBuilder'

export default function SettingsSection() {
  const { model, setSettings } = useArticleBuilder()
  const s = model.articleSettings
  return (
    <div style={{ display: 'grid', gap: 12 }}>
      <h3>Settings</h3>
      <label>
        <div>Article Size</div>
        <input value={s.articleSize} onChange={(e) => setSettings({ articleSize: e.target.value })} />
      </label>
      <label>
        <div>Target Country</div>
        <input value={s.targetCountry} onChange={(e) => setSettings({ targetCountry: e.target.value })} />
      </label>
      <label>
        <div>AI Model</div>
        <input value={s.aiModel} onChange={(e) => setSettings({ aiModel: e.target.value })} />
      </label>
      <label>
        <div>Humanize Text</div>
        <input value={s.humanizeText} onChange={(e) => setSettings({ humanizeText: e.target.value })} />
      </label>
      <label>
        <div>Point of View</div>
        <input value={s.pointOfView} onChange={(e) => setSettings({ pointOfView: e.target.value })} />
      </label>
      <label>
        <div>Tone of Voice</div>
        <input value={s.toneOfVoice} onChange={(e) => setSettings({ toneOfVoice: e.target.value })} />
      </label>
      <label>
        <div>Details</div>
        <textarea value={s.detailsToInclude ?? ''} onChange={(e) => setSettings({ detailsToInclude: e.target.value })} />
      </label>
    </div>
  )
}


