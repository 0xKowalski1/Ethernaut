
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
