import React from "react";
import { ethers } from "ethers";
import { useMetaMask } from "../hooks/MetaMask";
import { useContracts } from "../hooks/Contracts";
import { useSubGraph } from "../hooks/SubGraph";
import { CryptoBeatGraphQLEntity } from "../types/subgraph/crypto-beat";
import { OnSaleCryptoBeatGraphQLEntity } from "../types/subgraph/on-sale-crypto-beat";

export default function Buy(props: any) {
  const [erc20Balance, setErc20Balance] = React.useState(ethers.constants.Zero);
  const [cryptoBeats, setCryptoBeats] = React.useState(
    [] as CryptoBeatGraphQLEntity[]
  );
  const [cryptoBeatsOnSale, setCryptoBeatsOnSale] = React.useState(
    [] as OnSaleCryptoBeatGraphQLEntity[]
  );

  const { signerAddress } = useMetaMask();

  const { erc20, cryptoBeatMarketplace } = useContracts();

  const { getCryptoBeats, getCryptoBeatsOnSale } = useSubGraph();

  erc20
    .balanceOf(signerAddress)
    .then((result: ethers.BigNumber) => setErc20Balance(result));

  getCryptoBeats().then((result) => setCryptoBeats(result));

  getCryptoBeatsOnSale().then((result) => setCryptoBeatsOnSale(result));

  const onBuyButtonClick = async (
    cryptoBeatOnSale: OnSaleCryptoBeatGraphQLEntity
  ) => {
    await erc20.approve(
      cryptoBeatMarketplace.address,
      cryptoBeatOnSale.cryptoBeatPrice
    );
    await cryptoBeatMarketplace.buy(cryptoBeatOnSale.cryptoBeatId);
  };

  return (
    <div>
      <table>
        {cryptoBeatsOnSale.map((cryptoBeatOnSale) => {
          return (
            <div>
              <tr>
                <a
                  href={
                    cryptoBeats.find(
                      (cryptoBeat) =>
                        cryptoBeat.id ==
                        cryptoBeatOnSale.cryptoBeatId.toString()
                    )!.url
                  }
                >
                  Link
                </a>
              </tr>
              <tr>{cryptoBeatOnSale.cryptoBeatPrice.toString()}</tr>
              <tr>
                <button
                  disabled={erc20Balance < cryptoBeatOnSale.cryptoBeatPrice}
                  onClick={async () => await onBuyButtonClick(cryptoBeatOnSale)}
                >
                  Buy
                </button>
              </tr>
            </div>
          );
        })}
      </table>
    </div>
  );
}
