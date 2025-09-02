// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

library Calc{

    function add(uint a,uint b) internal pure returns (uint){
        return a+b;
    }

    function jianfa(uint a,uint b) internal  pure  returns (uint){
        return a-b;
    }
}

library StrBuild{

    function append(string memory str,string memory str2) internal pure returns (string memory){
        return string(abi.encodePacked(str,str2));
    }
}

library IdsArray{
    function find(uint[] memory ids , uint i) internal  pure   returns (int){
        if (i<ids.length) return int(ids[i]);
        return -1;
    }
}

contract LibrarySectionEP16 {
    using Calc for uint;

    using StrBuild for string;

    using IdsArray for uint[];

    uint[] public ids;

    function push(uint t) external {
        ids.push(t);
    }

    function getValueByIndex(uint index) external view  returns(int){
        return ids.find(index);
    }

    function sample(uint a) external pure returns (uint){
        return Calc.add(a,5);   
    }

    function sample1(uint a) external pure returns (uint){
        return a.add(5);
    }

    function buildStr(string memory str) external pure  returns (string memory){
        return str.append("xc");
    }

    
}