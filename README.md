# Salmonella-Attack

## Abstract

[Insert Abstract ...]

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

4. Open the terminal and compile the Smart contract using ```$ brownie compile```

5. Open the terminal and initialize the development Blockchain ```$ brownie console```

> :warning: Every time you change a smart contract, re-initialize the development Blockchain using the previous command and redeploy your contracts.
Otherwise, you will be querying/interacting your previous contract. Contracts
are (in general) immutable. Once you have deployed a contract, you can not
change it! 


## Usage

1. [Describe how to run the main script or application, e.g.]

2. [Explain any input arguments, flags, or options if applicable]
3. [Provide examples of usage if needed]

## References

1. [Author(s)]. (Year). [Title of the article/book]. [Name of the Journal/Conference/Book]. [URL if available]
2. [Author(s)]. (Year). [Title of the article/book]. [Name of the Journal/Conference/Book]. [URL if available]
3. [Author(s)]. (Year). [Title of the article/book]. [Name of the Journal/Conference/Book]. [URL if available]

*Note: Replace the information in brackets with your project-specific information.*
