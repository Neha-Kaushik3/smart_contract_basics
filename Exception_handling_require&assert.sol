pragma solidity ^0.6.0;
contract ExceptionalHandling{
    mapping (address=>uint64) public BalanceRecieved;
     
    function recievemoney() public payable{
        assert(BalanceRecieved[msg.sender]+ uint64(msg.value)>=BalanceRecieved[msg.sender]);
        BalanceRecieved[msg.sender]+=uint64(msg.value);
        
    }
    
    function WithdrawMoney(address payable _to, uint _amount) public{
        require(_amount <= BalanceRecieved[msg.sender],"not enough funds");
        assert(BalanceRecieved[msg.sender]>=BalanceRecieved[msg.sender] - _amount);   
            BalanceRecieved[msg.sender] -=uint64(_amount);
            _to.transfer(_amount);
        
    } 
}