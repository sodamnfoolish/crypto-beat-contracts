// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../CryptoBeatGovernance/presets/CryptoBeatGovernanceInjected.sol";
import "./structs/CryptoBeatLicenseInfo.sol";
import "./libraries/CryptoBeatLicenseId.sol";
import "./libraries/CryptoBeatLicenses.sol";

contract CryptoBeatLicensing is CryptoBeatGovernanceInjected {
    mapping(bytes32 => CryptoBeatLicenseInfo) private _cryptoBeatLicenses;

    uint256[50] private __gap;

    event AddCryptoBeatLicense(address admin, bytes32 cryptoBeatLicenseId, CryptoBeatLicenseInfo cryptoBeatLicenseInfo);
    event RemoveCryptoBeatLicense(address admin, bytes32 cryptoBeatLicenseId);

    function initialize(CryptoBeatGovernance cryptoBeatGovernance) external initializer {
        __CryptoBeatGovernanceInjected_init(cryptoBeatGovernance);
    }

    function getCryptoBeatLicenseInfo(bytes32 cryptoBeatLicenseId) external view returns(CryptoBeatLicenseInfo memory) {
        return _cryptoBeatLicenses[cryptoBeatLicenseId];
    }

    function addCryptoBeatLicense(CryptoBeatLicenseInfo memory cryptoBeatLicense) external onlyAdmin {
        require(bytes(cryptoBeatLicense.name).length > 0, "CryptoBeatLicenses: CryptoBeatLicense name should be not empty");

        bytes32 cryptoBeatLicenseId = CryptoBeatLicenseId.ComputeId(cryptoBeatLicense);

        _cryptoBeatLicenses[cryptoBeatLicenseId] = cryptoBeatLicense;

        emit AddCryptoBeatLicense(msg.sender, cryptoBeatLicenseId, cryptoBeatLicense);
    }

    function removeCryptoBeatLicense(bytes32 cryptoBeatLicenseId) external onlyAdmin {
        _cryptoBeatLicenses[cryptoBeatLicenseId] = _cryptoBeatLicenses[CryptoBeatLicenses.ZERO_LICENSE_ID];

        emit RemoveCryptoBeatLicense(msg.sender, cryptoBeatLicenseId);
    }
}
