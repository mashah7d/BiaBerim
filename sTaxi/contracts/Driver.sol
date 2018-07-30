pragma solidity ^0.4.24;

import "./Location.sol";

contract Driver{
    uint private id;
    string private name;
    string private plateNumber;
    string private mobileNumber;
    uint private rateValue;
    uint private numRates; 
    Location private location;
    Location temp;
    uint x;
    uint y;
    bool isFree = true;
    

    constructor(string _name, string _plateNumber, string _mobileNumber,uint x, uint y, uint _id) public{
        temp.setX(x);
        temp.setY(y);
        name = _name;
        plateNumber = _plateNumber;
        mobileNumber = _mobileNumber;
        location=temp;
        id = _id;
    }

    function rate(uint _rate) public{   
        rateValue= ((numRates * rateValue )+_rate)/(numRates+1);
        numRates++;
    }

    function getRateValue() public returns(uint) {
        return rateValue; 
    }

    function getName() public returns(string) {
        return name; 
    }

    function getPlateNumber() public returns(string) {
        return plateNumber; 
    }

    function getMobileNumber() public returns(string) {
        return mobileNumber; 
    }
    
    function getLocation() public returns(Location) {
        return location; 
    }
    
    function setLocation(uint _x,uint _y) public{
        location=new Location(_x,_y);
    }
    
    function getIsFree() public returns (bool){
        return isFree;
    }
    
    function setIsFree(bool isFree_) public{
        isFree=isFree_;
    }
    
    function toggle() public{
        if(isFree)
            isFree = false;
        else
            isFree = true;
    }
}
