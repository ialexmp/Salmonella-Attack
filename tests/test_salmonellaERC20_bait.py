import pytest

def test_transfer(SalmonellaAttackToken, accounts):
    
    initial_supply = 10000000
    deployer = accounts[0] # Miner account --> 0x0063046686E46Dc6F15918b61AE2B121458534a5 / Salmonella Not Applied
    # deployer = accounts[1] # Other Account --> Salmonella will be Applied
    recipient = accounts[1]
    SA_Token = SalmonellaAttackToken.deploy(initial_supply,{'from':deployer})
   
    #print(f"Deployer's address: {deployer.address}")
    
    assert SA_Token.totalSupply() == initial_supply * 10**18
    assert SA_Token.balanceOf(deployer) == initial_supply * 10**18
    assert SA_Token.name() == "SalmonellaAttackToken"
    assert SA_Token.symbol() == "SAT"
    
    # Get the initial balances
    owner_balance = SA_Token.balanceOf(deployer)
    recipient_balance = SA_Token.balanceOf(recipient)
    print("\n |---------------------- TEST RESULTS: ----------------------| ") 
    print("\n Balances before Transaction: \n") 
    print("   Sender:", owner_balance / 10**18, " (eth)" )
    print("   Recipient:", recipient_balance / 10**18, " (eth)")

    # Perform the transfer
    amount = 100 
    ethAmount = amount * 10**18
    SA_Token.transfer(recipient, ethAmount, {'from': deployer})

    # Get the updated balances
    owner_balance = SA_Token.balanceOf(deployer)
    recipient_balance = SA_Token.balanceOf(recipient)

    print("\n Balances after Transaction: \n")
    print("   Sender:", owner_balance / 10**18, " (eth)")
    print("   Recipient:", recipient_balance / 10**18, " (eth)\n")
    print("|----------------------------------------------------------| \n") 
