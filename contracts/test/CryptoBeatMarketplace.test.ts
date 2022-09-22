import {ethers} from "hardhat";
import {TestERC20__factory, CryptoBeat__factory, CryptoBeatMarketplace__factory} from "../typechain-types";
import {calculateFee, randomFee, randomPrice} from "../helpers/CryptoBeatMarketplace";
import {BigNumber} from "ethers";
import {randomTokenURISuffix} from "../helpers/CryptoBeat";
import {expect} from "chai";

describe("CryptoBeatMarketplace", async () => {
    const fixture = async () => {
        const [deployer, seller, buyer] = await ethers.getSigners();

        const erc20 = await (await new TestERC20__factory(deployer).deploy()).deployed();

        const cryptoBeat = await (await new CryptoBeat__factory(deployer).deploy()).deployed();

        const fee = randomFee();

        const cryptoBeatMarketplace = await (await new CryptoBeatMarketplace__factory(deployer).deploy(erc20.address, cryptoBeat.address, fee)).deployed();

        return {
            deployer,
            seller,
            buyer,
            erc20,
            cryptoBeat,
            fee,
            cryptoBeatMarketplace
        };
    };

    describe("Sell", async () => {
        it("Should sell", async () => {
            const {
                seller,
                cryptoBeat,
                cryptoBeatMarketplace
            } = await fixture();

            const cryptoBeatId = await cryptoBeat.connect(seller).callStatic.mint(randomTokenURISuffix());
            await cryptoBeat.connect(seller).mint(randomTokenURISuffix());

            await cryptoBeat.connect(seller).approve(cryptoBeatMarketplace.address, cryptoBeatId)

            const cryptoBeatPrice = randomPrice();

            await cryptoBeatMarketplace.connect(seller).sell(cryptoBeatId, cryptoBeatPrice);

            expect(await cryptoBeat.ownerOf(cryptoBeatId)).eq(cryptoBeatMarketplace.address);

            const cryptoBeatSaleInfo = await cryptoBeatMarketplace._cryptoBeatSaleInfo(cryptoBeatId);

            expect(cryptoBeatSaleInfo.seller).eq(seller.address);
            expect(cryptoBeatSaleInfo.price).eq(cryptoBeatPrice);
        });
    });

    describe("Buy", async () => {
        const buyFixture = async () => {
            const {
                seller,
                buyer,
                erc20,
                cryptoBeat,
                fee,
                cryptoBeatMarketplace
            } = await fixture();

            const cryptoBeatId = await cryptoBeat.connect(seller).callStatic.mint(randomTokenURISuffix());
            await cryptoBeat.connect(seller).mint(randomTokenURISuffix());

            await cryptoBeat.connect(seller).approve(cryptoBeatMarketplace.address, cryptoBeatId)

            const cryptoBeatPrice = randomPrice();

            await cryptoBeatMarketplace.connect(seller).sell(cryptoBeatId, cryptoBeatPrice);

            return {
                seller,
                buyer,
                erc20,
                cryptoBeat,
                fee,
                cryptoBeatMarketplace,
                cryptoBeatId,
                cryptoBeatPrice
            }
        };

        it ("Should buy", async () => {
            const  {
                seller,
                buyer,
                erc20,
                cryptoBeat,
                fee,
                cryptoBeatMarketplace,
                cryptoBeatId,
                cryptoBeatPrice
            } = await buyFixture();

            await erc20.transfer(buyer.address, cryptoBeatPrice);

            await erc20.connect(buyer).approve(cryptoBeatMarketplace.address, cryptoBeatPrice);
            await cryptoBeatMarketplace.connect(buyer).buy(cryptoBeatId);

            const calculatedFee = calculateFee(cryptoBeatPrice, fee);

            expect(await cryptoBeat.ownerOf(cryptoBeatId)).eq(buyer.address);
            expect(await erc20.balanceOf(seller.address)).eq(cryptoBeatPrice.sub(calculatedFee));
            expect(await erc20.balanceOf(buyer.address)).eq(BigNumber.from(0));
            expect(await erc20.balanceOf(cryptoBeatMarketplace.address)).eq(calculatedFee);
        });
    });
});