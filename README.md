
## Run Solutions
Run solutions using ```forge test```

## Deploy
Deploy to anvil.
```
forge script script/Deployer.s.sol --broadcast --rpc-url http://localhost:8545/ --private-key $ANVIL_PRIVATE_KEY
```


## Solutions

### 00 Hello Ethernaut
Call each method, then authenticate with password

### 01 Fallback
Send with no calldata to hit fallback, make sure to have first contributed to meet the fallback criteria, then withdraw when owner.

### 02 Fallout
Badly named constructor, does not make sense in modern solidity

### 03 Coin Flip
Prng

### 04 Telephone
tx.origin != msg.sender when msg.sender is a contract called by tx.origin

### 05 Token
Under/Overflow's now revert, added unchecked block to mimic old functionality. Why is another account required?

### 06 Delegation
Use fallback to delegate call pwn to change the owner of delegation. Delegatecall allows contracts to use the logic of another contract with their own state.

### 07 Force
Use self destruct to force funds into contract, note that selfdestruct is now deprecated.

### 08 Vault
There is no private on chain data!

### 09 King
Malicious user can revert on receive and cause contract to not be able to transfer funds to user. Freezing the contract

### 10 Reentrance
Classic reentrancy

### 11 Elevator
Have to bare in mind how state changes accross multiple calls

### 12 Privacy
No priv on chain data, slightly harder to access

### 13 Gatekeeper One

### 14 Gatekeeper Two

### 15 NaughtCoin
Use approve and transferFrom to bypass transfer lock

### 16 Preservation
how storage works with delegate calls
