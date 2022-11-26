// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./libraries/CryptoBeatGovernanceRoles.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract CryptoBeatGovernance is Initializable {
    mapping(address => mapping(bytes32 => bool)) public _hasRole;

    uint256[50] private __gap;

    function initialize() external initializer {
        _hasRole[msg.sender][CryptoBeatGovernanceRoles.ADMIN_ROLE] = true;
    }

    function setRole(address who, bytes32 role, bool hasRole) external onlyAdmin {
        _hasRole[who][role] = hasRole;
    }

    modifier onlyAdmin() {
        require(_hasRole[msg.sender][CryptoBeatGovernanceRoles.ADMIN_ROLE], "CryptoBeatGovernance: only admin");
        _;
    }
}
