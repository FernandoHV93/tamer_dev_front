import { motion } from 'framer-motion';
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
  if (!isVisible) return null;

  const currentSectionData = wizardSections.find(s => s.id === currentSection);
  const previousSectionData = wizardSections.find(s => s.id === previousSection);

  if (!currentSectionData || !previousSectionData) return null;

  return (
    <motion.div
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      exit={{ opacity: 0 }}
      className="fixed inset-0 z-50 flex items-center justify-center bg-black/70 backdrop-blur-sm"
      onClick={onClose} // 🔹 cierre al hacer click en overlay
    >
      <motion.div
        initial={{ scale: 0.8, opacity: 0 }}
        animate={{ scale: 1, opacity: 1 }}
        exit={{ scale: 1.2, opacity: 0 }}
        className="text-center p-8 bg-gray-800 rounded-2xl border border-gray-600 cursor-pointer"
        onClick={(e) => {
          e.stopPropagation(); // evita que click en el card cierre inmediatamente
          onClose(); // 🔹 cierre al hacer click directo en el modal
        }}
      >
        <div className="text-4xl mb-4">{currentSectionData.icon}</div>
        <h2 className="text-2xl font-bold text-white mb-2">
          Entering {currentSectionData.name}
        </h2>
        <p className="text-gray-300">
          From {previousSectionData.name}
        </p>
      </motion.div>
    </motion.div>
  );
}
