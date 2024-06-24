# TimeLock Smart Contract

This repository contained a smart contract called `TimeLock` that I wrote in Solidity.

## Description

The `TimeLock` contract was a basic example of a smart contract on the Ethereum blockchain. It demonstrated the fundamental structure and syntax of a Solidity contract. This contract allowed locking and unlocking of funds based on a specified time duration.

## Contract Code

The contract code was as follows:

```solidity
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

contract TimeLock {
    address public owner;
    uint public unlockTime;

    event Deposited(uint amount, uint when);
    event Withdrawn(uint amount, uint when);

    constructor(uint _unlockTime) {
        require(_unlockTime > block.timestamp, "Unlock time should be in the future");
        owner = msg.sender;
        unlockTime = _unlockTime;
    }

    function deposit() external payable onlyOwner {
        emit Deposited(msg.value, block.timestamp);
    }

    function withdraw() external onlyOwner {
        require(block.timestamp >= unlockTime, "Current time is before unlock time");
        emit Withdrawn(address(this).balance, block.timestamp);
        payable(msg.sender).transfer(address(this).balance);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }
}
```

### Explanation:

- **SPDX-License-Identifier**: Specified the license type. Here it was MIT.
- **pragma solidity ^0.8.25**: Specified the Solidity compiler version to use. The `^` symbol indicated that the contract was compatible with compiler versions 0.8.25 and above but below 0.9.0.
- **contract TimeLock**: Defined a new contract named `TimeLock`.
- **address public owner**: Declared a state variable named `owner` of type `address` that was publicly accessible.
- **uint public unlockTime**: Declared a state variable named `unlockTime` of type `uint` that was publicly accessible.
- **event Deposited(uint amount, uint when)**: Declared an event to log deposit actions.
- **event Withdrawn(uint amount, uint when)**: Declared an event to log withdraw actions.
- **constructor(uint _unlockTime)**: Defined a constructor that set the owner and the unlock time.
- **function deposit() external payable onlyOwner**: Defined a function named `deposit` that was `external` and `payable` (could receive ether). It was restricted to the contract owner.
- **function withdraw() external onlyOwner**: Defined a function named `withdraw` that was `external` (could be called from other contracts and transactions). It transferred the contract balance to the owner if the current time was greater than or equal to the unlock time.
- **modifier onlyOwner()**: Defined a modifier that restricted access to the contract owner.

## Functions

### `constructor(uint _unlockTime)`

- **Description**: This constructor was used to set the owner and the unlock time of the contract. It required that the unlock time be in the future.
- **Parameters**: `uint _unlockTime` - The time after which funds can be withdrawn.

### `deposit()`

- **Description**: This function was used to deposit ether into the contract. It emitted a `Deposited` event.
- **Visibility**: `external` - The function could be called from other contracts or from transactions.
- **Payable**: Yes, it could receive ether.

### `withdraw()`

- **Description**: This function was used to withdraw ether from the contract. It emitted a `Withdrawn` event and transferred the balance to the owner if the current time was greater than or equal to the unlock time.
- **Visibility**: `external` - The function could be called from other contracts or from transactions.
- **Requirements**: The current time had to be greater than or equal to the unlock time. Only the owner could call this function.

### `onlyOwner()`

- **Description**: This modifier restricted access to the contract owner.
- **Visibility**: `internal` - The modifier could only be used within the contract.

