// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "../CryptoBeatMembers.sol";

contract CryptoBeatMembersAccess is Initializable {
    CryptoBeatMembers _cryptoBeatMembers;

    function __CryptoBeatMembersAccess_init(CryptoBeatMembers cryptoBeatMembers) internal onlyInitializing {
        _cryptoBeatMembers = cryptoBeatMembers;
    }

    modifier onlyCryptoBeatmaker() {
        require(_cryptoBeatMembers.cryptoBeatmakerInfoOf(msg.sender).joined, "CryptoBeatMembersAccess: only CryptoBeatmaker");
        _;
    }

    modifier onlyCryptoArtist() {
        require(_cryptoBeatMembers.cryptoArtistInfoOf(msg.sender).joined, "CryptoBeatMembersAccess: only CryptoArtist");
        _;
    }
}
