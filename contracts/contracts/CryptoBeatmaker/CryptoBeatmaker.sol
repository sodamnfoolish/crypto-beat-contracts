// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./structs/CryptoBeatmakerInfo.sol";
import "../CryptoBeatGovernance/extensions/CryptoBeatGovernanceAccess.sol";
import "@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol";

contract CryptoBeatmaker is CryptoBeatGovernanceAccess {
    using AddressUpgradeable for address;

    mapping(address => CryptoBeatmakerInfo) public _cryptoBeatmakers;

    event Join(address who);
    event Verify(address verifier, address who);

    function initialize(CryptoBeatGovernance cryptoBeatGovernance) external initializer {
        __CryptoBeatGovernanceAccess_init(cryptoBeatGovernance);
    }

    function join() external {
        require(!msg.sender.isContract(), "CryptoBeatmakers: contracts not allowed");

        _cryptoBeatmakers[msg.sender].joined = true;

        emit Join(msg.sender);
    }

    function verify(address who) external onlyAdmin {
        require(_cryptoBeatmakers[who].joined, "CryptoBeatmakers: CryptoBeatmaker not joined");

        _cryptoBeatmakers[who].verified = true;

        emit Verify(msg.sender, who);
    }
}
