// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract TestFirst {
    string public name;

    function setName(string memory _name)external  {
        name=_name;
    }
}

contract TestSecond {

    uint public gender;

    function setGender(uint8 _gender) external {
        gender=_gender;
    }
    
}

contract MultiCallEP29 {

    event log(address indexed addr);

    address[2] public addr;

    function makeTestFirst()external {
       addr[0]=address(new TestFirst());
    }

    function makeTestSecond()external {
        addr[1] = address(new TestSecond());
    }

    function makeCallData(string memory fn,string memory args) external pure returns (bytes memory){
        return abi.encodeWithSignature(fn, args);
    }

        function makeCallData(string memory fn,uint8 args) external pure returns (bytes memory){
        return abi.encodeWithSignature(fn, args);
    }

    function multiRead(bytes[2] memory _calldata) external view returns (string memory name,uint8 gender) {

       (bool ok,bytes memory result) =  addr[0].staticcall(_calldata[0]);

        require(ok, "address[0] faild");

        name = abi.decode(result, (string));

        (bool isok,bytes memory data) =  addr[1].staticcall(_calldata[1]);

        require(isok, "address[1] faild");

        gender = abi.decode(data, (uint8));
    }

    

    // calldata0 ["0xc47f0027000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000000027863000000000000000000000000000000000000000000000000000000000000","0xc871cb8b0000000000000000000000000000000000000000000000000000000000000016"]
    //calldata1 

// statucall ["0x06fdde03000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000000023078000000000000000000000000000000000000000000000000000000000000","0x79caad860000000000000000000000000000000000000000000000000000000000000000"]

    function multiWrite(bytes[2] memory _calldata) external{
        


    }
}