import { BigNumber } from "ethers";

export const randomPrice = () =>
  BigNumber.from(100 + Math.floor(Math.random() * 100)); // 100 ... 200

export const randomFee = () =>
  BigNumber.from(25 + Math.floor(Math.random() * 50)); // 25 .. 75

export const calculateFee = (price: BigNumber, fee: BigNumber) =>
  price.mul(fee).div(100);

export enum Signers {
  deployer,
  publisher,
  buyer,
}
