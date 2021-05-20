const UsingAmlOracle = artifacts.require('UsingAmlOracle');
const Oracle = artifacts.require('Oracle');

module.exports = async (deployer) => {
  await deployer.deploy(UsingAmlOracle, Oracle.address);

  const oracleInstance = await Oracle.deployed();
  await oracleInstance.grantAccessToAddress(UsingAmlOracle.address);
};
