import { useArticleBuilder } from '../../store/articleBuilder'
import { Input } from '../ui/input'
import { Select } from '../ui/select'
import { Button } from '../ui/button'

export default function ArticleGeneratorSection() {
  const { model, setGeneral, saveForm, generate } = useArticleBuilder()
  const g = model.articleGeneratorGeneral

  return (
    <div style={{ display: 'grid', gap: 8 }} className="p-12 card">
        <div className='flex justify-between'>
            <h2 className="text-2xl font-bold">Article Generator</h2>
            {/* Actions */}
             <div className="flex justify-end gap-4">
            <Button
                className='btn-primary '
                variant="default"
                onClick={() => saveForm('session123', 'user123')}
            >
                Save Data
            </Button>
            <Button
            className='btn-primary'
            onClick={() => generate('session123', 'user123')}>
            Run
            </Button>
        </div>
        </div>
      
      <div className="muted-text mb-3 text-base">Generate and publish article in 1 click</div>

      {/* Language */}
      <div className="row" style={{ gap: 16, flexWrap: 'wrap' }}>
        <div style={{ flex: 1, minWidth: 220 }}>
          <div>Language</div>
          <Select
            value={g.language}
            onChange={(e) => setGeneral({ language: e.target.value })}
          >
            <option>English(US)</option>
            <option>English(UK)</option>
            <option>Spanish</option>
            <option>French</option>
          </Select>
        </div>

        {/* Article Type */}
        <div style={{ flex: 1, minWidth: 220 }}>
          <div>Article Type</div>
          <Select
            value={g.articleType}
            onChange={(e) => setGeneral({ articleType: e.target.value })}
          >
            <option>None</option>
            <option>Blog</option>
            <option>News</option>
            <option>Guide</option>
            <option>Review</option>
          </Select>
        </div>
      </div>

      {/* Main Keyword */}
      <div>
        <div>Main Keyword</div>
        <Input
          value={g.articleMainKeyword}
          onChange={(e) => setGeneral({ articleMainKeyword: e.target.value })}
          placeholder="Enter your main keyword"
        />
      </div>

      {/* Title */}
      <div>
        <div>Title</div>
        <Input
          value={g.articleTitle}
          onChange={(e) => setGeneral({ articleTitle: e.target.value })}
          placeholder="Enter your blog title or topic"
        />
      </div>

      {/* Meta Title */}
      <div>
        <div>Meta Title</div>
        <Input
          value={g.articleMetaTitle}
          onChange={(e) => setGeneral({ articleMetaTitle: e.target.value })}
          placeholder="Enter your meta title"
        />
      </div>

      
    </div>
  )
}
