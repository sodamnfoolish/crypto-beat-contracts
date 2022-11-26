// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "../CryptoBeatGovernance.sol";

contract CryptoBeatGovernanceInjected is Initializable {
    CryptoBeatGovernance public _cryptoBeatGovernance;

    uint256[50] private __gap;

    function __CryptoBeatGovernanceInjected_init(CryptoBeatGovernance cryptoBeatGovernance) internal onlyInitializing {
        _cryptoBeatGovernance = cryptoBeatGovernance;
    }

    modifier onlyAdmin() {
        require(_cryptoBeatGovernance.hasRole(msg.sender, CryptoBeatGovernanceRoles.ADMIN_ROLE), "CryptoBeatGovernanceInjected: only admin");
        _;
    }
}
