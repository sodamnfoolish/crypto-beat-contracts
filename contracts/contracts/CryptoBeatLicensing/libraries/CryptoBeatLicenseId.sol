// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../structs/CryptoBeatLicenseInfo.sol";

library CryptoBeatLicenseId {
    function ComputeId(CryptoBeatLicenseInfo memory cryptoBeatLicense) external pure returns(bytes32) {
        return keccak256(abi.encode(cryptoBeatLicense));
    }
}
