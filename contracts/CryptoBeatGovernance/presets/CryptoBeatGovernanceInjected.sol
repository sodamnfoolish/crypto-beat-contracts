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

    function __CryptoBeatGovernanceInjected_init_unchained(
        CryptoBeatGovernance cryptoBeatGovernance
    ) internal onlyInitializing {
        _cryptoBeatGovernance = cryptoBeatGovernance;
    }

    modifier onlyCryptoBeatAdmin() {
        require(
            _cryptoBeatGovernance.hasRole(msg.sender, CryptoBeatGovernanceRoles.CRYPTO_BEAT_ADMIN_ROLE),
            "CryptoBeatGovernanceInjected: only CryptoBeatAdmin"
        );
        _;
    }

    modifier onlyCryptoBeatMarketplace() {
        require(
            _cryptoBeatGovernance.hasRole(msg.sender, CryptoBeatGovernanceRoles.CRYPTO_BEAT_MARKETPLACE_ROLE),
            "CryptoBeatGovernanceInjected: only CryptoBeatMarketplace"
        );
        _;
    }
}
