import { useState } from 'react';
import { Button } from '../ui/button';
import { Input } from '../ui/input';
import { Plus } from 'lucide-react';

interface BrandVoice {
  brandName: string;
  toneOfVoice: string;
  keyValues: string[];
  targetAudience: string;
  brandIdentityInsights: string;
}

interface BrandVoicePreviewProps {
  onAddBrand: (brandVoice: BrandVoice) => void;
  isLoading?: boolean;
}

export default function BrandVoicePreview({ onAddBrand, isLoading = false }: BrandVoicePreviewProps) {
  const [brandName, setBrandName] = useState('');
  const [toneOfVoice, setToneOfVoice] = useState('');
  const [keyValues, setKeyValues] = useState<string[]>(['']);
  const [targetAudience, setTargetAudience] = useState('Business professionals... (Example)');
  const [brandIdentityInsights, setBrandIdentityInsights] = useState('');

  const handleAddKeyValue = () => {
    setKeyValues([...keyValues, '']);
  };

  const handleRemoveKeyValue = (index: number) => {
    if (keyValues.length === 1) return; // Keep at least one field
    const newKeyValues = [...keyValues];
    newKeyValues.splice(index, 1);
    setKeyValues(newKeyValues);
  };

  const handleKeyValueChange = (index: number, value: string) => {
    const newKeyValues = [...keyValues];
    newKeyValues[index] = value;
    setKeyValues(newKeyValues);
  };

  const handleSubmit = () => {
    const brandVoice: BrandVoice = {
      brandName,
      toneOfVoice,
      keyValues: keyValues.filter(value => value.trim() !== ''),
      targetAudience,
      brandIdentityInsights
    };
    
    onAddBrand(brandVoice);
  };

  const isFormValid = brandName.trim() !== '' && toneOfVoice.trim() !== '';

  return (
    <div className="bg-gradient-to-br from-gray-900 to-gray-950 sm:rounded-xl border border-gray-700 p-6 w-full">
      <h1 className="text-2xl font-bold mb-6 text-start">Brand Voice Preview</h1>
      
      <div className="grid grid-rows-2 md:grid-rows-none md:grid-cols-2 gap-6 mb-6">
        <div className='row-[1/2] col-[1/3] sm:row-[1/3] sm:col-[1/2]'>
          <label className="block text-sm font-medium mb-2">Brand Name</label>
          <Input
            type="text"
            value={brandName}
            onChange={(e) => setBrandName(e.target.value)}
            placeholder="Enter brand name..."
            className="w-full p-3 rounded-lg bg-[#111317] border border-gray-700 focus:border-blue-500 focus:outline-none"
          />
        </div>
        
        <div className='row-[2/3] col-[1/3] sm:row-[1/3] sm:col-[2/3]'>
          <label className="block text-sm font-medium mb-2 ">Tone of Voice</label>
          <Input
            type="text"
            value={toneOfVoice}
            onChange={(e) => setToneOfVoice(e.target.value)}
            placeholder="Enter tone of voice..."
            className="w-full p-3 rounded-lg bg-[#111317] border border-gray-700 focus:border-blue-500 focus:outline-none"
          />
        </div>
      </div>
      
      <div className="mb-6">
        <div className="flex items-center justify-between mb-2">
          <label className="block text-sm font-medium">Key Values</label>
          
        </div>
        
        <div className="space-y-3 flex-1 h-max">
          {keyValues.map((value, index) => (
            <div key={index} className="flex items-center gap-2">
              <Input
                type="text"
                value={value}
                onChange={(e) => handleKeyValueChange(index, e.target.value)}
                placeholder="Enter key value..."
                className="flex-1 p-3 rounded-lg bg-[#111317] border border-gray-700 focus:border-blue-500 focus:outline-none"
              />
              {keyValues.length > 1 && (
                <button
                  type="button"
                  onClick={() => handleRemoveKeyValue(index)}
                  className="p-2 text-gray-400 hover:text-red-400"
                >
                  ×
                </button>
              )}
              <button
            type="button"
            onClick={handleAddKeyValue}
            className=" text-blue-500 hover:text-blue-400 items-center justify-between flexfile:text-foreground placeholder:text-muted-foreground selection:bg-primary selection:text-primary-foreground dark:bg-input/30 border-input flex h-9 min-w-0 rounded-md border bg-[#0f1115] px-3 py-1 text-base shadow-xs transition-[color,box-shadow] outline-none file:inline-flex file:h-7 file:border-0 file:bg-transparent file:text-sm file:font-medium disabled:pointer-events-none disabled:cursor-not-allowed disabled:opacity-50 md:text-sm"
          >
            <Plus/> Add Value
                </button>
            </div>
          ))}
        </div>
      </div>
      
      <div className="border-t border-gray-700 my-6"></div>
      
      <div className="mb-6">
        <label className="block text-sm font-medium mb-2">Target Audience</label>
        <textarea
          value={targetAudience}
          onChange={(e) => setTargetAudience(e.target.value)}
          rows={2}
          className="w-full p-3 rounded-lg bg-[#111317] border border-gray-700 focus:border-blue-500 focus:outline-none"
        />
      </div>
      
      <div className="border-t border-gray-700 my-6"></div>
      
      <div className="mb-6">
        <label className="block text-sm font-medium mb-2">Brand Identity Insights</label>
        <textarea
          value={brandIdentityInsights}
          onChange={(e) => setBrandIdentityInsights(e.target.value)}
          placeholder="Enter Brand Identity Insights..."
          rows={3}
          className="w-full p-3 rounded-lg bg-[#111317] border border-gray-700 focus:border-blue-500 focus:outline-none"
        />
      </div>
      
      <div className="border-t border-gray-700 my-6"></div>
      
      <button
        onClick={handleSubmit}
        disabled={!isFormValid || isLoading}
        className="w-full bg-blue-600 hover:bg-blue-700 disabled:bg-blue-800 disabled:opacity-50 text-white py-3 px-4 rounded-md font-medium"
      >
        {isLoading ? 'Adding Brand...' : 'Add Brand'}
      </button>
    </div>
  );
}