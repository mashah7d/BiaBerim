pragma solidity ^0.4.24;

contract Trip{
    
    struct location{
        uint X;
        uint Y;
    }
    
    struct driver{
        location dloc;
        uint rate;
    }
    
    mapping (address => location) driverLocations;
    
    address passenger;
    uint public fee;
    uint public contractValue;
    bool tripping = false;

    location source;
    location destination;
    
    driver driverInstance;
    
    function Trip(uint sourceX_, uint sourceY_, uint destinationX_, uint destinationY_){
        source.X = sourceX_;
        source.Y = sourceY_;
        destination.X = destinationX_;
        destination.Y = destinationY_;
        passenger = msg.sender;
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
    
    modifier sameStartLocation(){
        require(sqrt((driverInstance.dloc.X - source.X)**2 + (driverInstance.dloc.Y - source.Y)**2) <= 5);
        _;
    }
    
    modifier sameEndLocation(){
        require(sqrt((driverInstance.dloc.X - destination.X)**2 + (driverInstance.dloc.Y - destination.Y)**2) <= 5);
        _;
    }
    
    function calculateFee() returns (bool){
        fee = sqrt((destination.X - source.X)**2 + (destination.Y - source.Y)**2)*1 ether;
        
        if((msg.value > fee))
            return true;
        else
            return false;
    }
    
    bool public sendAck = false;
    function () payable {       //sendingTripFeeToContract from passenger account
        contractValue=this.balance;
    }
    
    function endTrip() public sameEndLocation {
        suicide(msg.sender);
    }
    
    function startTrip() private sameStartLocation{
        tripping = true;
        
    }
}