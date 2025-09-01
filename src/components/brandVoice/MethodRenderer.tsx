import ContentAnalysis from "./ContentAnalysis";
import DeepWizard from "./DeepWizard";

interface MethodRendererProps {
  method: "deep" | "analysis" | null;
  sessionId: string;
  userId: string;
  showToast: (message: string, type: string) => void;
}

export default function MethodRenderer({ method, sessionId, userId, showToast }: MethodRendererProps) {
  if (method === "deep") {
    return <DeepWizard sessionId={sessionId} userId={userId} showToast={showToast} />;
  }

  if (method === "analysis") {
    return <ContentAnalysis sessionId={sessionId} userId={userId} showToast={showToast} />;
  }

  return null;
}