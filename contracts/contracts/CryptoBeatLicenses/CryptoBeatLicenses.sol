// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../CryptoBeatGovernance/presets/CryptoBeatGovernanceInjected.sol";
import "../CryptoBeatMembers/presets/CryptoBeatMembersInjected.sol";
import "./structs/CryptoBeatLicenseInfo.sol";
import "./libraries/CryptoBeatLicenseInfoLibrary.sol";

contract CryptoBeatLicenses is CryptoBeatGovernanceInjected, CryptoBeatMembersInjected {
    CryptoBeatLicenseInfo public ZERO_LICENSE = CryptoBeatLicenseInfo("", false, false, false);
    CryptoBeatLicenseInfo public DEFAULT_BASIC_LICENSE = CryptoBeatLicenseInfo("Basic", true, false, false);
    CryptoBeatLicenseInfo public DEFAULT_PREMIUM_LICENSE = CryptoBeatLicenseInfo("Premium", true, true, false);
    CryptoBeatLicenseInfo public DEFAULT_UNLIMITED_LICENSE = CryptoBeatLicenseInfo("Unlimited", true, true, true);
    CryptoBeatLicenseInfo public DEFAULT_EXCLUSIVE_LICENSE = CryptoBeatLicenseInfo("Exclusive", true, true, true);

    mapping(bytes32 => CryptoBeatLicenseInfo) private _cryptoBeatLicenses;

    uint256[50] private __gap;

    event AddCryptoBeatLicense(address admin, bytes32 cryptoBeatLicenseId, CryptoBeatLicenseInfo cryptoBeatLicense);
    event RemoveCryptoBeatLicense(address admin, bytes32 cryptoBeatLicenseId);

    function initialize(CryptoBeatGovernance cryptoBeatGovernance, CryptoBeatMembers cryptoBeatMembers) external initializer {
        __CryptoBeatGovernanceInjected_init(cryptoBeatGovernance);
        __CryptoBeatMembersInjected_init(cryptoBeatMembers);

        _cryptoBeatLicenses[CryptoBeatLicenseInfoLibrary.ComputeId(DEFAULT_BASIC_LICENSE)] = DEFAULT_BASIC_LICENSE;
        _cryptoBeatLicenses[CryptoBeatLicenseInfoLibrary.ComputeId(DEFAULT_PREMIUM_LICENSE)] = DEFAULT_PREMIUM_LICENSE;
        _cryptoBeatLicenses[CryptoBeatLicenseInfoLibrary.ComputeId(DEFAULT_UNLIMITED_LICENSE)] = DEFAULT_UNLIMITED_LICENSE;
        _cryptoBeatLicenses[CryptoBeatLicenseInfoLibrary.ComputeId(DEFAULT_EXCLUSIVE_LICENSE)] = DEFAULT_EXCLUSIVE_LICENSE;
    }

    function addCryptoBeatLicense(CryptoBeatLicenseInfo memory cryptoBeatLicense) external onlyAdmin {
        require(bytes(cryptoBeatLicense.name).length > 0, "CryptoBeatLicenses: CryptoBeatLicense name should be not empty");

        bytes32 cryptoBeatLicenseId = CryptoBeatLicenseInfoLibrary.ComputeId(cryptoBeatLicense);

        _cryptoBeatLicenses[cryptoBeatLicenseId] = cryptoBeatLicense;

        emit AddCryptoBeatLicense(msg.sender, cryptoBeatLicenseId, cryptoBeatLicense);
    }

    function removeCryptoBeatLicense(bytes32 cryptoBeatLicenseId) external onlyAdmin {
        _cryptoBeatLicenses[cryptoBeatLicenseId] = ZERO_LICENSE;

        emit RemoveCryptoBeatLicense(msg.sender, cryptoBeatLicenseId);
    }

    function getCryptoBeatLicenseInfo(bytes32 cryptoBeatLicenseId) external view returns(CryptoBeatLicenseInfo memory) {
        return _cryptoBeatLicenses[cryptoBeatLicenseId];
    }
}
