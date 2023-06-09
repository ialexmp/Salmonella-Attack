from brownie import accounts, network, web3
from eth_utils import to_wei

def main():
    # Set up development network
    network_selected = "development"
    if network.show_active() != network_selected:
        network.connect(network_selected)


    # Load accounts from the local keystore
    sender = accounts[0]
    receiver = accounts.add()  # Create a new account for demonstration purposes

    # Define the transfer amount in ether
    transfer_amount = 1  # 1 ether

    # Convert the transfer amount to wei
    transfer_amount_wei = to_wei(transfer_amount, "ether")

    # Display balances before the transfer
    print(f"Sender's balance before transfer: {web3.fromWei(sender.balance(), 'ether')} ether")
    print(f"Receiver's balance before transfer: {web3.fromWei(receiver.balance(), 'ether')} ether")

    # Transfer ether
    sender.transfer(receiver, transfer_amount_wei)

    # Display balances after the transfer
    print(f"Sender's balance after transfer: {web3.fromWei(sender.balance(), 'ether')} ether")
    print(f"Receiver's balance after transfer: {web3.fromWei(receiver.balance(), 'ether')} ether")

if __name__ == "__main__":
    main()
