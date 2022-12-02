// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "../CryptoBeatERC721.sol";

contract CryptoBeatERC721Injected is Initializable {
    CryptoBeatERC721 public _cryptoBeatERC721;

    uint256[50] private __gap;

    function __CryptoBeatERC721Injected_init(CryptoBeatERC721 cryptoBeatERC721) internal onlyInitializing {
        __CryptoBeatERC721Injected_init_unchained(cryptoBeatERC721);
    }

    function __CryptoBeatERC721Injected_init_unchained(CryptoBeatERC721 cryptoBeatERC721) internal onlyInitializing {
        _cryptoBeatERC721 = cryptoBeatERC721;
    }
}