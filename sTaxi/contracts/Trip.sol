import "./Location.sol";
import "./Driver.sol";
import "./Manager.sol";
contract Trip{
    
    
    Location source = new Location(0,0);
    Location destination = new Location(0,0);
    Manager manager;

    //write all trip statuses, check the status in each function carefully
    enum tripStatus{tripRequested,driverArrived,tripEnded,tripCanceldByPassenger}

    uint private tripFee;
    uint public contractValue;
    Driver public driver;
    address public passengerAddress;
    bool private paid=false;
    bool public sendAck = false;
    bool rated=false;
    address public driverAddress;
    constructor(uint _xSource,uint _ySource,uint _xDestination,uint _yDestination) payable {
        manager=new Manager(); 
        source.setX(_xSource);
        source.setY(_ySource);
        destination.setX(_xDestination);
        destination.setY(_yDestination);
        tripFee=sqrt(( _xDestination - _xSource)**2 + (_yDestination - _ySource)**2)* 1 ether;
        passengerAddress=msg.sender;
        driver=findDriver(_xSource,_ySource);
        driverAddress=manager.getDriverAddress(driver);
    } 
    
    function findDriver(uint _xSource,uint _ySource) returns (Driver){
      return (manager.findNearestDriver(_xSource,_ySource));
    }
    
    
    modifier  passengerHasEnoughDeposit()  {
        require(passengerAddress.balance > tripFee,"Not enough Ether provided.");
        _;
    }
    
    
    function sqrt(uint x) private returns (uint y) {
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
    
    
    function () payable {      
        contractValue = this.balance;
        if(contractValue>=tripFee){
            paid=true;
        }else{
            paid=false;
            refund();
        }
    }
    
    function refund() payable{
        suicide(passengerAddress);
    }
    
    
    
  function startTrip() private {
        if(sameLocation(driver.getLocation(), source))    {
            //change the status
        }

    }
    
    
    //complete the passenger request for ending the trip
    function passengerEndTrip(){
        
     refund();
     }   
    
    
    
    
    function rateDriver(uint _rate){
        if(_rate!=0){
            driver.rate(_rate);
        }
            rated=true;
    }
    
    
    
    function endTrip() public {
        
    //we need three requier for endTrip
    //check the timer not to be ended 10 hour for example

 //   require(sameLocation(driver.getLocation(),destination));
   // require(rated);
    suicide(msg.sender);
    
    }
}
