const CoShoe = artifacts.require('CoShoe')

contract('CoShoe', function (accounts) {
  // predefine parameters
  const owner = 'Cool Song'
  const name = 'example.com'
  const image = 'example.com'
  const sold = 'true'
  //const songPrice = web3.utils.toWei('1', 'ether')

  it('should contain zero shoes in the beginning', async function () {
    // fetch instance of SongRegistry contract
    let CoShoeInstance = await CoShoe.deployed()
    // get the number of songs
    let shoeCounter = await CoShoeInstance.getNumberOfSongs()
    // check that there are no songs initially
    assert.equal(shoeCounter, 0, 'initial number not equal to zero')
  })

  it('should add a shoe to the registry', async function () {
    let CoShoeInstance = await CoShoe.deployed()
    // register a song from account 0
    await CoShoeInstance.registerSong(
      owner,
      name,
      image,
      sold,
    )
    // get the number of songs
    let songCounter = await SongRegistryInstance.getNumberOfSongs()
    // check that there is one song available now
    assert.equal(songCounter, 1, 'song was not successfully registered')
    // retrieve the song details
    let song = await SongRegistryInstance.songs(0)
    // check that they match the original song details
    assert.equal(song['owner'], accounts[0], 'owner does not match')
    assert.equal(song['title'], songTitle, 'title does not match')
    assert.equal(song['url'], songUrl, 'url does not match')
    assert.equal(song['price'], songPrice, 'price does not match')
  })

  it('should only return true for buyers', async function () {
    let SongRegistryInstance = await SongRegistry.deployed()
    // call the checkBuyer function from account 0
    let checkBuyer = await SongRegistryInstance.checkBuyer(0, { from: accounts[0] })
    // check that it returns true
    assert.equal(checkBuyer, true, 'Owner is not buyer')
    // call the checkBuyer function from account 1
    checkBuyer = await SongRegistryInstance.checkBuyer(0, { from: accounts[1] })
    // check that it returns false
    assert.equal(checkBuyer, false, 'Account 1 should not be a buyer')
  })

  it('should allow account 1 to buy the song', async function () {
    let SongRegistryInstance = await SongRegistry.deployed()
    // get the initial balance of account 0
    let account0InitialBalance = await web3.eth.getBalance(accounts[0])
    // buy the song from account 1
    await SongRegistryInstance.buySong(0, { from: accounts[1], value: songPrice })
    // call checkBuyer from account 1
    let checkBuyer = await SongRegistryInstance.checkBuyer(0, { from: accounts[1] })
    // check that it returns true
    assert.equal(checkBuyer, true, 'Account 1 should be a buyer')
    // get the new balance of account 0
    let account0NewBalance = await web3.eth.getBalance(accounts[0])
    // check that it has increased by the song price
    assert.equal(account0NewBalance, Number(account0InitialBalance) + Number(songPrice), 'Account 0 was paid by account 1')
  })
})
