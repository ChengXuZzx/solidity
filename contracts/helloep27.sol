// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
/**
*  委托调用
*
*
*
*/

contract  Executor {

    string public name;

    function setName(string memory _name) external {
        name= _name;
    }
    
}

contract Executor_1 {

    string public name;

    string public str;

    function setName(string memory _name) external {
        str=_name;
    }
    
}
contract DelegateCallSectionEP27 {

    string public  name_0;

    string public name_1;


    function makeExecutor () external returns (Executor){
        return new Executor();
    }

    function makeExecutor_1 () external returns (Executor_1){
        return new Executor_1();
    }
    
    function setName(address addr,string memory _name) external returns (bool,bytes memory){
        return  addr.delegatecall(abi.encodeWithSignature("setName(string)",_name));
    }
    
}