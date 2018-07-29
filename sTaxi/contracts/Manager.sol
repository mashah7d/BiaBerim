pragma solidity ^0.4.24;

import './Driver.sol';
import './Trip.sol';

contract Manager{ 
    
    mapping (address => Driver) public drivers;
    mapping (uint => address) public driverAddressFinder;
    uint public driverCounter=0;

    function driverSignUp(string _name, string _plateNumber, string _mobileNumber,uint _x,uint _y) public{
         Driver driver = new Driver(_name, _plateNumber, _mobileNumber,new Location(_x,_y),driverCounter,msg.sender);
         addDriver(msg.sender,driver);
    }
    
    function addDriver(address _driverAddress,Driver _driver) private {
        drivers[_driverAddress] = _driver;
        driverAddressFinder[driverCounter]=_driverAddress;
        driverCounter++;
    }
  
  
    function sqrt(uint x) private returns (uint y) {
            uint z = (x + 1) / 2;
        y = x;
        while (z < y) {
            y = z;
            z = (x / z + z) / 2;
        }
    }
  
 
    
    //Ali ino bezan :)
    function findNearestDriver(uint _xSource,uint _ySource) returns (Driver){
        //Write the code to iterate all drivers and calculate their distance from source 
        Location source = new Location(_xSource, _ySource);
        uint temp=0;
        for(uint i=1; i<driverCounter; i++){
            if(drivers[driverAddressFinder[i]].getLocation().distanceFrom(source) < drivers[driverAddressFinder[temp]].getLocation().distanceFrom(source))
                temp=i;
        }
        
        return drivers[driverAddressFinder[temp]];
    }
    
    // function getDriverAddress(Driver driver) returns (address){
    //     //Write the code to iterate all drivers and calculate their distance from source 
        
    //     return driverAddressFinder[0];
    // }

}
