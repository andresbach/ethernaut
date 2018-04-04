pragma solidity ^0.4.18;

contract Delegate {

  address public owner;

  function Delegate(address _owner) {
    owner = _owner;
  }

  function pwn() {
    owner = msg.sender;
  }
}

contract Delegation {

  address public owner;
  address public dir_yo = msg.sender;
  
  Delegate delegate;

  function Delegation(address _delegateAddress) public {
    delegate = Delegate(_delegateAddress);
    owner = msg.sender;
  }

  function() public {
      // 0xdd365b8b
    if(delegate.delegatecall(msg.data)) {
      this;
    }
  }
}
