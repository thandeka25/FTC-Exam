pragma solidity ^0.5.0;

//import "openzeppelin-solidity/contracts/ownership/Ownable.sol";
//import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/ownership/Ownable.sol";


contract CoToken is Ownable, ERC20 {
    uint public totsupply;  //current number of tokens available
    uint public tokenBuyPrice_;
    uint public tokenSellPrice_;
    uint public poolBalance; //the eth always available in the contract

    /**
    function buyPrice () public view returns(uint) {
        tokenBuyPrice_ = (totsupply * 10**16) + (2*10**17);
        //tokensupply.add(num);
        return tokenBuyPrice_;
    } */

    function _integralFunction (uint _quantity) internal returns (uint){
        uint reqBuyPrice = ((_quantity * 10**16)**2) + (_quantity*2*10**17); //the integral function
        return reqBuyPrice;
    }

    function integralBuyPrice (uint _amount) public returns(uint) {
        uint Q0 = totsupply; //token supply before minting
        uint Q1 = totsupply + _amount; //token supply after potential buy
        tokenBuyPrice_ = _integralFunction(Q1) - _integralFunction(Q0);
        return tokenBuyPrice_;
    }

    /**create a function to check how much ether is in the contracts
    the contract will not be able to burn tokens if it does have enough pool balance 
    the pool balance increase with every mint
    the pool balance decrease with every burn*/
    function _updatePoolBalance (uint _amount) internal returns(uint) {
        poolBalance = _integralFunction(_amount);
        return poolBalance;
    }

    function mint (uint256 amount) public payable {
        require(msg.value >= tokenBuyPrice_, "Not enough funds");
        _mint(msg.sender, amount);
        totsupply = totsupply + amount;
        poolBalance = _updatePoolBalance(totsupply);
    }

    /**
    function sellPrice () public view returns (uint) {
        tokenSellPrice_ = (totsupply * 10**16) + (2*10**17);
        return tokenSellPrice_;
    } */

    function integralSellPrice (uint _amount) public returns(uint) {
        uint Q0 = totsupply; //token supply before selling back to curve
        uint Q1 = totsupply - _amount; //token supply after potential sell
        tokenSellPrice_ = _integralFunction(Q1) - _integralFunctions(Q0);
        return tokenSellPrice_;
    }

    function burn(uint _n) public payable {
        require(poolBalance >= tokenSellPrice_, "Funds not enugh to buy tokens"); //check if funds in contract are enough to sell
        //mint(_n);
        totsupply = totsupply - _n;
        poolBalance = _updatePoolBalancetotsupply);
    }
    function destroy () public onlyOwner {
        //require(totsupply[msg.sender] == 100, "owner does not have all the tokens"); //check that the owner is in possession of all the tokens
        selfdestruct(msg.sender);
    }


}