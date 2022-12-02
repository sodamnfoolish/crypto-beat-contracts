// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../CryptoBeatGovernance/presets/CryptoBeatGovernanceInjected.sol";
import "./structs/CryptoBeatLicenseInfo.sol";
import "./libraries/CryptoBeatLicenses.sol";

contract CryptoBeatLicensing is CryptoBeatGovernanceInjected {
    mapping(bytes32 => CryptoBeatLicenseInfo) private _cryptoBeatLicenseInfos;

    uint256[50] private __gap;

    event AddCryptoBeatLicense(address cryptoBeatAdmin, bytes32 cryptoBeatLicenseId, CryptoBeatLicenseInfo cryptoBeatLicenseInfo);
    event RemoveCryptoBeatLicense(address cryptoBeatAdmin, bytes32 cryptoBeatLicenseId);

    function initialize(CryptoBeatGovernance cryptoBeatGovernance) external initializer {
        __CryptoBeatGovernanceInjected_init(cryptoBeatGovernance);
    }

    function getCryptoBeatLicenseInfo(bytes32 cryptoBeatLicenseId) external view returns(CryptoBeatLicenseInfo memory) {
        return _cryptoBeatLicenseInfos[cryptoBeatLicenseId];
    }

    function addCryptoBeatLicense(CryptoBeatLicenseInfo memory cryptoBeatLicenseInfo) external onlyCryptoBeatAdmin {
        require(bytes(cryptoBeatLicenseInfo.name).length > 0, "CryptoBeatLicenses: CryptoBeatLicenseInfo name should be not empty");

        bytes32 cryptoBeatLicenseId = CryptoBeatLicenses.ComputeId(cryptoBeatLicenseInfo);

        _cryptoBeatLicenseInfos[cryptoBeatLicenseId] = cryptoBeatLicenseInfo;

        emit AddCryptoBeatLicense(msg.sender, cryptoBeatLicenseId, cryptoBeatLicenseInfo);
    }

    function removeCryptoBeatLicense(bytes32 cryptoBeatLicenseId) external onlyCryptoBeatAdmin {
        _cryptoBeatLicenseInfos[cryptoBeatLicenseId] = _cryptoBeatLicenseInfos[CryptoBeatLicenses.ZERO_LICENSE_ID];

        emit RemoveCryptoBeatLicense(msg.sender, cryptoBeatLicenseId);
    }
}
