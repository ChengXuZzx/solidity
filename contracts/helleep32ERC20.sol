// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20Metadata {

    function name() external view returns (string memory );

    function symbol() external view returns (string memory);

    function decimals() external view returns (uint8) ;//小数点精度

    function totalSupply() external view returns(uint);//总供应量

    function balanceOf(address account) external view returns (uint);//查询余额

    function transfer(address to,uint amout) external returns (bool);//转账

    function allowance(address owner,address spender) external view returns (uint256);//查询授权额度

    function approve(address spender,uint amout) external  returns (bool);//授权

    function transferFrom(address from,address to,uint amout) external returns (bool);

    event Transfer(address indexed owner,address indexed spender,uint value);

    event Approve(address spender,uint amout);
    
}

contract ERC20TokenEP32 is  IERC20Metadata{
    string _name;
    string _symbol;
    uint8 _decimal;
    uint _totalSupply;
    mapping (address=>uint) balances;
    mapping (address=>mapping (address=>uint)) apprvoes;

    constructor(
        string memory _name_,
        string memory _symbol_,
        uint8 _decimal_,
        uint _totalSupply_
    ){
        _name=_name_;
        _symbol=_symbol_;
        _decimal=_decimal_;
        _totalSupply=_totalSupply_;
        balances[msg.sender] += _totalSupply_;
        emit Transfer(address(0), msg.sender, _totalSupply_);
    }

    function name() external override view  returns (string memory ){
        return _name;
    }

    function  symbol() external override view returns (string memory){
        return _symbol;
    }

    function decimals() external override view returns (uint8){
        return _decimal;
    }  

    function totalSupply() external override view returns(uint){
        return _totalSupply;
    }

    function balanceOf(address account) external override view returns (uint){
        return balances[account];
    }

    function transfer(address to,uint amount) external override returns (bool){
        return transferCommon(msg.sender,to,amount);
    }

    function allowance(address owner,address spender) external override view  returns (uint256){
        return apprvoes[owner][spender];
    }

    function approve(address spender,uint amout) external override  returns (bool){
        require(apprvoes[msg.sender][spender]==0,"ERC20: spender was approved");
        apprvoes[msg.sender][spender]=amout;
        emit Approve(spender, amout);
        return true;
    }

    function transferFrom(address from,address to,uint amout) external override returns (bool){
        require(apprvoes[from][msg.sender]>0, "ERC20: out of approval funds");
        apprvoes[from][msg.sender] -= amout;
        return transferCommon(from,to,amout);
    }

    function transferCommon(address from,address to,uint amount) internal returns (bool){
            require(to != address(0), "ERC20: transfer to the zero address");
            require(balances[from] >= amount, "ERC20: insufficient balance");
            balances[from]-=amount;
            balances[to] += amount;
              emit Transfer(from, to, amount);
            return true;
    }

    


}