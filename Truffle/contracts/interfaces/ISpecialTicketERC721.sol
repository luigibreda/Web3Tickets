// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

interface ISpecialTicketERC721 {
    function safeMint(address to) external returns (uint256 _tokenId);
}