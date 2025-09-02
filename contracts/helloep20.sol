// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract EventSectionEP20 {
    
    event Created (address indexed  sender,uint timeAt);

    event tarnsfer(address sender,uint val,uint timeAt);

    event withdraw(address sender,uint val,uint timeAt);

    mapping (address=>uint) public  balance;

    receive() external payable { 
        deposit();
    }

    function Create(uint v) external   returns (uint){
       emit  Created(msg.sender, block.timestamp);
        return v;
    }

    function deposit() public  payable {
        balance[msg.sender]+=msg.value;
        emit tarnsfer(msg.sender, msg.value, block.timestamp);
    }
    
}