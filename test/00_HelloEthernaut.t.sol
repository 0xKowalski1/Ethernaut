// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/00_HelloEthernaut.sol";

contract HelloEthernautTest is Test {
    HelloEthernaut helloEthernaut;
    address deployer;
    address attacker;

    function setUp() public {
        deployer = address(this);
        attacker = address(1);

        helloEthernaut = new HelloEthernaut("SecretPassword");

    }

    function testSolution() public {
        vm.prank(attacker);

        console.log(helloEthernaut.info());
        console.log(helloEthernaut.info1());
        console.log(helloEthernaut.info2("hello"));
        console.log(helloEthernaut.infoNum());
        console.log(helloEthernaut.info42());
        console.log(helloEthernaut.theMethodName());
        console.log(helloEthernaut.method7123949());

        string memory password = helloEthernaut.password();

        helloEthernaut.authenticate(password);

        assertTrue(helloEthernaut.getCleared(), "Level is not cleared!");
    }
}
