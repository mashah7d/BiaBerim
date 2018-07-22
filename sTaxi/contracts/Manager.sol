pragma solidity ^0.4.24;

import './Driver.sol';
import './Trip.sol';

contract Manager{
    
    mapping (address => Driver) public drivers;
    uint public driverCounter=0;

    function driverSignUp(string _name, string _plateNumber, string _mobileNumber,uint _x,uint _y) public{
         Driver driver = new Driver(_name, _plateNumber, _mobileNumber,new Location(_x,_y),driverCounter);
         addDriver(msg.sender,driver);
    }
    
    function addDriver(address _driverAddress,Driver _driver) private {
        drivers[_driverAddress] = _driver;
        driverCounter++;
    }
  
    
    
    //in chie? behine shavad!!
    function sqrt(uint x) private returns (uint y) {
        uint z = (x + 1) / 2;
        y = x;
        while (z < y) {
            y = z;
            z = (x / z + z) / 2;
        }
    }
    
    //Passenger calls this. so msg.sender would be the passenger address
    function tripRequest(uint _xSource,uint _ySource,uint _xDestination,uint _yDestination) returns (uint){
        uint tripFee= sqrt(( _xDestination - _xSource)**2 + (_yDestination - _ySource)**2)* 1 ether;
        Driver driver=findNearestDriver(new Location(_xSource,_ySource));
        Trip trip=new Trip(driver,new Location(_xSource,_ySource),new Location(_xDestination,_yDestination),tripFee,msg.sender);
        return tripFee;
    }
    
  
   /* 
    function startNewTripOnConfirm(Location source){
        
     findNearestDriver(source);
    }
   */ 
    
    //Ali ino bezan :)
    function findNearestDriver(Location source) returns (Driver){
        //Write the code to iterate all drivers and calculate their distance from source 
        return drivers[0];
    }
}