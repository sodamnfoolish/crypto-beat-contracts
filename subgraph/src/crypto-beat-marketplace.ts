import {
  Buy as BuyEvent,
  Sell as SellEvent
} from "../generated/CryptoBeatMarketplace/CryptoBeatMarketplace"
import { Buy, Sell } from "../generated/schema"

export function handleBuy(event: BuyEvent): void {
  let entity = new Buy(
    event.transaction.hash.toHex() + "-" + event.logIndex.toString()
  )
  entity.seller = event.params.seller
  entity.buyer = event.params.buyer
  entity.cryptoBeatId = event.params.cryptoBeatId
  entity.cryptoBeatPrice = event.params.cryptoBeatPrice
  entity.fee = event.params.fee
  entity.save()
}

export function handleSell(event: SellEvent): void {
  let entity = new Sell(
    event.transaction.hash.toHex() + "-" + event.logIndex.toString()
  )
  entity.seller = event.params.seller
  entity.cryptoBeatId = event.params.cryptoBeatId
  entity.cryptoBeatPrice = event.params.cryptoBeatPrice
  entity.save()
}
