// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol";
import "../CryptoBeatGovernance/presets/CryptoBeatGovernanceInjected.sol";
import "./structs/CryptoBeatmakerInfo.sol";
import "./structs/CryptoArtistInfo.sol";

contract CryptoBeatMembers is CryptoBeatGovernanceInjected {
    using AddressUpgradeable for address;

    mapping(address => bool) private _banned;
    mapping(address => CryptoBeatmakerInfo) private _cryptoBeatmakers;
    mapping(address => CryptoArtistInfo) private _cryptoArtists;

    uint256[50] private __gap;

    event JoinAsCryptoBeatmaker(address cryptoBeatmaker);
    event JoinAsCryptoArtist(address cryptoArtist);
    event VerifyCryptoBeatmaker(address admin, address cryptoBeatmaker);
    event VerifyCryptoArtist(address admin, address cryptoArtist);
    event Ban(address admin, address who);

    function initialize(CryptoBeatGovernance cryptoBeatGovernance) external initializer {
        __CryptoBeatGovernanceInjected_init(cryptoBeatGovernance);
    }

    function getCryptoBeatmakerInfo(address who) external view returns (CryptoBeatmakerInfo memory) {
        return _cryptoBeatmakers[who];
    }

    function getCryptoArtistInfo(address who) external view returns (CryptoArtistInfo memory) {
        return _cryptoArtists[who];
    }

    function isBanned(address who) external view returns(bool) {
        return _banned[who];
    }

    function joinAsCryptoBeatmaker() external {
        require(!msg.sender.isContract(), "CryptoBeatMembers: contracts not allowed");
        require(!_cryptoBeatmakers[msg.sender].joined, "CryptoBeatMembers: CryptoBeatmaker already joined");

        _cryptoBeatmakers[msg.sender].joined = true;

        emit JoinAsCryptoBeatmaker(msg.sender);
    }

    function joinAsCryptoArtist() external {
        require(!msg.sender.isContract(), "CryptoBeatMembers: contracts not allowed");
        require(!_cryptoArtists[msg.sender].joined, "CryptoBeatMembers: CryptoArtist already joined");

        _cryptoArtists[msg.sender].joined = true;

        emit JoinAsCryptoArtist(msg.sender);
    }

    function verifyCryptoBeatmaker(address cryptoBeatmaker) external onlyAdmin {
        require(_cryptoBeatmakers[cryptoBeatmaker].joined, "CryptoBeatMembers: CryptoBeatmaker not joined");

        _cryptoBeatmakers[cryptoBeatmaker].verified = true;

        emit VerifyCryptoBeatmaker(msg.sender, cryptoBeatmaker);
    }

    function verifyCryptoArtist(address cryptoArtist) external onlyAdmin {
        require(_cryptoArtists[cryptoArtist].joined, "CryptoBeatMembers: CryptoArtist not joined");

        _cryptoArtists[cryptoArtist].verified = true;

        emit VerifyCryptoArtist(msg.sender, cryptoArtist);
    }

    function ban(address who) external onlyAdmin {
        _banned[who] = true;

        emit Ban(msg.sender, who);
    }
}
