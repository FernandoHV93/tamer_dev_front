
interface MethodCardProps {
  title: string;
  description: string;
  badge?: string;
  isSelected: boolean;
  onClick: () => void;
  borderColor: string;
}

interface ChooseMethodProps {
  method: "deep" | "analysis" | null;
  setMethod: (method: "deep" | "analysis" | null) => void;
}

const MethodCard = ({ title, description, badge, isSelected, onClick, borderColor }: MethodCardProps) => (
  <div
    onClick={onClick}
    className={`cursor-pointer p-6 rounded-xl border transition  ${
      isSelected
        ? `${borderColor} bg-[#111317]`
        : "border-gray-700 hover:" + borderColor.replace('border-', 'border-')
    }`}
  >
    <div className="flex flex-col md:flex-row md:justify-between md:items-center">
      <h3 className="text-lg font-bold">{title}</h3>
      {badge && (
        <span className="bg-green-500 text-xs text-black px-2 py-1 rounded-full ">
          {badge}
        </span>
      )}
    </div>
    <p className="text-gray-400 mt-2 text-sm">{description}</p>
  </div>
);

export default function ChooseMethod({ method, setMethod }: ChooseMethodProps) {
  const methods = [
    {
      title: "DEEP",
      description: "A comprehensive and challenging process designed for those who truly want to make a difference with their content.",
      badge: "Most Valuable Way",
      type: "deep" as const,
      borderColor: "border-green-400"
    },
    {
      title: "Content Analysis",
      description: "Let us analyze your existing content to extract your brand voice patterns.",
      type: "analysis" as const,
      borderColor: "border-blue-400"
    }
  ];

  return (
    <div className="bg-[#1a1d26] p-6 sm:rounded-xl border mb-8 border-gray-700 w-auto sm:w-[80%] lg:w-[62%] max-w-[1200px]">
      <h2 className="text-lg font-semibold mb-4">Choose Your Method</h2>
      <div className="grid grid-rows-2 sm:grid-rows-none sm:grid-cols-2 gap-6">
        {methods.map((methodItem) => (
          <MethodCard
            key={methodItem.type}
            title={methodItem.title}
            description={methodItem.description}
            badge={methodItem.badge}
            isSelected={method === methodItem.type}
            onClick={() => setMethod(methodItem.type)}
            borderColor={methodItem.borderColor}
          />
        ))}
      </div>
    </div>
  );
}