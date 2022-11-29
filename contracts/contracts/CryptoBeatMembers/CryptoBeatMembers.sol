// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol";
import "../CryptoBeatGovernance/presets/CryptoBeatGovernanceInjected.sol";
import "./structs/CryptoBeatBeatmakerInfo.sol";
import "./structs/CryptoBeatArtistInfo.sol";

contract CryptoBeatMembers is CryptoBeatGovernanceInjected {
    using AddressUpgradeable for address;

    mapping(address => bool) private _banned;
    mapping(address => CryptoBeatBeatmakerInfo) private _cryptoBeatBeatmakers;
    mapping(address => CryptoBeatArtistInfo) private _cryptoBeatArtists;

    uint256[50] private __gap;

    event JoinAsCryptoBeatBeatmaker(address cryptoBeatBeatmaker);
    event JoinAsCryptoBeatArtist(address cryptoBeatArtist);
    event VerifyCryptoBeatBeatmaker(address admin, address cryptoBeatBeatmaker);
    event VerifyCryptoBeatArtist(address admin, address cryptoBeatArtist);
    event Ban(address admin, address who);

    function initialize(CryptoBeatGovernance cryptoBeatGovernance) external initializer {
        __CryptoBeatGovernanceInjected_init(cryptoBeatGovernance);
    }

    function getCryptoBeatBeatmakerInfo(address who) external view returns (CryptoBeatBeatmakerInfo memory) {
        return _cryptoBeatBeatmakers[who];
    }

    function getCryptoBeatArtistInfo(address who) external view returns (CryptoBeatArtistInfo memory) {
        return _cryptoBeatArtists[who];
    }

    function isBanned(address who) external view returns(bool) {
        return _banned[who];
    }

    function joinAsCryptoBeatBeatmaker() external onlyNotContracts {
        require(!_cryptoBeatBeatmakers[msg.sender].joined, "CryptoBeatMembers: CryptoBeatBeatmaker already joined");

        _cryptoBeatBeatmakers[msg.sender].joined = true;

        emit JoinAsCryptoBeatBeatmaker(msg.sender);
    }

    function joinAsCryptoBeatArtist() external onlyNotContracts {
        require(!_cryptoBeatArtists[msg.sender].joined, "CryptoBeatMembers: CryptoBeatArtist already joined");

        _cryptoBeatArtists[msg.sender].joined = true;

        emit JoinAsCryptoBeatArtist(msg.sender);
    }

    function verifyCryptoBeatBeatmaker(address cryptoBeatBeatmaker) external onlyAdmin {
        require(_cryptoBeatBeatmakers[cryptoBeatBeatmaker].joined, "CryptoBeatMembers: CryptoBeatBeatmaker not joined");

        _cryptoBeatBeatmakers[cryptoBeatBeatmaker].verified = true;

        emit VerifyCryptoBeatBeatmaker(msg.sender, cryptoBeatBeatmaker);
    }

    function verifyCryptoBeatArtist(address cryptoBeatArtist) external onlyAdmin {
        require(_cryptoBeatArtists[cryptoBeatArtist].joined, "CryptoBeatMembers: CryptoBeatArtist not joined");

        _cryptoBeatArtists[cryptoBeatArtist].verified = true;

        emit VerifyCryptoBeatArtist(msg.sender, cryptoBeatArtist);
    }

    function ban(address who) external onlyAdmin {
        _banned[who] = true;

        emit Ban(msg.sender, who);
    }

    modifier onlyNotContracts() {
        require(!msg.sender.isContract(), "CryptoBeatMembers: contracts not allowed");
        _;
    }
}
