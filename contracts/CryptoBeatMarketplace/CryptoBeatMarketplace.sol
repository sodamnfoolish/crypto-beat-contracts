// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../CryptoBeatGovernance/presets/CryptoBeatGovernanceInjected.sol";
import "../CryptoBeatMembers/presets/CryptoBeatMembersInjected.sol";
import "../CryptoBeatLicensing/presets/CryptoBeatLicensingInjected.sol";
import "../CryptoBeatERC721/presets/CryptoBeatERC721Injected.sol";

contract CryptoBeatMarketplace is CryptoBeatGovernanceInjected, CryptoBeatMembersInjected, CryptoBeatLicensingInjected, CryptoBeatERC721Injected {
    uint256[50] private __gap;

    function initialize(CryptoBeatGovernance cryptoBeatGovernance, CryptoBeatMembers cryptoBeatMembers, CryptoBeatLicensing cryptoBeatLicensing, CryptoBeatERC721 cryptoBeatERC721) external initializer {
        __CryptoBeatGovernanceInjected_init(cryptoBeatGovernance);
        __CryptoBeatMembersInjected_init(cryptoBeatMembers);
        __CryptoBeatLicensingInjected_init(cryptoBeatLicensing);
        __CryptoBeatERC721Injected_init(cryptoBeatERC721);
    }
}