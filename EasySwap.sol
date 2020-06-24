// ------------------------------------------------------------------------------------------------
// Author: Alex Schwarz
// Copyright Chimera Digital 2020
// Smart contract allowing users to send tokens to it, keeping track of how much each person sent.
// -------------------------------------------------------------------------------------------------
pragma solidity ^0.5.17;

contract EasySwap {
    
  mapping ( address => uint256 ) public balances;
  mapping ( uint256 => address ) public holders;
  mapping (uint256 => uint256  ) public holderDeposits;
  uint256 holderCount;
    
  function ByteToInt(bytes32 _number) public pure returns (uint256) {
      uint256 number = uint256(_number);
      return number;
  } 

  function deposit(bytes memory data) public payable {

      bytes32 tokendata;
        
      data = msg.data;

      assembly {
          tokendata := mload(add(data, add(32, 36)))
      }
        
      uint256 tokenAmnt = ByteToInt(tokendata);
      balances[msg.sender] += tokenAmnt;
      holders[holderCount] = msg.sender;
      holderDeposits[holderCount] = tokenAmnt;
      holderCount += 1;
  }

   function () external payable {
      deposit(msg.data);
    }  
}
