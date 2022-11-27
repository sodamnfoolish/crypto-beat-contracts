// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "../CryptoBeatLicenses.sol";

contract CryptoBeatLicensesInjected is Initializable {
    CryptoBeatLicenses _cryptoBeatLicenses;

    function __CryptoBeatLicensesInjected_init(CryptoBeatLicenses cryptoBeatLicenses) internal onlyInitializing {
        _cryptoBeatLicenses = cryptoBeatLicenses;
    }

    function _isCryptoBeatLicenseExist(bytes32 cryptoBeatLicenseId) internal view returns(bool) {
        return bytes(_cryptoBeatLicenses.getCryptoBeatLicenseInfo(cryptoBeatLicenseId).name).length > 0;
    }
}
