pragma solidity ^0.5.0;

//import "openzeppelin-solidity/contracts/ownership/Ownable.sol";
//import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/ownership/Ownable.sol";


contract CoToken is Ownable, ERC20 {
    uint public totsupply;
    uint public tokenBuyPrice_;
    uint public tokenSellPrice_;

    function buyPrice () public returns(uint) {
        tokenBuyPrice_ = (totsupply * 10**16)  + (2*10**17);
        //tokensupply.add(num);
        return tokenBuyPrice_;
    }

    function mint (uint256 amount) public payable {
        require(msg.value >= buyPrice()*amount);
        _mint(msg.sender, amount);
        totsupply = totsupply + amount;
    }

    function sellPrice () public returns (uint) {
        tokenSellPrice_ = (totsupply * 10**16)  + (2*10**17);
        return tokenSellPrice_;
    }
    
    function burn(uint _n) payable public {
        require(msg.value >= sellPrice ()*_n);
        //mint(_n);
        totsupply = totsupply - _n;
    }
    
    function destroy () public onlyOwner {
        selfdestruct(msg.sender);
    }


}