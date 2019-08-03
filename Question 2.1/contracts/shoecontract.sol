pragma solidity ^0.5.2;

contract CoShoe {
  struct Shoe {
    address owner;
    string name;
    string image;
    bool sold;
  }

  uint price = 500000000000000000;
  uint shoesSold = 0;

  Shoe [] public shoes;
  
  constructor {
    shoes.push(Shoe(msg.sender, " ", " ", false));
  }
  
  function buyShoe payable external (string _name, string _image) {
    require (shoes.length >= 1, "No shoes left.");
    require (price == msg.value, "Value is not equal to the price.");
    shoes.push(Shoe(msg.sender, _name, _image, true)) - 1;
    shoesSold++;
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
