export const randomPrice = () => 100 + Math.floor(Math.random() * 100); // 100 ... 200

export const randomFee = () => 25 + Math.floor(Math.random() * 50); // 25 .. 75

export const calculateFee = (price: number, fee: number) => Math.floor(price * fee / 100);

export enum Signers {
    deployer,
    publisher,
    buyer
};