// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract SpecialTicket is ERC721, ERC721Burnable, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;
    string eventId;

    constructor(string memory _eventId) ERC721("SpecialTicket", "TICKET") {
        eventId = _eventId;
    }

    function _baseURI() internal view override returns (string memory) {
        return string(abi.encodePacked("https://web3_ticket.com/nfts/erc721/", eventId, "/"));
    }

    function safeMint(address to) external onlyOwner returns (uint256 _tokenId) {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        return tokenId;
    }

    function tokenURI(
        uint256 _tokenId
    ) public view override returns (string memory) {
        _requireMinted(_tokenId);
        string memory base = _baseURI();

        return string(abi.encodePacked(base, _tokenId));
    }
}
