// ----------------------------------------------------------------------------
// ERC Token Standard #20 Interface
// https://github.com/ethereum/EIPs/blob/master/EIPS/eip-20-token-standard.md
// ----------------------------------------------------------------------------
pragma solidity ^0.5.17;

contract EasySwap {
    
  mapping ( address => uint256 ) public balances;
  mapping ( uint256 => address ) public holders;
  mapping (uint256 => uint256  ) public holderDeposits;
  uint256 holderCount;


    function sliceUint(bytes memory bs, uint start) public pure returns (uint)
    {
        require(bs.length >= start + 32, "slicing out of range");
        uint256 x;
        assembly {
            x := mload(add(bs, add(0x20, start)))
        }
        return x;
    }    
    
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
