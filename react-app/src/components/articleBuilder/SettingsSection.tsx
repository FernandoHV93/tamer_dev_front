import { useArticleBuilder } from '../../store/articleBuilder'
import { Input } from '../ui/input'
import { Select } from '../ui/select'
import { Button } from '../ui/button'

export default function SettingsSection() {
  const { model, setSettings } = useArticleBuilder()
  const s = model.articleSettings
  return (
    <div className='sm:rounded-2xl card '>
      <h2 className='mb-6 text-2xl font-bold'>Article Settings</h2>
      <div style={{ display: 'flex', flexDirection: 'column', gap: '24px' }}>
        <div style={{ display: 'flex', gap: '16px', flexWrap: 'wrap' }}>
          <div style={{ flex: '1', minWidth: '200px' }}>
            <label style={{
              display: 'block',
              fontSize: '14px',
              fontWeight: '500',
              color: '#e5e7eb',
              marginBottom: '8px'
            }}>
              Article Size
            </label>
            <div style={{ position: 'relative' }}>
              <img 
                src="/assets/images/icons/files.svg" 
                alt="" 
                style={{
                  position: 'absolute',
                  left: '12px',
                  top: '50%',
                  transform: 'translateY(-50%)',
                  width: '16px',
                  height: '16px',
                  filter: 'brightness(0) invert(1)',
                  opacity: 0.7,
                  pointerEvents: 'none'
                }}
              />
              <Select 
                value={s.articleSize} 
                onChange={(e) => setSettings({ articleSize: e.target.value })}
                style={{
                  width: '100%',
                  padding: '6px 6px 6px 40px',
                  border: '1px solid #374151',
                  borderRadius: '8px',
                  color: '#ffffff',
                  fontSize: '14px'
                }}
              >
                <option>X-Small</option>
                <option>Small</option>
                <option>Medium</option>
                <option>Large</option>
                <option>XL</option>
              </Select>
            </div>
          </div>
          <div style={{ flex: '1', minWidth: '200px' }}>
            <label style={{
              display: 'block',
              fontSize: '14px',
              fontWeight: '500',
              color: '#e5e7eb',
              marginBottom: '8px'
            }}>
              Size Details
            </label>
            <div style={{ position: 'relative' }}>
              <img 
                src="/assets/images/icons/docs.svg" 
                alt="" 
                style={{
                  position: 'absolute',
                  left: '12px',
                  top: '50%',
                  transform: 'translateY(-50%)',
                  width: '16px',
                  height: '16px',
                  filter: 'brightness(0) invert(1)',
                  opacity: 0.7,
                  pointerEvents: 'none'
                }}
              />
              <Input 
                value={sizeDetailsFor(s.articleSize)} 
                readOnly 
                style={{
                  width: '100%',
                  padding: '6px 6px 6px 40px',
                
                  border: '1px solid #374151',
                  borderRadius: '8px',
                  color: '#ffffff',
                  fontSize: '14px'
                }}
              />
            </div>
          </div>
          <div style={{ flex: '1', minWidth: '200px' }}>
            <label style={{
              display: 'block',
              fontSize: '14px',
              fontWeight: '500',
              color: '#e5e7eb',
              marginBottom: '8px'
            }}>
              Target Country
            </label>
            <div style={{ position: 'relative' }}>
              <img 
                src="/assets/images/icons/worldwide.svg" 
                alt="" 
                style={{
                  position: 'absolute',
                  left: '12px',
                  top: '50%',
                  transform: 'translateY(-50%)',
                  width: '16px',
                  height: '16px',
                  filter: 'brightness(0) invert(1)',
                  opacity: 0.7,
                  pointerEvents: 'none'
                }}
              />
              <Select 
                value={s.targetCountry} 
                onChange={(e) => setSettings({ targetCountry: e.target.value })}
                style={{
                  width: '100%',
                  padding: '6px 6px 6px 40px',
                
                  border: '1px solid #374151',
                  borderRadius: '8px',
                  color: '#ffffff',
                  fontSize: '14px'
                }}
              >
                <option>USA</option>
                <option>Spain</option>
                <option>France</option>
                <option>Germany</option>
              </Select>
            </div>
          </div>
        </div>

        <div style={{ display: 'flex', gap: '16px', flexWrap: 'wrap' }}>
          <div style={{ flex: '1', minWidth: '200px' }}>
            <label style={{
              display: 'block',
              fontSize: '14px',
              fontWeight: '500',
              color: '#e5e7eb',
              marginBottom: '8px'
            }}>
              AI Model
            </label>
            <div style={{ position: 'relative' }}>
              <img 
                src="/assets/images/icons/brain.svg" 
                alt="" 
                style={{
                  position: 'absolute',
                  left: '12px',
                  top: '50%',
                  transform: 'translateY(-50%)',
                  width: '16px',
                  height: '16px',
                  filter: 'brightness(0) invert(1)',
                  opacity: 0.7,
                  pointerEvents: 'none'
                }}
              />
              <Select 
                value={s.aiModel} 
                onChange={(e) => setSettings({ aiModel: e.target.value })}
                style={{
                  width: '100%',
                  padding: '6px 6px 6px 40px',
                
                  border: '1px solid #374151',
                  borderRadius: '8px',
                  color: '#ffffff',
                  fontSize: '14px'
                }}
              >
                <option>gpt-4o</option>
                <option>GPT-4</option>
                <option>Claude-3.5</option>
              </Select>
            </div>
          </div>
          <div style={{ flex: '1', minWidth: '200px' }}>
            <label style={{
              display: 'block',
              fontSize: '14px',
              fontWeight: '500',
              color: '#e5e7eb',
              marginBottom: '8px'
            }}>
              Humanize Text
            </label>
            <div style={{ position: 'relative' }}>
              <img 
                src="/assets/images/icons/hand-heart.svg" 
                alt="" 
                style={{
                  position: 'absolute',
                  left: '12px',
                  top: '50%',
                  transform: 'translateY(-50%)',
                  width: '16px',
                  height: '16px',
                  filter: 'brightness(0) invert(1)',
                  opacity: 0.7,
                  pointerEvents: 'none'
                }}
              />
              <Select 
                value={s.humanizeText} 
                onChange={(e) => setSettings({ humanizeText: e.target.value })}
                style={{
                  width: '100%',
                  padding: '6px 6px 6px 40px',
                
                  border: '1px solid #374151',
                  borderRadius: '8px',
                  color: '#ffffff',
                  fontSize: '14px'
                }}
              >
                <option>None</option>
                <option>Low</option>
                <option>Medium</option>
                <option>High</option>
              </Select>
            </div>
          </div>
          <div style={{ flex: '1', minWidth: '200px' }}>
            <label style={{
              display: 'block',
              fontSize: '14px',
              fontWeight: '500',
              color: '#e5e7eb',
              marginBottom: '8px'
            }}>
              AI Words Removal
            </label>
            <div style={{ position: 'relative' }}>
              <img 
                src="/assets/images/icons/shield-user.svg" 
                alt="" 
                style={{
                  position: 'absolute',
                  left: '12px',
                  top: '50%',
                  transform: 'translateY(-50%)',
                  width: '16px',
                  height: '16px',
                  filter: 'brightness(0) invert(1)',
                  opacity: 0.7,
                  pointerEvents: 'none'
                }}
              />
              <Select 
                value={s.aiWordsRemoval} 
                onChange={(e) => setSettings({ aiWordsRemoval: e.target.value })}
                style={{
                  width: '100%',
                  padding: '6px 6px 6px 40px',
                
                  border: '1px solid #374151',
                  borderRadius: '8px',
                  color: '#ffffff',
                  fontSize: '14px'
                }}
              >
                <option>No AI Words Removal</option>
                <option>Light</option>
                <option>Moderate</option>
                <option>Aggressive</option>
              </Select>
            </div>
          </div>
        </div>

        <div style={{ display: 'flex', gap: '16px', flexWrap: 'wrap' }}>
          <div style={{ flex: '1', minWidth: '200px' }}>
            <label style={{
              display: 'block',
              fontSize: '14px',
              fontWeight: '500',
              color: '#e5e7eb',
              marginBottom: '8px'
            }}>
              Point of View
            </label>
            <div style={{ position: 'relative' }}>
              <img 
                src="/assets/images/icons/eye.svg" 
                alt="" 
                style={{
                  position: 'absolute',
                  left: '12px',
                  top: '50%',
                  transform: 'translateY(-50%)',
                  width: '16px',
                  height: '16px',
                  filter: 'brightness(0) invert(1)',
                  opacity: 0.7,
                  pointerEvents: 'none'
                }}
              />
              <Select 
                value={s.pointOfView} 
                onChange={(e) => setSettings({ pointOfView: e.target.value })}
                style={{
                  width: '100%',
                  padding: '6px 6px 6px 40px',
                
                  border: '1px solid #374151',
                  borderRadius: '8px',
                  color: '#ffffff',
                  fontSize: '14px'
                }}
              >
                <option>First Person Singular</option>
                <option>First Person Plural</option>
                <option>Second Person</option>
                <option>Third Person</option>
              </Select>
            </div>
          </div>
          <div style={{ flex: '1', minWidth: '200px' }}>
            <label style={{
              display: 'block',
              fontSize: '14px',
              fontWeight: '500',
              color: '#e5e7eb',
              marginBottom: '8px'
            }}>
              Tone of Voice
            </label>
            <div style={{ position: 'relative' }}>
              <img 
                src="/assets/images/icons/speech.svg" 
                alt="" 
                style={{
                  position: 'absolute',
                  left: '12px',
                  top: '50%',
                  transform: 'translateY(-50%)',
                  width: '16px',
                  height: '16px',
                  filter: 'brightness(0) invert(1)',
                  opacity: 0.7,
                  pointerEvents: 'none'
                }}
              />
              <Select 
                value={s.toneOfVoice} 
                onChange={(e) => setSettings({ toneOfVoice: e.target.value })}
                style={{
                  width: '100%',
                  padding: '6px 6px 6px 40px',
                
                  border: '1px solid #374151',
                  borderRadius: '8px',
                  color: '#ffffff',
                  fontSize: '14px'
                }}
              >
                <option>Normal</option>
                <option>Friendly</option>
                <option>Professional</option>
                <option>Playful</option>
              </Select>
            </div>
          </div>
        </div>

        <div>
          <label style={{
            display: 'block',
            fontSize: '14px',
            fontWeight: '500',
            color: '#e5e7eb',
            marginBottom: '8px'
          }}>
            Details
          </label>
          <textarea 
            value={s.detailsToInclude ?? ''} 
            onChange={(e) => setSettings({ detailsToInclude: e.target.value })}
            placeholder="Add any specific details or requirements for your article..."
            style={{
              width: '100%',
              minHeight: 120,
              padding: '12px',
            
              border: '1px solid #374151',
              borderRadius: '8px',
              color: '#ffffff',
              fontSize: '14px',
              resize: 'vertical',
              fontFamily: 'inherit'
            }}
          />
        </div>

        <div>
          <h4 style={{ 
            margin: '0 0 12px 0', 
            fontSize: 16, 
            fontWeight: 600, 
            color: '#ffffff',
            letterSpacing: '-0.025em'
          }}>
            Brand Voice
          </h4>
          <div style={{ position: 'relative' }}>
            <Input 
              placeholder="Enter brand voice name" 
              value={s.brandVoice?.brandName ?? ''} 
              onChange={(e) => setSettings({ brandVoice: { ...(s.brandVoice ?? { id: '' } as any), brandName: e.target.value } as any })} 
              style={{ 
                width: '100%',
                padding: '6px 80px 6px 12px',
              
                border: '1px solid #374151',
                borderRadius: '8px',
                color: '#ffffff',
                fontSize: '14px'
              }}
            />
            <div style={{ 
              position: 'absolute', 
              right: '8px', 
              top: '50%', 
              transform: 'translateY(-50%)',
              display: 'flex',
              alignItems: 'center',
              gap: '8px'
            }}>
              <img 
                src="/assets/images/icons/shield-user.svg" 
                alt="" 
                width={16} 
                height={16} 
                style={{ 
                  filter: 'brightness(0) invert(1)',
                  opacity: 0.7,
                  cursor: 'pointer'
                }} 
              />
              <div style={{
                width: '16px',
                height: '16px',
                border: '1px solid #6b7280',
                borderRadius: '50%',
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'center',
                cursor: 'pointer'
              }}>
                <div style={{
                  width: '0',
                  height: '0',
                  borderLeft: '4px solid transparent',
                  borderRight: '4px solid transparent',
                  borderTop: '4px solid #6b7280',
                  marginTop: '2px'
                }}></div>
              </div>
            </div>
          </div>
          <p style={{ 
            margin: '8px 0 0 0', 
            fontSize: 13, 
            color: '#9ca3af',
            lineHeight: 1.5
          }}>
            Create unique styles and tones for different situations to keep your content consistent.
          </p>
        </div>
      </div>
    </div>
  )
}

function sizeDetailsFor(size: string): string {
  switch (size) {
    case 'X-Small':
    case 'Small':
      return '600-1200 words, H2 headings'
    case 'Medium':
      return '1200-2000 words, H2/H3 headings'
    case 'Large':
    case 'XL':
      return '2000+ words, H2/H3 headings'
    default:
      return '600-1200 words, H2 headings'
  }
}


