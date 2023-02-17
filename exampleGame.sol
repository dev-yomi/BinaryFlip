pragma solidity ^0.8.0;

// Imports the BinaryFlip library from a separate file
import "./BinaryFlip.sol";

contract CoinFlip {

    // Allows the BinaryFlip library to be used on the uint256 data type
    using BinaryFlip for uint256;
    
    uint256 public lastFlipBlock; // The block number of the last flip
    uint256 public flipCount; // The number of flips that have occurred
    uint256 public totalWins; // The total number of wins
    uint256 public totalLosses; // The total number of losses
    
    event NewFlip(address indexed player, bool indexed win, uint256 indexed blockNumber, uint256 randomNumber);
    
    constructor() {
        // Initializes the lastFlipBlock, flipCount, totalWins, and totalLosses variables
        lastFlipBlock = block.number;
        flipCount = 0;
        totalWins = 0;
        totalLosses = 0;
    }
    
    function flipCoin() public {
        // Calls the flip function from the BinaryFlip library to generate a random number
        // Uses the lastFlipBlock and a minimum of 5 blocks between flips as input parameters
        uint256 randomNumber = BinaryFlip.flipBinary(lastFlipBlock, 5);
        // Determines whether the player wins based on the random number
        bool win = (randomNumber == 1);
        // Increments the flipCount variable
        flipCount += 1;
        // If the player wins, increments the totalWins variable; otherwise, increments the totalLosses variable
        if (win) {
            totalWins += 1;
        } else {
            totalLosses += 1;
        }
        // Updates the lastFlipBlock variable to the current block number
        lastFlipBlock = block.number;
        // Emits the NewFlip event with the player's address, win status, block number, and random number
        emit NewFlip(msg.sender, win, block.number, randomNumber);
    }
    
    // Defines a function that allows users to retrieve the contract statistics
    function getStats() public view returns (uint256, uint256, uint256, uint256) {
        // Returns a tuple containing the lastFlipBlock, flipCount, totalWins, and totalLosses variables
        return (lastFlipBlock, flipCount, totalWins, totalLosses);
    }
    
}
