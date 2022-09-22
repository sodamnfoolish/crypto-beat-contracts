import {CryptoBeatERC721__factory} from "../typechain-types";
import {ethers} from "hardhat";
import {randomTokenURISuffix} from "../helpers/CryptoBeatERC721";
import {expect} from "chai";
import {BigNumber} from "ethers";

const _baseTokenURI = "https://ipfs.io/ipfs/";

describe("CryptoBeatERC721", async () => {
    const fixture = async () => {
        const [deployer, randomGuy] = await ethers.getSigners();

        const cryptoBeatERC721 = await (await new CryptoBeatERC721__factory(deployer).deploy()).deployed();

        return {
            deployer,
            randomGuy,
            cryptoBeatERC721
        };
    };

    describe("Mint", async () => {
        it("Should mint", async () => {
            const {
                randomGuy,
                cryptoBeatERC721
            } = await fixture();

            const tokenURISuffix = randomTokenURISuffix();

            const tokenId = await cryptoBeatERC721.connect(randomGuy).callStatic.mint(tokenURISuffix);
            await cryptoBeatERC721.connect(randomGuy).mint(tokenURISuffix);

            expect(await cryptoBeatERC721.balanceOf(randomGuy.address)).eq(BigNumber.from(1));
            expect(await cryptoBeatERC721.ownerOf(tokenId)).eq(randomGuy.address);
            expect(await cryptoBeatERC721.tokenURI(tokenId)).eq(_baseTokenURI + tokenURISuffix);
        });
    });
});