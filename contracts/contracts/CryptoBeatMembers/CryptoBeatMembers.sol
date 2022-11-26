// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol";
import "../CryptoBeatGovernance/extensions/CryptoBeatGovernanceAccess.sol";
import "./structs/CryptoBeatmakerInfo.sol";
import "./structs/CryptoArtistInfo.sol";

contract CryptoBeatMembers is CryptoBeatGovernanceAccess {
    using AddressUpgradeable for address;

    mapping(address => CryptoBeatmakerInfo) private _cryptoBeatmakers;
    mapping(address => CryptoArtistInfo) private _cryptoArtists;

    uint256[50] private __gap;

    event JoinAsCryptoBeatmaker(address who);
    event JoinAsCryptoArtist(address who);
    event VerifyCryptoBeatmaker(address verifier, address who);
    event VerifyCryptoArtist(address verifier, address who);

    function initialize(CryptoBeatGovernance cryptoBeatGovernance) external initializer {
        __CryptoBeatGovernanceAccess_init(cryptoBeatGovernance);
    }

    function joinAsCryptoBeatmaker() external {
        require(!msg.sender.isContract(), "CryptoBeatMembers: contracts not allowed");

        _cryptoBeatmakers[msg.sender].joined = true;

        emit JoinAsCryptoBeatmaker(msg.sender);
    }

    function joinAsCryptoArtist() external {
        require(!msg.sender.isContract(), "CryptoBeatMembers: contracts not allowed");

        _cryptoArtists[msg.sender].joined = true;

        emit JoinAsCryptoArtist(msg.sender);
    }

    function verifyCryptoBeatmaker(address who) external onlyAdmin {
        require(_cryptoBeatmakers[who].joined, "CryptoBeatMembers: CryptoBeatmaker not joined");

        _cryptoBeatmakers[who].verified = true;

        emit VerifyCryptoBeatmaker(msg.sender, who);
    }

    function verifyCryptoArtist(address who) external onlyAdmin {
        require(_cryptoArtists[who].joined, "CryptoBeatMembers: CryptoArtist not joined");

        _cryptoArtists[who].verified = true;

        emit VerifyCryptoArtist(msg.sender, who);
    }

    function cryptoBeatmakerInfoOf(address who) external view returns (CryptoBeatmakerInfo memory) {
        return _cryptoBeatmakers[who];
    }

    function cryptoArtistInfoOf(address who) external view returns (CryptoArtistInfo memory) {
        return _cryptoArtists[who];
    }
}
