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
    bool private paid=false;
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
        manager = Manager(mangerAddress);
        driver = Driver(manager.findNearestDriver(source.getX(),source.getY()));
    }
    
    //Not Used
    function findDriver(uint _xSource,uint _ySource) private returns (address){
        driverAddress = (manager.findNearestDriver(_xSource,_ySource));
        return driverAddress;
    }
    
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
   
    function sameLocation(Location a, Location b) view private returns (bool){
        if(sqrt((b.getX() - a.getX())**2 + (b.getY() - a.getY())**2) <= 5)
            return true;
        else
            return false;
    }
    
    // function test(){
    //     msg.sender.send(20 ether);
    // }
    
    function () public payable {
        contractValue = this.balance;
        if(contractValue>=tripFee){
            paid=true;
        }else{
            paid=false;
            refund();
        }
    }
    
    function refund() public payable{
        if(tripStat == tripStatus.tripNotStarted)
            suicide(passengerAddress);
    }
    
    function startTrip() private {
        if(sameLocation(driver.getLocation(), source))    {
            //change the status
            tripStat = tripStatus.tripStarted;
            driver.setIsFree(false);
        }

    }
    
    //complete the passenger request for ending the trip
    function passengerCancelTrip() public {
        if(tripStat == tripStatus.tripNotStarted)
            refund();
    }
    
    function rateDriver(uint _rate) public {
        if(_rate!=0){
            driver.rate(_rate);
        }
        rated=true;
    }
    
    function setNewDriverLocation(uint xx, uint yy) public{
        newDriverLocation = new Location(xx,yy);
    }
    
    function getNewPassengerLocation(uint xx, uint yy) public{
        newPassengerLocation = new Location(xx, yy);
    }
    
    modifier validLocationsForEndTrip(){
        require(sameLocation(newDriverLocation, destination) && sameLocation(newPassengerLocation, destination), "not modified");
        _;
    }
    
    event testEndTrip(uint a);
    function endTrip() public validLocationsForEndTrip {
        // require(msg.sender == driver.getDriverAddress());
        emit testEndTrip(111);

        tripStat = tripStatus.tripEnded;
        // driver.toggle();
        //we need three requirement for endTrip
        //check the timer not to be ended 10 hour for example
        // require(rated);
        suicide(msg.sender);
    }
}
