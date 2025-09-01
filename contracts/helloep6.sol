// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract helloep6 {

    error  lessThan10(uint v);

    function test(uint a) public pure returns (uint){
        assert(a<=10);
        return a;
    }

    function test1(uint b) public pure returns (uint){
        if (b>10) revert("Only less 10");
        return b;
    }

    function test2(uint c) public pure returns (uint){
        require(c<=10,"Only less than 10");
        return c;
    }

    function test3 (uint d) public pure returns (uint ){
        if (d>10) revert lessThan10(d);
        return d;
    }
    
}