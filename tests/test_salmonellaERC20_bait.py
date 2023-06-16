import pytest
from brownie import DEX, SalmonellaAttackToken, accounts

def test_transfer_properly():
    # Deploy contracts
    salmonellaAttacker = accounts[0]
    sandwichAttacker = accounts[1]
    
    price = 1
    pps = 18
    
    initial_supply = 1000000*10**18
    
    token = SalmonellaAttackToken.deploy(initial_supply, {'from': salmonellaAttacker})
    dex = DEX.deploy(token.address, price, pps, {'from': salmonellaAttacker})
    
    # Set the pool address to token
    token.setPoolAddress(dex.address)
    
    # Add addresses list
    allowedAddresses = [token.address, dex.address]
   	
    token.allowAddresses(allowedAddresses)
    
    initialBalance = 500*10**token.decimals()
    token.transfer(dex.address,initialBalance,{'from': salmonellaAttacker.address})
    token.transfer(salmonellaAttacker,initialBalance, {'from': salmonellaAttacker.address})
    token.transfer(sandwichAttacker,initialBalance,{'from': salmonellaAttacker.address})
    
    # Perform a token purchase
    amount = 100  # Number of tokens to purchase
    eth_amount = amount * 10**token.decimals()

    
    # sandwichAttacker transfers tokens to the DEX contract
    #token.transfer(dex.address, 1000*10**18, {'from': salmonellaAttacker})
    #print("sandwichAttacker balance before buy: ", token.balanceOf(sandwichAttacker))
    #print("DEX balance before buy: ", token.balanceOf(dex.address))
    #print("Attacker balance before buy: ", token.balanceOf(attacker))
	
    # Attacker buys tokens from the DEX contract
    #dex.buyToken({'from': salmonellaAttacker, 'value': eth_amount})
    #print("sandwichAttacker balance after buy: ", token.balanceOf(sandwichAttacker))-
    #print("DEX balance after buy: ", token.balanceOf(dex.address))
    print("\n----------- TEST SALMONELLA TRAP -----------\n")
    print("Sandwich balances before buy: ",token.balanceOf(sandwichAttacker)/(10**18))
    print("DEX balance before buy: ", token.balanceOf(dex.address)/(10**18))
    
    # Attacker buys tokens from the DEX contract
    dex.buyToken({'from': sandwichAttacker, 'value': eth_amount})
    print("\n sandwichAttacker balance after buy: ", token.balanceOf(sandwichAttacker)/(10**18))
    print("DEX balance after buy: ", token.balanceOf(dex.address)/(10**18))
    
    # user compra
    
    # Attacker buys tokens from the DEX contract
    dex.sellToken({'from': sandwichAttacker, 'value': eth_amount})
    print("sandwichAttacker balance after sell: ", token.balanceOf(sandwichAttacker)/(10**18))
    print("DEX balance after buy: ", token.balanceOf(dex.address)/(10**18))
    
    # Check balances
    #assert token.balanceOf(sandwichAttacker) == initial_supply - 1000
    #assert token.balanceOf(dex.address) == 1000
  
def main():
    test_transfer_properly()
    #test_transfer_trapped()
