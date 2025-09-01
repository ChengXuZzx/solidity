// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract EumAndeConstantSectionEP12 {

    enum State{
        Default,
        Pending,
        Fallback,
        Success
    }

    State public state;

    uint8 public id;

    uint public constant GENDER=0;

    function setState(State _state) public returns (State){
        state = _state;
        return state;
    }
    
    function reSet() public returns (State){
        delete state;
        return state;
    }


    function getStateMin() public pure returns (uint8){
        return uint8(type(State).min);
    }

        function getStateMax() public pure returns (uint8){
        return uint8(type(State).max);
    }

}