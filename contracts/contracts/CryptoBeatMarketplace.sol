// SPDX-License-Identifier: MIT

pragma solidity 0.8.16;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./CryptoBeatERC721.sol";

struct CryptoBeat {
    address seller;
    uint256 price;
}

contract CryptoBeatMarketplace {
    IERC20 public _erc20;
    CryptoBeatERC721 public _cryptoBeatERC721;
    uint256 public _fee; // % fee
    mapping(uint256 => CryptoBeat) public _cryptoBeats; // uint256 - cryptoBeatId

    event Sell(address seller, uint256 cryptoBeatId, uint256 cryptoBeatPrice);
    event Buy(address seller, address buyer, uint256 cryptoBeatId, uint256 cryptoBeatPrice, uint256 fee);

    constructor(IERC20 erc20, CryptoBeatERC721 cryptoBeatERC721, uint256 fee) {
        require(fee <= 100, "BeatsMarketplace: fee > 100");
        _erc20 = erc20;
        _cryptoBeatERC721 = cryptoBeatERC721;
        _fee = fee;
    }

    function sell(uint256 cryptoBeatId, uint256 cryptoBeatPrice) external {
        _cryptoBeatERC721.transferFrom(msg.sender, address(this), cryptoBeatId);

        _cryptoBeats[cryptoBeatId] = CryptoBeat(msg.sender, cryptoBeatPrice);

        emit Sell(msg.sender, cryptoBeatId, cryptoBeatPrice);
    }

    function buy(uint256 cryptoBeatId) external {
        uint256 fee = calculateFeeById(cryptoBeatId);

        _erc20.transferFrom(msg.sender, address(this), fee);
        _erc20.transferFrom(msg.sender, _cryptoBeats[cryptoBeatId].seller, _cryptoBeats[cryptoBeatId].price - fee);

        _cryptoBeatERC721.transferFrom(address(this), msg.sender, cryptoBeatId);

        emit Buy(_cryptoBeats[cryptoBeatId].seller, msg.sender, cryptoBeatId, _cryptoBeats[cryptoBeatId].price, fee);
    }

    function calculateFee(uint256 price) public view returns(uint256) {
        return price * _fee / 100;
    }

    function calculateFeeById(uint256 cryptoBeatId) public view returns(uint256) {
        return calculateFee(_cryptoBeats[cryptoBeatId].price);
    }
}