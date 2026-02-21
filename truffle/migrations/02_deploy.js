var contract = artifacts.require("./Lottery.sol");

module.exports = function (deployer) {
  deployer.deploy(contract);
};
