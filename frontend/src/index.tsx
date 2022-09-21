import React from 'react';
import ReactDOM from 'react-dom/client';
import reportWebVitals from './reportWebVitals';
import MetaMask from "./components/MetaMask";
import Marketplace from "./components/Marketplace";

const root = ReactDOM.createRoot(
    document.getElementById('root') as HTMLElement
);

root.render(
    <React.StrictMode>
        <MetaMask/>
        <Marketplace/>
    </React.StrictMode>
);

reportWebVitals(console.log);
