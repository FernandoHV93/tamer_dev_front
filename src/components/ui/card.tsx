import type { HTMLAttributes, DetailedHTMLProps } from 'react'
import { cn } from '../../lib/htmlUtils'

export function Card({ className, ...props }: DetailedHTMLProps<HTMLAttributes<HTMLDivElement>, HTMLDivElement>) {
  return <div className={cn('bg-panel border border-border rounded-lg shadow-sm', className)} {...props} />
}

export function CardHeader({ className, ...props }: DetailedHTMLProps<HTMLAttributes<HTMLDivElement>, HTMLDivElement>) {
  return <div className={cn('p-4 border-b border-border', className)} {...props} />
}

export function CardTitle({ className, ...props }: DetailedHTMLProps<HTMLAttributes<HTMLHeadingElement>, HTMLHeadingElement>) {
  return <h3 className={cn('text-lg font-semibold leading-none tracking-tight', className)} {...props} />
}

export function CardContent({ className, ...props }: DetailedHTMLProps<HTMLAttributes<HTMLDivElement>, HTMLDivElement>) {
  return <div className={cn('p-4', className)} {...props} />
}


