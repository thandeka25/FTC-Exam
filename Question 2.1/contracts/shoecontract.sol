pragma solidity ^0.5.0;

contract CoShoe {
  struct Shoe {
    address owner;
    string name;
    string image;
    bool sold;
  }

  uint price = 500000000000000000;
  uint shoesSold = 0; //number of shoes sold
  uint allShoes = 0; //number of shoes
  uint initial_supply = 100; //initial number of tokens to be created
  //uint numShoes = 0;
Shoe[] public shoes; //holds all the shoes instances

  //mint 100 tokens at the beginning
  constructor () public {
    for (uint i = 1; i <= initial_supply; i++ ){
      address owner_ = msg.sender;
      string memory name_ = " ";
      string memory image_ = " ";
      bool sold_ = false;

      shoes.push(Shoe(owner_, name_, image_, sold_));
      allShoes = allShoes + 1;

    }
  }

  //count the number of tokens created on deployment using a function
  function viewTokenCount () public view returns(uint) {
    return allShoes;
  }
  function buyShoe  (string  memory _name, string  memory  _image)  public payable {
    require (shoes.length <= 1, "No shoes left."); //there should be at least 1 pair of shoes available
    //require (shoes[1].sold == false, "All shoes have been sold");
    require (price == msg.value, "Value is not equal to the price."); //check to see if the amount being offered is equal to the price
    if (shoesSold < initial_supply){ //check if you havent sold more shoes than the shoes you have
      uint id = shoesSold++;  //index the next unsold shoe
      shoes[id].name = _name;
      shoes[id].image = _image;
      shoes[id].sold = true;
      //shoes.push(Shoe(msg.sender, _name, _image, true)) - 1;
      shoesSold++;    //increase the shoes sold by 1
    }
  }

  function checkPurchases () external view returns(bool[] memory) {
    bool[] memory checkPur;
    for ( uint i=0; i < shoes.length; i++ ) {
      if (shoes[i].owner == msg.sender) {
        checkPur[i] = true;
      }
    }

  }
}

