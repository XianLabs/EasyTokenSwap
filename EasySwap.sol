// ----------------------------------------------------------------------------
// COPYRIGHT CHIMERA DIGITAL INCORPOATED 2020
// ANY UNAUTHORIZED COPYING, USAGE, OR DISTRUBUTION IS PROHIBTED BY LAW
// AUTHOR: ALEX MICHAEL SCHWARZ
//--------------------------------------------------------------------------
pragma solidity ^0.5.17;

contract ERC20 {
    function totalSupply() public view returns (uint);
    function balanceOf(address tokenOwner) public view returns (uint balance);
    function allowance(address tokenOwner, address spender) public view returns (uint remaining);
    function transfer(address to, uint tokens) public returns (bool success);
    function approve(address spender, uint tokens) public returns (bool success);
    function transferFrom(address from, address to, uint tokens) public returns (bool success);
    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
}

// ----------------------------------------------------------------------------
// Safe Math Library 
// ----------------------------------------------------------------------------
contract SafeMath {
    function safeAdd(uint a, uint b) public pure returns (uint c) {
        c = a + b;
        require(c >= a);
    }
    function safeSub(uint a, uint b) public pure returns (uint c) {
        require(b <= a); c = a - b; } function safeMul(uint a, uint b) public pure returns (uint c) { c = a * b; require(a == 0 || c / a == b); } function safeDiv(uint a, uint b) public pure returns (uint c) { require(b > 0);
        c = a / b;
    }
}

contract EasySwap is SafeMath {
    
  address tracker_0x_address = address(0x0037737ad7e32ed440c312910cfc4a2e4d52867caf); // CMRA Address
  
  mapping ( address => uint256 ) public balances;
  mapping ( uint256 => address ) public holders;
  mapping (uint256 => uint256) public holderDeposits;
  
  uint256 holderCount = 0;
  
  function deposit(uint tokens) public {

    // add the deposited tokens into existing balance 
    balances[address(this)] = safeAdd(balances[address(this)], tokens);
    balances[msg.sender] = safeSub(balances[address(this)], tokens);
    holders[holderCount] = address(msg.sender);
    holderDeposits[holderCount] = tokens;
    holderCount += 1;
    
  }
  
    function () external payable { //send back any eth someone sends to this
        revert () ; 
    }  

    function transferOutERC20Token(address _tokenAddress, uint256 _tokens) public onlyOwner returns (bool success) { //send any ERC20 tokens other than CMRA people send to the contract so they can be returned
        require(msg.sender == address(0x4428E12154A97f19a318d7EbcfE526aF5e6b72Ee), "Must withdraw ERC-20 tokens only from the controller address");
        return ERC20Interface(_tokenAddress).transfer(owner, _tokens);
    }  
}
