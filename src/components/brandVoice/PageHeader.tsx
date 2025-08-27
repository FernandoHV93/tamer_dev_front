import { LucideCircleQuestionMark} from 'lucide-react';

interface PageHeaderProps {
  title: string;
}

export default function PageHeader({ title }: PageHeaderProps) {
  return (
    <div className="w-auto sm:w-[80%] lg:w-[62%] mb-4 max-w-[1200px] flex gap-1.5 items-center">
      <h1 className="text-2xl font-bold">{title}</h1>
      <LucideCircleQuestionMark/>
    </div>
  );
}