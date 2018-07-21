pragma solidity ^0.4.24;

contract Manager{
    mapping (address => Driver) public drivers;
    uint driverCounter=0;
    
    function driverSignUp(string _name, string _plateNumber, string _mobileNumber) public{
        addDriver(msg.sender);
    }
    
    function addDriver(address temp) private{
        Driver tempDriver = new Driver("sas", "41s166iran66", "09121111111", driverCounter);
        drivers[temp] = tempDriver;
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
    
    function tripRequest(Location source, Location destination) returns (uint){
        return sqrt((destination.getX() - source.getX())**2 + (destination.getY() - source.getY())**2)*1 ether;
        
    }
    
    function startNewTrip(Location source){
        findNearestDriver(source);
    }
    
    function findNearestDriver(Location source){
        
    }
}

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
    
    function setX(uint x_) public {
        x=x_; 
    }
    
    function setY(uint y_) public {
        y=y_; 
    }
}

contract Driver{
    uint private driverId;
    string private name;
    string private plateNumber;
    string private mobileNumber;
    uint private rateValue;
    uint private numRate; 
    Location dloc;

    constructor(string _name, string _plateNumber, string _mobileNumber, uint driverId_) public{
      name = _name;
      plateNumber = _plateNumber;
      mobileNumber = _mobileNumber;
      driverId = driverId_;
    }

    function rate(uint _rate) public{   
        rateValue= ((numRate * rateValue )+_rate)/(numRate+1);
        numRate++;
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
        return dloc; 
    }
}

contract Trip{
    
    Location source = new Location();
    Location destination = new Location();
    
    
    
    // mapping (address => location) driverLocations;
    
    address passenger;
    uint public fee;
    uint public contractValue;
    bool tripping = false;
    Driver driverInstance;
    constructor(Driver _driverInstance, uint _sourceX, uint sourceY_, uint destinationX_, uint destinationY_)payable{
        driverInstance = _driverInstance;
        source.setX(_sourceX);
        source.setY(sourceY_);
        destination.setX(destinationX_);
        destination.setY(destinationY_);
        //passenger = msg.sender;
    }
    
    function sqrt(uint x) private returns (uint y) {
        uint z = (x + 1) / 2;
        y = x;
        while (z < y) {
            y = z;
            z = (x / z + z) / 2;
        }
    }
    
    modifier passengerHasEnoughDeposit(){
        require(msg.value > fee,"Not enough Ether provided.");
        _;
    }
    
    function sameLocation(Location a, Location b) private returns (bool){
        if(sqrt((b.getX() - a.getX())**2 + (b.getY() - a.getY())**2) <= 5)
            return true;
        else
            return false;
    }
    
    // modifier sameStartLocation(){
    //     require(sqrt((driverInstance.getLocation().getX() - source.getX())**2 + (driverInstance.getLocation().getY() - source.getY())**2) <= 5);
    //     _;
    // }
    
    // modifier sameEndLocation(){
    //     require(sqrt((driverInstance.getLocation().getX() - destination.getX())**2 + (driverInstance.getLocation().getY() - destination.getY())**2) <= 5);
    //     _;
    // }
    
    // function calculateFee() returns (bool){
    //     fee = sqrt((destination.getX() - source.getX())**2 + (destination.getY() - source.getY())**2)*1 ether;
        
    //     if((msg.value > fee))
    //         return true;
    //     else
    //         return false;
    // }
    
    bool public sendAck = false;
    function () payable {       //sendingTripFeeToContract from passenger account
        contractValue = this.balance;
    }
    
    function startTrip() private {
        if(sameLocation(driverInstance.getLocation(), source))    
            tripping = true;
    }
    
    function endTrip() public {
        suicide(msg.sender);
    }
}