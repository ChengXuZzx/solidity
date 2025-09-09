// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
/*
*
* 多签名钱包
*
*/

    enum State{
        Pending,
        Approved,
        Rejected
    }

    struct Signer{
        address account;
        State state;
        uint signedAt;
    }

library SignerArray{
   function find(Signer[] storage singers,address addr) internal  view  returns (int){
        for(uint i ;i<singers.length;i++){
            if(singers[i].account==addr){
                return int(i);
            }
        }
        return -1;
    }
}
contract MultiSignEp34 {

    receive() external payable { }
    fallback() external payable { }

    using SignerArray for Signer[];

    struct Transaction{
        uint id;
        string title;
        uint value;
        bytes data;
        address to;
        State state;
        uint[3] timeAt;// approvedAt 交易通过时间,rejectedAt 拒绝时间,created 创建时间,

    }

    uint public txId;

    address[] public owner;

    constructor(address[] memory _owner){
        owner=_owner;
    }

    mapping (uint=>Signer[]) public transactionSigner; //uint 就是 txid 

    Transaction[] transaction;

    event Commit(uint  indexed txId,address indexed creator,string title,uint timeAt);
    event Approved(uint indexed txId,address indexed singer,uint timeAt);
    event Rejected(uint indexed txId,address indexed singer,uint timeAt);
 
    function commit(string memory title,uint value,address to,bytes calldata data) external {
        Transaction memory trx;
        trx.id=txId;
        trx.title = title;
        trx.state=State.Pending;
        trx.to=to;
        trx.timeAt[2] = block.timestamp;
        trx.value=value;
        trx.data=data;
        transaction.push();
        transactionSigner[txId].push(
                Signer({account:msg.sender,
                state:State.Approved,
                signedAt:block.timestamp})
        );
        emit Commit(txId, msg.sender, title, block.timestamp);
    }

    modifier checkBefore(uint _txId){
        require(_txId>0  && _txId<=txId,"transaction id is not exist");
        require(transaction[_txId-1].state == State.Pending, "trx is finished");
        require(transaction[_txId-1].timeAt[0]==0 && transaction[_txId-1].timeAt[1]==0,"trx is finished");
        require(transactionSigner[_txId].find(msg.sender) == -1 , "signer is exist");
        _;
    }

    function approved(uint _txId) external checkBefore(_txId) {
        Transaction memory trans =  transaction[_txId-1];
        transactionSigner[_txId].push(Signer({account:msg.sender,state:State.Approved,signedAt:block.timestamp}));
        if (transactionSigner[_txId].length == owner.length){
            trans.state=State.Approved;
            trans.timeAt[0]=block.timestamp;
            (bool success, ) = address(trans.to).call{value: trans.value}(trans.data);
            require(success, "Transaction failed");
        }

        emit Approved(_txId, msg.sender, block.timestamp);
    }

    function rejected(uint _txId) external checkBefore(_txId) {
       transaction[_txId-1].state=State.Rejected;
        transaction[_txId-1].timeAt[0]=block.timestamp;
        transactionSigner[_txId].push(Signer({account:msg.sender,state:State.Rejected,signedAt:block.timestamp}));
        emit Rejected(txId, msg.sender, block.timestamp);

    }

    function getTransactionList(State state,uint pageNum,uint pageSize) external view returns (Transaction[] memory){
        Transaction[] memory result = new Transaction[](pageSize);
        uint offset=pageNum<=1?0:pageSize*pageNum;
        uint i;
        for (uint n=offset; n<transaction.length;n++){
            if(transaction[n].state == state){
                result[i]=transaction[n];
            }
            if (++i >=pageSize) break ;
        }
        return  result;
    }

}