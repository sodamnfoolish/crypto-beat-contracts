import React from "react";
import { ethers } from "ethers";
import { useMetaMask } from "./MetaMask";
import ERC20Abi from "../abis/ERC20.json";
import CryptoBeatAbi from "../abis/CryptoBeat.json";
import CryptoBeatMarketplaceAbi from "../abis/CryptoBeatMarketplace.json";

export function useContracts() {
  const { signer } = useMetaMask();

  const erc20 = new ethers.Contract(
    process.env.REACT_APP_ERC20_ADDRESS,
    ERC20Abi,
    signer
  );
  const cryptoBeat = new ethers.Contract(
    process.env.REACT_APP_CRYPTOBEAT_ADDRESS,
    CryptoBeatAbi,
    signer
  );
  const cryptoBeatMarketplace = new ethers.Contract(
    process.env.REACT_APP_CRYPTOBEATMARKEPLACE_ADDRESS,
    CryptoBeatMarketplaceAbi,
    signer
  );

  return {
    erc20,
    cryptoBeat,
    cryptoBeatMarketplace,
  };
}
