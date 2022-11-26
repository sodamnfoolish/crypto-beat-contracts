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

    modifier onlyNotBannedCryptoBeatmaker() {
        require(_cryptoBeatMembers.getCryptoBeatmakerInfo(msg.sender).joined, "CryptoBeatMembersInjected: only CryptoBeatmaker");
        require(_cryptoBeatMembers.getCryptoBeatmakerInfo(msg.sender).banned, "CryptoBeatMembersInjected: CryptoBeatmaker banned");
        _;
    }

    modifier onlyNotBannedCryptoArtist() {
        require(_cryptoBeatMembers.getCryptoArtistInfo(msg.sender).joined, "CryptoBeatMembersInjected: only CryptoArtist");
        require(_cryptoBeatMembers.getCryptoArtistInfo(msg.sender).banned, "CryptoBeatMembersInjected: CryptoArtist banned");
        _;
    }
}
