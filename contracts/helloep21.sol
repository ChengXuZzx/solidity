// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract FallbackFunction {

    event log(string name,bytes data);

    receive() external payable { }

    fallback() external  payable { 
        emit log("fallback",msg.data);
    }
    
}