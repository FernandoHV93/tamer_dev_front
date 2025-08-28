import * as Slider from "@radix-ui/react-slider";

interface ScaleSelectorProps {
  label: string;
  options: string[];
  value: number;
  onChange: (index: number) => void;
}

export function ScaleSelector({ label, options, value, onChange }: ScaleSelectorProps) {
  return (
    <div className="mb-8">
      <h3 className="text-xl font-semibold text-white mb-4">{label}</h3>
      
      <Slider.Root
        className="relative flex items-center w-full h-6"
        value={[value]}
        max={options.length - 1}
        step={1}
        onValueChange={(v) => onChange(v[0])}
      >
        {/* Track */}
        <Slider.Track className="relative h-1 w-full bg-gray-700 rounded">
          <Slider.Range className="absolute h-full rounded bg-gradient-to-r from-blue-500 to-purple-500" />
        </Slider.Track>

        {/* Thumb */}
        <Slider.Thumb className="
          block w-5 h-5 
          bg-white border-2 border-purple-500 
          rounded-full shadow-lg cursor-pointer
          transition-transform duration-150 ease-in-out
          hover:scale-110
        " />
      </Slider.Root>

      {/* Labels debajo - Ajustados para alinear con el progreso */}
      <div className="flex justify-between mt-3 text-sm text-gray-400 relative">
        {options.map((opt, i) => (
          <div 
            key={opt}
            className="flex-1 flex justify-center first:justify-start last:justify-end"
            style={{ 
              position: 'relative',
              left: i === 0 ? '0%' : i === options.length - 1 ? '0%' : '0%'
            }}
          >
            <span
              className={`transition-colors duration-200 ${
                i === value 
                  ? "text-purple-400 font-semibold scale-105" 
                  : "text-gray-500"
              }`}
              style={{ 
                transform: i === value ? 'translateX(0)' : 'none',
                position: 'relative',
                textAlign: 'center'
              }}
            >
              {opt}
            </span>
          </div>
        ))}
      </div>
    </div>
  );
}