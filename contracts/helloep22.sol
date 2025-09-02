// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract SelfDestroySection {

    receive() external payable { }

    // function kill() external {
    //     selfdestruct(payable(msg.sender));
    // }

    function hello() external pure  returns (string memory){
        return "hello world";
    }
    
}