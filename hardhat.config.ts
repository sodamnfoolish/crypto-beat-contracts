import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "@openzeppelin/hardhat-upgrades";
import "hardhat-contract-sizer";
import "solidity-coverage";

const config: HardhatUserConfig = {
  solidity: "0.8.16",
  contractSizer: {
    runOnCompile: true
  }
};

export default config;
