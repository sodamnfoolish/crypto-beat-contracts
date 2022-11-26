// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "../CryptoBeatGovernance.sol";

contract CryptoBeatGovernanceAccess is Initializable {
    CryptoBeatGovernance public _cryptoBeatGovernance;

    function __CryptoBeatGovernanceAccess_init(CryptoBeatGovernance cryptoBeatGovernance) internal onlyInitializing {
        _cryptoBeatGovernance = cryptoBeatGovernance;
    }

    modifier onlyAdmin() {
        require(_cryptoBeatGovernance.hasRole(msg.sender, CryptoBeatGovernanceRoles.ADMIN_ROLE), "CryptoBeatGovernable: only admin");
        _;
    }
}
