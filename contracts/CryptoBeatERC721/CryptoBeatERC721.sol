// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
import "../CryptoBeatGovernance/presets/CryptoBeatGovernanceInjected.sol";
import "../CryptoBeatMembers/presets/CryptoBeatMembersInjected.sol";
import "../CryptoBeatLicensing/presets/CryptoBeatLicensingInjected.sol";
import "./structs/CryptoBeatTokenInfo.sol";

contract CryptoBeatERC721 is ERC721Upgradeable, CryptoBeatGovernanceInjected, CryptoBeatMembersInjected, CryptoBeatLicensingInjected {
    uint256 private _amountOfCryptoBeatTokens;

    mapping(uint256 => CryptoBeatTokenInfo) private _cryptoBeatTokens;

    uint256[50] private __gap;

    function initialize(CryptoBeatGovernance cryptoBeatGovernance, CryptoBeatMembers cryptoBeatMembers, CryptoBeatLicensing cryptoBeatLicensing) external initializer {
        __ERC721_init("CryptoBeat", "CB");
        __CryptoBeatGovernanceInjected_init(cryptoBeatGovernance);
        __CryptoBeatMembersInjected_init(cryptoBeatMembers);
        __CryptoBeatLicensingInjected_init(cryptoBeatLicensing);
    }

    
}
