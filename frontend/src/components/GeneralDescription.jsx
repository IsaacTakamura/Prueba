import React from 'react';

export default function GeneralDescription() {

  return (
    <div className="bg-[#1a1c29] text-white p-8 rounded-lg max-w-3xl mx-auto mt-8 space-y-6 text-center ring-1 ring-white/30">
      <div>
        <p className="text-lg md:text-xl leading-relaxed mb-2">
          At ITMEET, we believe that every great solution starts with a good test. That's why we created ITMEET Labs, our innovation program where we take ideas with potential and turn them into functional prototypes using technologies like Artificial Intelligence (AI), Machine Learning (ML), and more.
        </p>
        {/* Pregunta destacada */}
        <p className="text-xl md:text-1xl font-bold leading-relaxed mb-2">
          Do you have an idea that could revolutionize your business?
          <br />
          </p>
          <p className="text-lg md:text-xl leading-relaxed mb-2">
            Let's test it together at ITMEET Labs. 
          </p>
        {/* Botón */}
        <button
          className="rounded-full px-6 md:px-7 py-3 md:py-3.5 text-white font-semibold
                     bg-[linear-gradient(90deg,#2E63FF_0%,#5AA9FF_100%)]
                     shadow-lg shadow-black/20 hover:opacity-95 transition focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-opacity-75"
          onClick={() => console.log('Explorar Logros Clickeado')}
        >
          Explore Our Achievements
        </button>
      </div>

    </div>
  );
}