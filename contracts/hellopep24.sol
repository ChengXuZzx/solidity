// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract HashSection {

    function test(string memory a,string memory b) public pure  returns (bytes32){
        return keccak256(abi.encodePacked(a,b));
    }
    
}