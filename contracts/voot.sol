pragma solidity ^0.4.23;

import "zeppelin-solidity/contracts/token/ERC20/DetailedERC20.sol";
import "zeppelin-solidity/contracts/token/ERC20/StandardToken.sol";
import "zeppelin-solidity/contracts/math/SafeMath.sol";

contract Voot is DetailedERC20, StandardToken {

    address public founderAddress;
    
    event ChangeFounderAddress(uint256 _blockTimeStamp, address indexed _founderAddress);

    constructor
    (
        string  _name,
        string  _symbol,
        uint8   _decimals,
        address _founderAddress
    ) 
    DetailedERC20(_name, _symbol, _decimals)
    public
    {
        require(_founderAddress != address(0));

        totalSupply_ = 1000000 * (10 ** uint256(_decimals));

        founderAddress = _founderAddress;

        _allocation(_founderAddress, totalSupply_);
    }

    modifier onlyFounder() {
        require(msg.sender == founderAddress);
        _;
    }

    function changeFounderAddress(address _founderAddress) onlyFounder public {
        require(_founderAddress != address(0));
        founderAddress = _founderAddress;
        emit ChangeFounderAddress(now, founderAddress);
    }

    function _allocation(address addr, uint256 alloc) internal {
        balances[addr] = balances[addr].add(alloc);
        emit Transfer(address(0), addr, alloc);
    }

}