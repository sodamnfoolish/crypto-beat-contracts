import React from "react";
import {isMetaMaskAvailable, useMetaMask} from "../hooks/MetaMask";

export default function MetaMask(props: any) {
    if (!isMetaMaskAvailable())
        return <div>MetaMask not available :(</div>

    const {
        signerAddress,
        isMetaMaskConnected,
        isRightMetaMaskNetwork,
        connectMetaMask,
        switchChain
    } = useMetaMask();

    if (!isMetaMaskConnected)
        return (
            <div>
                <button onClick={connectMetaMask}>
                    Connect MetaMask
                </button>
            </div>
        );

    if (!isRightMetaMaskNetwork)
        return (
            <div>
                <button onClick={switchChain}>
                    Change network
                </button>
            </div>
        );

    return (
        <div>
            {signerAddress}
        </div>
    );
}