import type { HTMLAttributes, DetailedHTMLProps } from 'react'
import { cn } from '../../lib/htmlUtils'

export function Badge({ className, ...props }: DetailedHTMLProps<HTMLAttributes<HTMLSpanElement>, HTMLSpanElement>) {
  return <span className={cn('inline-flex items-center rounded-md border border-transparent bg-primary px-2 py-0.5 text-xs font-medium text-white', className)} {...props} />
}


