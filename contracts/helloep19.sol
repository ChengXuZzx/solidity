// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

/**
*  pay 
**/
contract TransferAndPayableEP19 {

    mapping (address=>uint) public  balances;

    modifier checkedBalance(uint v) {
        require(balances[msg.sender]>v,"out of bounds");
        _;
    }

    receive() external payable { 
        deposit();
    }

    function deposit() public  payable {
        balances[msg.sender]+=msg.value;
    }

    function withdraw(uint v) public checkedBalance(v) {
        balances[msg.sender]-=v;
        payable(msg.sender).transfer(v);
    }
    
}