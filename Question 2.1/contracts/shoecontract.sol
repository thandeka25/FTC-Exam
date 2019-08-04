pragma solidity ^0.5.0;

contract CoShoe {
  struct Shoe {
    address owner;
    string name;
    string image;
    bool sold;
  }

  uint price = 500000000000000000;
  uint shoesSold = 0;
  uint allShoes = 0;
  uint initial_supply = 100; //initial number of tokens to be created;
  //uint numShoes = 0;

  //mint 100 tokebs at the beginning
  constructor () public {
    _mint(msg.sender, initial_supply)
  }

  Shoe [] public shoes;
  
  constructor public {
    shoes.push(Shoe(msg.sender, " ", " ", false));
    allShoes = allShoes + 1;
  }
  
  function buyShoe payable external (string _name, string _image) {
    require (shoes.length <= 1, "No shoes left."); //there should be at least 1 pair of shoes available
    //require (shoes[1].sold == false, "All shoes have been sold");
    require (price == msg.value, "Value is not equal to the price."); //check to see if the amount being offered is equal to the price
    if (shoesSold < initial_supply){ //check if you havent sold more shoes than the shoes you have
      id = shoesSold++  //index the next unsold shoe
      shoes[id].name = _name;
      shoes[id].image = _image;
      shoes[id].sold = true;
      //shoes.push(Shoe(msg.sender, _name, _image, true)) - 1;
      shoesSold++;    //increase the shoes sold by 1
    }
  
  }

  function checkPurchases external view returns(bool [] memory) {
    bool [] memory checkPur;
    for (uint i < shoe.length; i=0; i++ ) {
      if (shoes[i].owner == msg.sender) {
        checkPur[i] = true;
      }
    }

  } 

}

