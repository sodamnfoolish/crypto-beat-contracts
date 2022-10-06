import { ethers } from "hardhat";
import { TestERC20__factory } from "../typechain-types";

const main = async () => {
  const [deployer] = await ethers.getSigners();

  const terc20 = await (
    await new TestERC20__factory(deployer).deploy()
  ).deployed();

  console.log(terc20.address);
};

main();
