// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "../CryptoBeatGovernance.sol";

contract CryptoBeatGovernanceInjected is Initializable {
    CryptoBeatGovernance public _cryptoBeatGovernance;

    uint256[50] private __gap;

    function __CryptoBeatGovernanceInjected_init(CryptoBeatGovernance cryptoBeatGovernance) internal onlyInitializing {
        __CryptoBeatGovernanceInjected_init_unchained(cryptoBeatGovernance);
    }

    function __CryptoBeatGovernanceInjected_init_unchained(CryptoBeatGovernance cryptoBeatGovernance) internal onlyInitializing {
        _cryptoBeatGovernance = cryptoBeatGovernance;
    }

    modifier onlyAdmin() {
        require(_cryptoBeatGovernance.hasRole(msg.sender, _cryptoBeatGovernance.ADMIN_ROLE()), "CryptoBeatGovernanceInjected: only Admin");
        _;
    }

    modifier onlyCryptoBeatMarketplace() {
        require(_cryptoBeatGovernance.hasRole(msg.sender, _cryptoBeatGovernance.CRYPTO_BEAT_MARKETPLACE_ROLE()), "CryptoBeatGovernanceInjected: only CryptoBeatMarketplace");
        _;
    }
}
