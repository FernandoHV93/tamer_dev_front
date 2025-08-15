import { useArticleBuilder } from '../../store/articleBuilder'

export default function MediaHubSection() {
  const { model, setMediaHub } = useArticleBuilder()
  const m = model.articleMediaHub
  return (
    <div style={{ display: 'grid', gap: 12 }}>
      <h3>Media Hub</h3>
      <label>
        <input type="checkbox" checked={m.aiImages} onChange={(e) => setMediaHub({ aiImages: e.target.checked })} /> AI Images
      </label>
      <label>
        <div>Number of Images</div>
        <input type="number" value={m.numberOfImages} onChange={(e) => setMediaHub({ numberOfImages: Number(e.target.value) })} />
      </label>
      <label>
        <div>Image Style</div>
        <input value={m.imageStyle} onChange={(e) => setMediaHub({ imageStyle: e.target.value })} />
      </label>
      <label>
        <div>Layout Option</div>
        <input value={m.layoutOption} onChange={(e) => setMediaHub({ layoutOption: e.target.value })} />
      </label>
      <label>
        <input type="checkbox" checked={m.youtubeVideos} onChange={(e) => setMediaHub({ youtubeVideos: e.target.checked })} /> YouTube Videos
      </label>
      <label>
        <div>Number of Videos</div>
        <input type="number" value={m.numberOfVideos} onChange={(e) => setMediaHub({ numberOfVideos: Number(e.target.value) })} />
      </label>
      <label>
        <input type="checkbox" checked={m.includeKeywords} onChange={(e) => setMediaHub({ includeKeywords: e.target.checked })} /> Include Keywords
      </label>
      <label>
        <input type="checkbox" checked={m.placeUnderHeadings} onChange={(e) => setMediaHub({ placeUnderHeadings: e.target.checked })} /> Place Under Headings
      </label>
      <label>
        <div>Additional Instructions</div>
        <textarea value={m.additionalInstructions} onChange={(e) => setMediaHub({ additionalInstructions: e.target.value })} />
      </label>
    </div>
  )
}


