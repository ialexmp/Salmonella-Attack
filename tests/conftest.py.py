import pytest
from brownie import DEX, SalmonellaAttackToken

@pytest.fixture(scope="module")
def dex(token, accounts):
    return DEX.deploy(token.address, {"from": accounts[0]})

@pytest.fixture(scope="module")
def token(accounts):
    return SalmonellaAttackToken.deploy(100000, {"from": accounts[0]})
