import { useArticleBuilder } from '../../store/articleBuilder'

export default function DistributionSection() {
  const { model, setDistribution } = useArticleBuilder()
  const d = model.articleDistribution
  return (
    <div style={{ display: 'grid', gap: 12 }}>
      <h3>Distribution</h3>
      <label>
        <input type="checkbox" checked={d.sourceLinks} onChange={(e) => setDistribution({ sourceLinks: e.target.checked })} /> Source Links
      </label>
      <label>
        <input type="checkbox" checked={d.citations} onChange={(e) => setDistribution({ citations: e.target.checked })} /> Citations
      </label>
      <label>
        <div>Internal Links (comma separated)</div>
        <input
          value={d.internalLinking.join(', ')}
          onChange={(e) => setDistribution({ internalLinking: e.target.value.split(',').map((s) => s.trim()).filter(Boolean) })}
        />
      </label>
      <label>
        <div>External Links (comma separated)</div>
        <input
          value={d.externalLinking.join(', ')}
          onChange={(e) => setDistribution({ externalLinking: e.target.value.split(',').map((s) => s.trim()).filter(Boolean) })}
        />
      </label>
    </div>
  )
}


