const CotOKEN = artifacts.require('CoToken');
const Erc20 = artifacts.require("./ERC20.sol");

contract('CoToken', function (accounts) {
  // predefine parameters
  let sellPrice = 0;
  let buyPrice ;
  const totSupply ;
  //const songPrice = web3.utils.toWei('1', 'ether')

  it('should mint the number of tokens to be sold', async function () { 
    let CoTokenInstance = await CoToken.deployed()
    await CoToken.mint(17, {from: tokenOwner});
    let balance = await CoTokenInstance.balanceOf(tokenOwner)
    const totSupply = await CoToken.totsupply();
    console.log(totSupply);
    assert.equal(balance, 17, "The balance is equal");
  },

  it('should burn the number of tokens to be sold', async function () { 
    let CoTokenInstance = await CoToken.deployed()
    await CoToken.burn(5, {from: tokenOwner});
    let balance = await CoTokenInstance.balanceOf(tokenOwner)
    const totSupply = await CoToken.totsupply();
    //show current total supply    
    console.log(totSupply);
    //check if the owners balance is equal to the minted tokens
    assert.equal(balance, 12, "The balance is equal");
 },

  it('should contain zero tokens in the beginning', async function () {
    // fetch instance of CoToken contract
    let CoTokenInstance = await CoToken.deployed()
    // get the number of songs
    let tokenCounter = await CoTokenInstance.getNumberOfSongs()
    // check that there are no songs initially
    assert.equal(shoeCounter, 0, 'initial number not equal to zero')
  }),



})
