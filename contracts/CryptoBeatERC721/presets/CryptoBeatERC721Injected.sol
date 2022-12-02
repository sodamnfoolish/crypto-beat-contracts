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

    modifier onlyCryptoBeatTokenOwner(uint256 cryptoBeatTokenId) {
        require(
            _cryptoBeatERC721.ownerOf(cryptoBeatTokenId) == msg.sender,
            "CryptoBeatERC721Injected: only CryptoBeatToken owner"
        );
        _;
    }

    modifier onlyExclusiveLicenseCryptoBeatToken(uint256 cryptoBeatTokenId) {
        require(
            _cryptoBeatERC721.getCryptoBeatTokenInfo(cryptoBeatTokenId).licenseId ==
                CryptoBeatLicenses.EXCLUSIVE_LICENSE_ID,
            "CryptoBeatERC721Injected: only CryptoBeatToken with Exclusive license"
        );
        _;
    }

    modifier onlyApprovedCryptoBeatToken(uint256 cryptoBeatTokenId) {
        require(
            _cryptoBeatERC721.isApprovedForAll(msg.sender, address(this)) ||
                _cryptoBeatERC721.getApproved(cryptoBeatTokenId) == address(this),
            "CryptoBeatERC721Injected: only approved CryptoBeatToken"
        );
        _;
    }
}
