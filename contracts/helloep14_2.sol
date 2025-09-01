// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract ParentClass {

    uint public  parentId;

    string parentName;

    constructor(uint _id,string memory _parentName){
        parentId=_id;
        parentName=_parentName;
    }

    function getParentId() public view returns (uint){
        return parentId;
    }

    function getParentName() public view returns (string memory){
        return parentName;
    }
    
}


contract childClass is ParentClass {
    uint   childId;

    string childName;

    constructor(uint _id,string memory _name) ParentClass(1,"parent::name") { 
        childId=_id;
        childName=_name;
    }

    function getChildId() public view returns (uint){
        return childId;
    }

    function getChildName() public view returns (string memory){
        return childName;
    }
    
}