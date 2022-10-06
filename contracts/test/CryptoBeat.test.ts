import { CryptoBeat__factory } from "../typechain-types";
import { ethers } from "hardhat";
import { randomTokenURISuffix } from "../helpers/CryptoBeat";
import { expect } from "chai";
import { BigNumber } from "ethers";

const _baseTokenURI = "https://ipfs.io/ipfs/";

describe("CryptoBeatERC721", async () => {
  const fixture = async () => {
    const [deployer, randomGuy] = await ethers.getSigners();

    const cryptoBeat = await (
      await new CryptoBeat__factory(deployer).deploy()
    ).deployed();

    return {
      deployer,
      randomGuy,
      cryptoBeat,
    };
  };

  describe("Mint", async () => {
    it("Should mint", async () => {
      const { randomGuy, cryptoBeat } = await fixture();

      const tokenURISuffix = randomTokenURISuffix();

      const tokenId = await cryptoBeat
        .connect(randomGuy)
        .callStatic.mint(tokenURISuffix);
      await cryptoBeat.connect(randomGuy).mint(tokenURISuffix);

      expect(await cryptoBeat.balanceOf(randomGuy.address)).eq(
        BigNumber.from(1)
      );
      expect(await cryptoBeat.ownerOf(tokenId)).eq(randomGuy.address);
      expect(await cryptoBeat.tokenURI(tokenId)).eq(
        _baseTokenURI + tokenURISuffix
      );
    });
  });
});
