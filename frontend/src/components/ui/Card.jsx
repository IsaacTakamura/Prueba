const Card = ({ number, title, icon: Icon }) => {
  return (
    <div className="bg-gradient-to-br from-gray-800 to-gray-900 rounded-3xl p-8 shadow-2xl border border-gray-700 max-w-sm">
      {/* Icono circular */}
      <div className="flex justify-center mb-6">
        <div className="bg-blue-600 rounded-full p-6 shadow-lg">
          {Icon && <Icon className="w-10 h-10 text-white" strokeWidth={2} />}
        </div>
      </div>

      {/* Texto */}
      <div className="text-center">
        <h2 className="flex items-baseline justify-center gap-1 text-6xl font-bold mb-2">
          <span className="text-blue-500">{number}</span>
          <span className="text-white ml-1 text-3xl">{title}</span>
        </h2>
      </div>
    </div>
  );
};

export default Card;