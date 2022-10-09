import { ethers } from "ethers";

export interface OnSaleCryptoBeatGraphQLEntity {
  id: string;
  onSale: boolean;
  seller: string;
  sellTimestamp: ethers.BigNumber;
  buyer: string;
  buyTimestamp: ethers.BigNumber;
  cryptoBeatId: ethers.BigNumber;
  cryptoBeatPrice: ethers.BigNumber;
}

export interface OnSaleCryptoBeatGraphQLResponse {
  onSaleCryptoBeats: OnSaleCryptoBeatGraphQLModel[];
}
