import { SignedIn, SignedOut, SignInButton, UserButton } from "@clerk/clerk-react";
import HeroBand from "./components/HeroBand";
import GeneralDescription from "./components/GeneralDescription";
import { MouseIcon } from './components/icons/MouseIcon';
import DownwardIcon from "./components/icons/DownwardIcon";
import LabsMetrics from "./components/LabsMetrics";
import {useCounters} from "./hooks/useCounters";
import ProofOfConcept from "./components/ProofOfConcept";

export default function App() {
  const { counters, loading } = useCounters();

  return (
    <div className="bg-black min-h-screen text-white flex flex-col items-center justify-center">
      <SignedOut>
        <SignInButton />
      </SignedOut>

      <SignedIn>
        

      </SignedIn>
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
        <div className="flex flex-col items-center gap-8 my-8">
          <div className="p-4 rounded-full bg-[#191919] ring-1 ring-white/30 flex items-center justify-center">
            <MouseIcon className="text-white" width={32} height={32} />
          </div>
          <div className="flex items-center justify-center">
            <DownwardIcon className="text-white transform scale-y-250" width={48} height={24} />
          </div>
        </div>
        <LabsMetrics loading={loading} counters={counters} />
        <ProofOfConcept />
    </div>
  )
}
