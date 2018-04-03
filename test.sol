pragma solidity ^0.4.18;

contract prueba {
    event meLlaman(address _from);
    uint public testing;
    
    function activar() public {
        meLlaman(this);
    }
}
