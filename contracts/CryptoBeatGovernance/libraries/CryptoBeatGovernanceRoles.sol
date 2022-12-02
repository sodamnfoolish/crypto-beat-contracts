// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

library CryptoBeatGovernanceRoles {
    bytes32 constant CRYPTO_BEAT_ADMIN_ROLE = keccak256("Admin");
    bytes32 constant CRYPTO_BEAT_MARKETPLACE_ROLE =
        keccak256("CryptoBeatMarketplace");
}
