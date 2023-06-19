# Salmonella-Attack

## Abstract

This research paper explores the Salmonella Attack, a type of security threat in Blockchain systems. The attack involves introducing malicious nodes that compromise the integrity of the Blockchain, potentially disrupting the consensus mechanism. The paper emphasizes the importance of implementing robust security measures, such as node authentication and monitoring for unusual behavior, to prevent Salmonella Attacks. It also aims to analyze contracts with Salmonella, detect them, and avoid buying from infected Blockchains. The study provides insights into the attack's prevalence, detection methods, and potential countermeasures.

## Dependencies

This project requires the following software and libraries:

- [Brownie](https://eth-brownie.readthedocs.io/en/stable/install.html) - tested with version v1.19.3

Brownie has the following dependencies:
  - Python3 version 3.7 or greater, python3-dev
  - [Ganache](https://github.com/trufflesuite/ganache) - tested with version 7.0.2


## Setup and Installation

1. Install the required [dependencies](##Dependencies)

2. Initialize a Brownie project ```$ brownie init``` 

3. Clone the repository:
  ```git clone https://github.com/ialexmp/Salmonella-Attack.git [cd your-project-name] ```

4. Open the terminal and compile the Smart contract using ```$ brownie compile``` [More information](https://eth-brownie.readthedocs.io/en/stable/interaction.html)

5. Open the terminal and initialize the development Blockchain ```$ brownie console```

> **Warning** 
> Every time you change a smart contract, re-initialize the development Blockchain using the previous command and redeploy your contracts.
Otherwise, you will be querying/interacting your previous contract. Contracts
are (in general) immutable. Once you have deployed a contract, you can not
change it! 



## Usage

> **Note**
> All the contracts are based to ERC-20.sol contract,  we encourage you to design and propose your own contracts
> 
> Whether is your first time using Brownie, we recommend you to check the [Brownie Website](https://eth-brownie.readthedocs.io/en/stable/toctree.html), specially the following sections:
> - [Structure of a Project](https://eth-brownie.readthedocs.io/en/stable/structure.html)
> - [Interacting with your Contracts](https://eth-brownie.readthedocs.io/en/stable/interaction.html)
> - [Guidelines about how to start Writing Unit Test](https://eth-brownie.readthedocs.io/en/stable/tests-pytest-intro.html)


You can execute any test as follows:  ``` $ brownie test tests/[test-name].py```

- The possible tests are: 
                                                       
  - Test Salmonella Simulation Bait: ``` $ brownie test tests/test_salmonella_bait.py```                        
  - Test Salmonella Probability Gambling: ``` $ brownie test tests/test_salmonella_higherProb.py```                        
  - Test Salmonella Risk Amount: ``` $ brownie test tests/test_salmonella_prob.py```    


## Results

#### Salmonella Simulation Bait.

```
--------------- TEST SALMONELLA BAIT TRAP ---------------

Sandwich initial balance:  0 (SAT) 

DEX initial balance:  1000 (SAT)
Amount Sandwich Attacker wants to expend:  100.0 (ETH)

Expected SAT in Sandwich attacker balance after buy:  100 (SAT)
Expected SAT in DEX balance before buy:  900.0 (SAT)

Real SAT in Sandwich attacker balance after buy: 10 (SAT)
Real SAT in DEX balance before buy:  990 (SAT)

// Execution stops since bot has been trapped:
// require(token.balanceOf(msg.sender)>=amount, 
// "You got trapped :)");
---------------------------------------------------------

```

#### Salmonella Probability Gambling.

##### Victim does not get trapped
```
----------- TEST SALMONELLA PROBABILITY TRAP ------------

Sandwich initial balance:  0 (SAT) 

DEX initial balance:  1000 (SAT)
Amount Sandwich Attacker wants to expend:  100.0 (ETH)

Expected SAT in Sandwich attacker balance after buy:  200 (SAT)
Expected SAT in DEX balance before buy:  800.0 (SAT)

Real SAT in Sandwich attacker balance after buy: 200 (SAT)
Real SAT in DEX balance before buy:  800 (SAT)
  
Real Salmonella Tokens in Sandwich attacker balance after sell:  0 (SAT)
Real Salmonella Tokens in DEX balance before sell:  1000 (SAT)

---------------------------------------------------------
```
##### Victim get trapped
```
----------- TEST SALMONELLA PROBABILITY TRAP ------------

Sandwich initial balance:  0 (SAT) 

DEX initial balance:  1000 (SAT)
Amount Sandwich Attacker wants to expend:  200.0 (ETH)

Expected SAT in Sandwich attacker balance after buy:  200 (SAT)
Expected SAT in DEX balance before buy:  800.0 (SAT)

Real SAT in Sandwich attacker balance after buy: 0 (SAT)
Real SAT in DEX balance before buy:  1000 (SAT)

// Execution stops since bot has been trapped:
// require(token.balanceOf(msg.sender)>=amount, 
// "You got trapped :)");
---------------------------------------------------------
```

#### Salmonella Risk Amount.

##### Victim does not get trapped
```
----------- TEST SALMONELLA RISK AMOUNT TRAP ------------

Sandwich initial balance:  0 (SAT) 

DEX initial balance:  1000 (SAT)
Amount Sandwich Attacker wants to expend:  400.0 (ETH)

Expected SAT in Sandwich attacker balance after buy:  400 (SAT)
Expected SAT in DEX balance before buy:  600.0 (SAT)

Real SAT in Sandwich attacker balance after buy: 400 (SAT)
Real SAT in DEX balance before buy:  600 (SAT)

Real Salmonella Tokens in Sandwich attacker balance after sell:  0 (SAT)
Real Salmonella Tokens in DEX balance before sell:  1000 (SAT)
---------------------------------------------------------
```
##### Victim get trapped
```
----------- TEST SALMONELLA RISK AMOUNT TRAP ------------

Sandwich initial balance:  0 (SAT) 

DEX initial balance:  1000 (SAT)
Amount Sandwich Attacker wants to expend:  400.0 (ETH)

Expected SAT in Sandwich attacker balance after buy:  400 (SAT)
Expected SAT in DEX balance before buy:  600.0 (SAT)

Real SAT in Sandwich attacker balance after buy: 0 (SAT)
Real SAT in DEX balance before buy:  1000 (SAT)

// Execution stops since bot has been trapped:
// require(token.balanceOf(msg.sender)>=amount, 
// "You got trapped :)");
---------------------------------------------------------
```


## References

1. Defi-Cartel. (2021, March 19). GitHub - Defi-Cartel/salmonella: Wrecking sandwich traders for fun and profit. GitHub. [https://github.com/Defi-Cartel/salmonella](https://github.com/Defi-Cartel/salmonella)
2. Blockchain-Course-Upf. (n.d.). GitHub - Blockchain-Course-UPF/labs. GitHub. [https://github.com/Blockchain-Course-UPF/labs](https://github.com/Blockchain-Course-UPF/labs)

> **Note**
> The above references are just the main references used to implement the code. Check the Bibliography section of this [paper](salmonella-attack-in-Blockchain.pdf) in order to see the whole list of references 

----------------------------------------------------------------------------------------------------------
See you in the mempool!
