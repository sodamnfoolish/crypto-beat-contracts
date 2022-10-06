import {
  CryptoBeat as CryptoBeatContract,
  Transfer as TransferEvent,
} from "../generated/CryptoBeat/CryptoBeat";

import { CryptoBeat } from "../generated/schema";

import { Address } from "@graphprotocol/graph-ts";

export function handleTransfer(event: TransferEvent): void {
  if (event.params.from == Address.zero()) {
    const cryptoBeat = new CryptoBeat(event.params.tokenId.toString());
    const url = CryptoBeatContract.bind(event.address).tokenURI(
      event.params.tokenId
    );

    cryptoBeat.owner = cryptoBeat.creator = event.params.to;
    cryptoBeat.ownerTimestamp = cryptoBeat.creatorTimestamp =
      event.block.timestamp;
    cryptoBeat.url = url;
    cryptoBeat.currentOnSaleCryptoBeatId = "";

    cryptoBeat.save();
  } else {
    const cryptoBeat = CryptoBeat.load(event.params.tokenId.toString())!;

    cryptoBeat.owner = event.params.to;
    cryptoBeat.ownerTimestamp = event.block.timestamp;

    cryptoBeat.save();
  }
}
