// SPDX-License-Identifier: MIT

pragma solidity 0.8.16;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract CryptoBeatERC721 is ERC721URIStorage {
    uint256 private _countOfTokens;
    string private _baseTokenURI = "https://ipfs.io/ipfs/";

    constructor () ERC721("CryptoBeat", "CB") {}

    function mint(string memory tokenURISuffix) external returns(uint256 tokenId) {
        tokenId = ++_countOfTokens;

        super._mint(msg.sender, tokenId);
        super._setTokenURI(tokenId, tokenURISuffix);
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return _baseTokenURI;
    }
}