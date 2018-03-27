pragma solidity ^0.4.18;

contract CoinFlip {
  uint256 public consecutiveWins;
  uint256 lastHash;
  //el FACTOR creo que es la mitad del maximo del numero de 256 bit
  uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;
  
  // es el contructor, inicializa en 0
  function CoinFlip() public {
    consecutiveWins = 0;
  }

  // se fija el hash del bloque (anterior estimo por el -1) y toma el valor que yo le entrego de guess. es 1 o 0 lo que le mando
  function flip(bool _guess) public returns (bool) {
    uint256 blockValue = uint256(block.blockhash(block.number-1));
    
    // si el valor coincide con lasthash me tira del contrato. No se cuando ocurre eso, ya que es el anterior
    if (lastHash == blockValue) {
      revert();
    }

    // en caso contrario, se asigna el valor del anterior
    lastHash = blockValue;
    
    // casteo el hash divido el factor constante que me da uno o cero
    uint256 coinFlip = uint256(uint256(blockValue) / FACTOR);
    
    // el operador condicional ? hace que si CoinFlip == 1, entonces hace lo primero (true) y sino lo segundo (false). En este caso, side se le asigna alguno de esos dos valores booleanos
    bool side = coinFlip == 1 ? true : false;
    
    
    // si resultado que obtuvo del random del hash es el mismo que dije yo, entonces, suma una victoria al acumulador. De lo contrario, pierdo todo y vuelvo a 0
    if (side == _guess) {
      consecutiveWins++;
      return true;
    } else {
      consecutiveWins = 0;
      return false;
    }
  }
}


La cosa es que se generan cada 15 segundos, entonces me genero un contrato que contrareste el valor en tiempo directo



pragma solidity ^0.4.18;

contract CoinFlip {
  uint256 public consecutiveWins;
  uint256 lastHash;
  uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;
  
  function CoinFlip() public {
    consecutiveWins = 0;
  }
  
  function hashbloque(uint _bloque) public returns (uint256){
      return uint256(block.blockhash(_bloque));
  }
  
  function numerobloque() public returns (uint) {
      return block.number;
  }


  function flip(bool _guess) public returns (bool) {
    //uint256 blockValue = uint256(block.blockhash(block.number-1));
    uint256 blockValue = hashbloque(numerobloque());
    
    if (lastHash == blockValue) {
      revert();
    }

    lastHash = blockValue;
    uint256 coinFlip = uint256(uint256(blockValue) / FACTOR);
    bool side = coinFlip == 1 ? true : false;
    
    if (side == _guess) {
      consecutiveWins++;
      return true;
    } else {
      consecutiveWins = 0;
      return false;
    }
  }
}
