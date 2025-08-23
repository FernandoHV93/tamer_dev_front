import { useState } from 'react'
import { useArticleBuilder } from '../../store/articleBuilder'
import { Input } from '../ui/input'

export default function SEOSection() {
  const { model, setSEO } = useArticleBuilder()
  const [value, setValue] = useState(model.articleSEO.keywords.join(', '))
  return (
    <div style={{ display: 'grid', gap: 12 }} className='p-5 sm:p-0'>
      <h2 className='mb-3 text-2xl font-bold'>SEO</h2>
      <div className="muted-text">Keywords will be used to generate relevant content. Add them manually or generate them automatically.</div>
      <div className='flex flex-col '>
        <span>Keywords to include in the text</span>
        <label className="flex flex-wrap lg:flex-nowrap gap-4 h-min" >
          <Input
          placeholder="Write keywords and press Enter"
          value={value}
          onChange={(e) => setValue(e.target.value)}
          onBlur={() => setSEO(value.split(',').map((s) => s.trim()).filter(Boolean))}
        />
          <button className="btn btn-primary w-full lg:w-1/3 ">NLP keywords generation</button>
        </label>
        
        <div className="muted-text" style={{ marginTop: 6 }}>Keywords will be used to generate relevant content. You can add them manually or generate them automatically.</div>
      </div>
    </div>
  )
}


