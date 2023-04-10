// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

interface ITicketERC1155 {
    function mint(address account, uint256 amount, bytes memory data) external;
}
