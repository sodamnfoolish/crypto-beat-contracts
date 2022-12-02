// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "../CryptoBeatMembers.sol";

contract CryptoBeatMembersInjected is Initializable {
    CryptoBeatMembers public _cryptoBeatMembers;

    uint256[50] private __gap;

    function __CryptoBeatMembersInjected_init(
        CryptoBeatMembers cryptoBeatMembers
    ) internal onlyInitializing {
        __CryptoBeatMembersInjected_init_unchained(cryptoBeatMembers);
    }

    function __CryptoBeatMembersInjected_init_unchained(
        CryptoBeatMembers cryptoBeatMembers
    ) internal onlyInitializing {
        _cryptoBeatMembers = cryptoBeatMembers;
    }

    modifier onlyCryptoBeatMemberNotBanned() {
        CryptoBeatMemberInfo memory cryptoBeatMemberInfo = _cryptoBeatMembers
            .getCryptoBeatMemberInfo(msg.sender);

        require(
            cryptoBeatMemberInfo.joined,
            "CryptoBeatMembersInjected: only CryptoBeatMember"
        );
        
        require(
            !cryptoBeatMemberInfo.banned,
            "CryptoBeatMembersInjected: banned"
        );
        _;
    }
}
