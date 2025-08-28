import { wizardSections } from '../../types/deepWizard';

interface ProgressNavigationProps {
  currentStep: number;
  totalSteps: number;
  progress: number;
  onStepClick: (step: number) => void;
}

export default function ProgressNavigation({ currentStep, totalSteps, progress, onStepClick }: ProgressNavigationProps) {
  return (
    <div className="bg-gray-800/50 backdrop-blur-sm rounded-2xl p-6 border border-gray-700/50">
      <div className="mb-4">
        <div className="flex justify-between items-center mb-2">
          <h1 className="text-2xl font-bold bg-gradient-to-r from-blue-400 to-purple-400 bg-clip-text text-transparent">
            Deep Analysis
          </h1>
          <span className="text-sm text-blue-400 font-medium">
            {progress}% Complete
          </span>
        </div>
        
        <div className="w-full bg-gray-700 rounded-full h-3 overflow-hidden">
          <div 
            className="bg-gradient-to-r from-blue-500 to-purple-500 h-3 rounded-full transition-all duration-500 ease-out"
            style={{ width: `${progress}%` }}
          />
        </div>
      </div>

      <div className="grid grid-cols-6 gap-2">
        {wizardSections.map((section, index) => (
          <div
            key={section.id}
            className={`p-2 rounded-lg text-center transition-all ${
              currentStep >= index * 4 ? 'bg-blue-500/20 border border-blue-500/50' : 'bg-gray-700/50'
            }`}
          >
            <div className="text-lg mb-1">{section.icon}</div>
            <div className="text-xs text-gray-300">{section.name}</div>
          </div>
        ))}
      </div>
    </div>
  );
}