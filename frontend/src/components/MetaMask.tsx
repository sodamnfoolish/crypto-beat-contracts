import React from "react";
import { useMetaMask } from "../hooks/MetaMask";

export default function MetaMask(props: any) {
  const {
    available,
    accounts,
    signerAddress,
    chainId,
    connectMetaMask,
    switchChain,
  } = useMetaMask();

  if (!available) return <div>MetaMask not available :(</div>;

  if (!accounts.length)
    return (
      <div>
        <button onClick={connectMetaMask}>Connect MetaMask</button>
      </div>
    );

  if (chainId != Number(process.env.REACT_APP_CHAIN_ID))
    return (
      <div>
        <button onClick={() => switchChain(process.env.REACT_APP_CHAIN_ID)}>
          Change network
        </button>
      </div>
    );

  return (
      <div>
        <div>{signerAddress}</div>
        <div>{props.children}</div>
      </div>
  );
}
