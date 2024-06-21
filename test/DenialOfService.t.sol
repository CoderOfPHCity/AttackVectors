// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/AttackVector.sol/DenialOfservice.sol";

contract HeavyLoopTest is Test {
    DenialOfservice public heavyLoop;

    function setUp() public {
        heavyLoop = new DenialOfservice();
    }

    function testSelectNextWinners() public {
        uint256 largeNumber = 1e6; // Set a large number to simulate attack

        // Capture the initial gas
        uint256 initialGas = gasleft();

        // Call selectNextWinners with a large number
        heavyLoop.selectNextWinners(largeNumber);

        // Capture the remaining gas
        uint256 remainingGas = gasleft();

        // Check the gas used
        console.log("Gas used:", initialGas - remainingGas);
        
        // Ensure the function didn't complete due to gas limitations
        assertTrue(remainingGas < initialGas, "Gas should be used");
    }
}
