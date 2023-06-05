def test_mytoken_deploy(accounts, MyToken):
    initial_supply = 1000000 
    deployer = accounts[0]
    mytoken = MyToken.deploy(initial_supply, {'from': deployer})

    assert mytoken.totalSupply() == initial_supply * 10**18
    assert mytoken.balanceOf(deployer) == initial_supply * 10**18
    assert mytoken.name() == "MyToken"
    assert mytoken.symbol() == "MTK"
