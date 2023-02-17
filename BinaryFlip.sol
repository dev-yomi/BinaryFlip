pragma solidity ^0.8.0;

library BinaryFlip {

     /*   
     The function returns a 0 or 1 at pseudo-random.
     The flip function generates a pseudo-random number based on the block hash of a block chosen by taking the current block number and moving 
     backwards in time a number of blocks equal to half the block difference between the current block and the lastBlockNumber parameter. 
     The maximum number of blocks to move is capped at 256 to prevent an out of range error. 
     If the resulting block number is even, that block's hash is used to generate the random number; if it's odd, the previous block's hash is used. 
     The resulting hash is then converted to a number between 0 and 1, which is returned by the function.  
     */


    function flip(uint256 lastBlockNumber, uint256 minBlocks) internal view returns (uint256) {
            // Calculates the number of blocks between the current block and the lastBlockNumber
            uint256 blockDifference = block.number - lastBlockNumber;
            // If the block difference is greater than 256, sets it to 256 to prevent an out of range error
            if (blockDifference > 256){
                blockDifference = 256;
            }
            // If the block difference is greater than or equal to the minimum number of blocks specified, generates a random number based on block hash
            // The block chosen is located in the future relative to the lastBlockNumber and the past relative to the call
            if (blockDifference >= minBlocks) {
                bytes32 blockHash = blockhash((block.number % 2 == 0) ? block.number - (blockDifference / 2) : block.number - (blockDifference / 2) - 1);
                return (uint256(blockHash) % 2);
            } else {
                // If the block difference is less than the minimum number of blocks specified, throws an error
                revert("Minimum block difference not met.");
            }
    }
}
