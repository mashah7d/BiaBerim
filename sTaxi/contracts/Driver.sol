pragma solidity ^0.4.24;

contract Driver{

    string private name;
    string private plateNumber;
    string private mobileNumber;
    uint private rateValue;
    uint private numRate; 

    constructor(string _name, string _plateNumber, string _mobileNumber) public{
      name=_name;
      plateNumber=_plateNumber;
      mobileNumber=_mobileNumber;
    }   

    function addDriver(){       //move to manager
        
    }

    function rate(uint _rate) public{   
        rateValue= ((numRate * rateValue )+_rate)/(numRate+1);
        numRate++;
    }

    function generateLocation() private{

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
}