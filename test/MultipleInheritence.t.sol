// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {Test, console} from "forge-std/Test.sol";
import "../src/AttackVector.sol/MultipleInheritance.sol";

contract MultipleInheritence is Test  {
    MultipleInheritance public multipleInheritence;

     address A = makeAddr("AttackA");
    address B = makeAddr("FakeAdress");


    function setUp() public {
        multipleInheritence = new MultipleInheritance();
    }

    function testAttack() public {
        multipleInheritence.kill();
    }
}