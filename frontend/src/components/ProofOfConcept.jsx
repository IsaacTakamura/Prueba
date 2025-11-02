import React from 'react';
import DescripcionCard from './ui/DescripcionCard';

const ProofOfConcept = () => {
    return (
        <div>
            <div className="text-4xl text-center text-blue-600 font-bold mb-6">Proof Of Concept (PoCs)</div>
            <div className="bg-linear-to-br from-gray-800 to-gray-900 rounded-3xl p-8 shadow-2xl border border-gray-700 mx-auto my-16">

                <div className="text-lg mb-6 text-center flex justify-center">
                    Here, we highlight innovative Proof of Concepts that demonstrate the feasibility and potential of emerging
                    technologies in real-world scenarios. Each PoC is a stepping stone to future large-scale projects.
                </div>
                <div className="grid grid-cols-1 sm:grid-cols-2 gap-6 max-w-4xl">
                    <DescripcionCard
                        title="AI-driven Supply Chain Optimization"
                        description="A PoC demonstrating how AI can predict demand fluctuations and optimize logistics."
                        icon="+X"
                    />
                    <DescripcionCard
                        title="Automated Quality Control with CV"
                        description="A system prototype using computer vision for real-time product defect detection on assembly lines."
                        icon="+X"
                    />
                    {/* Puedes agregar más DescripcionCard aquí */}
                </div>
            </div>
        </div>

    );
};

export default ProofOfConcept;
