pragma solidity ^0.4.18;

contract Telephone {

  //guarda la direccion actual del dueño del contrato
  address public owner;

  // contructor asigna el que lo crea como dueño
  function Telephone() {
    owner = msg.sender;
  }

  //para cambiar de owner por uno que le paso, el que envia la direccion del nuevo owner tiene que ser distinto al que origino toda la movida con la transferencia (el tx.origin que seria yo)
  function changeOwner(address _owner) public {
    if (tx.origin != msg.sender) {
      owner = _owner;
    }
  }
}
