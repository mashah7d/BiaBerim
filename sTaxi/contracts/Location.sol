pragma solidity ^0.4.24;

contract Location{
    uint x;
    uint y;

    constructor(uint _x,uint _y) public{
      x=_x;
      y=_y;
    }
 

    function getX() public returns(uint) {
        return x; 
    }

    function getY() public returns(uint) {
        return y; 
    }
    
    function setX(uint _x) public {
        x=_x; 
    }
    
    function setY(uint _y) public {
        y=_y; 
    }
}