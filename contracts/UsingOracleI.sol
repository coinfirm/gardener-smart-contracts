pragma solidity ^0.5.0;

interface UsingOracleI {
    function __callback(bytes32 _id, string calldata _value, uint _errorCode) external;

    event DataRequestedFromOracle(bytes32 indexed id, string url);
    event DataReadFromOracle(bytes32 indexed id, string value, uint errorCode);
}
