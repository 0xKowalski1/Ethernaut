// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/02_Fallout.sol";

contract REPLACETest is Test {
    Fallout _fallout;
    address deployer;
    address attacker;

    function setUp() public {
        deployer = address(this);
        attacker = vm.addr(1);

        _fallout = new Fallout();

    }

    function testSolution() public {
        vm.prank(attacker);


        assertEq(_fallout.owner(), attacker, "Atacker is not owner!");
    }
}
