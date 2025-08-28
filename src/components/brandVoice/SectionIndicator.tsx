import { wizardSections } from '../../types/deepWizard';

interface SectionIndicatorProps {
  section: string;
}

export default function SectionIndicator({ section }: SectionIndicatorProps) {
  const currentSection = wizardSections.find(s => s.id === section);
  
  if (!currentSection) return null;

  return (
    <div className="flex items-center mb-4 p-3 rounded-lg bg-gradient-to-r from-gray-700/50 to-gray-800/30">
      <span className="text-2xl mr-3">{currentSection.icon}</span>
      <div>
        <div className="text-sm text-gray-400">Current Section</div>
        <div className="text-white font-medium">{currentSection.name}</div>
      </div>
    </div>
  );
}