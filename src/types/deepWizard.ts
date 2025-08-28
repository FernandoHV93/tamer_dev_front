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
  type: 'select' | 'multiselect' | 'text' | 'textarea' | 'radio' | 'checkbox' | 'scale';
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
  icon: React.ComponentType<any>;
  color: string;
}

import { Target, Lightbulb, BarChart3, Building, Mic, Rocket } from 'lucide-react';

export const wizardSections: WizardSection[] = [
  { id: 'audience', name: 'Audience Discovery', icon: Target, color: 'from-blue-600 to-blue-800' },
  { id: 'problems', name: 'Problems & Desires', icon: Lightbulb, color: 'from-purple-600 to-purple-800' },
  { id: 'behavior', name: 'Behavior Patterns', icon: BarChart3, color: 'from-green-600 to-green-800' },
  { id: 'brand', name: 'Brand Identity', icon: Building, color: 'from-orange-600 to-orange-800' },
  { id: 'voice', name: 'Voice & Tone', icon: Mic, color: 'from-red-600 to-red-800' },
  { id: 'implementation', name: 'Implementation', icon: Rocket, color: 'from-indigo-600 to-indigo-800' }
];