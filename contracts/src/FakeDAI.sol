// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract FakeDAI is ERC20 {
    address private _owner;

    constructor() ERC20("FakeDAI", "FakeDAI") {
        _owner = msg.sender;
    }

    // only onwer can mint
    function mint(address dst, uint256 amt) public returns (bool) {
        require(msg.sender == _owner, "only owner can mint");
        _mint(dst, amt);
        return true;
    }

    function owner() public view returns (address) {
        return _owner;
    }
}
