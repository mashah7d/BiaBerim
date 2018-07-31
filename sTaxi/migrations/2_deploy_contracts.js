var Driver = artifacts.require("Driver");
var Location = artifacts.require("Location");
var Manager = artifacts.require("Manager");
var Trip = artifacts.require("Trip");

module.exports = function(deployer) {
    deployer.deploy(Location,0,0);
    deployer.deploy(Manager);
    deployer.deploy(Trip,0,0,1,1,);
	deployer.deploy(Driver,"sina","1234","4321",0,0,0);
};