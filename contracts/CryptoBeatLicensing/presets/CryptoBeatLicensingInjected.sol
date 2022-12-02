// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "../CryptoBeatLicensing.sol";

contract CryptoBeatLicensingInjected is Initializable {
    CryptoBeatLicensing public _cryptoBeatLicensing;

    uint256[50] private __gap;

    function __CryptoBeatLicensingInjected_init(
        CryptoBeatLicensing cryptoBeatLicensing
    ) internal onlyInitializing {
        __CryptoBeatLicensingInjected_init_unchained(cryptoBeatLicensing);
    }

    function __CryptoBeatLicensingInjected_init_unchained(
        CryptoBeatLicensing cryptoBeatLicensing
    ) internal onlyInitializing {
        _cryptoBeatLicensing = cryptoBeatLicensing;
    }
}
