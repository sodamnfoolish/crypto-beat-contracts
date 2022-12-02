// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol";
import "../CryptoBeatGovernance/presets/CryptoBeatGovernanceInjected.sol";
import "./structs/CryptoBeatMemberInfo.sol";

contract CryptoBeatMembers is CryptoBeatGovernanceInjected {
    using AddressUpgradeable for address;

    mapping(address => CryptoBeatMemberInfo) private _cryptoBeatMembers;

    uint256[50] private __gap;

    event Join(address who);
    event Verify(address admin, address who);
    event Ban(address admin, address who);

    function initialize(CryptoBeatGovernance cryptoBeatGovernance) external initializer {
        __CryptoBeatGovernanceInjected_init(cryptoBeatGovernance);
    }

    function getCryptoBeatMemberInfo(address who) external view returns (CryptoBeatMemberInfo memory) {
        return _cryptoBeatMembers[who];
    }

    function join() external {
        require(!msg.sender.isContract(), "CryptoBeatMembers: contracts not allowed");
        require(!_cryptoBeatMembers[msg.sender].joined, "CryptoBeatMembers: already joined");
        require(!_cryptoBeatMembers[msg.sender].banned, "CryptoBeatMembers: banned");

        _cryptoBeatMembers[msg.sender].joined = true;

        emit Join(msg.sender);
    }

    function verify(address who) external onlyAdmin {
        require(!_cryptoBeatMembers[who].banned, "CryptoBeatMembers: banned");

        _cryptoBeatMembers[who].verified = true;

        emit Verify(msg.sender, who);
    }

    function ban(address who) external onlyAdmin {
        require(!_cryptoBeatMembers[who].banned, "CryptoBeatMembers: already banned");

        _cryptoBeatMembers[who].banned = true;

        emit Ban(msg.sender, who);
    }
}
