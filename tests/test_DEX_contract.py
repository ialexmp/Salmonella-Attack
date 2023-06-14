import brownie

def test_dex_contract(dex_contract, token_contract, accounts):
    account1 = accounts[0]
    account2 = accounts[1]

    # Perform a token purchase
    amount = 1  # Number of tokens to purchase
    token_amount = amount * 10**token_contract.decimals()
    eth_amount = token_amount  # 1:1 token-to-ETH ratio for simplicity

    tx = dex_contract.buyTokens(token_amount, {"from": account1, "value": eth_amount})
    tx.wait()

    # Check the token balance of account1
    balance = token_contract.balanceOf(account1)
    assert balance == token_amount

    # Perform a token sale
    tx = dex_contract.sellTokens(token_amount, {"from": account1})
    tx.wait()

    # Check the token balance of account1 after the sale
    balance = token_contract.balanceOf(account1)
    assert balance == 0

    # Check the token balance of the DEX contract after the sale
    balance = token_contract.balanceOf(dex_contract)
    assert balance == token_amount
