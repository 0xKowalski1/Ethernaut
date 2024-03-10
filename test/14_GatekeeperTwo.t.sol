// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/14_GatekeeperTwo.sol";

contract GatekeeperTwoTest is Test {
    GatekeeperTwo _gatekeeperTwo;
    address deployer;
    address attacker;

    function setUp() public {
        deployer = address(this);
        attacker = vm.addr(1);

        _gatekeeperTwo = new GatekeeperTwo();

    }

    function testSolution() public {
        vm.startPrank(attacker);


        assertEq(_gatekeeperTwo.entrant(), attacker, "Attacker is not entrant!");
    }
}
