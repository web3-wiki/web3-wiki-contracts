// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
// import "./WikiRevision.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

interface IWikiPage {
    function pagename() external view returns (string memory);

    function symbol() external view returns (string memory);

    function name() external view returns (string memory);

    function safeMint(address to, string memory contentURL) external;

    function tokenURI(uint256 tokenId) external view returns (string memory);
}

contract WikiPage is ERC721, ERC721URIStorage, ERC721Burnable, Ownable {
    Counters.Counter private _tokenIdCounter;
    using Counters for Counters.Counter;
    address public facotry;
    address public founder;
    string public pagename;

    constructor(
        string memory _pagename,
        address _facotry,
        address _founder
    ) ERC721("WIKI", "WIKINFT") {
        pagename = _pagename;
        facotry = _facotry;
        founder = _founder;
    }

    // function _baseURI() internal pure override returns (string memory) {
    //     return "";
    // }

    function safeMint(address to, string memory uri) public {
        require(facotry == msg.sender, "factory");
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _mint(to, tokenId);
        _setTokenURI(tokenId, uri);
    }

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId) public view override(ERC721, ERC721URIStorage) returns (string memory) {
        return super.tokenURI(tokenId);
    }
}
