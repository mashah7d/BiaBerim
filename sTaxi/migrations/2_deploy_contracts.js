//var MainContract = artifacts.require("./MainContract.sol");
var Trip = artifacts.require("./Trip.sol");

module.exports = function(deployer) {
  //deployer.deploy(MainContract);
  deployer.deploy(Trip);
};

