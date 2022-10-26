import React from "react";
import { ethers } from "ethers";

export function useMetaMask() {
  const available = window.ethereum != undefined && window.ethereum.isMetaMask;
  const provider = new ethers.providers.Web3Provider(window.ethereum);
  const [accounts, setAccounts] = React.useState([] as string[]);
  const signer = provider.getSigner();
  const [signerAddress, setSignerAddress] = React.useState(
    ethers.constants.AddressZero
  );
  const [chainId, setChainId] = React.useState(0);

  provider.send("eth_accounts", []).then((result: string[]) => {
    setAccounts(result);

    signer.getAddress().then((result) => setSignerAddress(result));

    signer.getChainId().then((result) => setChainId(result));
  });

  const connectMetaMask = () => provider.send("eth_requestAccounts", []);

  const switchChain = (newChainId: number) =>
    provider.send("wallet_switchEthereumChain", [
      {
        chainId: ethers.utils.hexValue(Number(newChainId)),
      },
    ]);

  return {
    available,
    provider,
    accounts,
    signer,
    signerAddress,
    chainId,
    connectMetaMask,
    switchChain,
  };
}
