// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

/**
*  函数修改器

*
*/
contract FunctionModefierEP7 {

    modifier OnlyLessTen(uint v){
        require(v<10,"Value must be less than 10");
        _;
    }

    bool isLocked;

    modifier CheckedLocked(){
        require( !isLocked,"Locked");
        isLocked = true;
        _;
        isLocked= false;
    }

    address owner;

    modifier isOwner(){
        require(msg.sender == owner,"Persission denied!");
        _;
    }    
    function test(uint a) public OnlyLessTen(a) pure returns (uint){

     return a;    
    }

    function test1() public CheckedLocked() returns (uint){

        return 1;
    }

    function test2 (uint b) public view  isOwner() returns(uint){
        return b;
    }
 }