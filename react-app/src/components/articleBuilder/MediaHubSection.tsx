import { useArticleBuilder } from '../../store/articleBuilder'
import { Input } from '../ui/input'
import { Select } from '../ui/select'

export default function MediaHubSection() {
  const { model, setMediaHub } = useArticleBuilder()
  const m = model.articleMediaHub
  return (
    <div style={{ display: 'grid', gap: 16 }} className='card sm:rounded-2xl'>
      <h2 className='mb-6 text-2xl font-bold'>Media Hub</h2>
      <div className="row" style={{ gap: 16, flexWrap: 'wrap' }}>
        <div style={{ flex: 1, minWidth: 180 }}>
          <div>AI Images</div>
          <Select value={m.aiImages ? 'Yes' : 'No'} onChange={(e) => setMediaHub({ aiImages: e.target.value === 'Yes' })}>
            <option>No</option>
            <option>Yes</option>
          </Select>
        </div>
        <div style={{ flex: 1, minWidth: 180 }}>
          <div>Number of images</div>
          <Select value={m.numberOfImages} onChange={(e) => setMediaHub({ numberOfImages: Number(e.target.value) })}>
            {Array.from({ length: 11 }).map((_, i) => (
              <option key={i} value={i}>{i}</option>
            ))}
          </Select>
        </div>
        <div style={{ flex: 1, minWidth: 180 }}>
          <div>Image style</div>
          <Select value={m.imageStyle} onChange={(e) => setMediaHub({ imageStyle: e.target.value })}>
            <option>None</option>
            <option>Realistic</option>
            <option>Illustration</option>
            <option>3D</option>
          </Select>
        </div>
        <div style={{ flex: 1, minWidth: 180 }}>
          <div>Image Size</div>
          <Select value={`${m.imageSize.width}x${m.imageSize.height}`} onChange={(e) => {
            const [w, h] = e.target.value.split('x').map(Number)
            setMediaHub({ imageSize: { width: w, height: h } })
          }}>
            <option value="1080x1920">1080x1920(9:16)</option>
            <option value="1024x1024">1024x1024</option>
            <option value="1920x1080">1920x1080(16:9)</option>
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
          <Select value={m.youtubeVideos ? 'Yes' : 'No'} onChange={(e) => setMediaHub({ youtubeVideos: e.target.value === 'Yes' })}>
            <option>No</option>
            <option>Yes</option>
          </Select>
        </div>
        <div style={{ flex: 1, minWidth: 180 }}>
          <div>Number of videos</div>
          <Select value={m.numberOfVideos} onChange={(e) => setMediaHub({ numberOfVideos: Number(e.target.value) })}>
            {Array.from({ length: 11 }).map((_, i) => (
              <option key={i} value={i}>{i}</option>
            ))}
          </Select>
        </div>
        <div style={{ flex: 1, minWidth: 180 }}>
          <div>Layout Options</div>
          <Select value={m.layoutOption} onChange={(e) => setMediaHub({ layoutOption: e.target.value })}>
            <option>One column</option>
            <option>Two columns</option>
          </Select>
        </div>
      </div>

      <div className="muted-text">All media elements will be placed strictly under the headings. If disabled, the AI will decide and find the best placement.</div>
    </div>
  )
}


