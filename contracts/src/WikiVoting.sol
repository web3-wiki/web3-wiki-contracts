// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
// import "./WikiRevision.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

import "./WikiPage.sol";

contract WikiVoting is Ownable {
    // mapping(address => uint256) public collaterals;
    // address public baseToken;

    constructor() {
        // baseToken = _token;
    }

    function deposit(
        address _wikipage,
        uint256 _tokenId,
        uint256 _amount
    ) public {
        IERC20(IWikiPage(_wikipage).baseToken()).transferFrom(msg.sender, address(this), _amount);
        IERC20(IWikiPage(_wikipage).baseToken()).approve(address(_wikipage), _amount);
        IWikiPage(_wikipage).deposit(_tokenId, _amount, msg.sender);
    }

    function upvote(address _wikipage, uint256 _tokenId) public {
        deposit(_wikipage, _tokenId, 10 * 1e18);
    }
}
