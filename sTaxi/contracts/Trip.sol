pragma solidity ^0.4.24;

import "./Location.sol";
import "./Driver.sol";
import "./Manager.sol";
contract Trip{
    
    Location source = new Location(0,0);
    Location destination = new Location(0,0);
    Location newDriverLocation =  new Location(0,0);
    Location newPassengerLocation =  new Location(0,0);
    Manager manager;

    //trip statuses, checkign the status in each function
    enum tripStatus{tripRequested, tripNotStarted, tripStarted, tripEnded, tripCanceldByPassenger}
    tripStatus tripStat = tripStatus.tripRequested;

    uint public tripFee;
    uint public contractValue;
    Driver public driver;
    address public passengerAddress;
    bool public paid=false;
    bool public managerSet=false;
    bool public sendAck = false;
    bool rated=false;
    address public driverAddress;
    
    constructor(uint _xSource,uint _ySource,uint _xDestination,uint _yDestination) public payable {
        source.setX(_xSource);
        source.setY(_ySource);
        destination.setX(_xDestination);
        destination.setY(_yDestination);
        tripFee=sqrt(( _xDestination - _xSource)**2 + (_yDestination - _ySource)**2)* 1 ether;
        passengerAddress=msg.sender;
        // driverAddress = driver.getDriverAddress();
        //findDriver(_xSource,_ySource);
        // driverAddress=manager.getDriverAddress(driver);
    }
    
    function setManager(address mangerAddress) public {
        if(mangerAddress!=0x0){
            manager = Manager(mangerAddress);
            managerSet = true;
            driverAddress = (manager.findNearestDriver(source.getX(),source.getY()));
            driver = Driver(driverAddress);
        }
    }
    
    //Not Used
    function findDriver(uint _xSource,uint _ySource) private returns (address){
        driverAddress = (manager.findNearestDriver(_xSource,_ySource));
        return driverAddress;
    }
    
    //Not Used
    modifier passengerHasEnoughDeposit()  {
        require(passengerAddress.balance > tripFee,"Not enough Ether provided.");
        _;
    }
    
    
    function sqrt(uint x) pure private returns (uint y) {
        uint z = (x + 1) / 2;
        y = x;
        while (z < y) {
            y = z;
            z = (x / z + z) / 2;
        }
    }
   
    function sameLocation(Location a, Location b) private returns (bool){
        if(sqrt((b.getX() - a.getX())**2 + (b.getY() - a.getY())**2) <= 5)
            return true;
        else
            return false;
    }
    
    // function test(){
    //     msg.sender.send(20 ether);
    // }
    
    // function () public payable {
    //     contractValue = this.balance;
    //     if(contractValue>tripFee){
    //         paid=true;
    //     }else{
    //         paid=false;
    //         suicide(passengerAddress);
    //     }
    // }
    
    function payFee() public payable{
        require(msg.sender == passengerAddress);
        contractValue = this.balance;
        
        if(contractValue>tripFee){
            paid=true;
        }else{
            paid=false;
            suicide(passengerAddress);
        }
    }
    
    function startTrip() public payable {
        require(managerSet==true);
        
        if(sameLocation(manager.getDriver(driver).getLocation(), source) && paid)    {
            //changing the status
            tripStat = tripStatus.tripStarted;
            manager.setDriverFreeness(driver, false);
        }

    }
    
    //complete the passenger request for ending the trip
    function passengerCancelTrip() public {
        require(msg.sender == passengerAddress);
        if(tripStat == tripStatus.tripNotStarted || tripStat == tripStatus.tripRequested)
            suicide(passengerAddress);
    }
    
    // function refund() public payable{
    //     if(tripStat == tripStatus.tripNotStarted)
    //         suicide(passengerAddress);
    // }
    
    function rateDriver(uint _rate) public {
        if(_rate!=0){
            driver.rate(_rate);
        }
        rated=true;
    }
    
    function setNewDriverLocation(uint xx, uint yy) public{
        require(msg.sender == driverAddress);
        newDriverLocation = new Location(xx,yy);
    }
    
    function getNewPassengerLocation(uint xx, uint yy) public{
        require(msg.sender == passengerAddress);
        newPassengerLocation = new Location(xx, yy);
    }
    
    modifier validLocationsForEndTrip(){
        // require(sameLocation(newDriverLocation, destination) && sameLocation(newPassengerLocation, destination), "not modified");
        _;
    }
    
    // event testEndTrip(uint a);
    function endTrip() public validLocationsForEndTrip {
        require(msg.sender == driverAddress);
        // require(rated);
        // emit testEndTrip(111);

        tripStat = tripStatus.tripEnded;
        manager.setDriverFreeness(driver, true);
        suicide(msg.sender);
    }
}
