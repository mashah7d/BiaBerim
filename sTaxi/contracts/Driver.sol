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
    

    constructor(string _name, string _plateNumber, string _mobileNumber,Location _location, uint _id,address _add) public{
      name = _name;
      plateNumber = _plateNumber;
      mobileNumber = _mobileNumber;
      location=_location;
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
    
    
}
