// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract TicketToken is ERC721, ERC721Burnable, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;
    address minterAddress;

    constructor(address _minterAddress) ERC721("TicketToken", "TICKET") {
        minterAddress = _minterAddress;
    }

    function _baseURI() internal pure override returns (string memory) {
        return "https://web3_ticket.com/nfts/";
    }

    modifier ownerOrMinter() {
        require((msg.sender == owner()) || (msg.sender == minterAddress));
        _;
    }

    function safeMint(address to) public ownerOrMinter returns (uint256 _tokenId) {
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
