// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract helloep5 {

    uint public  id;

    function setId(uint v) public returns (bool){
        id=v;
        return true;
    }

    function getId() public view returns(uint){
        return id;
    } 

    
}