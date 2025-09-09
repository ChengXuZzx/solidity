// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ERC20Metadata {
    
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


contract TimeLockEP33 {

    // token=>tokenOwner=>[amout,expire]
    mapping(address=>mapping (address=>uint[2])) lockAttr; 
    event locaked(address tokenAddr,address msgSender,uint amount,uint expireAt);
    event Withdraw(address tokenAddr,address msgSender,uint amount,uint timeAt);

    function lock( address tokenAddr,uint amount,uint expireAt) external {
        require(expireAt>block.timestamp,"expireAt must be greater than current timestamp");
        require(expireAt>=lockAttr[tokenAddr][msg.sender][1], "expire is invalid");
        bool ok = ERC20Metadata(tokenAddr).transferFrom(msg.sender,address(this),amount);
        require(ok,"transferFrom failed");
        lockAttr[tokenAddr][msg.sender][0] += amount;
         expireAt > lockAttr[tokenAddr][msg.sender][1]?expireAt:lockAttr[tokenAddr][msg.sender][1];
         emit locaked(tokenAddr,msg.sender,amount,expireAt);
    }

    function getExpire(address tokenAddr,address tokenOwner) external view returns(uint){
            return lockAttr[tokenAddr][tokenOwner][1]>block.timestamp?lockAttr[tokenAddr][tokenOwner][0]:0;
    }

    function getAmount(address tokenAddr,address tokenOwner) external view   returns (uint){
            return lockAttr[tokenAddr][tokenOwner][0];
    }

    function withdraw(address tokenAddr)external {
        require(lockAttr[tokenAddr][msg.sender][0]>0,"out of token");
        require(lockAttr[tokenAddr][msg.sender][1]<=block.timestamp,"not expire");
        bool ok = ERC20Metadata(tokenAddr).transfer(msg.sender,lockAttr[tokenAddr][msg.sender][0]);
        uint amount = lockAttr[tokenAddr][msg.sender][0];
        require(ok,"transfer failed");
        lockAttr[tokenAddr][msg.sender][0] = 0;
        emit Withdraw(tokenAddr,msg.sender,amount,block.timestamp);
    }

    function getTime() external view  returns (uint){
        return block.timestamp + 120;
    }
    
}