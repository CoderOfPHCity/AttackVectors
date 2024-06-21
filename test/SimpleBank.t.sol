// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/AttackVector.sol/SimpleBank.sol";

contract SimpleBankTest is Test {
    SimpleBank public simpleBank;
    address A = makeAddr("AttackA");

    function setUp() public {
        
        simpleBank = new SimpleBank();
    }

    function testDeposit() public {
        // Deposit 1 ether
        simpleBank.deposit{value: 1 ether}();
        assertEq(simpleBank.balances(address(this)), 1 ether, "Deposit failed");
    }

    function testWithdraw() public {
        // Deposit 1 ether
        simpleBank.deposit{value: 1 ether}();
        assertEq(simpleBank.balances(address(this)), 1 ether, "Deposit failed");

        // Capture the initial gas
        uint256 initialGas = gasleft();

        // Withdraw 0.5 ether
        simpleBank.withdraw(0.5 ether);

        // Capture the remaining gas
        uint256 remainingGas = gasleft();

        // Check the gas used
        console.log("Gas used:", initialGas - remainingGas);

        // Ensure the balance is updated
        assertEq(simpleBank.balances(address(this)), 0.5 ether, "Withdraw failed");
    }

    function testWithdrawWithInsufficientBalance() public {
        // Deposit 0.1 ether
        simpleBank.deposit{value: 0.1 ether}();

        // Try to withdraw 1 ether (should fail)
        vm.expectRevert("Insufficient balance");
        simpleBank.withdraw(1 ether);
    }

    function testWithdrawWithGasLimit() public {
        // Deposit 1 ether
        simpleBank.deposit{value: 1 ether}();
        assertEq(simpleBank.balances(address(this)), 1 ether, "Deposit failed");

        // Set a gas limit for the withdrawal
        uint256 gasLimit = 20000;

        // Withdraw 0.5 ether with limited gas
        bool success;
        bytes memory data;
        (success, data) = address(simpleBank).call{gas: gasLimit}(abi.encodeWithSignature("withdraw(uint256)", 0.5 ether));

        // Check if the transaction was successful
        console.log("Withdrawal success:", success);

        if (success) {
            // Capture the remaining gas
            uint256 remainingGas = gasleft();
            console.log("Remaining gas:", remainingGas);
        }

        // Ensure the balance is updated or unchanged depending on success
        uint256 expectedBalance = success ? 0.5 ether : 1 ether;
        assertEq(simpleBank.balances(address(this)), expectedBalance, "Balance mismatch");
    }

    receive() external payable {}
}
