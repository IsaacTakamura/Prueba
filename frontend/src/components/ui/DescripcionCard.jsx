import React from 'react';

const DescripcionCard = ({ title, description, icon }) => {
  return (
    <div className="bg-blue-600 text-white p-6 rounded-2xl flex flex-col space-y-4 max-w-sm mx-auto">
      <div className="text-xl font-bold">{title}</div>
      <div>{description}</div>
      <div className="flex justify-between items-center">
        <div className="text-3xl">{icon}</div>
      </div>
    </div>
  );
};

export default DescripcionCard;