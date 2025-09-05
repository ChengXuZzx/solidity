// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
* create2部署合约
*  
*
*
*
*/
contract Student {
    
    function getName() external pure returns(string memory){
        return "zhangsan";
    }

}

contract Create2ByCreationgCodeEP3 {

    address public student;

    function callStudentName() external view returns (string memory){
        return Student(student).getName();
    }

    function makeStudent(string memory _salt) external  {
        student = address(
            new Student{salt:keccak256(abi.encodePacked(_salt))}()
        );
    }

    function create2Student(string memory _salt) external returns(address tokenAddr){
        bytes32 salt = keccak256(abi.encodePacked(_salt));
        bytes memory bytecode = type(Student).creationCode;
        assembly{
            tokenAddr := create2(0,add(bytecode,32),mload(bytecode),salt)
            if iszero(extcodesize(tokenAddr)){
                revert(0,0)
            }
            sstore(student.slot,tokenAddr)
        }
    }

    function getaddress(string memory _salt) external view returns (address){
        return  address(uint160(uint(keccak256(
            abi.encodePacked(uint8(0xff),address(this),keccak256(abi.encodePacked(_salt)),keccak256(type(Student).creationCode))
        ))));
    }

    function getCreateCode() external pure  returns (bytes memory){
        return type(Student).creationCode;
    }
}