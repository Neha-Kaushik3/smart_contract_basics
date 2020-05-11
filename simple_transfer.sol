pragma solidity >=0.5.11 <0.7.0;

contract SendMonenyExample
{
    uint public balanced_recieved;
    
    function receive_money () public payable{                   //This function will store money in the variable balanced_recieved
        balanced_recieved+=msg.value;
    }
    
}