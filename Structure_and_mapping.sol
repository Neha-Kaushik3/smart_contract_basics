pragma solidity^0.6.0;
contract Practice_structure{
    struct Payment{
        uint amount;
        uint timestamp;
    }
    struct Balance{
        uint total_balance;
        uint numpayments;
        mapping(uint=>Payment) Payment_details;
    }
    mapping(address=>Balance) public BalanceRecieved;
    
    function SendMoney() public payable{
        BalanceRecieved[msg.sender].total_balance+=msg.value;
        Payment memory this_payment = Payment(msg.value,now);
        BalanceRecieved[msg.sender].Payment_details[BalanceRecieved[msg.sender].numpayments]=this_payment;
        BalanceRecieved[msg.sender].numpayments++;
    }
    function WithDraw_money(address payable _address,uint _amt) public  {
        require(BalanceRecieved[msg.sender].total_balance>=_amt,"not enough balance");
        BalanceRecieved[msg.sender].total_balance-=_amt;
        _address.transfer(_amt);
    }
    function getbal() public view returns(uint){
        return address(this).balance; 
    }
    
}