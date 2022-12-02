// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../CryptoBeatGovernance/presets/CryptoBeatGovernanceInjected.sol";
import "./structs/CryptoBeatLicenseInfo.sol";
import "./libraries/CryptoBeatLicenseId.sol";

contract CryptoBeatLicensing is CryptoBeatGovernanceInjected {
    bytes32 public constant ZERO_LICENSE_ID = 0x9b76a4bf4986998f670e4288e1ca095948510235bd18bf1ce78dc183f8c80e7b;
    bytes32 public constant BASIC_LICENSE_ID = 0x0571230f591a2d7eebca8992af31002bd797e81a9d7adc67d6098b12e66606a2;
    bytes32 public constant PREMIUM_LICENSE_ID = 0x67099765bb3b97928ccaae184a8ccdce4c8ca76d5aaa1c2957183b9b6a8f06a3;
    bytes32 public constant UNLIMITED_LICENSE_ID = 0x5605f7162b0f18e1aac1c1c45a14fd57f40cd19c278711ced58f972532120248;
    bytes32 public constant EXCLUSIVE_LICENSE_ID = 0xae23893d9034cd49496b51d9208513d44d1bb9024c5a25acd578bff8b4c5810d;

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
        _cryptoBeatLicenses[cryptoBeatLicenseId] = _cryptoBeatLicenses[ZERO_LICENSE_ID];

        emit RemoveCryptoBeatLicense(msg.sender, cryptoBeatLicenseId);
    }
}
