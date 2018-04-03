pragma solidity ^0.4.17;

contract SomeContract {
    event callMeMaybeEvent(address _from);
    function callMeMaybe() payable public {
        callMeMaybeEvent(this);
    }
}

contract ThatCallsSomeContract {
    function callTheOtherContract(address _contractAddress) public {
        require(_contractAddress.call(bytes4(keccak256("callMeMaybe()"))));
        require(_contractAddress.delegatecall(bytes4(keccak256("callMeMaybe()"))));
        SomeLib.calledSomeLibFun();
    }
}

library SomeLib {
    event calledSomeLib(address _from);
    function calledSomeLibFun() public {
        calledSomeLib(this);
    }
}
