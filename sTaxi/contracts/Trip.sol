import "./Location.sol";
import "./Driver.sol";

contract Trip{
    
    
    Location source = new Location(0,0);
    Location destination = new Location(0,0);
    


    //write all trip statuses, check the status in each function carefully
    enum tripStatus{tripRequested,driverArrived,tripEnded,tripCanceldByPassenger}
    
    uint public tripFee;
    uint public contractValue;
    Driver driver;
    address passengerAddress;
    bool private paid=false;
    bool public sendAck = false;
    bool rated=false;
    constructor(Driver _driver, Location _source, Location _destination,uint _tripFee,address _passengerAddress) payable {
        driver = _driver;
        source.setX(_source.getX());
        source.setY(_source.getY());
        destination.setX(_destination.getX());
        destination.setY(_destination.getY());
        tripFee=_tripFee;
        passengerAddress=_passengerAddress;
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
    
 
    function payFee() passengerHasEnoughDeposit(){
        //passenger accepts to send the money- what shoud we do ?!?
    }
    
     //sendingTripFeeToContract from passenger account
    function () payable {      
        contractValue = this.balance;
        //check that the amount of the payment is equal to the tripFee,else return the money with refund()
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

    require(sameLocation(driver.getLocation(),destination));
   // require(rated);
    suicide(msg.sender);
    
    }
}