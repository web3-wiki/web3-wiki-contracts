// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/WikiFactory.sol";
import "../src/WikiVoting.sol";
import "../src/FakeAUSDC.sol";

contract ContractTest is Test {
    WikiFactory public factory;
    WikiVoting public voting;
    FakeAUSDC public ausdc;

    function setUp() public {
        ausdc = new FakeAUSDC();
        voting = new WikiVoting();
        factory = new WikiFactory(address(ausdc), address(voting));
    }

    struct UserInfo {
        uint256 amount;
        // uint256 rewardDebt;
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

    function testDeposit() public {
        //
        address addr1 = factory.createWikiPage("aaa", "https://test.com/1.json");
        address addr2 = factory.createWikiPage("aaa", "https://test.com/2.json");
        address addr3 = factory.createWikiPage("aaa", "https://test.com/3.json");
        assertTrue(addr2 == addr1);
        assertTrue(addr2 == addr3);

        //
        emit log_named_uint("wikipagesLength", factory.wikipagesLength());
        //
        emit log_named_string("IWikiPage(addr1).tokenURI(0)", IWikiPage(addr1).tokenURI(0));
        emit log_named_string("IWikiPage(addr1).tokenURI(1)", IWikiPage(addr1).tokenURI(1));
        emit log_named_string("IWikiPage(addr1).tokenURI(2)", IWikiPage(addr1).tokenURI(2));
        //
        ausdc.mint(address(this), 100000 * 1e18);
        emit log_named_uint("ausdc.balance(balanceOf(this))", ausdc.balanceOf(address(this)));
        ausdc.approve(address(voting), 100000 * 1e18);
        // ausdc.approve(address(addr1), 100000 * 1e18);
        //
        voting.deposit(addr1, 0, 10 * 1e18);
        emit log_named_uint("ausdc.balance(balanceOf(addr1))", ausdc.balanceOf(address(addr1)));
        emit log_named_uint("ausdc.balance(balanceOf(this))", ausdc.balanceOf(address(this)));
        //
        voting.deposit(addr1, 0, 10 * 1e18);
        emit log_named_uint("ausdc.balance(balanceOf(addr1))", ausdc.balanceOf(address(addr1)));
        emit log_named_uint("ausdc.balance(balanceOf(this))", ausdc.balanceOf(address(this)));

        //
        voting.deposit(addr1, 1, 10 * 1e18);
        emit log_named_uint("ausdc.balance(balanceOf(addr1))", ausdc.balanceOf(address(addr1)));
        emit log_named_uint("ausdc.balance(balanceOf(this))", ausdc.balanceOf(address(this)));

        //
        IWikiPage(addr1).withdraw(0, 10 * 1e18, address(this));
        emit log_named_uint("ausdc.balance(balanceOf(addr1))", ausdc.balanceOf(address(addr1)));
        emit log_named_uint("ausdc.balance(balanceOf(this))", ausdc.balanceOf(address(this)));
        //
        IWikiPage(addr1).withdraw(0, 10 * 1e18, address(this));
        emit log_named_uint("ausdc.balance(balanceOf(addr1))", ausdc.balanceOf(address(addr1)));
        emit log_named_uint("ausdc.balance(balanceOf(this))", ausdc.balanceOf(address(this)));
        //
        IWikiPage(addr1).withdraw(1, 10 * 1e18, address(this));
        emit log_named_uint("ausdc.balance(balanceOf(addr1))", ausdc.balanceOf(address(addr1)));
        emit log_named_uint("ausdc.balance(balanceOf(this))", ausdc.balanceOf(address(this)));

        // upvote 1
        voting.upvote(addr1, 1);
        emit log_named_uint("ausdc.balance(balanceOf(addr1))", ausdc.balanceOf(address(addr1)));
        emit log_named_uint("ausdc.balance(balanceOf(this))", ausdc.balanceOf(address(this)));
        //upvote 0
        voting.upvote(addr1, 0);
        emit log_named_uint("ausdc.balance(balanceOf(addr1))", ausdc.balanceOf(address(addr1)));
        emit log_named_uint("ausdc.balance(balanceOf(this))", ausdc.balanceOf(address(this)));
        //upvote 2
        voting.upvote(addr1, 2);
        emit log_named_uint("ausdc.balance(balanceOf(addr1))", ausdc.balanceOf(address(addr1)));
        emit log_named_uint("ausdc.balance(balanceOf(this))", ausdc.balanceOf(address(this)));
    }
}
