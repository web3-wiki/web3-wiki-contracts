// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
import "./WikiRevision.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";

contract WikiPage is ERC721, ERC721Burnable {
    Counters.Counter private _tokenIdCounter;
    using Counters for Counters.Counter;
    address public owner;
    string public pagename;

    constructor(string memory _pagename, address _owner) {
        pagename = _pagename;
        owner = _owner;
        // constructor(address _nftContract, uint256 _tokenId) {
        // nftContract = _nftContract;
        // tokenId = _tokenId;
        // collateralController = msg.sender;
    }
}
