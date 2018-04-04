pragma solidity ^0.4.18;

contract Delegate {

  // me deja ver la direccion del owner. Es bueno eso?
  address public owner;

  // es el contructor, en el cual cuando es llamado para crear el contrato, le debo otorgar que direccion es la del dueño
  function Delegate(address _owner) {
    owner = _owner;
  }

  // Asigna el que llama a la funcion como owner de la variable publica
  function pwn() {
    owner = msg.sender;
  }
}

contract Delegation {

  // No me copa que haya dos variables identicas en contratos distintos. Puede ocurrir un error con eso?
  address public owner;
  // creo un nuevo contrato Delegate y lo llamo igual pero en minuscula
  Delegate delegate;
  
  // 
  function Delegation(address _delegateAddress) {
    delegate = Delegate(_delegateAddress);
    owner = msg.sender;
  }

  function() {
    if(delegate.delegatecall(msg.data)) {
      this;
    }
  }
}


// Tengo entendido que cuando llamo a travez de una delegacion, sigue actuando alguein en nombre del contrato madre.
// Ademas, tengo que en el contrato secundario, aparece una funcion callback que vuelve a llamar al owner. Si llograra llamarla desde una call hacia esa, podria cambiar el nobmre. Hago un contrato extra que trate de llamarla a esa.

// En teoria, si llamo a una call donde los primero 4 bytes no se corresponden con ninguna funcion del contrato, deberia ir directamente al fallback

// no se le puede enviar plata a traves de una referencia porque la funcion fallback no es payable


// cuando llamo desde remix a un contrato que ya fue deployed, tengo que usar la direccion 0x68756ad5e1039e4f3b895cfaa16a3a79a5a73c59 sobre Delegate. La otra no sirve

//hice el web3.sha3("pwn()") y los primeros 4 bytes (8 cifras) son 0xdd365b8b. porque asi se la mando al fallback para que haga la delegate y con eso llame a la funcion pwn pero me sale rechazada. Vi que en la direccion del contrato muchos hicieron lo mismo pero sale rechazada


// estaba bien encaminado pero al parecer tenia unos problemas con la apertura del contrato madre desde remix. Entonces si lo hago desde la instancia misma usando la consola, lo que hago es hacer una transferencia SIN ETH hacia el nivel desde mi usuario pero incluyendo como data el sha3 ese que obtuve del nombre de la funcion pwn. Entonces se soluciona el nivel haciendo

await contract.sendTransaction({from: player, to: level, value: 0, data: "0xdd365b8b"})


