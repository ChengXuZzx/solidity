// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
/**
* storage 永久存储在区块链上面
   memory 内存数据
   calldata 只读而且 也是存在内存中
**
*/
contract DataLocation {
    string name = "localtion";

    function mock(string memory v,uint[] calldata arr) external view returns (string memory,string memory,uint[] calldata){
        string storage _name= name;  //指针指向 只能是 aryy struct mapping
        return (_name,v,arr[0:2]);
    }
}