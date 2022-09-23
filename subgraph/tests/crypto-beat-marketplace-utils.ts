import { newMockEvent } from "matchstick-as"
import { ethereum, Address, BigInt } from "@graphprotocol/graph-ts"
import {
  Buy,
  Sell
} from "../generated/CryptoBeatMarketplace/CryptoBeatMarketplace"

export function createBuyEvent(
  seller: Address,
  buyer: Address,
  cryptoBeatId: BigInt,
  cryptoBeatPrice: BigInt,
  fee: BigInt
): Buy {
  let buyEvent = changetype<Buy>(newMockEvent())

  buyEvent.parameters = new Array()

  buyEvent.parameters.push(
    new ethereum.EventParam("seller", ethereum.Value.fromAddress(seller))
  )
  buyEvent.parameters.push(
    new ethereum.EventParam("buyer", ethereum.Value.fromAddress(buyer))
  )
  buyEvent.parameters.push(
    new ethereum.EventParam(
      "cryptoBeatId",
      ethereum.Value.fromUnsignedBigInt(cryptoBeatId)
    )
  )
  buyEvent.parameters.push(
    new ethereum.EventParam(
      "cryptoBeatPrice",
      ethereum.Value.fromUnsignedBigInt(cryptoBeatPrice)
    )
  )
  buyEvent.parameters.push(
    new ethereum.EventParam("fee", ethereum.Value.fromUnsignedBigInt(fee))
  )

  return buyEvent
}

export function createSellEvent(
  seller: Address,
  cryptoBeatId: BigInt,
  cryptoBeatPrice: BigInt
): Sell {
  let sellEvent = changetype<Sell>(newMockEvent())

  sellEvent.parameters = new Array()

  sellEvent.parameters.push(
    new ethereum.EventParam("seller", ethereum.Value.fromAddress(seller))
  )
  sellEvent.parameters.push(
    new ethereum.EventParam(
      "cryptoBeatId",
      ethereum.Value.fromUnsignedBigInt(cryptoBeatId)
    )
  )
  sellEvent.parameters.push(
    new ethereum.EventParam(
      "cryptoBeatPrice",
      ethereum.Value.fromUnsignedBigInt(cryptoBeatPrice)
    )
  )

  return sellEvent
}
