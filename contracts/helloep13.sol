// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

interface User {

    function runWork() external returns (bool);

    function getWork() external returns (bool);
    
}


contract ParentClassA is User{
        bool isWork;

    function runWork() external override  returns(bool){
        isWork=true;
        return isWork;
    }

        function getWork() external view  override returns(bool){
        return isWork;
    }

    function test() public  virtual pure returns (string memory){
        
        return "this is parent method!";
    }
}

contract InterfaceAndExternal is ParentClassA{

    function callParent() public pure  returns (string memory){
        return super.test();
    }

    function test() public pure   override  returns(string memory){
        return "this is son!";
    } 

}

