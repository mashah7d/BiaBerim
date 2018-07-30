pragma solidity ^0.4.24;

contract Location{
    uint x;
    uint y;

    constructor(uint _x,uint _y) public{
      x=_x;
      y=_y;
    }
 

    function getX() view public returns(uint) {
        return x; 
    }

    function getY() view public returns(uint) {
        return y; 
    }
    
    function setX(uint _x) public {
        x=_x; 
    }
    
    function setY(uint _y) public {
        y=_y; 
    }
    
    function sqrt(uint x) pure private returns (uint y) {
            uint z = (x + 1) / 2;
        y = x;
        while (z < y) {
            y = z;
            z = (x / z + z) / 2;
        }
    }
    
    function distanceFrom(Location A) view public returns (uint){
        uint distance = sqrt((A.getX()-x)**2+(A.getY()-y)**2);
        return distance;
    }
}