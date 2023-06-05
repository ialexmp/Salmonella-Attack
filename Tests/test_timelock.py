from brownie import TimeLock, accounts, chain

def test_timelock():
    # Setup accounts
    deployer = accounts[0]
    receiver = accounts[1]

    # Deploy the contract
    timelock = TimeLock.deploy(receiver, {'from': deployer})

    # Initial lockedAmount should be 0
    assert timelock.lockedAmount() == 0

    # Deposit 1 ETH into the contract
    deposit_amount = 10**18  # 1 Ether
    timelock.deposit({'from': deployer, 'value': deposit_amount})
    print("Contract deployed")
    # lockedAmount should be equal to deposit_amount
    assert timelock.lockedAmount() == deposit_amount

    # Try to withdraw before 1 day has passed
    try:
        timelock.withdraw({'from': receiver})
    except Exception as e:
        # This exception is expected, as the funds are still locked
        assert "Lock period not ended yet" in str(e)

    # Fast forward time by 1 day
    chain.sleep(86400)  # 1 day in seconds
    chain.mine()

    # Withdraw the locked funds
    initial_balance = receiver.balance()
    timelock.withdraw({'from': receiver})

    # Check that the receiver's balance increased by the deposit amount
    assert receiver.balance() == initial_balance + deposit_amount

    # Check that withdrawn is set to true
    assert timelock.withdrawn() == True
