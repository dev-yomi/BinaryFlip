# BinaryFlip

A solidity library to generate a pseudo-random 0 or 1 from a block hash in the past, on-chain and in a way that is impractical to manipulate.


The library BinaryFlip is used to define the function flip, which returns a pseudo-random number (0 or 1) based on the block hash.
The flip function takes two arguments: lastBlockNumber and minBlocks. lastBlockNumber is the number of the last block that was used to generate a pseudo-random number, and minBlocks is the minimum number of blocks that must be generated between calls to flip.
The flip function calculates the number of blocks between the current block and the lastBlockNumber parameter and caps the value at 256 to prevent out of range errors.
If the block difference is >= the minBlocks parameter, the flip function generates a random number based on a block hash. The block hash is chosen by taking the current block number and moving backward in time a number of blocks equal to half the block difference between the current block and the lastBlockNumber parameter. If the resulting block number is even, that block's hash is used to generate the random number. If it's odd, the previous block's hash is used.
The flip function returns a number between 0 and 1 based on the hash generated at this stage.
If the block difference is less than the minimum number of blocks specified, the function throws an error.

## Things to be aware of 
- The flip function generates a pseudo-random number based on the block hash, so it is important to ensure that the lastBlockNumber parameter is set correctly and that the minimum number of blocks specified is met.
- The function is marked as internal, meaning it can only be called within the contract that imports the BinaryFlip library.
- If the block difference is less than the minimum number of blocks specified, the function throws an error using the revert keyword, so developers should be prepared to handle this error within their contract.
- The flip function is not very gas efficient and may consume more gas than other methods of generating random numbers. Therefore, I do not recommend to use this function in high frequency or high gas cost environments.
- DO NOT USE THIS LIBRARY WITHOUT EXTREME CAUTION. IT IS LARGELY UNTESTED.

## Other stuff

- You can see an example of an on-chain coin-flip game using the library at exampleGame.sol.
- BinaryFlipRange is a slightly modified version that allows the generation of any integer between the given values.

## Issues

- I have hardly even tested it.
- It's pseudo-random, not random. This can technically be gamed, although it is designed around the idea of making that a larger task than it's worth.
- The above is reliant on utilising the library correctly and preventing incorrect, potentially dangerous, values from being passed to it.
- It requires a delay before a number is resolved.

### Reason I did this?

I just wanted to put my idea into fruition. I realise it is not at all a bulletproof method, but originally it was being used to develop a coin-flip game without relying on an Oracle. If the game was $1 a pop, I am fairly confident it would not be worth it for an attacker to manipulate it. I think it's an interesting approach and the method allows for some composability in less serious, or entirely non-financial applications.

Once again, don't use it without extreme caution.
