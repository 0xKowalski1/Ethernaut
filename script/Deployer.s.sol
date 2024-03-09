// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "forge-std/console.sol";
import "../src/00_HelloEthernaut.sol";

contract Deployer is Script {
    function run() external {
        vm.startBroadcast();

        // 00
        HelloEthernaut helloEthernaut = new HelloEthernaut("SecretPassword");
        console.log("Deployed 00_HelloEthernaut at address:", address(helloEthernaut));

        //01

        vm.stopBroadcast();
    }
}

