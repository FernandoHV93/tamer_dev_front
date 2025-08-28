import { wizardSections } from '../../types/deepWizard';

interface ProgressNavigationProps {
  currentStep: number;
  totalSteps: number;
  progress: number;
  onStepClick: (step: number) => void;
}

export default function ProgressNavigation({ currentStep, totalSteps, progress, onStepClick }: ProgressNavigationProps) {
  return (
    <div className="backdrop-blur-sm rounded-2xl">
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
        {wizardSections.map((section, index) => {
          const IconComponent = section.icon;
          return (
            <div
              key={section.id}
              className={`p-2 rounded-lg text-center transition-all ${
                currentStep >= index * 4 ? 'bg-blue-500/20 border border-blue-500/50' : 'bg-gray-700/50'
              }`}
            >
              <IconComponent className="w-5 h-5 mx-auto mb-1 text-gray-300" />
              <div className="text-xs text-gray-300 hidden lg:block">{section.name.split(' ')[0]}</div>
            </div>
          );
        })}
      </div>
    </div>
  );
}