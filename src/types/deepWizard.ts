export interface WizardStep {
  id: number;
  title: string;
  description: string;
  progress: number;
  section: string;
  theme: {
    primary: string;
    secondary: string;
    gradient: string;
  };
  fields: WizardField[];
  milestone?: boolean;
}

export interface WizardField {
  type: 'select' | 'multiselect' | 'text' | 'textarea' | 'radio' | 'checkbox';
  key: string;
  label: string;
  options?: string[];
  placeholder?: string;
  required?: boolean;
  tooltip?: string;
}

export interface WizardData {
  [key: string]: any;
}

export interface WizardSection {
  id: string;
  name: string;
  icon: string;
  color: string;
}

export const wizardSections: WizardSection[] = [
  { id: 'audience', name: 'Audience Discovery', icon: '🎯', color: 'from-blue-600 to-blue-800' },
  { id: 'problems', name: 'Problems & Desires', icon: '💡', color: 'from-purple-600 to-purple-800' },
  { id: 'behavior', name: 'Behavior Patterns', icon: '📊', color: 'from-green-600 to-green-800' },
  { id: 'brand', name: 'Brand Identity', icon: '🏢', color: 'from-orange-600 to-orange-800' },
  { id: 'voice', name: 'Voice & Tone', icon: '🎙️', color: 'from-red-600 to-red-800' },
  { id: 'implementation', name: 'Implementation', icon: '🚀', color: 'from-indigo-600 to-indigo-800' }
];