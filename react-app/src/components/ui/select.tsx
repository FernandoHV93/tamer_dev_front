import type { DetailedHTMLProps, SelectHTMLAttributes } from 'react'
import { cn } from '../../lib/htmlUtils'

export function Select(props: DetailedHTMLProps<SelectHTMLAttributes<HTMLSelectElement>, HTMLSelectElement>) {
  const { className, ...rest } = props
  return (
    <select 
      className={cn('select', className)} 
      style={{
        WebkitFontSmoothing: 'antialiased',
        MozOsxFontSmoothing: 'grayscale',
        textRendering: 'optimizeLegibility'
      }}
      {...rest} 
    />
  )
}



