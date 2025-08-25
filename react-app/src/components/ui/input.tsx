import type { DetailedHTMLProps, InputHTMLAttributes } from 'react'
import { cn } from '../../lib/htmlUtils'

export function Input(props: DetailedHTMLProps<InputHTMLAttributes<HTMLInputElement>, HTMLInputElement>) {
  return (
    <input
      className={cn('input')}
      style={{
        WebkitFontSmoothing: 'antialiased',
        MozOsxFontSmoothing: 'grayscale',
        textRendering: 'optimizeLegibility'
      }}
      {...props}
    />
  )
}


