// ----------------------------------------------------------------------------
// ERC Token Standard #20 Interface
// https://github.com/ethereum/EIPs/blob/master/EIPS/eip-20-token-standard.md
// Copyright Chimera Digital Incorporated
// Author: Alex Schwarz
// User must Approve transaction this contract using CMRA before transferFrom allows to send to this contract (ERC-20 compliance standard)
// ----------------------------------------------------------------------------
pragma solidity ^0.5.17;

contract ERC20 
{
    function totalSupply() public view returns (uint);
    function balanceOf(address tokenOwner) public view returns (uint balance);
    function allowance(address tokenOwner, address spender) public view returns (uint remaining);
    function transfer(address to, uint tokens) public returns (bool success);
    function approve(address spender, uint tokens) public returns (bool success);
    function transferFrom(address from, address to, uint tokens) public returns (bool success);
    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
}

contract Swap 
{
  address tracker_address = 0x37737ad7E32ED440c312910CFc4A2e4D52867Caf; // Old token Address
  
  mapping ( address => uint256 ) public balances;

  //USER must call approve before deposit() or tx will fail
  function deposit(uint tokens) public {
    
    require(tokens > 0, "Must have more than 0 tokens to swap.");
    
    // add the deposited tokens into existing balance 
    balances[msg.sender]+= tokens;
    // transfer the tokens from the sender to this contract using CMRA contract transferFrom
    ERC20(tracker_address).transferFrom(msg.sender, address(this), tokens);
  }
  
   function () external payable { //Send any ether back if it's accidentally sent here.
        revert();
    }    
}
