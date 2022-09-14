import { ethers, upgrades } from "hardhat";
import { BeatMarketplace } from "../typechain-types";

const terc20Address = "";
const fee = 50;

const main = async () => {
    const [deployer] = await ethers.getSigners();

    const beatMarketplaceFactory = await ethers.getContractFactory("BeatMarketplace", deployer);

    const beatMarketplace = await (await upgrades.deployProxy(
        beatMarketplaceFactory,
        [
            terc20Address,
            fee
        ],
        {
            initializer: 'initialize(address, uint256)'
        }
    )).deployed() as BeatMarketplace;

    console.log(beatMarketplace.address);
};

main();