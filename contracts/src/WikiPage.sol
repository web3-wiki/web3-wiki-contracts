// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
// import "./WikiRevision.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

interface IWikiPage {
    function pagename() external view returns (string memory);

    function baseToken() external view returns (address);

    function symbol() external view returns (string memory);

    function name() external view returns (string memory);

    function safeMint(address to, string memory contentURL) external;

    function tokenURI(uint256 tokenId) external view returns (string memory);

    function deposit(
        uint256 _tokenId,
        uint256 _amount,
        address _to
    ) external;

    function withdraw(
        uint256 _tokenId,
        uint256 _amount,
        address _to
    ) external;
}

contract WikiPage is ERC721, ERC721URIStorage, ERC721Burnable, Ownable {
    using SafeERC20 for IERC20;

    Counters.Counter private _tokenIdCounter;
    using Counters for Counters.Counter;
    address public facotry;
    address public founder;
    address public baseToken;
    string public pagename;

    // // Info of each user.
    // struct UserInfo {
    //     uint256 amount;
    //     // uint256 rewardDebt;
    // }
    // mapping(uint256 => mapping(address => UserInfo)) public userInfo;
    mapping(uint256 => mapping(address => uint256)) public userAmount;

    // /// Info of each pool.
    // struct PoolInfo {
    //     uint128 accRewardPerShare;
    //     uint64 lastRewardTimestamp;
    //     uint64 allocPoint;
    // }

    constructor(
        string memory _pagename,
        address _facotry,
        address _founder,
        address _baseToken
    ) ERC721("WIKI", "WIKINFT") {
        pagename = _pagename;
        facotry = _facotry;
        founder = _founder;
        baseToken = _baseToken;
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

    function deposit(
        uint256 _tokenId,
        uint256 _amount,
        address _to
    ) public {
        // UserInfo storage user = userInfo[_tokenId][_to];
        uint256 ua = userAmount[_tokenId][_to];
        IERC20(baseToken).safeTransferFrom(msg.sender, address(this), _amount);
        // user.amount += _amount;
        userAmount[_tokenId][_to] = ua + _amount;
        // emit Deposit( _tokenId, _amount, _to);
    }

    function withdraw(
        uint256 _tokenId,
        uint256 _amount,
        address _to
    ) public {
        // UserInfo storage user = userInfo[_tokenId][msg.sender];
        // require(user.amount >= _amount, "withdraw: amount");
        uint256 ua = userAmount[_tokenId][msg.sender];
        require(ua >= _amount, "withdraw: amount");

        // user.amount -= _amount;
        userAmount[_tokenId][msg.sender] = ua - _amount;
        IERC20(baseToken).safeTransfer(_to, _amount);

        // emit Withdraw(msg.sender, _tokenId, _amount, _to);
    }

    // event Deposit(address indexed user, uint256 indexed tokenId, uint256 amount, address indexed to);

    // event Withdraw(address indexed user, uint256 indexed tokenId, uint256 amount, address indexed to);

    //
    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId) public view override(ERC721, ERC721URIStorage) returns (string memory) {
        return super.tokenURI(tokenId);
    }
}
