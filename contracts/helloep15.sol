// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Goods{
    string  public  name;
     constructor(string memory _name){
        name=_name;
     }

     function getname() external view returns (string memory){
        return name;
     }
}

contract FactorySectionEP15 {

    Goods[] public  goodsList;

    function makeGoods(string memory name) external   returns (Goods){
       Goods goods =  new Goods(name);
       goodsList.push(goods);
       return goods;
    }
    
    function callGoodsName (uint index) external view returns (string memory){
        if (index<goodsList.length) return goodsList[index].getname();
        return "";
    }

}