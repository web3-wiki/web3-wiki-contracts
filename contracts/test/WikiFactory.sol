// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/WikiFactory.sol";

contract ContractTest is Test {
    WikiFactory public factory;

    function setUp() public {
        factory = new WikiFactory();
    }

    function testExample() public {
        assertTrue(true);
    }
}
