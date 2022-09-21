import React, {useEffect, useState} from "react";
import {ethers} from "ethers";

export function isMetaMaskAvailable() {
    return window.ethereum != undefined && window.ethereum.isMetaMask;
}

export function useMetaMask() {
    const provider = new ethers.providers.Web3Provider(window.ethereum);
    const signer = provider.getSigner();

    const [signerAddress, setSignerAddress] = useState("");
    const [isMetaMaskConnected, setIsMetaMaskConnected] = useState(false);
    const [isRightMetaMaskNetwork, setIsRightMetaMaskNetwork] = useState(false);

    useEffect(() => {
        window.ethereum.on("chainChanged", () => {
            window.location.reload();
        });
        window.ethereum.on("accountsChanged", () => {
            window.location.reload();
        });
    });

    signer
        .getAddress()
        .then(result => {
            setSignerAddress(result);
            setIsMetaMaskConnected(true);

            signer
                .getChainId()
                .then(result => setIsRightMetaMaskNetwork(result == process.env.REACT_APP_CHAIN_ID));
        });

    const connectMetaMask = () => provider.send("eth_requestAccounts", []);

    const switchChain = () => provider.send("wallet_switchEthereumChain", [{ chainId: ethers.utils.hexValue(Number(process.env.REACT_APP_CHAIN_ID)) }])

    return {
        provider,
        signer,
        signerAddress,
        isMetaMaskConnected,
        isRightMetaMaskNetwork,
        connectMetaMask,
        switchChain
    };
}