import { Award, RotateCcw } from 'lucide-react';

interface CompletionCelebrationProps {
  onRestart: () => void;
  totalSteps: number;
}

export default function CompletionCelebration({ onRestart, totalSteps }: CompletionCelebrationProps) {
  return (
    <div className=" bg-gradient-to-br rounded-2xl from-blue-900 to-purple-900 flex items-center justify-center p-4 h-[90dvh]">
      <div className="text-center text-white">
        <Award className="w-16 h-16 mx-auto mb-6" />
        <h1 className="text-4xl font-bold mb-4">Congratulations!</h1>
        <p className="text-xl mb-8">You've completed all {totalSteps} steps of the Deep Analysis</p>
        <button
          onClick={onRestart}
          className="px-8 py-3 bg-white text-blue-600 rounded-xl font-semibold hover:scale-105 transition-transform flex items-center mx-auto"
        >
          <RotateCcw className="w-5 h-5 mr-2" />
          Start New Analysis
        </button>
      </div>
    </div>
  );
}