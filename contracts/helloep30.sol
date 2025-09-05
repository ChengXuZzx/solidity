// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
*
*   多维数组
*
*/
contract MulitidArrayEP30 {

    function normArray() external pure  returns (uint[][] memory){
        uint[][] memory ids = new uint[][](3);
        for (uint n;n<ids.length;n++){ 
             ids[n]= new uint[](3);
            ids[n][0]=11+n;
            ids[n][1]=22+n;
            ids[n][2]=33+n;
        }
        return ids;
    }

    //uint[2][3] 和其他语言是反的  这个意思是 外层数组长度是3，里层数组长度为2 即[ [0,1],[1，3],[5，6] ] 这种形式！
    function fixedArray() external pure  returns ( uint[2][3] memory v) {
                for (uint n;n<v.length;n++){
            v[n][0]=100+n;
            v[n][1]=200+n;
        }
    }

}