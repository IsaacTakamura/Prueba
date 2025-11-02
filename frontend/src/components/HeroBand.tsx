export default function HeroBand() {
  
  return (
    <div className="w-full bg-gradient-to-r from-[#423DD3] to-[#0F20DC]">
      <div className="container mx-auto px-4">
        <section className=" py-12 md:py-16 items-center text-center flex flex-col">
      {/* Título */}
      <h1 className="flex flex-wrap items-baseline gap-3">
        <span className="text-white font-extrabold tracking-tight text-5xl md:text-7xl leading-none">
          ITMEET
        </span>
        <span className="text-black font-extrabold tracking-tight text-5xl md:text-7xl leading-none">
          Labs
        </span>
      </h1>

      {/* Subtítulo */}
      <p className="mt-4 text-white/90 text-lg md:text-2xl">
        Where ideas become prototypes
      </p>

      {/* Botón */}
      <div className="mt-8">
        <button
          className="rounded-full px-6 md:px-7 py-3 md:py-3.5 text-white font-semibold
                     bg-[linear-gradient(90deg,#2E63FF_0%,#5AA9FF_100%)]
                     shadow-lg shadow-black/20 hover:opacity-95 transition"
        >
          What’s ITMEET Labs?
        </button>
      </div>
    </section>
      </div>
    </div>
    
  );
}