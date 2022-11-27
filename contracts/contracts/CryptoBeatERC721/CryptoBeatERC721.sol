// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
import "../CryptoBeatGovernance/presets/CryptoBeatGovernanceInjected.sol";
import "../CryptoBeatMembers/presets/CryptoBeatMembersInjected.sol";
import "../CryptoBeatLicenses/presets/CryptoBeatLicensesInjected.sol";
import "./structs/CryptoBeatInfo.sol";

contract CryptoBeatERC721 is ERC721Upgradeable, CryptoBeatGovernanceInjected, CryptoBeatMembersInjected, CryptoBeatLicensesInjected {
    uint256 private _amountOfTokens;

    mapping(uint256 => CryptoBeatInfo) private _cryptoBeats;

    uint256[50] private __gap;

    event MintNewCryptoBeat(address owner, uint256 cryptoBeatId, CryptoBeatInfo cryptoBeatInfo);
    event MintExistCryptoBeatWithAnotherLicense(address cryptoBeatMarketplace, address to, uint256 cryptoBeatId, CryptoBeatInfo cryptoBeatInfo);
    event BurnMyCryptoBeat(address owner, uint256 cryptoBeatId);
    event BurnCryptoBeat(address admin, uint256 cryptoBeatId);

    function initialize(CryptoBeatGovernance cryptoBeatGovernance, CryptoBeatMembers cryptoBeatMembers, CryptoBeatLicenses cryptoBeatLicenses) external initializer {
        __ERC721_init("CryptoBeat", "CB");
        __CryptoBeatGovernanceInjected_init(cryptoBeatGovernance);
        __CryptoBeatMembersInjected_init(cryptoBeatMembers);
        __CryptoBeatLicensesInjected_init(cryptoBeatLicenses);
    }

    function mintNewCryptoBeat(string memory name, string memory mp3Url, string memory wavUrl, string memory trackStemsUrl) external onlyCryptoBeatmaker notBanned {
        require(bytes(name).length > 0, "CryptoBeatERC721: name is empty");
        require(bytes(mp3Url).length > 0, "CryptoBeatERC721: mp3Url is empty");

        uint256 cryptoBeatId = ++_amountOfTokens;

        _mint(msg.sender, cryptoBeatId);

        bytes32 defaultExclusiveLicenseId = CryptoBeatLicenseInfoLibrary.ComputeId(_cryptoBeatLicenses.getDefaultExclusiveLicenseInfo());

        _cryptoBeats[cryptoBeatId] = CryptoBeatInfo(name, mp3Url, wavUrl, trackStemsUrl, defaultExclusiveLicenseId);

        emit MintNewCryptoBeat(msg.sender, cryptoBeatId, _cryptoBeats[cryptoBeatId]);
    }

    function mintExistCryptoBeatWithAnotherLicense(address to, uint256 cryptoBeatId, bytes32 cryptoBeatLicenseId) external onlyCryptoBeatMarketplace {
        require(_isCryptoBeatLicenseExist(cryptoBeatLicenseId), "CryptoBeatERC721: license does not exist");
        require(_ownerOf(cryptoBeatId) != address(0), "CryptoBeatERC721: owner is address zero");

        CryptoBeatInfo memory cryptoBeatInfo = _cryptoBeats[cryptoBeatId];
        CryptoBeatLicenseInfo memory cryptoBeatLicenseInfo = _cryptoBeatLicenses.getCryptoBeatLicenseInfo(cryptoBeatLicenseId);

        uint256 newCryptoBeatId = ++_amountOfTokens;
        CryptoBeatInfo memory newCryptoBeatInfo = CryptoBeatInfo(cryptoBeatInfo.name, "", "", "", cryptoBeatLicenseId);

        if (cryptoBeatLicenseInfo.mp3) {
            require(bytes(cryptoBeatInfo.mp3Url).length > 0, "CryptoBeatERC721: mp3Url is empty");
            newCryptoBeatInfo.mp3Url = cryptoBeatInfo.mp3Url;
        }

        if (cryptoBeatLicenseInfo.wav) {
            require(bytes(cryptoBeatInfo.wavUrl).length > 0, "CryptoBeatERC721: wavUrl is empty");
            newCryptoBeatInfo.wavUrl = cryptoBeatInfo.wavUrl;
        }

        if (cryptoBeatLicenseInfo.trackStems) {
            require(bytes(cryptoBeatInfo.trackStemsUrl).length > 0, "CryptoBeatERC721: trackStemsUrl is empty");
            newCryptoBeatInfo.trackStemsUrl = cryptoBeatInfo.trackStemsUrl;
        }

        _mint(to, newCryptoBeatId);

        _cryptoBeats[newCryptoBeatId] = newCryptoBeatInfo;

        emit MintExistCryptoBeatWithAnotherLicense(msg.sender, to, newCryptoBeatId, newCryptoBeatInfo);
    }

    function burnMyCryptoBeat(uint256 cryptoBeatId) external notBanned {
        require(_ownerOf(cryptoBeatId) == msg.sender, "CryptoBeatERC721: owner is not sender");

        _burn(cryptoBeatId);

        emit BurnMyCryptoBeat(msg.sender, cryptoBeatId);
    }

    function burnCryptoBeat(uint256 cryptoBeatId) external onlyAdmin {
        require(_ownerOf(cryptoBeatId) != address(0), "CryptoBeatERC721: owner is address zero");

        _burn(cryptoBeatId);

        emit BurnCryptoBeat(msg.sender, cryptoBeatId);
    }
}
