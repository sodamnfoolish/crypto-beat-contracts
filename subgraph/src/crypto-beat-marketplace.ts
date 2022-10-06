import {
  Buy as BuyEvent,
  Sell as SellEvent,
} from "../generated/CryptoBeatMarketplace/CryptoBeatMarketplace";

import { CryptoBeat, OnSaleCryptoBeat } from "../generated/schema";

import { Address, BigInt } from "@graphprotocol/graph-ts";

export function handleBuy(event: BuyEvent): void {
  const cryptoBeat = CryptoBeat.load(event.params.cryptoBeatId.toString())!;

  const onSaleCryptoBeat = OnSaleCryptoBeat.load(
    cryptoBeat.currentOnSaleCryptoBeatId
  )!;

  onSaleCryptoBeat.onSale = false;
  onSaleCryptoBeat.buyer = event.params.buyer;
  onSaleCryptoBeat.buyTimestamp = event.block.timestamp;

  onSaleCryptoBeat.save();
}

export function handleSell(event: SellEvent): void {
  const onSaleCryptoBeat = new OnSaleCryptoBeat(
    event.transaction.hash.toString() + event.logIndex.toString()
  );

  onSaleCryptoBeat.onSale = true;
  onSaleCryptoBeat.seller = event.params.seller;
  onSaleCryptoBeat.sellTimestamp = event.block.timestamp;
  onSaleCryptoBeat.buyer = Address.zero();
  onSaleCryptoBeat.buyTimestamp = BigInt.zero();
  onSaleCryptoBeat.cryptoBeatId = event.params.cryptoBeatId;
  onSaleCryptoBeat.cryptoBeatPrice = event.params.cryptoBeatPrice;

  onSaleCryptoBeat.save();

  const cryptoBeat = CryptoBeat.load(event.params.cryptoBeatId.toString())!;

  cryptoBeat.currentOnSaleCryptoBeatId = onSaleCryptoBeat.id;

  cryptoBeat.save();
}
