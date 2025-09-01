// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract StructDemo{

    struct Student{
     //   uint id;
        string name;
        uint8 gender;
        uint8 age;
        uint createdAt;
    }

    Student[] students;

    modifier checkedArrayOutOfBounds(uint index){
        require(!(index>students.length),"Data out-of-bounds exception");
        _;
    }

    function add(Student memory item)public returns (Student memory){
        students.push(item);
        return item;

    }

    function editName(uint index, string memory name)public checkedArrayOutOfBounds(index) returns (Student memory){
        students[index].name = name;
        return students[index];
    }

    function getStudentByIndex(uint index) public view checkedArrayOutOfBounds(index)  returns (Student memory){

    }

    function remove(uint index) public checkedArrayOutOfBounds(index) returns (Student[] memory){
        Student memory temp;
        for (uint i;i<students.length;i++){
            if (i>=index){
                students[i]= (i+1)>=students.length?temp:students[i+1];
            }
        }
        students.pop();
        return students;
    }


}