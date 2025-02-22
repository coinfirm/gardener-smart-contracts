pragma solidity ^0.5.0;

import "./OracleI.sol";
import "./UsingOracleI.sol";


contract UsingOracle is UsingOracleI {

    OracleI public oracle;

    mapping(bytes32 => bool) pendingRequests;

    constructor(OracleI _oracle) public {
        oracle = _oracle;
    }

    function request(string memory _url) public {
        bytes32 id = oracle.request(_url);
        pendingRequests[id] = true;

        emit DataRequestedFromOracle(id, _url);
    }

    function delayedRequest(string memory _url, uint _delay) public {
        bytes32 id = oracle.delayedRequest(_url, _delay);
        pendingRequests[id] = true;

        emit DataRequestedFromOracle(id, _url);
    }

    function __callback(bytes32 _id, string calldata _value, uint _errorCode) external onlyFromOracle {
        emit DataReadFromOracle(_id, _value, _errorCode);
    }

    modifier onlyFromOracle() {
        require(msg.sender == address(oracle), "Sender address doesn't equal Oracle");
        _;
    }
}
