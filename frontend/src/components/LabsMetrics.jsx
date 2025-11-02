import Card from "./ui/Card";
import DocumentWritting from "./icons/DocumentWriting";
import CheckIcon from "./icons/CheckIcon";
import TechonologyIcon from "./icons/TechonologyIcon";

export default function LabsMetrics({ loading, counters }) {
  return (
    <div className="py-16 bg-gray-950 p-8">
      <div className="max-w-6xl mx-auto">
        <h1 className="text-4xl font-bold text-white text-center mb-12">
          Our Labs In Numbers
        </h1>
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
          <Card 
            number={loading ? "..." : counters.proofConcepts} 
            title="Proof Of Concept" 
            icon={DocumentWritting} 
          />
          <Card 
            number={loading ? "..." : counters.successStories} 
            title="Success Stories" 
            icon={CheckIcon} 
          />
          <Card 
            number={loading ? "..." : counters.appliedTechnologies} 
            title="Applied Technologies" 
            icon={TechonologyIcon} 
          />
        </div>
      </div>
    </div>
  );
}