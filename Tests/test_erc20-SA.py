def test_transfer(accounts, SalmonellaAttackToken):
    initial_supply = 1000000
    deployer = accounts[0]
    recipient = accounts[1]

    print("Initial balances:")
    print("Owner Balance:", deployer )
    print("Recipient Balance:", recipient )
    amount = 100

    assert mytoken.transfer(recipient, amount, {'from': deployer})

    assert mytoken.balanceOf(deployer) == initial_supply * 10**18 - amount
    assert mytoken.balanceOf(recipient) == amount
