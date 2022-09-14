import { BeatMarketplace, TestERC20__factory } from "../typechain-types";
import { ethers, upgrades } from "hardhat";
import { randomHash } from "hardhat/internal/hardhat-network/provider/utils/random";
import { expect } from "chai";
import {calculateFee, randomFee, randomPrice, Signers} from "../helpers/BeatsMarketplace";
import {getSigner} from "../helpers/ethers";

describe("BeatMarketplace", async () => {
    const publishFixture = async () => {
        const deployer = await getSigner(Signers.deployer);

        const terc20 = await(await new TestERC20__factory(deployer).deploy()).deployed();
        const fee = randomFee();

        const beatMarketplaceFactory = await ethers.getContractFactory("BeatMarketplace", deployer);

        const beatMarketplace = await (await upgrades.deployProxy(
            beatMarketplaceFactory,
            [
                terc20.address,
                fee
            ],
            {
                initializer: 'initialize(address, uint256)'
            }
        )).deployed() as BeatMarketplace;

        const publisher = await getSigner(Signers.publisher);

        const id = randomHash();
        const price = randomPrice();

        return {
            deployer,
            terc20,
            fee,
            beatMarketplace,
            publisher,
            id,
            price,
        };
    };

    describe("Publish", async () => {
        it("Should publish", async () => {
            const { beatMarketplace, publisher, id, price } = await publishFixture();

            await beatMarketplace.connect(publisher).publish(id, price);

            const beat = await beatMarketplace._beats(id);

            expect(beat.publisher, "Wrong owner address").eq(publisher.address);
            expect(beat.price, "Wrong price").eq(price);
            expect(beat.onSold, "Wrong onSold").eq(true);
        });

        it("Should not publish - BeatsMarketplace: duplicate ID", async () => {
            const { beatMarketplace, publisher, id, price } = await publishFixture();

            await beatMarketplace.connect(publisher).publish(id, price);

            const beat = await beatMarketplace._beats(id);

            expect(beat.publisher, "Wrong owner address").eq(publisher.address);
            expect(beat.price, "Wrong price").eq(price);
            expect(beat.onSold, "Wrong onSold").eq(true);

            const newPrice = price + randomPrice();

            await expect(beatMarketplace.connect(publisher).publish(id, newPrice)).revertedWith("BeatsMarketplace: duplicate ID");

            expect(beat.publisher, "Wrong owner address").eq(publisher.address);
            expect(beat.price, "Wrong price").eq(price);
            expect(beat.onSold, "Wrong onSold").eq(true);
        });
    })

    const buyFixture = async () => {
        const {
            deployer,
            terc20,
            fee,
            beatMarketplace,
            publisher,
            id,
            price
        } = await publishFixture();

        await beatMarketplace.connect(publisher).publish(id, price);

        const buyer = await getSigner(Signers.buyer);

        await terc20.connect(deployer).transfer(buyer.address, price);

        await terc20.connect(buyer).approve(beatMarketplace.address, price);

        const calculatedFee = calculateFee(price, fee);

        return {
            deployer,
            terc20,
            fee,
            beatMarketplace,
            publisher,
            id,
            price,
            buyer,
            calculatedFee
        };
    }

    describe("Buy", async () => {
        it("Should buy", async () => {
            const {
                terc20,
                beatMarketplace,
                publisher,
                id,
                price,
                buyer,
                calculatedFee
            } = await buyFixture();

            await beatMarketplace.connect(buyer).buy(id);

            expect(await terc20.balanceOf(beatMarketplace.address), "Wrong beatsMarketplace terc20 balance").eq(calculatedFee);
            expect(await terc20.balanceOf(publisher.address), "Wrong publisher terc20 balance").eq(price - calculatedFee);
            expect(await terc20.balanceOf(buyer.address), "Wrong buyer terc20 balance").eq(0);

            const beat = await beatMarketplace._beats(id);

            expect(beat.publisher, "Wrong owner address").eq(publisher.address);
            expect(beat.price, "Wrong price").eq(price);
            expect(beat.onSold, "Wrong onSold").eq(false);
        });

        it("Should not buy - BeatsMarketplace: not published", async () => {
            const {
                beatMarketplace,
                buyer
            } = await buyFixture();

            const newId = randomHash();

            await expect(beatMarketplace.connect(buyer).buy(newId)).revertedWith("BeatsMarketplace: not published");
        });

        it("Should not buy - BeatsMarketplace: sold", async () => {

            const {
                terc20,
                beatMarketplace,
                publisher,
                id,
                price,
                buyer,
                calculatedFee
            } = await buyFixture();

            await beatMarketplace.connect(buyer).buy(id);

            expect(await terc20.balanceOf(beatMarketplace.address), "Wrong beatsMarketplace terc20 balance").eq(calculatedFee);
            expect(await terc20.balanceOf(publisher.address), "Wrong publisher terc20 balance").eq(price - calculatedFee);
            expect(await terc20.balanceOf(buyer.address), "Wrong buyer terc20 balance").eq(0);

            const beat = await beatMarketplace._beats(id);

            expect(beat.publisher, "Wrong owner address").eq(publisher.address);
            expect(beat.price, "Wrong price").eq(price);
            expect(beat.onSold, "Wrong onSold").eq(false);

            await expect(beatMarketplace.connect(buyer).buy(id)).revertedWith("BeatsMarketplace: sold");

            expect(beat.publisher, "Wrong owner address").eq(publisher.address);
            expect(beat.price, "Wrong price").eq(price);
            expect(beat.onSold, "Wrong onSold").eq(false);
        });
    });
});