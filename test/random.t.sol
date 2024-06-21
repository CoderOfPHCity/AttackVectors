// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/AttackVector.sol/Randomness.sol";

contract GuessNumberTest is Test {
    Randomness public guessNumber;

    function setUp() public {
        guessNumber = new Randomness();
    }

    function testGuessNumber() public {
        // Retrieve the random number directly for testing purposes
        uint8 targetNumber = 24;

        bool guessedCorrectly = false;

        // Loop through all possible uint8 values to find the correct guess
        for (uint8 i = 0; i < 256; i++) {
            try guessNumber.guess(i) {
                if (i == targetNumber) {
                    guessedCorrectly = true;
                    break;
                }
            } catch {
                // Catch any reverts
            }
        }

        // Check that the correct number was guessed
        assertTrue(guessedCorrectly, "Failed to guess the correct number.");
    }
}
