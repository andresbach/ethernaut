pragma solidity ^0.4.18;

contract Vault {
  bool public locked;
  bytes32 private password;

  function Vault(bytes32 _password) {
    locked = true;
    password = _password;
  }

  function unlock(bytes32 _password) public {
    if (password == _password) {
      locked = false;
    }
  }
}

// La cosa es que a pesar de que tengo la password como private, lo que ocurre es que eso hace que otro contrato no pueda acceder a esa variable, sin embargo como en la blockchain cualquier expectador externo puede ver toda la info de la bc (mediante el bytecode publicado), la informacion de esa variable se ve desde afuera. Claro, esta en bytecode.

// Por otro lado, Analizando la transaccion que creo el contrato y que le mando la frase de password en un comienzo, puedo obtenerla por otro camino. Busco la transaccion que la crea, busco el codigo y luego paso a ascii lo que hay ahi. Con eso, la unica frase que tiene sentido es:

"A very strong secret password :)"

// Voy de vuelta a la consola y le pongo 
await contract.unlock("A very strong secret password :)")
