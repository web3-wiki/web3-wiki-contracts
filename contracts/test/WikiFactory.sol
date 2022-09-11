// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/WikiFactory.sol";

contract ContractTest is Test {
    WikiFactory public factory;

    function setUp() public {
        factory = new WikiFactory();
    }

    function testCreateWiki() public {
        //
        address addr1 = factory.createWikiPage("aaa", "https://test.com/1.json");
        address addr2 = factory.createWikiPage("aaaaa", "https://test.com/2.json");
        address addr3 = factory.createWikiPage("aaaaa", "https://test.com/3.json");
        address addr4 = factory.createWikiPage("aaaaaa", "https://test.com/4.json");
        address addr5 = factory.createWikiPage("aaaaaA", "https://test.com/5.json");
        //
        assertTrue(addr2 == addr3);
        assertTrue(addr2 != addr1);
        assertTrue(addr4 != addr1);
        assertTrue(addr4 != addr3);
        assertTrue(addr4 != addr5);
        //
        emit log_named_string("addr1.pagename", IWikiPage(addr1).pagename());
        emit log_named_string("addr2.pagename", IWikiPage(addr2).pagename());
        emit log_named_string("addr3.pagename", IWikiPage(addr3).pagename());
        emit log_named_string("addr4.pagename", IWikiPage(addr4).pagename());
        emit log_named_string("addr5.pagename", IWikiPage(addr5).pagename());
        //
        emit log_named_address("addr1", addr1);
        emit log_named_address("addr2", addr2);
        emit log_named_address("addr3", addr3);
        emit log_named_address("addr4", addr4);
        emit log_named_address("addr5", addr5);
        //
        emit log_named_uint("wikipagesLength", factory.wikipagesLength());
        //
        emit log_named_string("IWikiPage(addr1).tokenURI(0)", IWikiPage(addr1).tokenURI(0));
        emit log_named_string("IWikiPage(addr2).tokenURI(0)", IWikiPage(addr2).tokenURI(0));
        emit log_named_string("IWikiPage(addr3).tokenURI(0)", IWikiPage(addr3).tokenURI(0));
        emit log_named_string("IWikiPage(addr3).tokenURI(1)", IWikiPage(addr3).tokenURI(1));
        emit log_named_string("IWikiPage(addr4).tokenURI(0)", IWikiPage(addr4).tokenURI(0));
        emit log_named_string("IWikiPage(addr5).tokenURI(0)", IWikiPage(addr5).tokenURI(0));
        //
    }
}
