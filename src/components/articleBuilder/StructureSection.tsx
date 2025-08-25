import { useArticleBuilder } from '../../store/articleBuilder'
// import { Input } from '../ui/input'

export default function StructureSection() {
  const { model, setStructure } = useArticleBuilder()
  const st = model.articleStructure
  function toggle(key: string) {
    setStructure({ contentOptions: { ...st.contentOptions, [key]: !st.contentOptions[key] } as any })
  }
  const hookOptions = ['Intriguing Question', 'Statistical Impact', 'Anecdotal', 'Memorable Quote', 'Contrast/Paradox', 'Scene-Setting', 'Universal Problem', 'Surprising Revelation', 'Prediction/Future', 'Unique Definition']
  return (
    <div style={{ display: 'grid', gap: 12 }} className='p-5 sm:p-0'>
      <h2 className='mb-3 text-2xl font-bold'>Structure</h2>
      <div>Introductory Hook Brief</div>
      <div className="flex flex-col gap-3 sm:flex-wrap sm:flex-row" >
        {hookOptions.map((opt) => (
          <button key={opt} className={`btn${st.typeOfHook === opt ? ' btn-primary' : ''}`} onClick={() => setStructure({ typeOfHook: opt })}>{opt}</button>
        ))}
      </div>
      <textarea className="textarea" value={st.introductoryHookBrief} onChange={(e) => setStructure({ introductoryHookBrief: e.target.value })} />

      <h4 style={{ marginTop: 8 }} className='mb-3 text-2xl font-bold'>Content Options</h4>
      <div className="row" style={{ gap: 12, flexWrap: 'wrap' }}>
        {Object.keys(st.contentOptions).map((k) => (
          <label key={k} className="row" style={{ alignItems: 'center', gap: 6, border: '1px solid var(--border)', padding: 8, borderRadius: 8 }}>
            <input type="checkbox" checked={!!st.contentOptions[k]} onChange={() => toggle(k)} /> {k}
          </label>
        ))}
      </div>
    </div>
  )
}


