// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../CryptoBeatGovernance/presets/CryptoBeatGovernanceInjected.sol";
import "../CryptoBeatMembers/presets/CryptoBeatMembersInjected.sol";
import "../CryptoBeatLicensing/presets/CryptoBeatLicensingInjected.sol";
import "../CryptoBeatERC721/presets/CryptoBeatERC721Injected.sol";
import "./structs/CryptoBeatTokenOnMarketplaceInfo.sol";

contract CryptoBeatMarketplace is
    CryptoBeatGovernanceInjected,
    CryptoBeatMembersInjected,
    CryptoBeatLicensingInjected,
    CryptoBeatERC721Injected
{
    mapping(uint256 => CryptoBeatTokenOnMarketplaceInfo) _cryptoBeatTokenOnMarketplaceInfos;

    uint256[50] private __gap;

    event AddCryptoBeat(address cryptoBeatMember, uint256 cryptoBeatTokenId);

    function initialize(
        CryptoBeatGovernance cryptoBeatGovernance,
        CryptoBeatMembers cryptoBeatMembers,
        CryptoBeatLicensing cryptoBeatLicensing,
        CryptoBeatERC721 cryptoBeatERC721
    ) external initializer {
        __CryptoBeatGovernanceInjected_init(cryptoBeatGovernance);
        __CryptoBeatMembersInjected_init(cryptoBeatMembers);
        __CryptoBeatLicensingInjected_init(cryptoBeatLicensing);
        __CryptoBeatERC721Injected_init(cryptoBeatERC721);
    }

    function addCryptoBeat(
        uint256 cryptoBeatTokenId
    )
        external
        onlyCryptoBeatMemberNotBanned
        onlyCryptoBeatTokenOwner(cryptoBeatTokenId)
        onlyExclusiveLicenseCryptoBeatToken(cryptoBeatTokenId)
        onlyApprovedCryptoBeatToken(cryptoBeatTokenId)
    {
        _cryptoBeatERC721.transferFrom(msg.sender, address(this), cryptoBeatTokenId);

        _cryptoBeatTokenOnMarketplaceInfos[cryptoBeatTokenId].isOn = true;
        _cryptoBeatTokenOnMarketplaceInfos[cryptoBeatTokenId].owner = msg.sender;

        emit AddCryptoBeat(msg.sender, cryptoBeatTokenId);
    }
}
