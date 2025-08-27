import { useState } from 'react';
import WizardStep from './WizardStep';
import { type WizardData } from '../../types/deepWizard';
import { wizardSteps } from '../../lib/wizardData';

interface DeepWizardProps {
  sessionId: string;
  userId: string;
  showToast: (message: string, type: string) => void;
}



export default function DeepWizard({ sessionId, userId, showToast }: DeepWizardProps) {
  const [currentStep, setCurrentStep] = useState(0);
  const [formData, setFormData] = useState<WizardData>({});
  const [isSubmitting, setIsSubmitting] = useState(false);

  const currentStepData = wizardSteps[currentStep];
  const isFirstStep = currentStep === 0;
  const isLastStep = currentStep === wizardSteps.length - 1;

  const handleFieldChange = (key: string, value: any) => {
    setFormData(prev => ({
      ...prev,
      [key]: value
    }));
  };

  const handleNext = () => {
    // Validar campos requeridos del paso actual
    const currentFields = currentStepData.fields;
    const hasErrors = currentFields.some(field => 
      field.required && !formData[field.key]
    );

    if (hasErrors) {
      showToast('Please complete all required fields', 'error');
      return;
    }

    if (!isLastStep) {
      setCurrentStep(prev => prev + 1);
    } else {
      handleSubmit();
    }
  };

  const handlePrevious = () => {
    if (!isFirstStep) {
      setCurrentStep(prev => prev - 1);
    }
  };

  const handleSubmit = async () => {
    setIsSubmitting(true);
    try {
      // Aquí iría la llamada a tu API
      console.log('Submitting data:', formData);
      showToast('Data submitted successfully!', 'success');
    } catch (error: any) {
      showToast(error?.message || 'Error submitting data', 'error');
    } finally {
      setIsSubmitting(false);
    }
  };

  return (
    <div className="bg-[#1a1d26] rounded-xl border border-gray-700 p-6 w-full">
      {/* Progress Header */}
      <div className="mb-6">
        <h1 className="text-2xl font-bold mb-2">Deep Analysis</h1>
        <div className="flex items-center justify-between mb-4">
          <span className="text-sm text-gray-400">
            Section {currentStep + 1} of {wizardSteps.length}
          </span>
          <span className="text-sm text-gray-400">
            {Math.round((currentStep + 1) / wizardSteps.length * 100)}% Complete
          </span>
        </div>
        
        {/* Progress Bar */}
        <div className="w-full bg-gray-700 rounded-full h-2 mb-4">
          <div 
            className="bg-blue-500 h-2 rounded-full transition-all duration-300"
            style={{ width: `${(currentStep + 1) / wizardSteps.length * 100}%` }}
          ></div>
        </div>

        <div className="border-t border-gray-700 my-4"></div>
      </div>

      {/* Current Step Content */}
      <div className="mb-6">
        <h2 className="text-xl font-semibold mb-2">{currentStepData.title}</h2>
        <p className="text-gray-400 mb-6">{currentStepData.description}</p>

        <WizardStep
          fields={currentStepData.fields}
          formData={formData}
          onChange={handleFieldChange}
        />
      </div>

      {/* Navigation */}
      <div className="flex justify-between items-center">
        <button
          onClick={handlePrevious}
          disabled={isFirstStep}
          className="px-6 py-2 rounded-md border border-gray-600 text-gray-300 hover:border-gray-400 hover:text-white disabled:opacity-50 disabled:cursor-not-allowed transition-colors"
        >
          Back
        </button>

        <button
          onClick={handleNext}
          disabled={isSubmitting}
          className="px-6 py-2 rounded-md bg-blue-600 text-white hover:bg-blue-700 disabled:opacity-50 disabled:cursor-not-allowed transition-colors"
        >
          {isSubmitting ? 'Processing...' : isLastStep ? 'Finish' : 'Next'}
        </button>
      </div>
    </div>
  );
}