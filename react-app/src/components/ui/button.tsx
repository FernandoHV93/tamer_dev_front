import type { ButtonHTMLAttributes, DetailedHTMLProps } from 'react'
import { cn } from '../../lib/htmlUtils'

type Props = DetailedHTMLProps<ButtonHTMLAttributes<HTMLButtonElement>, HTMLButtonElement> & {
  variant?: 'default' | 'primary' | 'outline'
}

export function Button({ className, variant = 'default', ...props }: Props) {
  const base = 'btn'
  const variants: Record<string, string> = {
    default: '',
    primary: 'btn-primary',
    outline: '',
  }
  return (
    <button 
      className={cn(base, variants[variant], className)} 
      style={{
        WebkitFontSmoothing: 'antialiased',
        MozOsxFontSmoothing: 'grayscale',
        textRendering: 'optimizeLegibility'
      }}
      {...props} 
    />
  )
}


