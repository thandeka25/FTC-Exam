pragma solidity ^0.5.0;

import "openzeppelin-solidity/contracts/ownership/Ownable.sol";
import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";


contract CoToken is Ownable, ERC20 {
    uint256 constant public decimals = 10**18;
    uint public totsupply;

    function buyPrice (uint _tokensupply, uint num) public returns(uint) {
        uint tokenprice = ((_tokensupply /100) + (2/10)) * decimals;
        //tokensupply.add(num);
        return tokenprice;
    }

    function mint (uint256 amount) public {
        _mint(msg.sender, amount);
        totsupply = totsupply + amount;
    }

    function sellPrice (uint _tokensupply) public returns (uint) {
        uint tokenprice = ((_tokensupply /100) + (2/10)) * decimals;
    }
    
    function burn(uint _numtokens, uint _amount) payable public {
        require(msg.value >= buyprice (_amount));
    }


}