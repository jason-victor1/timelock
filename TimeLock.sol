// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

contract MyContract {
    uint public unlockTime;
    address public owner;

    constructor(uint _unlockOffset) payable {
        unlockTime = block.timestamp + _unlockOffset;
        owner = msg.sender;
    }

    function withdraw() external {
        require(block.timestamp >= unlockTime, "Funds are locked");
        require(msg.sender == owner, "Only owner can withdraw");
        (bool sent, ) = payable (owner).call{value: address(this).balance}("");
        require(sent == true, "transfer failed" );
    }
}