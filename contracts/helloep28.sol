// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
*
*  签名验证
*  step 1 内容进 kecccak256() bytes32
*  step2 通过当前账户 对step1 结果签名
*  step3 通过（含有签名前缀）ETH哈希 内容+签名结果  还原签名账户address
*   step4 验证签名
*/
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
contract VerifySignedEP28 {

    using ECDSA for bytes32;
    using ECDSA for bytes;

    function msgHash(string memory _msg) public pure returns (bytes32){
        return keccak256(bytes(_msg));
    }

    function signtureHash(bytes32 _hash) public pure  returns (bytes32){
        return keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32",_hash));
    }

    function recoverSinger(bytes32 _ethHash,bytes calldata _sig) public pure returns (address){

        return _ethHash.recover(_sig);
    }

    function verif(string memory _msg,bytes calldata _sig,address signer) public pure returns (bool){
            return recoverSinger(signtureHash(msgHash(_msg)), _sig) == signer;
    }
}