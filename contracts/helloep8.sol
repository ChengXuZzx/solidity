// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract GlobleVars{

    function test() public view returns (uint,uint,address,uint,uint,uint){
        return (block.number,block.timestamp,block.coinbase,block.chainid,block.gaslimit,block.basefee);
    }

    function echo(uint a ) public  view returns (uint,bytes4,address,bytes memory,uint){
        return (a,msg.sig,msg.sender,msg.data,gasleft());
    }

    function echo1(uint b ) public  view returns (uint,address,address){
        return (b,msg.sender,tx.origin);
    }

 }