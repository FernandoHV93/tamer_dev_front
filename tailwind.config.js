/** @type {import('tailwindcss').Config} */
export default {
  content: [
    './index.html',
    './src/**/*.{ts,tsx}',
  ],
  theme: {
    extend: {
      colors: {
        border: 'hsl(217.2 32.6% 17.5%)',
        background: '#0f1115',
        panel: '#1a1d24',
        muted: '#9ca3af',
        primary: '#2563eb',
      },
      borderRadius: {
        lg: '0.5rem',
        md: '0.375rem',
        sm: '0.25rem',
      },
    },
  },
  darkMode: ['class'],
}


