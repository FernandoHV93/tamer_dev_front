import { useArticleBuilder } from '../../store/articleBuilder'

export default function StructureSection() {
  const { model, setStructure } = useArticleBuilder()
  const st = model.articleStructure
  function toggle(key: string) {
    setStructure({ contentOptions: { ...st.contentOptions, [key]: !st.contentOptions[key] } as any })
  }
  return (
    <div style={{ display: 'grid', gap: 12 }}>
      <h3>Structure</h3>
      <label>
        <div>Type of Hook</div>
        <input value={st.typeOfHook} onChange={(e) => setStructure({ typeOfHook: e.target.value })} />
      </label>
      <label>
        <div>Introductory Hook Brief</div>
        <textarea value={st.introductoryHookBrief} onChange={(e) => setStructure({ introductoryHookBrief: e.target.value })} />
      </label>
      <div style={{ display: 'flex', flexWrap: 'wrap', gap: 12 }}>
        {Object.keys(st.contentOptions).map((k) => (
          <label key={k} style={{ border: '1px solid #333', padding: 8, borderRadius: 8 }}>
            <input type="checkbox" checked={!!st.contentOptions[k]} onChange={() => toggle(k)} /> {k}
          </label>
        ))}
      </div>
    </div>
  )
}


