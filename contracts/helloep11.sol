// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract MappingSectionEPqq {

    mapping (uint => address) users;

    mapping (address=> mapping (address=> uint8)) friends;

    function put(uint k,address v) public returns (address){
        users[k] =v;
        return v;
    }

    function remove(uint k) public  returns (bool){

        delete users[k];
        return true;
    }

    function getUserByIndex(uint index) public view returns(address){
        return users[index];
    }
    
    function addFriend(address addr) public returns (bool){
        friends[tx.origin][addr]=2;// 0 deleted 1 pending 2 success
        friends[addr][tx.origin]=1;
        return true;
    }

}