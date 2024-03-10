// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/15_NaughtCoin.sol";

contract NaughtCoinTest is Test {
    NaughtCoin _naughtCoin;
    address deployer;
    address attacker;
    address attackersFriend;

    function setUp() public {
        deployer = address(this);
        attacker = vm.addr(1);

        _naughtCoin = new NaughtCoin(attacker);
    }

    function testSolution() public {
        vm.prank(attacker);
        _naughtCoin.approve(deployer, 1000000000000000000000000);
        
        vm.prank(deployer);
        _naughtCoin.transferFrom(attacker, deployer, _naughtCoin.balanceOf(attacker));

        assertEq(_naughtCoin.balanceOf(attacker), 0, "Attacker still has coins!");
    }
}
