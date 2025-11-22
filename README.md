# Mirror Trap Token (Replay Mirror Trap)

This contract implements a replay-based trap designed to detect and punish malicious callers.

## How the Trap Works
- The function `attemptDrain()` acts as bait.
- The first time a caller uses it, they get flagged.
- The next time they call it (or try to transfer tokens), the contract activates a mirror attack.
- The mirror attack burns a percentage of their balance.

## Features
- Replay detection
- Burn-based punishment
- Configurable burn percentage
- Simple ERC20-like behavior

## Files
- MirrorTrapToken.sol

This trap contract is original and written in Solidity, following Drosera trap logic requirements.
