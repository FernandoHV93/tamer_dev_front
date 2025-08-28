import { useState, useEffect, useCallback } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import WizardStep from './WizardStep';
import ProgressNavigation from './ProgressNavigation';
import SectionTransition from './SectionTransition';
import AchievementToast from './AchievementToast';
import SectionIndicator from './SectionIndicator';
import CompletionCelebration from './CompletionCelebration';
import { wizardSections, type WizardStep as WizardStepType, type WizardData } from '../../types/deepWizard';
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
  const [showCelebration, setShowCelebration] = useState(false);
  const [currentSection, setCurrentSection] = useState('audience');
  const [previousSection, setPreviousSection] = useState('audience');
  const [showSectionTransition, setShowSectionTransition] = useState(false);
  const [achievement, setAchievement] = useState<{icon: string; title: string; message: string} | null>(null);
  const [visitedSections, setVisitedSections] = useState(new Set(['audience']));

 useEffect(() => {
  if (achievement) {
    const timer = setTimeout(() => setAchievement(null), 3000)
    return () => clearTimeout(timer)
  }
}, [achievement])


  const currentStepData = wizardSteps[currentStep];
  const progressPercentage = Math.round((currentStep + 1) / wizardSteps.length * 100);

  // Detectar cambios de sección
  useEffect(() => {
  const newSection = currentStepData.section;
  if (newSection !== currentSection) {
    setPreviousSection(currentSection);
    setCurrentSection(newSection);
    setShowSectionTransition(true);

    if (!visitedSections.has(newSection)) {
      setVisitedSections(prev => new Set([...prev, newSection]));
      showSectionAchievement(newSection);
    }

    const timer = setTimeout(() => {
      setShowSectionTransition(false);
    }, 2000);

    return () => clearTimeout(timer);
  }
}, [currentStep, currentStepData.section, currentSection, visitedSections]);


  const showSectionAchievement = (sectionId: string) => {
  const section = wizardSections.find(s => s.id === sectionId)
  if (section) {
    setAchievement({
      icon: section.icon,
      title: `Section Complete!`,
      message: `You've mastered ${section.name}`
    })
  }
}


  const handleNext = useCallback(async () => {
    const currentFields = currentStepData.fields;
    const hasErrors = currentFields.some(field => 
      field.required && !formData[field.key]
    );

    if (hasErrors) {
      showToast('Please complete all required fields', 'error');
      return;
    }

    if (currentStep < wizardSteps.length - 1) {
      setCurrentStep(prev => prev + 1);
    } else {
      await handleSubmit();
    }
  }, [currentStep, formData, currentStepData.fields, showToast]);

  const handlePrevious = useCallback(() => {
    if (currentStep > 0) {
      setCurrentStep(prev => prev - 1);
    }
  }, [currentStep]);

  const handleSubmit = async () => {
    setIsSubmitting(true);
    try {
      await new Promise(resolve => setTimeout(resolve, 1500));
      setShowCelebration(true);
      showToast('Analysis completed successfully!', 'success');
    } catch (error: any) {
      showToast(error?.message || 'Error submitting data', 'error');
    } finally {
      setIsSubmitting(false);
    }
  };

  const handleRestart = () => {
    setCurrentStep(0);
    setFormData({});
    setCurrentSection('audience');
    setPreviousSection('audience');
    setVisitedSections(new Set(['audience']));
    setShowCelebration(false);
  };

  if (showCelebration) {
    return <CompletionCelebration onRestart={handleRestart} totalSteps={wizardSteps.length} />;
  }

  return (
    <div className="min-h-screen rounded-2xl bg-gradient-to-br from-gray-900 to-gray-950 p-4 relative">
      <AnimatePresence>
  {showSectionTransition && (
    <SectionTransition
      currentSection={currentSection}
      previousSection={previousSection}
      isVisible={showSectionTransition}
      onClose={() => setShowSectionTransition(false)}
    />
  )}
</AnimatePresence>


      <div className="max-w-4xl mx-auto relative z-10">
        <motion.header 
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          className="mb-8"
        >
          <ProgressNavigation 
            currentStep={currentStep}
            totalSteps={wizardSteps.length}
            progress={progressPercentage}
            onStepClick={setCurrentStep}
          />
        </motion.header>

        <AnimatePresence mode="wait">
          <motion.div
            key={currentStep}
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            transition={{ duration: 0.3 }}
            className="bg-gray-800/50 backdrop-blur-sm rounded-2xl border border-gray-700/50 p-6 mb-6"
          >
            <SectionIndicator section={currentStepData.section} />
            
            <div className="mb-6">
              <motion.h2 
                initial={{ opacity: 0 }}
                animate={{ opacity: 1 }}
                transition={{ delay: 0.1 }}
                className="text-2xl font-bold text-white mb-2"
              >
                {currentStepData.title}
              </motion.h2>
              
              <motion.p 
                initial={{ opacity: 0 }}
                animate={{ opacity: 1 }}
                transition={{ delay: 0.2 }}
                className="text-gray-300 mb-6"
              >
                {currentStepData.description}
              </motion.p>

              <WizardStep
                fields={currentStepData.fields}
                formData={formData}
                onChange={(key, value) => setFormData(prev => ({ ...prev, [key]: value }))}
              />
            </div>
          </motion.div>
        </AnimatePresence>

        <motion.div 
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.4 }}
          className="flex justify-between items-center"
        >
          <button
            onClick={handlePrevious}
            disabled={currentStep === 0 || isSubmitting}
            className="px-6 py-3 rounded-xl border border-gray-600 text-gray-300 hover:border-blue-400 hover:text-blue-300 disabled:opacity-50 transition-all duration-300"
          >
            ← Back
          </button>

          <button
            onClick={handleNext}
            disabled={isSubmitting}
            className="px-8 py-3 rounded-xl bg-gradient-to-r from-blue-500 to-blue-600 text-white hover:from-blue-600 hover:to-blue-700 disabled:opacity-50 transition-all duration-300 shadow-lg hover:shadow-blue-500/25"
          >
            {isSubmitting ? 'Processing...' : currentStep === wizardSteps.length - 1 ? 'Complete' : 'Next'}
          </button>
        </motion.div>
      </div>

      <AnimatePresence>
  {achievement && (
    <AchievementToast 
      icon={achievement.icon}
      title={achievement.title}
      message={achievement.message}
      onClose={() => setAchievement(null)}
    />
  )}
</AnimatePresence>

    </div>
  );
}