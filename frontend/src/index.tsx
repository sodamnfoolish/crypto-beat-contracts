import React from "react";
import ReactDOM from "react-dom/client";
import reportWebVitals from "./reportWebVitals";
import MetaMask from "./components/MetaMask";
import Menu from "./components/Menu";

const root = ReactDOM.createRoot(
  document.getElementById("root") as HTMLElement
);

root.render(
  <React.StrictMode>
    <MetaMask>
      <Menu />
    </MetaMask>
  </React.StrictMode>
);

reportWebVitals(console.log);
