 // SPDX-License-Identifier: MIT
// pragma solidity ^0.8.19;
// pragma solidity ^0.8.19;

// import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

// import {Test, console} from "forge-std/Test.sol";
// import {SafeNFT} from "../src/SafeNFT.sol";
// import {Reentrancy} from "./../src/Reentrancy.sol";

// contract CounterTest is Test {
//     SafeNFT public safeNFT;
//     Reentrancy public reentrancy;


//     address A = makeAddr("AttackA");
//     address B = makeAddr("FakeAdress");
//      address public ATTACKER = vm.addr(0x02);

//     function setUp() public {
//         safeNFT = new SafeNFT("safetoken", "SFT", 10 ether);
//         reentrancy = new Reentrancy(address(safeNFT));

//            vm.deal(ATTACKER, 10 ether);
//     }

//     function test() public {
//         uint256 balanceBefore = 10 ether;
//         vm.deal(A, balanceBefore);
//         vm.startPrank(A);
//         assert(A.balance == 10 ether);
//         safeNFT.buyNFT{value: 10 ether}();

//         uint256 totalSupplyBefore = safeNFT.totalSupply();

//         // Verify totalSupply before claiming (should be 0 initially)
//         assert(totalSupplyBefore == 0);
//         safeNFT.claim();

//         vm.startPrank(A);
//         vm.deal(A, balanceBefore);
    
//          safeNFT.buyNFT{value: 10 ether}();
//          safeNFT.claim();

//         // Ensure A cannot claim again after claiming once
//         bool canClaimAfter = safeNFT.canClaim(A);
//         assert(canClaimAfter == false);

//       // Verify totalSupply after claiming (should be 2 after minting two NFTs)
//         uint256 totalSupplyAfter = safeNFT.totalSupply();
//         assert(totalSupplyAfter == 2);

//         // Check balance of address A after minting a token
//         assert(safeNFT.balanceOf(A) == 2);
    


//         assert(A.balance == 0 ether);

//         assert(address(safeNFT).balance == 20 ether);


//     }

//     function testReentrancy() public {

//         vm.startPrank(ATTACKER);
//        // safeNFT.buyNFT{value: 10 ether}();
//         // vm.stopPrank();
//         reentrancy.attack{value: 10 ether}();
//         assert(address(safeNFT).balance == 0);


//     }
// }
