import { SignedIn, SignedOut, SignInButton, UserButton } from "@clerk/clerk-react";
import HeroBand from "./components/HeroBand";
import GeneralDescription from "./components/GeneralDescription";
import { MaterialSymbolsLightMouse } from './components/icons/MouseIcon';
import Card from "./components/ui/Card";

export default function App() {
  
  return (
    <div className="bg-black min-h-screen flex flex-col items-center justify-center">
      <SignedOut>
        <SignInButton />
      </SignedOut>

      <SignedIn>
        <div className="absolute top-4 right-4">
          <UserButton />
        </div>
        
        <div className="p-4">
          <HeroBand />
        </div>
        <div className="p-4 rounded-full bg-[#191919] ring-1 ring-white/30 flex items-center justify-center">
          <MaterialSymbolsLightMouse className="text-white" width={32} height={32} />
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
                <Card number="5" title="Applied Technologies" />
                <Card number="5" title="Applied Technologies" />
            </div>

          </div>

        </div>

      </SignedIn>
    </div>
  )
}
