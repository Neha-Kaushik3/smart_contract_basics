pragma solidity ^0.6.0;
import"./owner.sol";
contract InheritanceModifierExample is owned{
    mapping (address=>uint) public TokenBalance;
   
    uint tokenPrice = 1 ether;
    constructor() public{
        
        TokenBalance[owner]=100; //100 tokens are credited in owners account
    }
  
    function Creatnewtoken() public Onlyowner{
      
       TokenBalance[owner]++;
    }
       function Destroytoken() public Onlyowner{
       
       TokenBalance[owner]--;
    }
    function PurchaseToken() public payable{
        require((TokenBalance[owner]*tokenPrice)/msg.value > 0,"not enough token"); 
        TokenBalance[owner]-=msg.value/tokenPrice;
        TokenBalance[msg.sender]+=msg.value/tokenPrice;
        
    }
    function Sendtoken(address _to, uint _numberOftoken) public{
        require(TokenBalance[msg.sender]>=_numberOftoken,"not enough tokens");
        assert(TokenBalance[_to]+_numberOftoken>TokenBalance[_to]); //avoiding rolling over of integers
        assert(TokenBalance[msg.sender]- _numberOftoken<=TokenBalance[msg.sender]);
        TokenBalance[msg.sender]-=_numberOftoken;
        TokenBalance[_to]+=_numberOftoken;
    }
}