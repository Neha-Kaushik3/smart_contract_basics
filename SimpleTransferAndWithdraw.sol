pragma solidity >=0.5.11 <0.7.0;

contract SendMonenyExample{
    uint public balanced_recieved;
    //payable is keyword that enable the address/variable in order to recieve money
    function receive_money () public payable{                   //This function will store money in the variable balanced_recieved
        balanced_recieved+=msg.value;
    }
    
    function get_balance () public view returns(uint256){
        return address(this).balance;
    }
    
    //function to transfer money to the one who is calling the function
    function Withdarw_money() public {
        address payable _to = msg.sender;
        _to.transfer(this.get_balance());
    }
    //function to transfer to a arbitary address
    function WithdrawMoneyTO (address payable to) public {
        to.transfer(this.get_balance());
    }
} 