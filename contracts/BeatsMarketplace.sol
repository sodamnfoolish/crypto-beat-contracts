// SPDX-License-Identifier: MIT

pragma solidity 0.8.16;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

struct Beat {
    address publisher;
    uint256 price;
    bool onSold;
}

contract BeatsMarketplace is Initializable {
    IERC20 public _erc20;
    uint256 public _fee; // % fee
    mapping(bytes32 => Beat) public _beats; // bytes32 - beat id

    uint256[1000] private __gap; // gap for contract upgrade

    event Publish(address publisher, uint256 price);
    event Buy(address publisher, uint256 price, address buyer);

    function initialize(IERC20 erc20, uint256 fee) public initializer {
        require(fee <= 100, "BeatsMarketplace: fee > 100");
        _erc20 = erc20;
        _fee = fee;
    }

    function publish(bytes32 id, uint256 price) external {
        require(_beats[id].publisher == address(0), "BeatsMarketplace: duplicate ID");

        _beats[id] = Beat(msg.sender, price, true);

        emit Publish(msg.sender, price);
    }

    function buy(bytes32 id) external {
        require(_beats[id].publisher != address(0), "BeatsMarketplace: not published");
        require(_beats[id].onSold, "BeatsMarketplace: sold");
        require(_erc20.allowance(msg.sender, address(this)) >= _beats[id].price, "BeatsMarketplace: price > allowance");

        _beats[id].onSold = false;

        uint256 fee = calculateFeeById(id);

        _erc20.transferFrom(msg.sender, address(this), fee);
        _erc20.transferFrom(msg.sender, _beats[id].publisher, _beats[id].price - fee);

        emit Buy(_beats[id].publisher, _beats[id].price, msg.sender);
    }

    function calculateFee(uint256 price) public view returns(uint256) {
        return price * _fee / 100;
    }

    function calculateFeeById(bytes32 id) public view returns(uint256) {
        return calculateFee(_beats[id].price);
    }
}