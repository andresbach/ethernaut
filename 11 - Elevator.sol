pragma solidity ^0.4.18;

// reenombro por comodidad. Me tira true si estoy en el ultimo piso. Igual deberia estar implementado en algun lado esa funcion
interface Building {
  function isLastFloor(uint) view public returns (bool);
}


contract Elevator {
    // mmm porque es un booleano el top?
  bool public top;
  uint public floor;

  // cuando se llama publicamente, le mando a que piso quiero ir
  function goTo(uint _floor) public {
  // aca no tiene mucho sentido la parte de que primero Building no toma una address y ademas no esta en ningun lado como funciona isLastFloor
  // crea la variable building que es Building y ya le asigna lo que deberia hacer
    Building building = Building(msg.sender);

    // Si el piso que le indique no es el ultimo
    if (! building.isLastFloor(_floor)) {
    // entonces el piso actual publico se asigna al que le indique (subi?)
      floor = _floor;
      
      top = building.isLastFloor(floor);
    }
  }
}

// para ver la variable que esta publica puedo hacerlo mediante la consola como
await contract.top()
await contract.floor()

// me tengo que generar un building? y ahi pongo la funcion isLastFloor? mmm

pragma solidity ^0.4.18;

interface Ori {
    function goTo(uint _floor) public;
}

contract Building {
    
    address public original;
    bool public blah = true;
    
    function Building(address _original) public {
        original = _original;
    }
    
    function llama(uint _piso) public {
        Ori ori = Ori(original);
        ori.goTo(_piso);
    }
    
  function isLastFloor(uint _piso) view public returns (bool) {
      if(!blah) {
          blah = true;
          return false;
      }
      blah = false;
      return true;
  }
  
}

luego llamo a llama(cualquierNumero) y eso hace que la primera sea falso isLastFloor, pero a la segunda vuelta sea verdero
