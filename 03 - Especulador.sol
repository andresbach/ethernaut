pragma solidity ^0.4.18;

contract especulador {
  uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;
  uint256 public blockhasha;
  uint public blocknum;
  //uint public caraceca;
  bool public unidad;


  function update() public {
    //blockValue = blnum;
    blocknum = block.number-1;
    blockhasha = uint256(block.blockhash(block.number-1));
    //caraceca = uint256(uint256(blockhasha) / FACTOR);
    if (blockhasha>=FACTOR) {
        unidad = true;
    } else {
        unidad = false;
    }
    //uint256 blockValue = hashbloque(numerobloque()-1);
    
    
  }
}
