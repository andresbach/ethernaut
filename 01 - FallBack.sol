pragma solidity ^0.4.18;

import 'zeppelin-solidity/contracts/ownership/Ownable.sol';

// el contrato es adueñable, y se puede cambiar de dueño dentro mismo
contract Fallback is Ownable {
// mapeo las direcciones de la red a contribuciones, para luego usarlo con las direcciones como owner, sender, etc
  mapping(address => uint) public contributions; // aca asigna a una nueva tabla? tipo hace un copy paste de los balances sobre contribuciones?

  //genera una contribucion del que llama el contrato de 1000 ether. Es un constructor
  function Fallback() {
    contributions[msg.sender] = 1000 * (1 ether); // no comprendo bien porque hace esto, no me afecta los balances reales que tiene cada uno cuando lo usa abajo?
  } 

  function contribute() public payable { //tengo que aca puedo enviar eth a otros
    require(msg.value < 0.001 ether); // si el monto que transfiero es muy chico
    contributions[msg.sender] += msg.value; // le suma lo que contribuye el que llamo el contrato
    if(contributions[msg.sender] > contributions[owner]) { //el que contribuye mas es el nuevo dueño del contrato
      owner = msg.sender; // me asigno como nuevo dueño
    }
  }

  function getContribution() public constant returns (uint) {// solamente me dice las contribuciones de mi cuenta cuando llamo al contrato
    return contributions[msg.sender];
  }

  // el dueño puede llamar a la funcion para retirar el balance de todo el contrato
  function withdraw() onlyOwner {
    owner.transfer(this.balance);
  }

  // lo que hace aca es que cuando creo el contrato, o sea soy el primer msg.sender, me asigna como dueño siempre y cuando le haya contribuido algo al contrato desde el principio
  //no se podria que dentro de fallback utilice un constructor e inicializarlo ahi?
  // si esta es la funcion fallback, entonces cada vez que alguien la pifie se le asigna el cargo de dueño? (https://ethereum.stackexchange.com/questions/7570/whats-a-fallback-function-when-using-address-send)
  function() payable {
    require(msg.value > 0 && contributions[msg.sender] > 0);
    owner = msg.sender;
  }
}

//sendTransaction({from: player, to: level, value: toWei(0.0001)})

// await getBalance(level) veo lo que tiene el contrato de balance

//llamo a la funcion contribuir para que me asigne la direccion y luego le hago la transferencia. En este caso, lo que hace es que en data escribe la direccion hasheada de la funcion que quiero y lo manda a la direccion del contrato
contract.contribute.sendTransaction({from: player, to: contract.address, value: toWei(0.0009)})

//anda tambien igual pero necesito saber de atemano el sha3 de la funcion
await sendTransaction({from: player, to: contract.address, value: toWei(0.0009), data: "0xd7bb99ba"})

// luego llamo al fallback para que se ejecute como
await sendTransaction({from: player, to: contract.address, value: toWei(0.00099)})

// y despues hago
contract.withdraw()

//se ve que de antemano el metamask sabe cuando va a tirar un error el contrato. En este caso tuve que como yo no era contribudor aun, al ir al fallback el require me hacia un throw y nunca llegaba a cambiar el owner. Una vez que llego a ser contribuidor, me acepta evaluar el requiere. Es raro que lo evalue antes de ir mi transaccion al bloque y se mine
