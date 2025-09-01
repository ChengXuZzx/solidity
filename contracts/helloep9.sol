// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract ArraySectionEP9 {

    uint[] public  list;

    modifier  chekedLength(uint index){
        require(!(index>=list.length),"Data out-of-bounds exception");
        _;
    }

    function add(uint a) public returns (uint[] memory){
        list.push(a);
      return list;
    }

    function del(uint index) public chekedLength(index) returns (uint[] memory){
         for (uint i;i<list.length;i++){
            if (i>=index) {
            list[i]= (i+1)>=list.length?0:list[i+1];
            }
         }
         list.pop();
        return list;
    }

    function len() public view returns (uint){
        return list.length;
    }

    function findVal(uint val) public view returns (int){
        for (uint i;i<list.length;i++){
            if(list[i]==val) return int(i);
               
        }
        return -1;
    }
    
}