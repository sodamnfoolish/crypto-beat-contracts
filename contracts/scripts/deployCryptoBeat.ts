import { ethers } from "hardhat";
import { CryptoBeat__factory } from "../typechain-types";

const main = async () => {
  const [deployer] = await ethers.getSigners();

  const cryptoBeat = await (
    await new CryptoBeat__factory(deployer).deploy()
  ).deployed();

  console.log(cryptoBeat.address);
};

main();
