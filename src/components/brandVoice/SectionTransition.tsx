import { motion, AnimatePresence } from 'framer-motion';
import { wizardSections } from '../../types/deepWizard';

interface SectionTransitionProps {
  currentSection: string;
  previousSection: string;
  isVisible: boolean;
  onClose: () => void;
}

export default function SectionTransition({ 
  currentSection, 
  previousSection, 
  isVisible,
  onClose
}: SectionTransitionProps) {
  const currentSectionData = wizardSections.find(s => s.id === currentSection);
  const previousSectionData = wizardSections.find(s => s.id === previousSection);

  if (!currentSectionData || !previousSectionData) return null;

  const CurrentIcon = currentSectionData.icon;
  const PreviousIcon = previousSectionData.icon;

  return (
    <AnimatePresence>
      {isVisible && (
        <motion.div
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          exit={{ opacity: 0 }}
          className="fixed inset-0 z-50 flex items-center justify-center bg-black/70 backdrop-blur-sm"
          onClick={onClose} // 🔥 cierre al hacer click
        >
          <motion.div
            initial={{ scale: 0.8, opacity: 0 }}
            animate={{ scale: 1, opacity: 1 }}
            exit={{ scale: 1.2, opacity: 0 }}
            className="text-center p-8 bg-gray-800 rounded-2xl border border-gray-600"
            onClick={(e) => e.stopPropagation()} // evita que al hacer click dentro también cierre
          >
            <CurrentIcon className="w-12 h-12 mx-auto mb-4 text-blue-400" />
            <h2 className="text-2xl font-bold text-white mb-2">
              Entering {currentSectionData.name}
            </h2>
            <div className="flex items-center justify-center text-gray-300 text-sm">
              <PreviousIcon className="w-4 h-4 mr-2" />
              <span>From {previousSectionData.name}</span>
            </div>
          </motion.div>
        </motion.div>
      )}
    </AnimatePresence>
  );
}
