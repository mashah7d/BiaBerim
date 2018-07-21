pragma solidity ^0.4.24;

contract Location{
	uint x;
	uint y;

	constructor() public{
      x=10;
      y=10;
    }

    function getX() public returns(uint) {
        return x; 
    }

    function getY() public returns(uint) {
        return y; 
    }
}