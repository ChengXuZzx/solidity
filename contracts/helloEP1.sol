// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract hello1 {
    int public  key= -1 ;

    uint public id =1 ;

    string public name ="hell0";

    bool public isActive = false;

    mapping(uint => bool) blocked;

    struct User{
        string name;
        string sex;
        uint age;
    }

    bytes public data;

    

    
}
