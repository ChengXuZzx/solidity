// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IMyLogic {
    function getValue() external view returns (uint256);
    function setValue(uint256 val) external;
    function greet() external pure returns (string memory);
}

contract MyLogicV1 {
    uint256 public value;

    function setValue(uint256 val) external {
        value = val;
    }

    function getValue() external view returns (uint256) {
        return value;
    }

    function greet() external pure returns (string memory) {
        return "Hello from V1";
    }
}

contract Proxy {
    address public implementation;
    address public owner;

    receive() external payable { }

    constructor(address _implementation) {
        implementation = _implementation;
        owner = msg.sender;
    }

    // 升级实现合约
    function upgradeTo(address newImplementation) external {
        require(msg.sender == owner, "Not authorized");
        implementation = newImplementation;
    }

    // 所有调用都转发到实现合约
    fallback() external payable {
        address impl = implementation;
        require(impl != address(0), "No implementation");

        assembly {
            calldatacopy(0, 0, calldatasize())
            let result := delegatecall(gas(), impl, 0, calldatasize(), 0, 0)
            returndatacopy(0, 0, returndatasize())

            switch result
            case 0 { revert(0, returndatasize()) }
            default { return(0, returndatasize()) }
        }
    }
}