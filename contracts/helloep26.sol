// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;


interface Proxy {

    function setName(string memory _name)external payable  ;
    function getName()external view returns (string memory); 
    function getBalance() external view  returns (uint256)   ;
    function throwError() external pure;
}


contract User {

    string name;
    receive() external payable { }

    fallback() external payable { 
        
    }


    function setName(string memory _name) external payable  {
        name=_name;
    }
 
    function getName() external view returns (string memory) {
        return name;
    }

        function getBalance() external view returns (uint256) {
        return address(this).balance;
    }

    function throwError() external pure {
        revert("throws a error");
    }
    
}
contract LowLevelCallEP26 {

    address public  addr;

    receive() external payable { }

    fallback() external payable { }
        


    function makeUser()external returns (address){
        addr = address(new User());
        return addr;
    }

    function callSetName(string memory _name)external payable  {
          (bool ok,)=addr.call{value:1 ether}(abi.encodeCall(User.setName,(_name)));
           require(ok,"Call failed");
    }

    function getBalance() external view returns (uint256){
        return address(this).balance;
    }

    function callGetName()external view returns (string memory){
        (bool ok,bytes memory data)=addr.staticcall(abi.encodeCall(User.getName,()));
        require(ok,"Call failed");
        return abi.decode(data, (string));
    }

    function CallGetBalance() external view  returns (uint256) {
      (bool ok,bytes memory data) = addr.staticcall(abi.encodeCall(User.getBalance,()));
      require(ok,"Call failed");
      return abi.decode(data, (uint256));
    }


    function callThrowError() external view  returns (string memory)  {
       (bool ok,bytes memory data) = addr.staticcall(abi.encodeCall(User.throwError,()));
       if (!ok){
            assembly{
                data := add(data,4)
            }
            return abi.decode(data, (string));
       }
       return abi.decode(data, (string));
    }  

     function proxySetName(string memory _name)external payable  {
        return Proxy(addr).setName(_name);
    }


    function proxyGetName()external view returns (string memory){
        return Proxy(addr).getName();
    }

    function proxyGetBalance() external view  returns (uint256) {
        return Proxy(addr).getBalance();
    }

    function ProxyThrowError() external view returns (string memory){
        try Proxy(addr).throwError(){
                return "";
        }catch Error(string memory reson){
            return  reson;
        }
    }


    
}