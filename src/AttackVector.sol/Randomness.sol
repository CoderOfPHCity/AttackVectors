// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Randomness {
    uint8 private randomNumber;

    event NumberGuessed(address indexed player, uint8 guessedNumber, bool isCorrect);

    constructor() {
        generateRandomNumber();
    }

    // Function to generate a pseudo-random number
    function generateRandomNumber() private {
        randomNumber = uint8(uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender))) % 256);
    }

    // Function to guess the number
    function guess(uint8 guessedNumber) external {
        bool isCorrect = (guessedNumber == randomNumber);
        if (isCorrect) {
            // If the guess is correct, emit an event and generate a new random number
            emit NumberGuessed(msg.sender, guessedNumber, true);
            generateRandomNumber();
        } else {
            emit NumberGuessed(msg.sender, guessedNumber, false);
        }
    }
}
