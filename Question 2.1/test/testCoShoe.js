const CoShoe = artifacts.require('CoShoe.sol')

contract('CoShoe', function (accounts) {
  // predefine parameters
  const Footowner = accounts[0];
  const random_address = accounts[1];
  const eg_image = "theimage.com";
  
  const validateShoe = {
    name: '',
    image: '',
    sold: false,
    price: 1
  }

  //const songPrice = web3.utils.toWei('1', 'ether')

  //start off without any shoes
  let num_shoes = 0;
  let prize = 1;

  /** 
  it('should contain zero shoes in the beginning', async function () {
    // fetch instance of SongRegistry contract
    //let CoShoeInstance = await CoShoe.deployed()
    // get the number of songs
    //let shoeCounter = await CoShoeInstance.getNumberOfSongs()
    // check that there are no songs initially
    //assert.equal(shoeCounter, 0, 'initial number not equal to zero')
  }) */

  context ("Buy Another Shoe", function () {
  it('transfers ownership correctly', async function () => {
    let CoShoeInstance = await CoShoe.deployed()
    // register a song from account 0
    await CoShoeInstance.buyShoe(validShoe.name, validShoe.image, {
      from: shoeOwner
    })
    // retrieve the shoes details
    let shoe = await CoShoeInstance.shoes()
  
    // check that they match the original shoe details
    assert.equal(shoe['owner'], shoeOwner, 'owner does not match')
    assert.equal(shoe['name'], validShoe.name, 'name does not match')
    assert.equal(shoe['image'], validShoe.image, 'image url does not match')
    assert.equal(shoe.sold, false, 'no change in status')
    assert.equal(validShoe.price, price, "Insufficient funds")
    num_shoes += 1;
    console.log(num_shoes)
  })

  it('should return the correct number of trues', async () => {
    let CoShoeInstance = await CoShoe.deployed()
    // call the checkPur function 
    let checkPurchase = await CoShoeInstance.checkPur()
 
  })


})
