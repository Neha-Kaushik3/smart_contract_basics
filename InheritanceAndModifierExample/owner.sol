pragma solidity ^0.6.0;
contract owned{
     address owner;
       constructor() public{
        owner=msg.sender;
       
    }
    modifier Onlyowner{
        require(msg.sender==owner,"you are not allowed");
        _;
    }
}