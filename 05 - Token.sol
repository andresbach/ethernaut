pragma solidity ^0.4.18;

contract Token {
    //mapeo los balances de las direcciones. totalSupply es un valor fijo y es de 256bit
  mapping(address => uint) balances;
  uint public totalSupply;

  // contructor. le asigna una cantidad limitada de tokens para el uso cuando se crea el contrato y los coloca en la cuenta del que los crea
  function Token(uint _initialSupply) {
    balances[msg.sender] = totalSupply = _initialSupply;
  }

  // el usuario que lo abre transfiere de su cuenta a la cuenta del otro, teniendo como requisito que no puede gastar mas que lo que tiene
  function transfer(address _to, uint _value) public returns (bool) {
    require(balances[msg.sender] - _value >= 0);
    balances[msg.sender] -= _value;
    balances[_to] += _value;
    return true;
  }

  // indica el balance que tiene la direccion que le paso. No necesariamente la mia
  function balanceOf(address _owner) public constant returns (uint balance) {
    return balances[_owner];
  }
}


level tiene una infinidad de tokens y yo 20
await contract.balanceOf(player)
await contract.balanceOf(level)
await contract.transfer(level,20)
await contract.balanceOf(level)
await contract.balanceOf(player)
await contract.totalSupply.call()
await contract.transfer(level,20)
await contract.balanceOf(player)

//porque no salto el require???
