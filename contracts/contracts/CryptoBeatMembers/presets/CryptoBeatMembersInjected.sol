// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "../CryptoBeatMembers.sol";

contract CryptoBeatMembersInjected is Initializable {
    CryptoBeatMembers _cryptoBeatMembers;

    uint256[50] private __gap;

    function __CryptoBeatMembersInjected_init(CryptoBeatMembers cryptoBeatMembers) internal onlyInitializing {
        _cryptoBeatMembers = cryptoBeatMembers;
    }

    modifier notBanned() {
        require(!_cryptoBeatMembers.isBanned(msg.sender), "CryptoBeatMembersInjected: banned");
        _;
    }

    modifier onlyCryptoBeatmaker() {
        require(_cryptoBeatMembers.getCryptoBeatmakerInfo(msg.sender).joined, "CryptoBeatMembersInjected: only CryptoBeatmaker");
        _;
    }

    modifier onlyCryptoArtist() {
        require(_cryptoBeatMembers.getCryptoArtistInfo(msg.sender).joined, "CryptoBeatMembersInjected: only CryptoArtist");
        _;
    }
}
