// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
import "./WikiPage.sol";

contract WikiFactory {
    address[] public wikipages;
    mapping(address => bool) public isWikiAddr;
    mapping(bytes32 => address) public getAddrByHash;

    address public baseToken;
    address public voting;

    constructor(address _token, address _voting) {
        baseToken = _token;
        voting = _voting;
    }

    //
    event WikiPageCreated(address indexed owner, address wikipage);

    function createWikiPage(string memory pagename, string memory contentURL) public returns (address) {
        address addr = _createWikiPage(pagename);
        IWikiPage(addr).safeMint(msg.sender, contentURL);
        return addr;
    }

    function _createWikiPage(string memory pagename) internal returns (address) {
        // pagename = toLowercase(pagename);
        bytes32 titlehash = keccak256(abi.encode(address(this), pagename));
        if (getAddrByHash[titlehash] != address(0)) {
            return getAddrByHash[titlehash];
        }
        address addr = address(0);
        addr = address(new WikiPage{salt: keccak256(abi.encode(address(this), msg.sender))}(pagename, address(this), msg.sender, baseToken));
        getAddrByHash[titlehash] = addr;
        wikipages.push(addr);
        isWikiAddr[addr] = true;
        emit WikiPageCreated(msg.sender, addr);
        return (addr);
    }

    function wikipagesLength() public view returns (uint256) {
        return wikipages.length;
    }

    // //
    // function toUppercase(string memory str) public pure returns (string memory) {
    //     bytes memory bStr = bytes(str);
    //     bytes memory bUpper = new bytes(bStr.length);
    //     uint8 num = 0;
    //     for (uint256 i = 0; i < bStr.length; i++) {
    //         // Lowercase character...
    //         if ((uint8(bStr[i]) >= 97) && (uint8(bStr[i]) <= 122)) {
    //             // So we subtract 32 to make it uppercase
    //             bUpper[i] = bytes1(uint8(bStr[i]) - 32);
    //         } else {
    //             bUpper[i] = bStr[i];
    //         }

    //         if (
    //             ((uint8(bUpper[i]) >= 65) && (uint8(bUpper[i]) <= 90)) || ((uint8(bUpper[i]) >= 30) && (uint8(bUpper[i]) <= 39)) // A-Z // 0-9
    //         ) {
    //             num++;
    //         }
    //     }
    //     require(num > 0, "symbol must be A-Z0-9");
    //     bytes memory bSymbol = new bytes(num);
    //     uint256 j = 0;
    //     for (uint256 i = 0; i < bUpper.length; i++) {
    //         if (
    //             ((uint8(bUpper[i]) >= 65) && (uint8(bUpper[i]) <= 90)) || ((uint8(bUpper[i]) >= 30) && (uint8(bUpper[i]) <= 39)) // A-Z // 0-9
    //         ) {
    //             bSymbol[j++] = bUpper[i];
    //         }
    //     }

    //     // return string(bUpper);
    //     return string(bSymbol);
    // }

    //
    function toLowercase(string memory str) public pure returns (string memory) {
        bytes memory bStr = bytes(str);
        bytes memory bUpper = new bytes(bStr.length);
        uint8 num = 0;
        for (uint256 i = 0; i < bStr.length; i++) {
            // Uppercase character...
            if ((uint8(bStr[i]) >= 65) && (uint8(bStr[i]) <= 90)) {
                // So we add 32 to make it lowercase
                bUpper[i] = bytes1(uint8(bStr[i]) + 32);
            } else {
                bUpper[i] = bStr[i];
            }

            if (
                ((uint8(bUpper[i]) >= 97) && (uint8(bUpper[i]) <= 122)) || ((uint8(bUpper[i]) >= 30) && (uint8(bUpper[i]) <= 39)) // a-z // 0-9
            ) {
                num++;
            }
        }
        require(num > 0, "must be a-z0-9");
        bytes memory bSymbol = new bytes(num);
        uint256 j = 0;
        for (uint256 i = 0; i < bUpper.length; i++) {
            if (
                ((uint8(bUpper[i]) >= 65) && (uint8(bUpper[i]) <= 90)) || ((uint8(bUpper[i]) >= 30) && (uint8(bUpper[i]) <= 39)) // A-Z // 0-9
            ) {
                bSymbol[j++] = bUpper[i];
            }
        }

        // return string(bUpper);
        return string(bSymbol);
    }
}
