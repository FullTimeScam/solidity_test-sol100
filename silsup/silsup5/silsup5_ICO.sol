// SPDX-License-Identifier: GPL-3.0

pragma solidity >= 0.8.2 < 0.9.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ICO is ERC1155, Ownable {
    uint[4] public tokensSold;
    uint public icoStartBlock;

    constructor(string memory uri) ERC1155(uri) Ownable() {
        icoStartBlock = block.number;
    }
    
    // Function to buy tokens by specifying the tier and amount
    function buyTokens(uint tier, uint amount) external payable {
        require(tier >= 1 && tier <= 4, "Invalid tier");
        require((block.number - icoStartBlock) <= 100, "ICO has ended");

        // Implement token buying logic here
        // For example:
        tokensSold[tier - 1] += amount;
        
        // Check for payment amount and other business logic...
    }
}