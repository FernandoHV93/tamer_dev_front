import { type WizardField, type WizardData } from '../../types/deepWizard';
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '../ui/select';

interface WizardStepProps {
  fields: WizardField[];
  formData: WizardData;
  onChange: (key: string, value: any) => void;
}

export default function WizardStep({ fields, formData, onChange }: WizardStepProps) {
  const renderField = (field: WizardField) => {
    const value = formData[field.key] || '';

    switch (field.type) {
      case 'select':
        return (
          <div key={field.key} className="mb-6">
            <label className="block text-sm font-medium mb-2 text-gray-200">
              {field.label}
              {field.required && <span className="text-red-400 ml-1">*</span>}
            </label>
            <Select
              value={value}
              onValueChange={(selectedValue) => onChange(field.key, selectedValue)}
            >
              <SelectTrigger className="w-full p-3 rounded-lg bg-[#111317] border border-gray-700 focus:border-blue-500 focus:outline-none text-white">
                <SelectValue placeholder={field.placeholder || 'Select an option'} />
              </SelectTrigger>
              <SelectContent 
                className="bg-[#1a1d26] border border-gray-700 text-white"
                position="popper"
                sideOffset={5}
              >
                {field.options?.map((option) => (
                  <SelectItem
                    key={option}
                    value={option}
                    className="cursor-pointer focus:bg-[#2d313c] px-3 py-2"
                  >
                    {option}
                  </SelectItem>
                ))}
              </SelectContent>
            </Select>
          </div>
        );

      case 'radio':
        return (
          <div key={field.key} className="mb-6">
            <label className="block text-sm font-medium mb-2 text-gray-200">
              {field.label}
              {field.required && <span className="text-red-400 ml-1">*</span>}
            </label>
            <div className="space-y-2">
              {field.options?.map(option => (
                <label key={option} className="flex items-center space-x-2">
                  <input
                    type="radio"
                    name={field.key}
                    value={option}
                    checked={value === option}
                    onChange={(e) => onChange(field.key, e.target.value)}
                    className="text-blue-500 focus:ring-blue-500"
                  />
                  <span className="text-gray-200">{option}</span>
                </label>
              ))}
            </div>
          </div>
        );

      case 'checkbox':
        return (
          <div key={field.key} className="mb-6">
            <label className="block text-sm font-medium mb-2 text-gray-200">
              {field.label}
              {field.required && <span className="text-red-400 ml-1">*</span>}
            </label>
            <div className="space-y-2">
              {field.options?.map(option => (
                <label key={option} className="flex items-center space-x-2">
                  <input
                    type="checkbox"
                    checked={Array.isArray(value) ? value.includes(option) : false}
                    onChange={(e) => {
                      const currentValues = Array.isArray(value) ? value : [];
                      const newValues = e.target.checked
                        ? [...currentValues, option]
                        : currentValues.filter(v => v !== option);
                      onChange(field.key, newValues);
                    }}
                    className="text-blue-500 focus:ring-blue-500"
                  />
                  <span className="text-gray-200">{option}</span>
                </label>
              ))}
            </div>
          </div>
        );

      case 'text':
      case 'textarea':
        return (
          <div key={field.key} className="mb-6">
            <label className="block text-sm font-medium mb-2 text-gray-200">
              {field.label}
              {field.required && <span className="text-red-400 ml-1">*</span>}
            </label>
            {field.type === 'textarea' ? (
              <textarea
                value={value}
                onChange={(e) => onChange(field.key, e.target.value)}
                placeholder={field.placeholder}
                rows={4}
                className="w-full p-3 rounded-lg bg-[#111317] border border-gray-700 focus:border-blue-500 focus:outline-none text-white resize-none"
              />
            ) : (
              <input
                type="text"
                value={value}
                onChange={(e) => onChange(field.key, e.target.value)}
                placeholder={field.placeholder}
                className="w-full p-3 rounded-lg bg-[#111317] border border-gray-700 focus:border-blue-500 focus:outline-none text-white"
              />
            )}
          </div>
        );

      default:
        return null;
    }
  };

  return (
    <div className="space-y-4">
      {fields.map(renderField)}
    </div>
  );
}