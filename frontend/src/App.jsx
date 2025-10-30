import { useState, useEffect } from "react";
import { getSiteCounters } from "./services/countersService";
import { useSupabaseClient } from "./hooks/useSupabaseClient";
import { SignedIn, SignedOut, SignInButton, UserButton } from "@clerk/clerk-react";
import HeroBand from "./components/HeroBand";
import GeneralDescription from "./components/GeneralDescription";
import { MouseIcon } from './components/icons/MouseIcon';
import Card from "./components/ui/Card";
import DocumentWritting from "./components/icons/DocumentWritting";
import DownwardIcon from "./components/icons/DownwardIcon";
import CheckIcon from "./components/icons/CheckIcon";
import TechonologyIcon from "./components/icons/TechonologyIcon";

export default function App() {
  const { getClient } = useSupabaseClient();
  const [counters, setCounters] = useState({
    appliedTechnologies: 0,
    proofConcepts: 0,
    successStories: 0
  });
  const [loading, setLoading] = useState(true);

  // Cargar los contadores al montar el componente
  useEffect(() => {
    const loadCounters = async () => {
      try {
        const supabase = await getClient();
        const data = await getSiteCounters(supabase);

        if (data) {
          setCounters(data);
        }
      } catch (error) {
        console.error('Error cargando contadores:', error);
      } finally {
        setLoading(false);
      }
    };

    loadCounters();
  }, []);

  return (
    <div className="bg-black min-h-screen text-white flex flex-col items-center justify-center">
      <SignedOut>
        <SignInButton />
      </SignedOut>

      <SignedIn>
        <div className="absolute text-white top-4 right-4">
          <UserButton />
        </div>

        <div className="w-full rounded-b-3xl overflow-hidden">
          <HeroBand />
        </div>
        <div className="flex flex-col items-center gap-8 my-8">
          <div className="p-4 rounded-full bg-[#191919] ring-1 ring-white/30 flex items-center justify-center">
            <MouseIcon className="text-white" width={32} height={32} />
          </div>
          <div className="flex items-center justify-center">
            <DownwardIcon className="text-white transform scale-y-250" width={48} height={24} />
          </div>
        </div>
        <div className="bg-black min-h-screen flex flex-col items-center justify-center">
          <GeneralDescription />
        </div>
        <div className="min-h-screen bg-gray-950 p-8">
          <div className="max-w-6xl mx-auto">
            <h1 className="text-4xl foont-bold text-white text-center mb-12">
              Our Labs In Numbers
            </h1>
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
              {/* Aquí puedes agregar los NumberCards u otros componentes */}
              <Card number="5" title="Proof Of Concept" icon={DocumentWritting} />
              <Card number={loading ? "..." : counters.successStories} title="Success Stories" icon={CheckIcon} />
              <Card number={loading ? "..." : counters.appliedTechnologies} title="Applied Technologies" icon={TechonologyIcon} />
            </div>

          </div>

        </div>

      </SignedIn>
    </div>
  )
}
