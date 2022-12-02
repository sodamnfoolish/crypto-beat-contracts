// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "./libraries/CryptoBeatGovernanceRoles.sol";

contract CryptoBeatGovernance is Initializable {
    mapping(address => mapping(bytes32 => bool)) private _hasRole;

    uint256[50] private __gap;

    event SetRole(address cryptoBeatAdmin, address who, bytes32 role, bool has);

    function initialize() external initializer {
        _setRole(
            msg.sender,
            CryptoBeatGovernanceRoles.CRYPTO_BEAT_ADMIN_ROLE,
            true
        );
    }

    function hasRole(address who, bytes32 role) external view returns (bool) {
        return _hasRole[who][role];
    }

    function setRole(address who, bytes32 role, bool has) external {
        require(
            _hasRole[msg.sender][
                CryptoBeatGovernanceRoles.CRYPTO_BEAT_ADMIN_ROLE
            ],
            "CryptoBeatGovernance: only CryptoBeatAdmin"
        );
        _setRole(who, role, has);
    }

    function _setRole(address who, bytes32 role, bool has) private {
        _hasRole[who][role] = has;

        emit SetRole(msg.sender, who, role, has);
    }
}
