interface CompletionCelebrationProps {
  onRestart: () => void;
  totalSteps: number;
}

export default function CompletionCelebration({ onRestart, totalSteps }: CompletionCelebrationProps) {
  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-900 to-purple-900 flex items-center justify-center p-4">
      <div className="text-center text-white">
        <div className="text-6xl mb-6">🎉</div>
        <h1 className="text-4xl font-bold mb-4">Congratulations!</h1>
        <p className="text-xl mb-8">You've completed all {totalSteps} steps of the Deep Analysis</p>
        <button
          onClick={onRestart}
          className="px-8 py-3 bg-white text-blue-600 rounded-xl font-semibold hover:scale-105 transition-transform"
        >
          Start New Analysis
        </button>
      </div>
    </div>
  );
}