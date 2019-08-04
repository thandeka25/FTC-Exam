pragma solidity ^0.5.0;

//import "openzeppelin-solidity/contracts/ownership/Ownable.sol";
//import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/ownership/Ownable.sol";



contract CoToken is Ownable, ERC20 {
    uint public totsupply;  //current number of tokens available
    uint public tokenBuyPrice_;
    uint public tokenSellPrice_;

    function buyPrice () public view returns(uint) {
        tokenBuyPrice_ = (totsupply * 10**16)  + (2*10**17);
        //tokensupply.add(num);
        return tokenBuyPrice_;
    }

    /** 
    function _integralFunction (uint _quantity) internal returns (uint){
        uint reqBuyPrice = ((_quantity * 10**16)**2)  + (_quantity*2*10**17) //the integral function to calcbuying price required to buy a certain amount of 
        return reqBuyPrice
    } 
    */

    /** 
    function integralBuyPrice (uint _amount) public returns(uint) {
        uint Q0 = totsupply; //token supply before minting
        uint Q1 = totsupply + _amount; //token supply after potential buy
        uint lower_bound = reqBuyPrice(Q0);
        uint upper_bound = reqBuyPrice(Q1);
        tokenBuyPrice_ = upper_bound - lower_bound;
        return tokenBuyPrice_
    }
    */


    function mint (uint256 amount) public payable {
        require(msg.value >= buyPrice()*amount);
        _mint(msg.sender, amount);
        totsupply = totsupply + amount;
    }

    function sellPrice () public view returns (uint) {
        tokenSellPrice_ = (totsupply * 10**16)  + (2*10**17);
        return tokenSellPrice_;
    }

    /**
    function integralSellPrice (uint _amount) public returns(uint) {
        uint Q0 = totsupply; //token supply before selling back to curve
        uint Q1 = totsupply - _amount; //token supply after potential sell
        uint lower_bound = reqBuyPrice(Q0);
        uint upper_bound = reqBuyPrice(Q1);
        tokenSellPrice_ = upper_bound - lower_bound;
        return tokenSellPrice_
    }
     */
    
    function burn(uint _n) payable public {
        require(msg.value >= sellPrice ()*_n);
        //mint(_n);
        totsupply = totsupply - _n;
    }
    
    function destroy () public onlyOwner {
        //require(totsupply[msg.sender] == 100, "owner does not have all the tokens"); //check that the owner is in possession of all the tokens
        selfdestruct(msg.sender);
    }


}