export interface WizardStep {
  id: number;
  title: string;
  description: string;
  progress: number;
  fields: WizardField[];
}

export interface WizardField {
  type: 'select' | 'multiselect' | 'text' | 'textarea' | 'radio' | 'checkbox';
  key: string;
  label: string;
  options?: string[];
  placeholder?: string;
  required?: boolean;
}

export interface WizardData {
  [key: string]: any;
}