// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

interface InterfaceDemoA {
    function methodA() external  returns (string memory);
}

interface  InterfaceDemoB {
       function methodB() external  returns (string memory); 
}

contract ParentClass{
    function ParentMethodA() virtual  public  pure returns (string memory){
        return "this is parentMethod";
    }
}


contract classA is InterfaceDemoA , InterfaceDemoB ,ParentClass {

    function methodA() external pure   override returns (string memory){
        return "this override methodA";
    }

        function methodB() external pure   override returns (string memory){
        return "this override methodB";
    }

    function callParent() public pure  returns (string memory){
        return super.ParentMethodA();
    }

    function ParentMethodA () public  pure override returns (string memory){
        return "this is parentMethod override";
    }
}

contract classB is classA{
    function test() public pure returns (string memory)  {
        return super.ParentMethodA();
    }

}