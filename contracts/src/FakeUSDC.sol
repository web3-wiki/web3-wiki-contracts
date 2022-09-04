// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract FakeUSDC is ERC20 {
    address private _owner;

    uint8 private _decimals;

    constructor() ERC20("FakeUSDC", "FakeUSDC") {
        _decimals = 6;
        _owner = msg.sender;
    }

    // only onwer can mint
    function mint(address dst, uint256 amt) public returns (bool) {
        require(msg.sender == _owner, "only owner can mint");
        _mint(dst, amt);
        return true;
    }

    function decimals() public view override returns (uint8) {
        return _decimals;
    }

    function owner() public view returns (address) {
        return _owner;
    }
}
