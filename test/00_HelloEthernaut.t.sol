// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/00_HelloEthernaut.sol";

contract HelloEthernautTest is Test {
    HelloEthernaut _helloEthernaut;
    address deployer;
    address attacker;

    function setUp() public {
        deployer = address(this);
        attacker = vm.addr(1);

        _helloEthernaut = new HelloEthernaut("SecretPassword");

    }

    function testSolution() public {
        vm.startPrank(attacker);

        console.log(_helloEthernaut.info());
        console.log(_helloEthernaut.info1());
        console.log(_helloEthernaut.info2("hello"));
        console.log(_helloEthernaut.infoNum());
        console.log(_helloEthernaut.info42());
        console.log(_helloEthernaut.theMethodName());
        console.log(_helloEthernaut.method7123949());

        string memory password = _helloEthernaut.password();

        _helloEthernaut.authenticate(password);

        assertTrue(_helloEthernaut.getCleared(), "Level is not cleared!");
    }
}
