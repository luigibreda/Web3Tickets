// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

import "./nfts/SpecialTicket.sol";
import "./nfts/Ticket.sol";

contract Event is Ownable {
    
    struct EventAttributes {
        string name;
    }
    
    SpecialTicket erc721;
    Ticket erc1155;
    EventAttributes eventAttributes;

    constructor(uint256 _eventId, address _owner, string memory _name, bool hasSpecialTicket) {
        string memory strEvent = Strings.toString(_eventId);
        if (hasSpecialTicket) {
            erc721 = new SpecialTicket(strEvent);
        }
        erc1155 = new Ticket(strEvent);

        eventAttributes.name = _name;

        transferOwnership(_owner);
    }

    function createSpecialTicket(address _to) external onlyOwner {
        erc721.safeMint(_to);
    }

    function createTicket(address _account, uint256 _amount, bytes memory _data) external onlyOwner {
        erc1155.mint(_account, _amount, _data);
    }

    function getErc1155Address() external view returns(address _address) {
        return address(erc1155);
    }

    function getErc721Address() external view returns(address _address) {
        return address(erc721);
    }
}
