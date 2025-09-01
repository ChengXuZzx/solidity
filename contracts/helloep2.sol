// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract hello2{

    function add(uint a,uint b) pure public returns (uint){
        return a+b;
    }

    function sub(uint a,uint b) pure public returns (uint){
        return a-b;
    }

    function mul(uint a,uint b) pure public returns (uint){
        return a *b;
    }

    function div(uint a,uint b) pure public returns (uint){
        return a /b ;
    }

    function val(uint a,uint b,uint c) pure public returns (uint,uint,uint){
        return (a,b,c);
    }

    function getName() public pure returns(string memory){
        return _getName();
    }

    function _getName() private pure returns(string memory) {
        return "hello solidity";
    }

}