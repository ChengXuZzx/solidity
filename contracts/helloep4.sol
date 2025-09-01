
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract helloep4{

    event Dump(uint n);

    function test(uint a) public  returns (uint){
        for(uint i;i<10;i++){
            emit Dump(i);
        }
        return a;
    }

    function test1(uint b) public  returns (uint){
        uint i ;
        while(i<b){
            emit Dump(i++);
        }
        return b;
    }

}