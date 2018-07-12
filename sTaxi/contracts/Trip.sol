pragma solidity ^0.4.24;

contract Trip{
    struct driver{
        location dloc;
        uint rate;
    }
    
    mapping (address => location) driverLocations;
    
    address passenger;
    uint fee;
    bool tripping = false;
    
    uint sourceX;
    uint sourceY;
    uint destinationX;
    uint destinationY;
    
    struct location{
        uint srcX;
        uint srcY;
    }
    
    function Trip(uint sourceX_, uint sourceY_, uint destinationX_, uint destinationY_){
        sourceX = sourceX_;
        sourceY = sourceY_;
        destinationX = destinationX_;
        destinationY = destinationY_;
        passenger = msg.sender;
    }
    
    uint driverX;
    uint driverY;
    
    function sqrt(uint x) returns (uint y) {
        uint z = (x + 1) / 2;
        y = x;
        while (z < y) {
            y = z;
            z = (x / z + z) / 2;
        }
    }
    
    modifier passengerHasEnoughDeposit(){
        require(msg.value > fee);
        _;
    }
    
    modifier sameLocation(){
        require(sqrt((driverX - sourceX)**2 + (driverY - sourceY)**2) <= 5);
        _;
    }
    
    function calculateFee() private returns (bool){
        fee = sqrt((destinationX - sourceX)**2 + (destinationY - sourceY)**2)*1 ether;
        
        if((msg.value > fee))
            return true;
        else
            return false;
    }
    
    // function tripRequest() private passengerHasEnoughDeposit{
    //     _;
    // }
    
    function startTrip() private sameLocation{
        tripping = true;
        
    }
}
