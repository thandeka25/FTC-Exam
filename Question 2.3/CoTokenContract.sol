pragma solidity ^0.5.0;

import "openzeppelin-solidity/contracts/ownership/Ownable.sol";
import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";
import "openzeppelin-solidity/contracts/math/SafeMath.sol";
//import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";
//import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/ownership/Ownable.sol";

//import "ERC20.sol";
//import "Ownable.sol";
//import "SafeMath.sol";


contract CoToken is Ownable, ERC20 {
    uint public totsupply;  //current number of tokens available
    uint public tokenBuyPrice_;
    uint public tokenSellPrice_;
    uint public poolBalance; //the eth always available in the contract
    //declare token variables
    string public Name = "CoToken"; //name of token
    string public Symbol = "COT";   //symbol of token
    uint public Decimals = 0;  //number of decimals

    /**
    function buyPrice () public view returns(uint) {
        tokenBuyPrice_ = (totsupply * 10**16) + (2*10**17);
        //tokensupply.add(num);
        return tokenBuyPrice_;
    } */

    /**create an integral function from the curve function given
    the function is internal as it will only be called by other functions */
    function _integralFunction (uint _quantity) internal returns (uint){
        uint reqBuyPrice = ((_quantity * 10**16)**2) + (_quantity*2*10**17); //the integral function
        return reqBuyPrice;
    }

    function integralBuyPrice (uint _n) public returns(uint) {
        uint Q0 = totsupply; //token supply before minting
        uint Q1 = totsupply + _n; //token supply after potential buy
        tokenBuyPrice_ = _integralFunction(Q1) - _integralFunction(Q0);
        return tokenBuyPrice_;
    }

    /**create a function to check how much ether is in the contracts
    the contract will not be able to burn tokens if it does have enough pool balance
    the pool balance increase with every mint
    the pool balance decrease with every burn*/
    function _updatePoolBalance (uint _n) internal returns(uint) {
        poolBalance = _integralFunction(_n);
        return poolBalance;
    }

    /**when minting, check if the amount attached to the transaction is more than the token price
    mint the amount of token to the address calling te function
    increase the total supply
    update the pool balance based on the updated total supply */
    function mint (uint256 _n) public payable {
        require(msg.value >= integralBuyPrice (_n), "Not enough funds");
        _mint(msg.sender, _n);
        totsupply = totsupply + _n;
        poolBalance = _updatePoolBalance(totsupply);
    }

    /**
    function sellPrice () public view returns (uint) {
        tokenSellPrice_ = (totsupply * 10**16) + (2*10**17);
        return tokenSellPrice_;
    } */

    function integralSellPrice (uint _n) public returns(uint) { //_n is the number of tokens requested
        uint Q0 = totsupply; //token supply before selling back to curve
        uint Q1 = totsupply - _n; //token supply after potential sell
        tokenSellPrice_ = _integralFunction(Q1) - _integralFunction(Q0);
        return tokenSellPrice_;
    }

    /**when burning, check that the pool balance is more than the sell price
    the contract must have enough funds to burn the tokens being sold
    decrease total supply and then update pool balance */
    function burn(uint _n) public payable { //_n is the number of tokens requested
        require(poolBalance >= integralSellPrice (_n), "Funds not enugh to buy tokens"); //check if funds in contract are enough to sell
        totsupply = totsupply - _n;
        poolBalance = _updatePoolBalance(totsupply);
    }
    function destroy () public onlyOwner {
        //require(totsupply[msg.sender] == 100, "owner does not have all the tokens"); //check that the owner is in possession of all the tokens
        selfdestruct(msg.sender);
    }


}