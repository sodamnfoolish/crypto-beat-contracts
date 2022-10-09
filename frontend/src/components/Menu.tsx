import React from "react";

import Buy from "./Buy";
import Sell from "./Sell";
import Upload from "./Upload";

enum MarketplaceSelect {
  None,
  Buy,
  Sell,
  Upload,
}

export default function Menu(props: any) {
  const [select, setSelect] = React.useState(MarketplaceSelect.None);

  return (
    <div>
      <button
        disabled={select == MarketplaceSelect.Buy}
        onClick={() => setSelect(MarketplaceSelect.Buy)}
      >
        Buy
      </button>
      <button
        disabled={select == MarketplaceSelect.Sell}
        onClick={() => setSelect(MarketplaceSelect.Sell)}
      >
        Sell
      </button>
      <button
        disabled={select == MarketplaceSelect.Upload}
        onClick={() => setSelect(MarketplaceSelect.Upload)}
      >
        Upload
      </button>
      {select == MarketplaceSelect.Buy ? (
        <Buy />
      ) : select == MarketplaceSelect.Sell ? (
        <Sell />
      ) : select == MarketplaceSelect.Upload ? (
        <Upload />
      ) : (
        <></>
      )}
    </div>
  );
}
