import ContentAnalysis from "./ContentAnalysis";
import DeepWizard from "./DeepWizard";
import type { ToastType } from '../../context/ToastContext';

interface MethodRendererProps {
  method: "deep" | "analysis" | null;
  sessionId: string;
  userId: string;
  showToast: (message: string, type?: ToastType, ttlMs?: number) => void;
}

export default function MethodRenderer({ method, sessionId, userId, showToast }: MethodRendererProps) {
  if (method === "deep") {
    return <DeepWizard showToast={showToast} />;
  }

  if (method === "analysis") {
    return <ContentAnalysis sessionId={sessionId} userId={userId} showToast={showToast} />;
  }

  return null;
}