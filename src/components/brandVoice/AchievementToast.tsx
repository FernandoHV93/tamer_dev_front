import { motion } from 'framer-motion';

interface AchievementToastProps {
  icon: string;
  title: string;
  message: string;
  onClose: () => void;
}

export default function AchievementToast({ icon, title, message, onClose }: AchievementToastProps) {
  return (
    <motion.div
      initial={{ opacity: 0, y: 50 }}
      animate={{ opacity: 1, y: 0 }}
      exit={{ opacity: 0, y: 50 }}
      className="fixed bottom-6 left-1/2 transform -translate-x-1/2 z-50 pointer-events-none"
    >
      <div
        onClick={onClose}
        className="pointer-events-auto cursor-pointer bg-gradient-to-r from-blue-600 to-purple-600 text-white px-6 py-4 rounded-xl shadow-2xl border border-blue-400/30"
      >
        <div className="flex items-center space-x-3">
          <span className="text-2xl">{icon}</span>
          <div>
            <div className="font-bold">{title}</div>
            <div className="text-sm opacity-90">{message}</div>
          </div>
        </div>
      </div>
    </motion.div>
  );
}
