import { ethers } from "ethers";

export interface CryptoBeatGraphQLEntity {
  id: string;
  creator: string;
  creatorTimestamp: ethers.BigNumber;
  owner: string;
  ownerTimestamp: ethers.BigNumber;
  url: string;
  currentOnSaleCryptoBeatId: string;
}

export interface CryptoBeatGraphQLResponse {
  cryptoBeats: CryptoBeatGraphQLEntity[];
}
