import React, { createContext, useContext } from "react";

const data1 = "context test!";
const profilContext = createContext(data1);

const ProfilContext = () => {
  return <div>ProfilContext</div>;
};

export default ProfilContext;
