import type { ReactNode } from 'react'

type Props = {
  open: boolean
  title?: string
  description?: ReactNode
  confirmText?: string
  cancelText?: string
  onConfirm: () => void
  onCancel: () => void
}

export default function Modal({ open, title, description, confirmText = 'Confirm', cancelText = 'Cancel', onConfirm, onCancel }: Props) {
  if (!open) return null
  return (
    <div className="modal-overlay" onClick={onCancel}>
      <div className="modal-card" onClick={(e) => e.stopPropagation()}>
        {title && <h3 style={{ marginTop: 0 }}>{title}</h3>}
        {description && <div style={{ marginTop: 8 }}>{description}</div>}
        <div className="modal-actions">
          <button className="btn" onClick={onCancel}>{cancelText}</button>
          <button className="btn btn-danger" onClick={onConfirm}>{confirmText}</button>
        </div>
      </div>
    </div>
  )
}


