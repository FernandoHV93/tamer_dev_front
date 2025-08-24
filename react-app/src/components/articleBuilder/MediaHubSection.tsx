import { useArticleBuilder } from '../../store/articleBuilder'
import { Input } from '../ui/input'
import { Select,
  SelectContent,
  SelectGroup,
  SelectItem,
  SelectTrigger,
  SelectValue, } from '../ui/select'

export default function MediaHubSection() {
  const { model, setMediaHub } = useArticleBuilder()
  const m = model.articleMediaHub
  return (
    <div style={{ display: 'grid', gap: 16 }} className='card sm:rounded-2xl'>
      <h2 className='mb-6 text-2xl font-bold'>Media Hub</h2>
      <div className="row" style={{ gap: 16, flexWrap: 'wrap' }}>
        <div style={{ flex: 1, minWidth: 180 }}>
          <div>AI Images</div>
          <Select value={m.aiImages ? 'Yes' : 'No'} onValueChange={(val) => setMediaHub({ aiImages: val === 'Yes' })}>
             <SelectTrigger className="w-full bg-[var(--bg)]">
              <SelectValue placeholder="Yes or No" />
            </SelectTrigger>
            <SelectContent className='w-full bg-[var(--bg)] border-[var(--border)]'>
              <SelectGroup>
              <SelectItem className='hover:bg-[var(--panel)]' value="Yes">Yes</SelectItem>
              <SelectItem className='hover:bg-[var(--panel)]' value="No">No</SelectItem>
              </SelectGroup>
            </SelectContent>
          </Select>
        </div>
        <div style={{ flex: 1, minWidth: 180 }}>
          <div>Number of images</div>
          <Select value={String(m.numberOfImages)} onValueChange={(val) => setMediaHub({ numberOfImages: Number(val) })}>
            <SelectTrigger className="w-full bg-[var(--bg)]">
              <SelectValue placeholder="Number of Images" />
            </SelectTrigger>
            <SelectContent className='w-full bg-[var(--bg)] border-[var(--border)]'>
                {Array.from({ length: 11 }).map((_, i) => (
              <SelectItem className='hover:bg-[var(--panel)]' key={i} value={String(i)}>{i}</SelectItem>
            ))}
            </SelectContent>
          </Select>
        </div>
        <div style={{ flex: 1, minWidth: 180 }}>
          <div>Image style</div>
          <Select value={m.imageStyle} onValueChange={(val) => setMediaHub({ imageStyle: val })}>
            <SelectTrigger className="w-full bg-[var(--bg)]">
              <SelectValue placeholder="Image Style" />
            </SelectTrigger>
            <SelectContent className='w-full bg-[var(--bg)] border-[var(--border)]'>
              <SelectGroup>
              <SelectItem className='hover:bg-[var(--panel)]' value="None">None</SelectItem>
              <SelectItem className='hover:bg-[var(--panel)]' value="Realistic">Realistic</SelectItem>
              <SelectItem className='hover:bg-[var(--panel)]' value="Illustration">Illustration</SelectItem>
              <SelectItem className='hover:bg-[var(--panel)]' value="3D">3D</SelectItem>
              </SelectGroup>
            </SelectContent>
          </Select>
        </div>
        <div style={{ flex: 1, minWidth: 180 }}>
          <div>Image Size</div>
          <Select
              value={`${m.imageSize.width}x${m.imageSize.height}`}
              onValueChange={(val) => {
                const [w, h] = val.split('x').map(Number)
                setMediaHub({ imageSize: { width: w, height: h } })
              }}
            >
            <SelectTrigger className="w-full bg-[var(--bg)]">
              <SelectValue placeholder="Image Size" />
            </SelectTrigger>
            <SelectContent className='w-full bg-[var(--bg)] border-[var(--border)]'>
              <SelectGroup>
              <SelectItem className='hover:bg-[var(--panel)]' value="1080x1920">1080x1920(9:16)</SelectItem>
              <SelectItem className='hover:bg-[var(--panel)]' value="1024x1024">1024x1024</SelectItem>
              <SelectItem className='hover:bg-[var(--panel)]' value="1920x1080">1920x1080(16:9)</SelectItem>
              </SelectGroup>
            </SelectContent>
          </Select>
        </div>
      </div>

      <div className="row" style={{ gap: 16 }}>
        <div style={{ flex: 1 }}>
          <div>Additional Instructions</div>
          <textarea className="textarea" value={m.additionalInstructions} onChange={(e) => setMediaHub({ additionalInstructions: e.target.value })} />
          <div className="muted-text">Include the main keyword in the first image as Alt-text. Relevant keywords will be picked up and added to the rest of the images.</div>
        </div>
        
      </div>

      <div className="row" >
        <div style={{flex:1, minWidth: 180 }} >
          <div>Brand Name</div>
          <Input value={m.brandName}  onChange={(e) => setMediaHub({ brandName: e.target.value })} placeholder="Enter your brand name" />
        </div>
        <div style={{ flex: 1, minWidth: 180 }}>
          <div>YouTube videos</div>
          <Select
            value={m.youtubeVideos ? "Yes" : "No"}
            onValueChange={(val) => setMediaHub({ youtubeVideos: val === "Yes" })}
          >
            <SelectTrigger className="w-full">
              <SelectValue placeholder="YouTube videos" />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value="No">No</SelectItem>
              <SelectItem value="Yes">Yes</SelectItem>
            </SelectContent>
          </Select>
        </div>

        <div style={{ flex: 1, minWidth: 180 }}>
          <div>Number of videos</div>
          <Select
            value={String(m.numberOfVideos)}
            onValueChange={(val) => setMediaHub({ numberOfVideos: Number(val) })}
          >
            <SelectTrigger className="w-full">
              <SelectValue placeholder="Number of videos" />
            </SelectTrigger>
            <SelectContent>
              {Array.from({ length: 11 }).map((_, i) => (
                <SelectItem key={i} value={String(i)}>
                  {i}
                </SelectItem>
              ))}
            </SelectContent>
          </Select>
        </div>

        <div style={{ flex: 1, minWidth: 180 }}>
          <div>Layout Options</div>
          <Select
            value={m.layoutOption}
            onValueChange={(val) => setMediaHub({ layoutOption: val })}
          >
            <SelectTrigger className="w-full">
              <SelectValue placeholder="Layout Options" />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value="One column">One column</SelectItem>
              <SelectItem value="Two columns">Two columns</SelectItem>
            </SelectContent>
          </Select>
        </div>

      </div>

      <div className="muted-text">All media elements will be placed strictly under the headings. If disabled, the AI will decide and find the best placement.</div>
    </div>
  )
}


