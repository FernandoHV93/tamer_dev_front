import { type WizardField, type WizardData } from '../../types/deepWizard';
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '../ui/select';
import { ScaleSelector } from '../ui/scaleSelector';
import { RadioGroup, RadioGroupItem } from '../ui/radio-group';
import { Input } from '../ui/input';

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
      <label className="text-xl font-semibold text-white mb-4 block">
        {field.label}
        {field.required && <span className="text-red-400 ml-1">*</span>}
      </label>
      
      <Select
        value={value || ''}
        onValueChange={(selectedValue) => onChange(field.key, selectedValue)}
      >
        <SelectTrigger className="w-full bg-gray-800 border-gray-700 text-white hover:bg-gray-750">
          <SelectValue placeholder={`Select ${field.label.toLowerCase()}`} />
        </SelectTrigger>
        
        <SelectContent className="bg-gray-800 border-gray-700 text-white">
          {field.options?.map((option, index) => (
            <SelectItem 
              key={index} 
              value={option}
              className="hover:bg-gray-700 focus:bg-gray-700"
            >
              {option}
            </SelectItem>
          ))}
        </SelectContent>
      </Select>
    </div>
  );
      case 'scale':
  return (
    <ScaleSelector
      key={field.key}
      label={field.label}
      options={field.options || []}
      value={field.options?.indexOf(value) ?? 0}
      onChange={(index) => onChange(field.key, field.options?.[index])}
    />
  );

      case 'radio':
  return (
    <div key={field.key} className="mb-6 ">
      <label className="text-xl font-semibold text-white mb-4 block">
        {field.label}
        {field.required && <span className="text-red-400 ml-1">*</span>}
      </label>
      
      <RadioGroup
        value={value || ''}
        onValueChange={(selectedValue) => onChange(field.key, selectedValue)}
        className="flex  justify-between gap-4"
      >
        {field.options?.map(option => (
          <div key={option} className="flex items-center space-x-2">
            <RadioGroupItem 
              value={option} 
              id={`${field.key}-${option}`}
              className="text-blue-500"
            />
            <label 
              htmlFor={`${field.key}-${option}`}
              className="text-gray-200 cursor-pointer text-sm font-medium"
            >
              {option}
            </label>
          </div>
        ))}
      </RadioGroup>
    </div>
  );

      case 'checkbox':
        return (
          <div key={field.key} className="mb-6">
            <label className="block text-xl font-medium mb-2 text-gray-200">
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
            <label className="block text-xl font-medium mb-2 text-gray-200">
              {field.label}
              {field.required && <span className="text-red-400 ml-1">*</span>}
            </label>
            {field.type === 'textarea' ? (
              <textarea
                value={value}
                onChange={(e) => onChange(field.key, e.target.value)}
                placeholder={field.placeholder}
                rows={2}
                className="w-full p-3 rounded-lg bg-[#111317] border border-gray-700 focus:border-blue-500 focus:outline-none text-white resize-none"
              />
            ) : (
              <Input
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
    <div className="flex flex-col justify-between h-full">
      {fields.map(renderField)}
    </div>
  );
}