// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol";
import "../CryptoBeatGovernance/presets/CryptoBeatGovernanceInjected.sol";
import "./structs/CryptoBeatMemberInfo.sol";

contract CryptoBeatMembers is CryptoBeatGovernanceInjected {
    using AddressUpgradeable for address;

    mapping(address => CryptoBeatMemberInfo) private _cryptoBeatMemberInfos;

    uint256[50] private __gap;

    event Join(address cryptoBeatMember);
    event Verify(address cryptoBeatAdmin, address cryptoBeatMember);
    event Ban(address cryptoBeatAdmin, address cryptoBeatMember);

    function initialize(
        CryptoBeatGovernance cryptoBeatGovernance
    ) external initializer {
        __CryptoBeatGovernanceInjected_init(cryptoBeatGovernance);
    }

    function getCryptoBeatMemberInfo(
        address cryptoBeatMember
    ) external view returns (CryptoBeatMemberInfo memory) {
        return _cryptoBeatMemberInfos[cryptoBeatMember];
    }

    function join() external {
        require(
            !msg.sender.isContract(),
            "CryptoBeatMembers: contracts not allowed"
        );
        require(
            !_cryptoBeatMemberInfos[msg.sender].joined,
            "CryptoBeatMembers: already joined"
        );
        require(
            !_cryptoBeatMemberInfos[msg.sender].banned,
            "CryptoBeatMembers: banned"
        );

        _cryptoBeatMemberInfos[msg.sender].joined = true;

        emit Join(msg.sender);
    }

    function verify(address cryptoBeatMember) external onlyCryptoBeatAdmin {
        require(
            !_cryptoBeatMemberInfos[cryptoBeatMember].banned,
            "CryptoBeatMembers: CryptoBeatMember banned"
        );

        _cryptoBeatMemberInfos[cryptoBeatMember].verified = true;

        emit Verify(msg.sender, cryptoBeatMember);
    }

    function ban(address cryptoBeatMember) external onlyCryptoBeatAdmin {
        require(
            !_cryptoBeatMemberInfos[cryptoBeatMember].banned,
            "CryptoBeatMembers: already banned"
        );

        _cryptoBeatMemberInfos[cryptoBeatMember].banned = true;

        emit Ban(msg.sender, cryptoBeatMember);
    }
}
