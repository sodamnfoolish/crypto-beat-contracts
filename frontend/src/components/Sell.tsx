import React from "react";
import { ethers } from "ethers";
import { useMetaMask } from "../hooks/MetaMask";
import { useContracts } from "../hooks/Contracts";
import { useSubGraph } from "../hooks/SubGraph";
import { CryptoBeatGraphQLEntity } from "../types/subgraph/crypto-beat";

export default function Sell(props: any) {
  const [ownedCryptoBeats, setOwnedCryptoBeats] = React.useState(
    [] as CryptoBeatGraphQLEntity[]
  );
  const [ownedCryptoBeatsPrice, setOwnedCryptoBeatsPrice] = React.useState(
    [] as ethers.BigNumber[]
  );

  const { signerAddress } = useMetaMask();

  const { cryptoBeat, cryptoBeatMarketplace } = useContracts();

  const { getCryptoBeatsByOwner } = useSubGraph();

  getCryptoBeatsByOwner(signerAddress).then((cryptoBeats) => {
    while (cryptoBeats.length > ownedCryptoBeatsPrice.length)
      ownedCryptoBeatsPrice.push(ethers.constants.Zero);

    while (cryptoBeats.length < ownedCryptoBeatsPrice.length)
      ownedCryptoBeatsPrice.pop();

    setOwnedCryptoBeats(cryptoBeats);
  });

  const onOwnedCryptoBeatsPriceChanged = (
    event: any,
    ownedCryptoBeatIndex: number
  ) => {
    const newCryptoOwnedBeatsPrice = ownedCryptoBeatsPrice;

    newCryptoOwnedBeatsPrice[ownedCryptoBeatIndex] =
      event.target.value == ""
        ? ethers.BigNumber.from(0)
        : ethers.BigNumber.from(event.target.value);

    setOwnedCryptoBeatsPrice(newCryptoOwnedBeatsPrice);
  };

  const onSellButtonClick = async (
    ownedCryptoBeat: CryptoBeatGraphQLEntity,
    index: number
  ) => {
    await cryptoBeat.approve(
      cryptoBeatMarketplace.address,
      ethers.BigNumber.from(ownedCryptoBeat.id)
    );
    await cryptoBeatMarketplace.sell(
      ethers.BigNumber.from(ownedCryptoBeat.id),
      ownedCryptoBeatsPrice[index]
    );
  };

  return (
    <div>
      <table>
        <tbody>
          {ownedCryptoBeats.map((ownerCryptoBeat, index) => {
            return (
              <tr key={index}>
                <td>
                  <a href={ownerCryptoBeat.url} target="_blank">
                    Link
                  </a>
                </td>
                <td>
                  <input
                    value={ownedCryptoBeatsPrice[index].toString()}
                    onChange={(event) =>
                      onOwnedCryptoBeatsPriceChanged(event, index)
                    }
                  />
                </td>
                <td>
                  <button
                    disabled={ownedCryptoBeatsPrice[index]?.isZero()}
                    onClick={async () =>
                      await onSellButtonClick(ownerCryptoBeat, index)
                    }
                  >
                    Sell
                  </button>
                </td>
              </tr>
            );
          })}
        </tbody>
      </table>
    </div>
  );
}
