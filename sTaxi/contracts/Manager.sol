pragma solidity ^0.4.24;

import './Driver.sol';
import './Trip.sol';

contract Manager{ 
    
    mapping (address => Driver) public drivers;
    mapping (uint => address) public driverAddressFinder;
    uint public driverCounter=0;
    event newDriver(uint a);
    
    function driverSignUp(string _name, string _plateNumber, string _mobileNumber,uint _x,uint _y) public{
        Driver driver = new Driver(_name, _plateNumber, _mobileNumber, _x, _y, driverCounter);
        emit newDriver(1000);

        addDriver(msg.sender, driver);
    }
    
    function addDriver(address _driverAddress,Driver _driver) private {
        drivers[_driverAddress] = _driver;
        driverAddressFinder[driverCounter] = _driverAddress;
        
        driverCounter++;
    }
  
  
    function sqrt(uint x) private pure returns (uint y) {
        uint z = (x + 1) / 2;
        y = x;
        while (z < y) {
            y = z;
            z = (x / z + z) / 2;
        }
    }
  
    function changeDriverFreeStatus() public{
        for(uint i=0; i<driverCounter; i++){
            if(driverAddressFinder[i] == msg.sender){
                drivers[driverAddressFinder[i]].toggle();
            }
        }
    }
    
    event findNearestDriverLog(uint driverNum, address driverAddress);
    event logDistanceFrom(uint a);

    //Ali ino bezan :), Sina zadamesh:)
    function findNearestDriver(uint _xSource,uint _ySource) public returns (address){
        //Write the code to iterate all drivers and calculate their distance from source 
        Location source = new Location(_xSource, _ySource);
        uint temp=1000000;
        uint driverNum=2;
        for(uint i=0; i<2; i++){
            
            if(drivers[driverAddressFinder[i]].getLocation().distanceFrom(source) < temp && drivers[driverAddressFinder[i]].getIsFree()){
                temp=drivers[driverAddressFinder[i]].getLocation().distanceFrom(source);
                        emit logDistanceFrom(driverCounter);

                driverNum=i;
            }
        }
        emit findNearestDriverLog(driverNum, driverAddressFinder[driverNum]);                                                                                                              
        return driverAddressFinder[driverNum];
    }
    
    // function getDriverAddress(Driver driver) returns (address){
    //     //Write the code to iterate all drivers and calculate their distance from source 
        
    //     return driverAddressFinder[0];
    // }

}
