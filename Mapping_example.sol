pragma solidity ^0.6.0;
contract STORE{
    mapping(address=>uint) Depository;
    address owner=msg.sender;
    function StoreMoney() public payable{
        Depository[msg.sender]+=msg.value;
    }
    function Show_money() public view returns(uint){
        return address(this).balance;
    }
    function WithdrawTO_owner() public payable {
        require (msg.sender==owner,"you are not the owner");
        msg.sender.transfer(address(this).balance);
    }
    function SendALL(address payable _to) public {
         require (msg.sender==owner,"you are not the owner");
          _to.transfer(address(this).balance);
    }
    function WithdrawAllSaving(address payable requester) public payable {
        require (msg.sender==owner,"you are not the owner");
        uint tosend=Depository[requester];
        Depository[requester]=0;
        requester.transfer(tosend);
    }
    function Withdraw_PartialSaving(address payable requester, uint _Amountrequested) public payable {
        require (msg.sender==owner,"you are not the owner");
      require (_Amountrequested<=Depository[requester],"insufficient saveings");
        Depository[requester]-=_Amountrequested;
        requester.transfer(_Amountrequested);
    }
}