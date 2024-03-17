// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/18_MagicNumber.sol";

interface Solver {
  function whatIsTheMeaningOfLife() external view returns (bytes32);
}

contract MagicNumberTest is Test {
    MagicNum _magicNumber;
    address deployer;
    address attacker;

    function setUp() public {
        deployer = address(this);
        attacker = vm.addr(1);

        _magicNumber = new MagicNum();
    }

    function testSolution() public {
        vm.startPrank(attacker);

        address _solverAddress;
        bytes memory bytecode = hex"600a600c600039600a6000f3602a60005260206000f3";

        assembly {
            _solverAddress := create(0, add(bytecode, 0x20), mload(bytecode))
        }

        _magicNumber.setSolver(_solverAddress);

        Solver _solver = Solver(_magicNumber.solver());

        bytes32 magic = _solver.whatIsTheMeaningOfLife();
        assertEq(uint256(magic), 42, "Magic number is incorrect!");

        uint256 size;
        assembly {
            size := extcodesize(_solver)
        }

        assertTrue(size <= 10, "Solver is too large!");
    }
}
