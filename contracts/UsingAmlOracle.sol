pragma solidity ^0.5.0;

import "./OracleI.sol";
import "./UsingOracleI.sol";

contract UsingAmlOracle is UsingOracleI {
    OracleI public oracle;

    constructor(OracleI _oracle) public {
        oracle = _oracle;
    }

    function request(string calldata _cryptoId, string calldata _address) external {
        string memory query = string(abi.encodePacked("aml(", _cryptoId, ",", _address, ").cscore_section"));
        bytes32 id = oracle.request(query);

        emit DataRequestedFromOracle(id, query);
    }

    function __callback(bytes32 _id, string calldata _value, uint _errorCode) external onlyFromOracle {
        emit DataReadFromOracle(_id, _value, _errorCode);
        // or do something else with data returned from the oracle
    }

    modifier onlyFromOracle() {
        require(msg.sender == address(oracle), "Sender address doesn't equal Oracle");
        _;
    }
}
