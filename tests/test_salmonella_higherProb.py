import pytest
from brownie import DEX, SalmonellaHigherProbToken, accounts

def test_transfer_trapped():
    # Deploy contracts
    salmonellaAttacker = accounts[0]
    sandwichAttacker = accounts[1]
    
    price = 1
    pps = 18
    
    initial_supply = 100000000*10**pps
    initial_deposit_supply = 1000*10**pps
    
    token = SalmonellaHigherProbToken.deploy(initial_supply, {'from': salmonellaAttacker})
    dex = DEX.deploy(token.address, price, pps, {'from': salmonellaAttacker})
    
    token.setPoolAddress(dex.address);
    
    for i in range(0,10):
    	token.approve(dex.address , initial_supply, {'from': salmonellaAttacker})
    
    dex.deposit({'from':salmonellaAttacker, 'value':initial_deposit_supply })
    
    # Set the pool address to token
    token.setPoolAddress(dex.address)
    
    # Add addresses list
    allowedAddresses = [token.address, dex.address]
    
    initialBalance = 500*10**token.decimals()
    
    # Perform a token purchase
    amount = 400  # Number of tokens to purchase
    eth_amount = amount * 10**token.decimals()
    

    
    print("\n----------- TEST SALMONELLA TRAP -----------\n")
    print("  Sandwich initial balance: ",token.balanceOf(sandwichAttacker),"\n")
    print("  DEX initial balance: ", token.balanceOf(dex.address))
    print("  Eth Amount Sandwich Attacker wants to expend: ", eth_amount/(10**pps) ,"\n")
    
    dex.buyToken({'from': sandwichAttacker, 'value': eth_amount})
    
    
    print("  Expected Salmonella Tokens in Sandwich attacker balance after buy: ",amount)
    print("  Expected Salmonella Tokens in DEX balance before buy: ", (initial_deposit_supply -eth_amount)/(10**pps))
    print("\n")
    
    print("  Real Salmonella Tokens in Sandwich attacker balance after buy ",token.balanceOf(sandwichAttacker))
    print("  Real Salmonella Tokens in DEX balance before buy: ", token.balanceOf(dex.address))
    print("\n")
    
    # Attacker tries to sell the same quantity as he bought, but he cannot since he got trapped
    #token.transfer(sandwichAttacker.address , eth_amount, {'from': dex.address})
    dex.sellToken(amount, {'from': sandwichAttacker})
    
    print("  Real Salmonella Tokens in Sandwich attacker balance after sell: ",token.balanceOf(sandwichAttacker))
    print("  Real Salmonella Tokens in DEX balance before sell: ", token.balanceOf(dex.address))
    print("\n")

def main():
	test_transfer_trapped()
	
	
 
