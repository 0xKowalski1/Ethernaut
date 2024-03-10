// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Reentrance { 
  mapping(address => uint) public balances;

  function donate(address _to) public payable {
    balances[_to] = balances[_to] += msg.value;
  }

  function balanceOf(address _who) public view returns (uint balance) {
    return balances[_who];
  }

  function withdraw(uint _amount) public {
    unchecked{ // Contract originally written in 0.6.0, updated to 0.8.0 for simplicity, relies on underflow
    if(balances[msg.sender] >= _amount) {
      (bool result,) = msg.sender.call{value:_amount}("");
      if(result) {
        _amount;
      }
      balances[msg.sender] -= _amount;
    }
    }
  }

  receive() external payable {}
}
