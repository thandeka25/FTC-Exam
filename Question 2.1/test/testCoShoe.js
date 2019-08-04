const CoShoe = artifacts.require('CoShoe')

contract('CoShoe', function (accounts) {
  // predefine parameters
  const Footowner = accounts[0];
  const random_address = accounts[1];
  const eg_image = "theimage.com";
  
  //predefining parameters for our struct
  const validateShoe = {
    name: '',
    image: '',
    sold: false,
    price: 1
  }

  //const songPrice = web3.utils.toWei('1', 'ether')

  //start off without any shoes
  let num_shoes = 0;
  let price = 1;

  /** 
  it('should contain zero shoes in the beginning', async function () {
    // fetch instance of SongRegistry contract
    //let CoShoeInstance = await CoShoe.deployed()
    // get the number of songs
    //let shoeCounter = await CoShoeInstance.getNumberOfSongs()
    // check that there are no songs initially
    //assert.equal(shoeCounter, 0, 'initial number not equal to zero')
  }) */

  it("should mint 100 tokens when contract is deployed", async () => {
    //create an instance of a CoShoe contract
    let CoShoeInstance = await CoShoe.deployed()
    // view the number of tokens deployed
    let token_count = await CoShoeInstance.viewTokenCount()
    //make sure the tokens are equal to 100
    assert.equal(viewTokenCount, 100, 'did not mint 100 tokens on deployment')
  },


  context ("Create a digital twin of the shoe", function () {
  it('transfers ownership correctly', async function ()  {
    //create an instance of a CoShoe contract
    let CoShoeInstance = await CoShoe.deployed()
    // register a song from account 0
    await CoShoeInstance.buyShoe(validateShoe.name, validateShoe.image, {
      from: shoeOwner
    })
    // retrieve the shoes details
    let shoe = await CoShoeInstance.shoes(0)
  
    // check that they match the original shoe details
    assert.equal(shoe['owner'], FootOwner, 'owner does not match')
    assert.equal(shoe['name'], validateShoe.name, 'name does not match')
    assert.equal(shoe['image'], validateShoe.image, 'image url does not match')
    assert.equal(validateShoe.price, price, "Insufficient funds")
    assert.equal(shoe.sold, true, 'no change in status')
    num_shoes += 1
    console.log(num_shoes)
  })

  //check the purchases 
  it('should return the correct number of trues', async () => {
    let CoShoeInstance = await CoShoe.deployed()
    // call the checkPur function 
    let checkPurchase = await CoShoeInstance.checkPurchases()
 
  })


})
