// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DenialOfservice {
    uint256 public largestWinner;

    event WinnerProcessed(uint256 indexed winner);

    function selectNextWinners(uint256 _largestWinner) public {
        for (uint256 i = 0; i < _largestWinner; i++) {
            // Simulate heavy computation by emitting an event
            emit WinnerProcessed(i);

            // Check remaining gas and stop if too low
            if (gasleft() < 10000) {
                break;
            }
        }
        largestWinner = _largestWinner;
    }
}
