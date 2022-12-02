// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract CryptoBeatGovernance is Initializable {
    bytes32 public constant ADMIN_ROLE = keccak256("Admin");
    bytes32 public constant CRYPTO_BEAT_MARKETPLACE_ROLE = keccak256("CryptoBeatMarketplace");

    mapping(address => mapping(bytes32 => bool)) private _hasRole;

    uint256[50] private __gap;

    event SetRole(address admin, address who, bytes32 role, bool has);

    function initialize() external initializer {
       _setRole(msg.sender, ADMIN_ROLE, true);
    }

    function hasRole(address who, bytes32 role) external view returns(bool) {
        return _hasRole[who][role];
    }

    function setRole(address who, bytes32 role, bool has) external onlyAdmin {
        _setRole(who, role, has);
    }

    function _setRole(address who, bytes32 role, bool has) private {
        _hasRole[who][role] = has;

        emit SetRole(msg.sender, who, role, has);
    }

    modifier onlyAdmin() {
        require(_hasRole[msg.sender][ADMIN_ROLE], "CryptoBeatGovernance: only Admin");
        _;
    }
}
