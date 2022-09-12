import {ethers} from "hardhat";

export const getSigner = async (index: number) => (await ethers.getSigners())[index];