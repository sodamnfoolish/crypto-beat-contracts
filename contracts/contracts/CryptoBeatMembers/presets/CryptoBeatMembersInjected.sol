// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "../CryptoBeatMembers.sol";

contract CryptoBeatMembersInjected is Initializable {
    CryptoBeatMembers public _cryptoBeatMembers;

    uint256[50] private __gap;

    function __CryptoBeatMembersInjected_init(CryptoBeatMembers cryptoBeatMembers) internal onlyInitializing {
        __CryptoBeatMembersInjected_init_unchained(cryptoBeatMembers);
    }

    function __CryptoBeatMembersInjected_init_unchained(CryptoBeatMembers cryptoBeatMembers) internal onlyInitializing {
        _cryptoBeatMembers = cryptoBeatMembers;
    }

    modifier notBanned() {
        require(!_cryptoBeatMembers.isBanned(msg.sender), "CryptoBeatMembersInjected: banned");
        _;
    }

    modifier onlyCryptoBeatBeatmaker() {
        require(_cryptoBeatMembers.getCryptoBeatBeatmakerInfo(msg.sender).joined, "CryptoBeatMembersInjected: only CryptoBeatBeatmaker");
        _;
    }

    modifier onlyCryptoBeatArtist() {
        require(_cryptoBeatMembers.getCryptoBeatArtistInfo(msg.sender).joined, "CryptoBeatMembersInjected: only CryptoBeatArtist");
        _;
    }
}
