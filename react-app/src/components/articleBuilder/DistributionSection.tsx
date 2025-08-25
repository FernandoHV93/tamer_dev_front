import { useArticleBuilder } from '../../store/articleBuilder'
import { Select, 
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue, } from '../ui/select'
import { Input } from '../ui/input'

const socialMediaOptions = [
  { name: 'Twitter', icon: '/assets/images/socialmedia/gorjeo.png' },
  { name: 'LinkedIn', icon: '/assets/images/socialmedia/linkedin.png' },
  { name: 'Facebook', icon: '/assets/images/socialmedia/facebook.png' },
  { name: 'Email', icon: '/assets/images/socialmedia/gmail.png' },
  { name: 'WhatsApp', icon: '/assets/images/socialmedia/whatsapp.png' },
  { name: 'Pinterest', icon: '/assets/images/socialmedia/pinterest.png' }
]

export default function DistributionSection() {
  const { model, setDistribution } = useArticleBuilder()
  const d = model.articleDistribution
  return (
    <div style={{ display: 'grid', gap: 16 }}>
      <h3 style={{ margin: 0 }} className='mb-3 text-2xl font-bold p-5 sm:p-0'>Connect to Web</h3>
      <div className="row p-5 sm:p-0" style={{ gap: 16, flexWrap: 'wrap' }}>
        <div style={{ flex: 1, minWidth: 220 }}>
          <div>Source Links</div>
          <Select value={d.sourceLinks ? 'Yes' : 'No'} onValueChange={(e) => setDistribution({ sourceLinks: e === 'Yes' })}>
            <SelectTrigger className="w-full ">
                  <SelectValue placeholder="Select Links" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="Yes">Yes</SelectItem>
                  <SelectItem value="No">No</SelectItem>
                </SelectContent>
          </Select>
        </div>
        <div style={{ flex: 1, minWidth: 220 }}>
          <div>Citations</div>
          <Select value={d.citations ? 'Yes' : 'No'} onValueChange={(e) => setDistribution({ citations: e === 'Yes' })}>
            
            <SelectTrigger className="w-full ">
                  <SelectValue placeholder="Select Citation" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="Yes">Yes</SelectItem>
                  <SelectItem value="No">No</SelectItem>
                </SelectContent>
          </Select>
        </div>
      </div>

      <div className="card sm:rounded-2xl" >
        <div className="row mb-4" style={{ justifyContent: 'space-between', alignItems: 'center' }}>
          <h4 style={{ margin: 0 }}>Internal Linking</h4>
          <Select><option>None</option></Select>
        </div>
        <Input placeholder="Select a WordPress Site" readOnly />
      </div>

      <div className="card sm:rounded-2xl" >
        <div className="row mb-4" style={{ justifyContent: 'space-between', alignItems: 'center' }}>
          <h4 style={{ margin: 0 }}>External Linking</h4>
          <Select><option>None</option></Select>
        </div>
        <Input placeholder="Select or Add Link" readOnly />
      </div>

      <div className="card sm:rounded-2xl" >
        <h4 style={{ margin: '0 0 16px 0', fontSize: 16, fontWeight: 600, color: '#ffffff' }}>Syndication</h4>
        <div className="row" style={{ flexWrap: 'wrap', gap: 16, marginTop: 8 }}>
          {socialMediaOptions.map((option) => (
            <label key={option.name} className="row" style={{ 
              gap: 10, 
              alignItems: 'center', 
              cursor: 'pointer',
              padding: '8px 12px',
              borderRadius: '8px',
              border: '1px solid #374151',
              backgroundColor: '#1f2937',
              transition: 'all 0.2s ease',
              minWidth: '120px'
            }}>
              <input 
                type="checkbox" 
                style={{ 
                  cursor: 'pointer',
                  width: '16px',
                  height: '16px',
                  accentColor: '#3b82f6'
                }} 
              />
              <img 
                src={option.icon} 
                alt={option.name} 
                width={20} 
                height={20} 
                style={{ 
                  borderRadius: '4px',
                  objectFit: 'contain'
                }} 
              />
              <span style={{ 
                fontSize: 14, 
                color: '#ffffff',
                fontWeight: 500
              }}>
                {option.name}
              </span>
            </label>
          ))}
        </div>
      </div>
    </div>
  )
}


