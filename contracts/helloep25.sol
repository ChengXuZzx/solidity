// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract ABIEncoderEP25 {

    /**
    *
    *
    *abi.encode(...bytes memtory) bytes memory;
    *  
    *
    *
    */

    // function encode(uint a,string memory b) public pure returns (bytes memory) {
    //     return abi.encode(a,b);
    // }

    // function decode(bytes memory v) public pure returns (uint ,string memory ) {
    //     (uint a,string memory b) = abi.decode(v,(uint,string));
    //     return (a,b);
    // }  

    // function encodeSign() public pure returns (bytes memory) {
    //     return abi.encodeWithSignature("encode(uint256,string)",1,"hello");
    // }

    uint x = 10;
    address  addr  = 0xd457540c3f08f7F759206B5eA9a4cBa321dE60DC;
    string name="0xAA";
    uint[2] array = [5,6];

    function encode() external view  returns (bytes memory){
        return  abi.encode(x, addr,name,array);
    }

    function encodePackaged() public view  returns (bytes memory){
        return abi.encodePacked(x,addr,name,array);
    }

        //函数签名加密abi.encodeWithSignature(函数名称（传参类型）, 参数)
    function encodeSignature() public  view returns(bytes memory){
        return abi.encodeWithSignature("foo(uint256,address,string,uint256[2])",x,addr,name,array);
    }

    function encodeSelector() public view returns (bytes memory){
        return abi.encodeWithSelector(bytes4(keccak256("foo(uint256,address,string,uint256[2])")), x,addr,name,array);
    }

    function decode(bytes memory v) public pure  returns ( uint,address,string memory,uint[2] memory){
        return abi.decode(v, (uint,address,string,uint[2]));
    }
   
}