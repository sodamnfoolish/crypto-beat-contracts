import { ethers } from "hardhat";
import { CryptoBeatMarketplace__factory } from "../typechain-types";

const erc20Address = "0xdba5166A510a9E2ddd4366A29c18bc581Ae8fA7C";
const cryptoBeatAddress = "0xBeb2bCfc38Adf87a8412A99B6339b2D0BbfE19b0";
const fee = 50;

const main = async () => {
    const [deployer] = await ethers.getSigners();

    const cryptoBeatMarketplace = await (await new CryptoBeatMarketplace__factory(deployer).deploy(erc20Address, cryptoBeatAddress, fee)).deployed();

    console.log(cryptoBeatMarketplace.address);
};

main();