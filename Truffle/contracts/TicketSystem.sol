// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "./Event.sol";

contract TicketSystem is Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private eventCounter;

    mapping(uint256 => address) events;

    constructor(){}

    function createEvent(address _owner, string memory _name, bool hasSpecialTicket) external onlyOwner {
        uint256 eventId = eventCounter.current();
        eventCounter.increment();
        events[eventId] = address(new Event(eventId, _owner, _name, hasSpecialTicket));
    }

    function getEvent(uint256 eventId) view external returns(address _event){
        return events[eventId];
    }

    function getEventSize() view external returns(uint256 _size) {
        return eventCounter.current();
    }
}