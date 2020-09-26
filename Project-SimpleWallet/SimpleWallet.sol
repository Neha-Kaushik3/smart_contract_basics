pragma solidity ^0.6.1;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/math/SafeMath.sol";

contract Allowance is Ownable{
    using SafeMath for uint;
    event AllowanceChanged(address indexed _forWho,address indexed _bywhom,uint _oldAmount , uint _newAmount);
     
   mapping(address=>uint) allowance; //all initialized to zero ether
   
   function isOwner()internal view returns(bool){           //view cannot modify state of a smartcontract
       return msg.sender==owner();
   }
   function addAllowance(address _who, uint _amount) public onlyOwner{
       emit AllowanceChanged(_who,msg.sender,allowance[_who],_amount);
       allowance[_who]=_amount;
   }
   modifier ownerOrAllowed(uint _amount){
       require(isOwner()||allowance[msg.sender]>=_amount,"you are not allowed");
       _;
   }
   function reduceAllowance(address _who,uint _amount)internal ownerOrAllowed(_amount)
   {
       emit AllowanceChanged(_who, msg.sender, allowance[_who],allowance[_who].sub(_amount));
       allowance[_who]-=_amount;
   }
   /*
    function renounceOwnership() public override onlyOwner
    {
        revert("Can't renounce the ownership");
    }*/
}
contract SharedWAllet is Allowance{
    event MoneySent(address indexed _beneficiray, uint _amount);
    event MoneyReceived(address indexed _from, uint _amount);
    
    function renounceOwnership() public override onlyOwner
    {
        revert("Can't renounce the ownership");
    }
    function withdrawMoney(address payable _to,uint _amount ) public ownerOrAllowed(_amount){
       require(_amount<=address(this).balance,"contract does not have enough money");
       if(!isOwner()){
           reduceAllowance(msg.sender,_amount);
       }
       emit MoneySent(_to,_amount);
        _to.transfer(_amount);
    }
    receive() external payable{
      emit MoneyReceived(msg.sender,msg.value);
    }
    
}