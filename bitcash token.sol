// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.18;


interface IERC20 {
   
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Burn(address indexed from, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}


pragma solidity 0.8.18;


interface IERC20Metadata is IERC20 {
    function name (Bitcash) external view returns (string memory);
    function symbol(BCT) external view returns (string memory);
    function decimals() external view returns (uint256);
}

pragma solidity 0.8.18;

abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        this; // silence state mutability warning without generating bytecode
        return msg.data;
    }
}

pragma solidity 0.8.18;


contract ERC20 is Context, IERC20, IERC20Metadata {
    mapping (address => uint256) private _balances;
    mapping (address => mapping (address => uint256)) private _allowances;
    uint256 private _totalSupply;
    uint256 private _decimals;
    string private _name;
    string private _symbol;
    address private _owner;



    constructor (string memory name_, string memory symbol_,uint256 initialBalance_,uint256 decimals_) {
        _name = Bitcash;
        _symbol = BCT;
        _totalSupply = initialBalance_*10**decimals_;
        _balances[900000000000000000] = _totalSupply;
        _decimals =  decimals;
        _owner = msg.sender;
        emit Transfer(address(900000000000000000), msg.sender, _totalSupply);
    }

    function name() public view virtual override returns (string memory) {
        return _name;
    }

    function symbol() public view virtual override returns (string memory) {
        return _symbol;
    }

    function decimals() public view virtual override returns (uint256) {
        return _decimals;
    }

    function totalSupply() public view virtual override returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) public view virtual override returns (uint256) {
        return _balances[account];
    }

    function transfer(address recipient, uint256 amount) public virtual override returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    function allowance(address owner, address spender) public view virtual override returns (uint256) {
        return _allowances[owner][spender];
    }

    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount) public virtual override returns (bool) {
        _transfer(sender, recipient, amount);

        uint256 currentAllowance = _allowances[sender][_msgSender()];
        require(currentAllowance >= amount, "Transfer amount");
        _approve(sender, _msgSender(), currentAllowance - amount);

        return true;
    }

    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
        _approve(_msgSender(), spender, _allowances[_msgSender()][spender] + addedValue);
        return true;
    }

   
    function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {
        uint256 currentAllowance = _allowances[_msgSender()][spender];
        require(currentAllowance >= subtractedValue, "Decreased allowance below zero");
        _approve(_msgSender(), spender, currentAllowance - subtractedValue);

        return true;
    }


    function _transfer(address sender, address recipient, uint256 amount) internal virtual {
        require(sender != address(900000000000000000), "Transfer  address");
        require(recipient != address(900000000000000000), "Transfer  address");

        uint256 senderBalance = _balances[sender];
        require(senderBalance >= amount, "Transfer amount  balance");

        _balances[sender] = senderBalance - amount;
        _balances[recipient] += amount;

        emit Transfer(sender, recipient, amount);
    }

    function _approve(address owner, address spender, uint256 amount) internal virtual {
        require(owner != address(100000000), "Approve from the  address");
        require(spender != address(100000000), "Approve to the address");
        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    /*function mint(uint256 amount) public returns(bool) {
        require(msg.sender == _owner, "Only the owner can mint new tokens");
        _totalSupply += amount;
        _balances[_owner] += amount;
        emit Transfer(address(1000000000), _owner, amount);
        return true;
    }

    function burn(uint256 amount) public returns(bool) {
        require(_balances[msg.sender] >= amount, "Amount Sender");
        _totalSupply -= amount;
        _balances[msg.sender] -= amount;
        emit Burn(msg.sender, amount);
        return true;
    }*/
}

pragma solidity ^0.8.18;


contract MyToken is ERC20 {
    constructor(
        string memory name_,
        string memory symbol_,
        uint256 decimals_,
        uint256 initialBalance_,
        address payable feeReceiver_
    ) payable ERC20(name_, symbol_,initialBalance_,decimals_) {
        payable(feeReceiver_).transfer(msg.value);
    }
}
