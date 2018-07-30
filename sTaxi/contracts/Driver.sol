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
    uint x;
    uint y;
    bool isFree = true;
    

    constructor(string _name, string _plateNumber, string _mobileNumber,uint _x, uint _y, uint _id) public{
        name = _name;
        plateNumber = _plateNumber;
        mobileNumber = _mobileNumber;
        location=new Location(_x,_y);
        id = _id;
    }
    event WhatIsThis(address a);
    function getDriverAddress()  public returns (address){
        emit WhatIsThis(this);
        return this;
    }

    function rate(uint _rate) public{   
        rateValue= ((numRates * rateValue )+_rate)/(numRates+1);
        numRates++;
    }

    function getRateValue() view public returns(uint) {
        return rateValue; 
    }

    function getName() view public returns(string) {
        return name; 
    }

    function getPlateNumber() view public returns(string) {
        return plateNumber; 
    }

    function getMobileNumber() view public returns(string) {
        return mobileNumber; 
    }
    
    function getLocation() view public returns(Location) {
        return location; 
    }
    
    function getIsFree() view public returns (bool){
        return isFree;
    }
    
    function setLocation(uint _x,uint _y) public{
        location=new Location(_x,_y);
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
