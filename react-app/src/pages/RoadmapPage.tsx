import { useEffect, useState } from 'react'
import * as api from '../services/roadmap'
import { useToast } from '../context/ToastContext'

interface Block {
  id: string
  title: string
  status: 'done' | 'to-check' | 'to-fix'
  position?: { x: number; y: number }
  comments?: string[]
  links?: string[]
}

export default function RoadmapPage() {
  const { showToast } = useToast()
  const [blocks, setBlocks] = useState<Block[]>([
    { id: '1', title: 'Initial Block', status: 'done', position: { x: 50, y: 50 }, comments: [], links: [] }
  ])
  const [selectedBlock, setSelectedBlock] = useState<Block | null>(null)
  const [isLoading, setIsLoading] = useState(false)
  const [showEditModal, setShowEditModal] = useState(false)
  const [showToolbar, setShowToolbar] = useState(false)
  const [showAddContentModal, setShowAddContentModal] = useState(false)
  const [editTitle, setEditTitle] = useState('')
  const [editStatus, setEditStatus] = useState<'done' | 'to-check' | 'to-fix'>('to-check')
  const [newComment, setNewComment] = useState('')
  const [newLink, setNewLink] = useState('')
  const [draggedBlock, setDraggedBlock] = useState<string | null>(null)
  const [dragOffset, setDragOffset] = useState({ x: 0, y: 0 })

  // Calculate counts for each status
  const doneCount = blocks.filter(b => b.status === 'done').length
  const toCheckCount = blocks.filter(b => b.status === 'to-check').length
  const toFixCount = blocks.filter(b => b.status === 'to-fix').length

  async function load() {
    try {
      setIsLoading(true)
      const r = await api.getRoadmap()
      if (r && r.items) {
        setBlocks(r.items)
      }
    } catch (e: any) {
      showToast(e?.message ?? String(e), 'error')
    } finally {
      setIsLoading(false)
    }
  }

  async function saveRoadmap() {
    try {
      setIsLoading(true)
      await api.saveRoadmap({ items: blocks })
      showToast('Roadmap saved', 'success')
    } catch (e: any) {
      showToast(e?.message ?? String(e), 'error')
    } finally {
      setIsLoading(false)
    }
  }

  const openEditModal = (block: Block) => {
    setEditTitle(block.title)
    setEditStatus(block.status)
    setShowEditModal(true)
  }

  const saveBlockChanges = () => {
    if (selectedBlock) {
      const updatedBlocks = blocks.map(block => 
        block.id === selectedBlock.id 
          ? { ...block, title: editTitle, status: editStatus }
          : block
      )
      setBlocks(updatedBlocks)
      setShowEditModal(false)
      showToast('Block updated successfully', 'success')
    }
  }

  const addComment = () => {
    if (newComment.trim() && selectedBlock) {
      const updatedBlocks = blocks.map(block => 
        block.id === selectedBlock.id 
          ? { ...block, comments: [...(block.comments || []), newComment.trim()] }
          : block
      )
      setBlocks(updatedBlocks)
      setNewComment('')
    }
  }

  const addLink = () => {
    if (newLink.trim() && selectedBlock) {
      const updatedBlocks = blocks.map(block => 
        block.id === selectedBlock.id 
          ? { ...block, links: [...(block.links || []), newLink.trim()] }
          : block
      )
      setBlocks(updatedBlocks)
      setNewLink('')
    }
  }

  const exportRoadmap = () => {
    const dataStr = JSON.stringify(blocks, null, 2)
    const dataBlob = new Blob([dataStr], { type: 'application/json' })
    const url = URL.createObjectURL(dataBlob)
    const link = document.createElement('a')
    link.href = url
    link.download = 'roadmap.json'
    link.click()
    URL.revokeObjectURL(url)
    showToast('Roadmap exported successfully', 'success')
  }

  const importRoadmap = () => {
    const input = document.createElement('input')
    input.type = 'file'
    input.accept = '.json'
    input.onchange = (e) => {
      const file = (e.target as HTMLInputElement).files?.[0]
      if (file) {
        const reader = new FileReader()
        reader.onload = (e) => {
          try {
            const data = JSON.parse(e.target?.result as string)
            if (data && Array.isArray(data)) {
              setBlocks(data)
              showToast('Roadmap imported successfully', 'success')
            } else {
              showToast('Invalid file format', 'error')
            }
          } catch (error) {
            showToast('Error parsing file', 'error')
          }
        }
        reader.readAsText(file)
      }
    }
    input.click()
  }

  const shareRoadmap = () => {
    const dataStr = JSON.stringify(blocks)
    const encodedData = btoa(dataStr)
    const shareUrl = `${window.location.origin}${window.location.pathname}?data=${encodedData}`
    
    if (navigator.share) {
      navigator.share({
        title: 'My Roadmap',
        text: 'Check out my roadmap!',
        url: shareUrl
      })
    } else {
      navigator.clipboard.writeText(shareUrl)
      showToast('Share link copied to clipboard', 'success')
    }
  }

  const downloadRoadmap = () => {
    const dataStr = JSON.stringify(blocks, null, 2)
    const dataBlob = new Blob([dataStr], { type: 'application/json' })
    const url = URL.createObjectURL(dataBlob)
    const link = document.createElement('a')
    link.href = url
    link.download = 'roadmap.json'
    link.click()
    URL.revokeObjectURL(url)
    showToast('Roadmap downloaded successfully', 'success')
  }

  const addNewBlock = () => {
    setShowAddContentModal(true)
    setShowToolbar(false)
  }

  const addSingleChild = () => {
    const newBlock: Block = {
      id: Date.now().toString(),
      title: 'New Article',
      status: 'to-check',
      position: { x: 100, y: 100 },
      comments: [],
      links: []
    }
    setBlocks([...blocks, newBlock])
    setSelectedBlock(newBlock)
    setShowAddContentModal(false)
    showToast('Single article added', 'success')
  }

  const addBulkGenerate = () => {
    const newBlocks: Block[] = [
      {
        id: Date.now().toString(),
        title: 'Article 1',
        status: 'to-check',
        position: { x: 100, y: 100 },
        comments: [],
        links: []
      },
      {
        id: (Date.now() + 1).toString(),
        title: 'Article 2',
        status: 'to-check',
        position: { x: 250, y: 100 },
        comments: [],
        links: []
      },
      {
        id: (Date.now() + 2).toString(),
        title: 'Article 3',
        status: 'to-check',
        position: { x: 400, y: 100 },
        comments: [],
        links: []
      }
    ]
    setBlocks([...blocks, ...newBlocks])
    setSelectedBlock(newBlocks[0])
    setShowAddContentModal(false)
    showToast('Bulk articles generated', 'success')
  }

  const clearAllBlocks = () => {
    if (window.confirm('Are you sure you want to clear all blocks? This action cannot be undone.')) {
      setBlocks([])
      setSelectedBlock(null)
      setShowToolbar(false)
      showToast('All blocks cleared', 'success')
    }
  }

  const handleMouseDown = (e: React.MouseEvent, blockId: string) => {
    const block = blocks.find(b => b.id === blockId)
    if (block) {
      const rect = (e.currentTarget as HTMLElement).getBoundingClientRect()
      const offsetX = e.clientX - rect.left
      const offsetY = e.clientY - rect.top
      
      setDraggedBlock(blockId)
      setDragOffset({ x: offsetX, y: offsetY })
      setSelectedBlock(block)
    }
  }

  const handleMouseMove = (e: React.MouseEvent) => {
    if (draggedBlock) {
      const canvas = e.currentTarget as HTMLElement
      const rect = canvas.getBoundingClientRect()
      const x = e.clientX - rect.left - dragOffset.x
      const y = e.clientY - rect.top - dragOffset.y
      
      // Ensure block stays within canvas bounds
      const maxX = rect.width - 120 // approximate block width
      const maxY = rect.height - 50  // approximate block height
      
      const clampedX = Math.max(0, Math.min(x, maxX))
      const clampedY = Math.max(0, Math.min(y, maxY))
      
      setBlocks(prevBlocks => 
        prevBlocks.map(block => 
          block.id === draggedBlock 
            ? { ...block, position: { x: clampedX, y: clampedY } }
            : block
        )
      )
    }
  }

  const handleMouseUp = () => {
    setDraggedBlock(null)
  }

  useEffect(() => { load() }, [])

  // Prevent text selection during drag
  useEffect(() => {
    if (draggedBlock) {
      document.body.style.userSelect = 'none'
      document.body.style.cursor = 'grabbing'
    } else {
      document.body.style.userSelect = ''
      document.body.style.cursor = ''
    }

    return () => {
      document.body.style.userSelect = ''
      document.body.style.cursor = ''
    }
  }, [draggedBlock])

  const getStatusIcon = (status: string) => {
    switch (status) {
      case 'done': return '✅'
      case 'to-check': return '👁️'
      case 'to-fix': return '⚠️'
      default: return '📋'
    }
  }

  const getStatusColor = (status: string) => {
    switch (status) {
      case 'done': return '#16a34a'
      case 'to-check': return '#f59e0b'
      case 'to-fix': return '#dc2626'
      default: return '#6b7280'
    }
  }

  return (
    <div style={{ 
      display: 'flex', 
      height: 'calc(100vh - 120px)', 
      background: 'var(--bg)',
      borderRadius: '16px',
      overflow: 'hidden',
      border: '1px solid var(--border)'
    }}>
      {/* Sidebar */}
      <div style={{ 
        width: '280px', 
        background: 'var(--panel)', 
        borderRight: '1px solid var(--border)',
        padding: '20px',
        display: 'flex',
        flexDirection: 'column',
        gap: '20px'
      }}>
        {/* Done Section */}
        <div>
          <div style={{ 
            display: 'flex', 
            alignItems: 'center', 
            gap: '8px', 
            marginBottom: '12px',
            padding: '8px 12px',
            background: 'var(--panel-contrast)',
            border: '1px solid var(--border)',
            borderRadius: '12px',
            boxShadow: '0 2px 4px rgba(0, 0, 0, 0.1)'
          }}>
            <span style={{ color: '#16a34a', fontSize: '16px' }}>✅</span>
            <span style={{ color: '#16a34a', fontSize: '14px', fontWeight: '600' }}>Done ({doneCount})</span>
          </div>
          <div style={{ paddingLeft: '16px' }}>
            {blocks.filter(b => b.status === 'done').map(block => (
              <div 
                key={block.id}
                onClick={() => setSelectedBlock(block)}
                style={{
                  padding: '12px 16px',
                  background: selectedBlock?.id === block.id ? 'var(--panel-contrast)' : 'transparent',
                  border: '1px solid #16a34a',
                  borderRadius: '12px',
                  cursor: 'pointer',
                  marginBottom: '8px',
                  boxShadow: '0 2px 4px rgba(0, 0, 0, 0.1)',
                  transition: 'all 0.2s ease'
                }}
              >
                <div style={{ 
                  color: '#16a34a', 
                  fontSize: '16px', 
                  fontWeight: '600',
                  marginBottom: '4px'
                }}>
                  {block.title}
                </div>
                <div style={{ 
                  color: 'var(--muted)', 
                  fontSize: '12px',
                  fontWeight: '500'
                }}>
                  Done
                </div>
              </div>
            ))}
          </div>
        </div>

        {/* To Check Section */}
        <div>
          <div style={{ 
            display: 'flex', 
            alignItems: 'center', 
            gap: '8px', 
            marginBottom: '12px',
            padding: '8px 12px',
            background: 'var(--panel-contrast)',
            border: '1px solid var(--border)',
            borderRadius: '12px',
            boxShadow: '0 2px 4px rgba(0, 0, 0, 0.1)'
          }}>
            <span style={{ color: '#f59e0b', fontSize: '16px' }}>👁️</span>
            <span style={{ color: '#f59e0b', fontSize: '14px', fontWeight: '600' }}>To Check ({toCheckCount})</span>
          </div>
          <div style={{ paddingLeft: '16px' }}>
            {blocks.filter(b => b.status === 'to-check').map(block => (
              <div 
                key={block.id}
                onClick={() => setSelectedBlock(block)}
                style={{
                  padding: '12px 16px',
                  background: selectedBlock?.id === block.id ? 'var(--panel-contrast)' : 'transparent',
                  border: '1px solid #f59e0b',
                  borderRadius: '12px',
                  cursor: 'pointer',
                  marginBottom: '8px',
                  boxShadow: '0 2px 4px rgba(0, 0, 0, 0.1)',
                  transition: 'all 0.2s ease'
                }}
              >
                <div style={{ 
                  color: '#f59e0b', 
                  fontSize: '16px', 
                  fontWeight: '600',
                  marginBottom: '4px'
                }}>
                  {block.title}
                </div>
                <div style={{ 
                  color: 'var(--muted)', 
                  fontSize: '12px',
                  fontWeight: '500'
                }}>
                  To Check
                </div>
              </div>
            ))}
          </div>
        </div>

        {/* To Fix Section */}
        <div>
          <div style={{ 
            display: 'flex', 
            alignItems: 'center', 
            gap: '8px', 
            marginBottom: '12px',
            padding: '8px 12px',
            background: 'var(--panel-contrast)',
            border: '1px solid var(--border)',
            borderRadius: '12px',
            boxShadow: '0 2px 4px rgba(0, 0, 0, 0.1)'
          }}>
            <span style={{ color: '#dc2626', fontSize: '16px' }}>⚠️</span>
            <span style={{ color: '#dc2626', fontSize: '14px', fontWeight: '600' }}>To Fix ({toFixCount})</span>
          </div>
          <div style={{ paddingLeft: '16px' }}>
            {blocks.filter(b => b.status === 'to-fix').map(block => (
              <div 
                key={block.id}
                onClick={() => setSelectedBlock(block)}
                style={{
                  padding: '12px 16px',
                  background: selectedBlock?.id === block.id ? 'var(--panel-contrast)' : 'transparent',
                  border: '1px solid #dc2626',
                  borderRadius: '12px',
                  cursor: 'pointer',
                  marginBottom: '8px',
                  boxShadow: '0 2px 4px rgba(0, 0, 0, 0.1)',
                  transition: 'all 0.2s ease'
                }}
              >
                <div style={{ 
                  color: '#dc2626', 
                  fontSize: '16px', 
                  fontWeight: '600',
                  marginBottom: '4px'
                }}>
                  {block.title}
                </div>
                <div style={{ 
                  color: 'var(--muted)', 
                  fontSize: '12px',
                  fontWeight: '500'
                }}>
                  To Fix
                </div>
              </div>
            ))}
          </div>
        </div>

        {/* Selected Block Info */}
        {selectedBlock && (
          <div style={{ 
            marginTop: 'auto', 
            padding: '12px 16px',
            background: 'var(--panel-contrast)',
            border: '1px solid var(--border)',
            borderRadius: '12px',
            boxShadow: '0 2px 4px rgba(0, 0, 0, 0.1)'
          }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
              <span style={{ color: 'var(--primary)', fontSize: '14px' }}>▶️</span>
              <span style={{ color: 'var(--text)', fontSize: '13px', fontWeight: '500' }}>
                Selected: <span style={{ fontWeight: '600' }}>{selectedBlock.title}</span>
              </span>
            </div>
          </div>
        )}
      </div>

      {/* Main Content Area */}
      <div style={{ 
        flex: 1, 
        background: 'var(--bg)', 
        position: 'relative',
        overflow: 'hidden'
      }}>
        {/* Canvas for blocks */}
        <div 
          style={{ 
            width: '100%', 
            height: '100%', 
            position: 'relative',
            background: 'var(--bg)',
            cursor: draggedBlock ? 'grabbing' : 'default'
          }}
          onMouseMove={handleMouseMove}
          onMouseUp={handleMouseUp}
          onMouseLeave={handleMouseUp}
        >
          {blocks.map(block => (
            <div
              key={block.id}
              style={{
                position: 'absolute',
                left: block.position?.x || 50,
                top: block.position?.y || 50,
                background: 'var(--primary)',
                color: 'white',
                padding: '12px 16px',
                borderRadius: '12px',
                fontSize: '14px',
                fontWeight: '600',
                cursor: draggedBlock === block.id ? 'grabbing' : 'grab',
                boxShadow: draggedBlock === block.id 
                  ? '0 8px 16px -4px rgba(0, 0, 0, 0.3)' 
                  : '0 4px 6px -1px rgba(0, 0, 0, 0.1)',
                border: selectedBlock?.id === block.id ? '2px solid #ffffff' : 'none',
                transition: draggedBlock === block.id ? 'none' : 'all 0.2s ease',
                transform: draggedBlock === block.id ? 'scale(1.05)' : 'scale(1)',
                userSelect: 'none',
                zIndex: draggedBlock === block.id ? 1000 : 1
              }}
              onMouseDown={(e) => handleMouseDown(e, block.id)}
              onClick={(e) => {
                if (!draggedBlock) {
                  setSelectedBlock(block)
                }
              }}
            >
              {block.title}
            </div>
          ))}

          {/* Block controls (appear below selected block) */}
          {selectedBlock && (
            <div
              style={{
                position: 'absolute',
                left: (selectedBlock.position?.x || 50) + 10,
                top: (selectedBlock.position?.y || 50) + 50,
                background: 'white',
                border: '1px solid var(--border)',
                borderRadius: '8px',
                padding: '4px',
                display: 'flex',
                gap: '4px',
                boxShadow: '0 4px 6px -1px rgba(0, 0, 0, 0.1)'
              }}
            >
              <button
                style={{
                  width: '24px',
                  height: '24px',
                  background: 'var(--primary)',
                  color: 'white',
                  border: 'none',
                  borderRadius: '4px',
                  cursor: 'pointer',
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'center',
                  fontSize: '12px'
                }}
                onClick={() => {
                  setShowAddContentModal(true)
                }}
              >
                +
              </button>
              <button
                style={{
                  width: '24px',
                  height: '24px',
                  background: '#f59e0b',
                  color: 'white',
                  border: 'none',
                  borderRadius: '4px',
                  cursor: 'pointer',
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'center',
                  fontSize: '12px'
                }}
                                 onClick={() => openEditModal(selectedBlock)}
              >
                ✏️
              </button>
              <button
                style={{
                  width: '24px',
                  height: '24px',
                  background: '#dc2626',
                  color: 'white',
                  border: 'none',
                  borderRadius: '4px',
                  cursor: 'pointer',
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'center',
                  fontSize: '12px'
                }}
                onClick={() => {
                  setBlocks(blocks.filter(b => b.id !== selectedBlock.id))
                  setSelectedBlock(null)
                }}
              >
                🗑️
              </button>
            </div>
          )}
        </div>

                {/* Floating menu button */}
        <button
          style={{
            position: 'absolute',
            bottom: '20px',
            right: '20px',
            width: '48px',
            height: '48px',
            background: showToolbar ? '#8b5cf6' : 'var(--primary)',
            color: 'white',
            border: 'none',
            borderRadius: '12px',
            cursor: 'pointer',
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
            fontSize: '18px',
            boxShadow: '0 4px 6px -1px rgba(0, 0, 0, 0.1)',
            transition: 'all 0.2s ease',
            zIndex: 100
          }}
          onClick={() => setShowToolbar(!showToolbar)}
        >
          {showToolbar ? '✕' : '☰'}
        </button>

        {/* Toolbar */}
        {showToolbar && (
          <div style={{
            position: 'absolute',
            bottom: '80px',
            right: '20px',
            background: 'var(--panel)',
            border: '1px solid var(--border)',
            borderRadius: '12px',
            padding: '12px',
            display: 'flex',
            gap: '8px',
            boxShadow: '0 10px 25px -5px rgba(0, 0, 0, 0.3)',
            zIndex: 99
          }}>
            {/* Export Button */}
            <button
              onClick={exportRoadmap}
              style={{
                padding: '8px 12px',
                background: 'var(--panel-contrast)',
                border: '1px solid var(--border)',
                borderRadius: '8px',
                color: 'var(--text)',
                cursor: 'pointer',
                fontSize: '12px',
                fontWeight: '500',
                whiteSpace: 'nowrap'
              }}
            >
              Export
            </button>

            {/* Share Button */}
            <button
              onClick={shareRoadmap}
              style={{
                width: '36px',
                height: '36px',
                background: '#f59e0b',
                border: 'none',
                borderRadius: '8px',
                color: 'white',
                cursor: 'pointer',
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'center',
                fontSize: '14px'
              }}
            >
              🔗
            </button>

            {/* Load Button */}
            <button
              onClick={importRoadmap}
              style={{
                padding: '8px 12px',
                background: 'var(--panel-contrast)',
                border: '1px solid var(--border)',
                borderRadius: '8px',
                color: 'var(--text)',
                cursor: 'pointer',
                fontSize: '12px',
                fontWeight: '500',
                whiteSpace: 'nowrap'
              }}
            >
              Load
            </button>

            {/* Download Button */}
            <button
              onClick={downloadRoadmap}
              style={{
                width: '36px',
                height: '36px',
                background: '#16a34a',
                border: 'none',
                borderRadius: '8px',
                color: 'white',
                cursor: 'pointer',
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'center',
                fontSize: '14px'
              }}
            >
              ⬇️
            </button>

            {/* Add Block Button */}
            <button
              onClick={addNewBlock}
              style={{
                padding: '8px 12px',
                background: 'var(--panel-contrast)',
                border: '1px solid var(--border)',
                borderRadius: '8px',
                color: 'var(--text)',
                cursor: 'pointer',
                fontSize: '12px',
                fontWeight: '500',
                whiteSpace: 'nowrap'
              }}
            >
              Add Block
            </button>

            {/* Plus Button */}
            <button
              onClick={addNewBlock}
              style={{
                width: '36px',
                height: '36px',
                background: '#60a5fa',
                border: 'none',
                borderRadius: '8px',
                color: 'white',
                cursor: 'pointer',
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'center',
                fontSize: '16px',
                fontWeight: 'bold'
              }}
            >
              +
            </button>

            {/* Clear All Button */}
            <button
              onClick={clearAllBlocks}
              style={{
                width: '42px',
                height: '42px',
                background: '#8b5cf6',
                border: 'none',
                borderRadius: '10px',
                color: 'white',
                cursor: 'pointer',
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'center',
                fontSize: '16px',
                fontWeight: 'bold'
              }}
            >
              ✕
            </button>
          </div>
        )}
       </div>

       {/* Edit Block Modal */}
       {showEditModal && selectedBlock && (
         <div style={{
           position: 'fixed',
           top: 0,
           left: 0,
           right: 0,
           bottom: 0,
           background: 'rgba(0, 0, 0, 0.6)',
           display: 'grid',
           placeItems: 'center',
           zIndex: 1000,
           backdropFilter: 'blur(4px)'
         }}>
           <div style={{
             background: 'var(--panel)',
             border: '1px solid var(--border)',
             borderRadius: '16px',
             padding: '24px',
             width: '400px',
             maxWidth: '90vw',
             boxShadow: '0 20px 25px -5px rgba(0, 0, 0, 0.3)'
           }}>
             {/* Header */}
             <div style={{
               display: 'flex',
               alignItems: 'center',
               gap: '8px',
               marginBottom: '24px'
             }}>
               <span style={{ color: 'var(--primary)', fontSize: '18px' }}>✏️</span>
               <h3 style={{ margin: 0, color: 'var(--text)', fontSize: '18px', fontWeight: '600' }}>
                 Edit Block
               </h3>
             </div>

             {/* Title Section */}
             <div style={{ marginBottom: '20px' }}>
               <label style={{
                 display: 'block',
                 color: 'var(--text)',
                 fontSize: '14px',
                 fontWeight: '500',
                 marginBottom: '8px'
               }}>
                 Title
               </label>
               <input
                 type="text"
                 value={editTitle}
                 onChange={(e) => setEditTitle(e.target.value)}
                 style={{
                   width: '100%',
                   background: 'var(--panel-contrast)',
                   border: '1px solid var(--border)',
                   borderRadius: '8px',
                   padding: '10px 12px',
                   color: 'var(--text)',
                   fontSize: '14px',
                   boxSizing: 'border-box'
                 }}
               />
             </div>

             {/* Status Buttons */}
             <div style={{ marginBottom: '20px' }}>
               <label style={{
                 display: 'block',
                 color: 'var(--text)',
                 fontSize: '14px',
                 fontWeight: '500',
                 marginBottom: '8px'
               }}>
                 Status
               </label>
               <div style={{ display: 'flex', gap: '8px' }}>
                 <button
                   onClick={() => setEditStatus('done')}
                   style={{
                     display: 'flex',
                     alignItems: 'center',
                     gap: '6px',
                     padding: '8px 12px',
                     background: editStatus === 'done' ? '#16a34a' : 'transparent',
                     border: '1px solid #16a34a',
                     borderRadius: '6px',
                     color: editStatus === 'done' ? 'white' : '#16a34a',
                     cursor: 'pointer',
                     fontSize: '13px',
                     fontWeight: '500',
                     transition: 'all 0.2s ease'
                   }}
                 >
                   <span>✅</span>
                   Done
                 </button>
                 <button
                   onClick={() => setEditStatus('to-check')}
                   style={{
                     display: 'flex',
                     alignItems: 'center',
                     gap: '6px',
                     padding: '8px 12px',
                     background: editStatus === 'to-check' ? '#f59e0b' : 'transparent',
                     border: '1px solid #f59e0b',
                     borderRadius: '6px',
                     color: editStatus === 'to-check' ? 'white' : '#f59e0b',
                     cursor: 'pointer',
                     fontSize: '13px',
                     fontWeight: '500',
                     transition: 'all 0.2s ease'
                   }}
                 >
                   <span>👁️</span>
                   To Check
                 </button>
                 <button
                   onClick={() => setEditStatus('to-fix')}
                   style={{
                     display: 'flex',
                     alignItems: 'center',
                     gap: '6px',
                     padding: '8px 12px',
                     background: editStatus === 'to-fix' ? '#dc2626' : 'transparent',
                     border: '1px solid #dc2626',
                     borderRadius: '6px',
                     color: editStatus === 'to-fix' ? 'white' : '#dc2626',
                     cursor: 'pointer',
                     fontSize: '13px',
                     fontWeight: '500',
                     transition: 'all 0.2s ease'
                   }}
                 >
                   <span>⚠️</span>
                   To Fix
                 </button>
               </div>
             </div>

             {/* Comments Section */}
             <div style={{ marginBottom: '20px' }}>
               <label style={{
                 display: 'block',
                 color: 'var(--text)',
                 fontSize: '14px',
                 fontWeight: '500',
                 marginBottom: '8px'
               }}>
                 Comments
               </label>
               <div style={{ display: 'flex', gap: '8px' }}>
                 <input
                   type="text"
                   value={newComment}
                   onChange={(e) => setNewComment(e.target.value)}
                   placeholder="Add Comment"
                   style={{
                     flex: 1,
                     background: 'var(--panel-contrast)',
                     border: '1px solid var(--border)',
                     borderRadius: '8px',
                     padding: '10px 12px',
                     color: 'var(--text)',
                     fontSize: '14px'
                   }}
                   onKeyPress={(e) => e.key === 'Enter' && addComment()}
                 />
                 <button
                   onClick={addComment}
                   style={{
                     width: '40px',
                     height: '40px',
                     background: 'var(--primary)',
                     border: 'none',
                     borderRadius: '8px',
                     color: 'white',
                     cursor: 'pointer',
                     display: 'flex',
                     alignItems: 'center',
                     justifyContent: 'center',
                     fontSize: '16px',
                     fontWeight: 'bold'
                   }}
                 >
                   +
                 </button>
               </div>
               {/* Display existing comments */}
               {selectedBlock.comments && selectedBlock.comments.length > 0 && (
                 <div style={{ marginTop: '8px' }}>
                   {selectedBlock.comments.map((comment, index) => (
                     <div key={index} style={{
                       background: 'var(--panel-contrast)',
                       border: '1px solid var(--border)',
                       borderRadius: '6px',
                       padding: '6px 10px',
                       marginBottom: '4px',
                       fontSize: '13px',
                       color: 'var(--text)'
                     }}>
                       {comment}
                     </div>
                   ))}
                 </div>
               )}
             </div>

             {/* Links Section */}
             <div style={{ marginBottom: '24px' }}>
               <label style={{
                 display: 'block',
                 color: 'var(--text)',
                 fontSize: '14px',
                 fontWeight: '500',
                 marginBottom: '8px'
               }}>
                 Links
               </label>
               <div style={{ display: 'flex', gap: '8px' }}>
                 <input
                   type="text"
                   value={newLink}
                   onChange={(e) => setNewLink(e.target.value)}
                   placeholder="Add Link"
                   style={{
                     flex: 1,
                     background: 'var(--panel-contrast)',
                     border: '1px solid var(--border)',
                     borderRadius: '8px',
                     padding: '10px 12px',
                     color: 'var(--text)',
                     fontSize: '14px'
                   }}
                   onKeyPress={(e) => e.key === 'Enter' && addLink()}
                 />
                 <button
                   onClick={addLink}
                   style={{
                     width: '40px',
                     height: '40px',
                     background: '#ec4899',
                     border: 'none',
                     borderRadius: '8px',
                     color: 'white',
                     cursor: 'pointer',
                     display: 'flex',
                     alignItems: 'center',
                     justifyContent: 'center',
                     fontSize: '16px'
                   }}
                 >
                   🔗
                 </button>
               </div>
               {/* Display existing links */}
               {selectedBlock.links && selectedBlock.links.length > 0 && (
                 <div style={{ marginTop: '8px' }}>
                   {selectedBlock.links.map((link, index) => (
                     <div key={index} style={{
                       background: 'var(--panel-contrast)',
                       border: '1px solid var(--border)',
                       borderRadius: '6px',
                       padding: '6px 10px',
                       marginBottom: '4px',
                       fontSize: '13px',
                       color: 'var(--primary)',
                       textDecoration: 'underline',
                       cursor: 'pointer'
                     }}
                     onClick={() => window.open(link, '_blank')}
                     >
                       {link}
                     </div>
                   ))}
                 </div>
               )}
             </div>

             {/* Action Buttons */}
             <div style={{
               display: 'flex',
               justifyContent: 'flex-end',
               gap: '12px'
             }}>
               <button
                 onClick={() => setShowEditModal(false)}
                 style={{
                   padding: '10px 16px',
                   background: 'transparent',
                   border: '1px solid var(--border)',
                   borderRadius: '8px',
                   color: 'var(--text)',
                   cursor: 'pointer',
                   fontSize: '14px',
                   fontWeight: '500'
                 }}
               >
                 Cancel
               </button>
               <button
                 onClick={saveBlockChanges}
                 style={{
                   padding: '10px 16px',
                   background: 'var(--primary)',
                   border: 'none',
                   borderRadius: '8px',
                   color: 'white',
                   cursor: 'pointer',
                   fontSize: '14px',
                   fontWeight: '600'
                 }}
               >
                 Save
               </button>
             </div>
           </div>
         </div>
       )}

       {/* Add Content Modal */}
       {showAddContentModal && (
         <div style={{
           position: 'fixed',
           top: 0,
           left: 0,
           right: 0,
           bottom: 0,
           background: 'rgba(0, 0, 0, 0.6)',
           display: 'grid',
           placeItems: 'center',
           zIndex: 1000,
           backdropFilter: 'blur(4px)'
         }}>
           <div style={{
             background: 'var(--panel)',
             border: '1px solid var(--border)',
             borderRadius: '16px',
             padding: '24px',
             width: '500px',
             maxWidth: '90vw',
             boxShadow: '0 20px 25px -5px rgba(0, 0, 0, 0.3)'
           }}>
             {/* Header */}
             <div style={{
               textAlign: 'center',
               marginBottom: '24px'
             }}>
               <h3 style={{ 
                 margin: 0, 
                 color: 'var(--text)', 
                 fontSize: '20px', 
                 fontWeight: '600' 
               }}>
                 Add Content
               </h3>
             </div>

             {/* Options */}
             <div style={{
               display: 'flex',
               flexDirection: 'column',
               gap: '16px'
             }}>
               {/* Single Child Option */}
               <div
                 onClick={addSingleChild}
                 style={{
                   padding: '20px',
                   border: '2px solid #60a5fa',
                   borderRadius: '12px',
                   cursor: 'pointer',
                   transition: 'all 0.2s ease',
                   background: 'var(--panel-contrast)'
                 }}
                 onMouseEnter={(e) => {
                   e.currentTarget.style.transform = 'translateY(-2px)'
                   e.currentTarget.style.boxShadow = '0 8px 16px rgba(96, 165, 250, 0.2)'
                 }}
                 onMouseLeave={(e) => {
                   e.currentTarget.style.transform = 'translateY(0)'
                   e.currentTarget.style.boxShadow = 'none'
                 }}
               >
                 <div style={{
                   display: 'flex',
                   alignItems: 'center',
                   gap: '16px',
                   marginBottom: '12px'
                 }}>
                   <div style={{
                     width: '48px',
                     height: '48px',
                     background: '#60a5fa',
                     borderRadius: '50%',
                     display: 'flex',
                     alignItems: 'center',
                     justifyContent: 'center',
                     fontSize: '20px',
                     color: 'white',
                     fontWeight: 'bold'
                   }}>
                     +
                   </div>
                   <div>
                     <h4 style={{
                       margin: 0,
                       color: '#60a5fa',
                       fontSize: '16px',
                       fontWeight: '600'
                     }}>
                       Single Child
                     </h4>
                   </div>
                 </div>
                 <p style={{
                   margin: 0,
                   color: 'var(--muted)',
                   fontSize: '14px',
                   lineHeight: '1.5'
                 }}>
                   Add a single article node. Best for adding individual pieces of content.
                 </p>
               </div>

               {/* Bulk Generate Option */}
               <div
                 onClick={addBulkGenerate}
                 style={{
                   padding: '20px',
                   border: '2px solid #ec4899',
                   borderRadius: '12px',
                   cursor: 'pointer',
                   transition: 'all 0.2s ease',
                   background: 'var(--panel-contrast)'
                 }}
                 onMouseEnter={(e) => {
                   e.currentTarget.style.transform = 'translateY(-2px)'
                   e.currentTarget.style.boxShadow = '0 8px 16px rgba(236, 72, 153, 0.2)'
                 }}
                 onMouseLeave={(e) => {
                   e.currentTarget.style.transform = 'translateY(0)'
                   e.currentTarget.style.boxShadow = 'none'
                 }}
               >
                 <div style={{
                   display: 'flex',
                   alignItems: 'center',
                   gap: '16px',
                   marginBottom: '12px'
                 }}>
                   <div style={{
                     width: '48px',
                     height: '48px',
                     background: '#ec4899',
                     borderRadius: '8px',
                     display: 'flex',
                     alignItems: 'center',
                     justifyContent: 'center',
                     fontSize: '18px',
                     color: 'white'
                   }}>
                     📄
                   </div>
                   <div>
                     <h4 style={{
                       margin: 0,
                       color: '#ec4899',
                       fontSize: '16px',
                       fontWeight: '600'
                     }}>
                       Bulk Generate
                     </h4>
                   </div>
                 </div>
                 <p style={{
                   margin: 0,
                   color: 'var(--muted)',
                   fontSize: '14px',
                   lineHeight: '1.5'
                 }}>
                   Generate multiple articles at once. Perfect for planning content clusters.
                 </p>
               </div>
             </div>

             {/* Close Button */}
             <div style={{
               display: 'flex',
               justifyContent: 'center',
               marginTop: '24px'
             }}>
               <button
                 onClick={() => setShowAddContentModal(false)}
                 style={{
                   padding: '10px 20px',
                   background: 'transparent',
                   border: '1px solid var(--border)',
                   borderRadius: '8px',
                   color: 'var(--text)',
                   cursor: 'pointer',
                   fontSize: '14px',
                   fontWeight: '500'
                 }}
               >
                 Cancel
               </button>
             </div>
           </div>
         </div>
       )}
    </div>
  )
}


