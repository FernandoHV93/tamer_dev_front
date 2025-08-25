import { useArticleBuilder } from '../../store/articleBuilder'
import { Input } from '../ui/input'
import { Select,
  SelectContent,
  SelectGroup,
  SelectItem,
  SelectTrigger,
  SelectValue, } from '../ui/select'
import { Button } from '../ui/button'
import { useToast } from '../../context/ToastContext'

export default function ArticleGeneratorSection() {
  const { model, setGeneral, saveForm, generate } = useArticleBuilder()
  const g = model.articleGeneratorGeneral
  const { showToast } = useToast()

  const handleSave = async () => {
    try {
      await saveForm("Mayo8.com", "Mayo8.com")
      showToast("Article saved in proccess", "info")
    } catch {
      showToast("Error al guardar el artículo ❌", "error")
    }
  }
  const handleGenerate = async () => {
    try {
      await generate("Mayo8.com", "Mayo8.com")
      showToast("Article generated in proccess", "info")
    } catch {
      showToast("Error al guardar el artículo ❌", "error")
    }
  }


  return (
    <div style={{ display: 'grid', gap: 8 }} className="card sm:rounded-2xl w-[100vw] sm:w-full">
        <div className='flex  flex-wrap gap-1 lg:flex-row justify-between lg:justify-between'>
            <h2 className="text-2xl 2xl:text-3xl font-bold">Article Generator</h2>
            {/* Actions */}
             <div className="flex justify-end gap-4">
            <Button
                className='btn-primary 2xl:text-lg'
                variant="default"
                onClick={handleSave}
            >
                Save Data
            </Button>
            <Button
            className='btn-primary 2xl:text-lg'
            onClick={handleGenerate}>
            Run
            </Button>
        </div>
        </div>
      
      <div className="muted-text mb-3 text-base 2xl:text-lg">Generate and publish article in 1 click</div>

      {/* Language */}
      <div className="row" style={{ gap: 16, flexWrap: 'wrap' }}>
        <div style={{ flex: 1, minWidth: 220 }}>
          <div>Language</div>
          <Select
            value={g.language}
            onValueChange={(val) => setGeneral({ language: val })}
            
          >
             <SelectTrigger className="w-full bg-[var(--bg)]">
              <SelectValue placeholder="Select a Lenguage" />
            </SelectTrigger>
            <SelectContent className='w-full bg-[var(--bg)] border-[var(--border)]'>
              <SelectGroup>
              <SelectItem className='hover:bg-[var(--panel)]' value="English(US)">English(US)</SelectItem>
              <SelectItem className='hover:bg-[var(--panel)]' value="English(UK)">English(UK)</SelectItem>
              <SelectItem className='hover:bg-[var(--panel)]' value="Spanish">Spanish</SelectItem>
              <SelectItem className='hover:bg-[var(--panel)]' value="French">French</SelectItem>
              </SelectGroup>
            </SelectContent>
          </Select>
        </div>

        {/* Article Type */}
        <div style={{ flex: 1, minWidth: 220 }}>
          <div>Article Type</div>
          <Select
            value={g.articleType}
            onValueChange={(val) => setGeneral({ articleType: val })}
          >
            <SelectTrigger className="w-full bg-amber-50">
              <SelectValue placeholder="Lenguage" />
            </SelectTrigger>
            <SelectContent className='w-full bg-[var(--bg)] border-[var(--border)]'>
              <SelectItem className='hover:bg-[var(--panel)]' value="None">None</SelectItem>
              <SelectItem className='hover:bg-[var(--panel)]' value="Blog">Blog</SelectItem>
              <SelectItem className='hover:bg-[var(--panel)]' value="Guide">Guide</SelectItem>
              <SelectItem className='hover:bg-[var(--panel)]' value="Review">Review</SelectItem>
            </SelectContent>
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
