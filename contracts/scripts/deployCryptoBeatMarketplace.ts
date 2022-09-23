import { ethers } from "hardhat";
import { CryptoBeatMarketplace__factory } from "../typechain-types";

const erc20Address = "";
const cryptoBeatAddress = "";
const fee = 50;

const main = async () => {
    const [deployer] = await ethers.getSigners();

    const beatMarketplace = await (await new CryptoBeatMarketplace__factory(deployer).deploy(erc20Address, cryptoBeatAddress, fee)).deployed();

    console.log(beatMarketplace.address);
};

main();