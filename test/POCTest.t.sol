// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";

import "forge-std/Test.sol";

contract POCTest is Test {
    function setUp() public {
        // vm.createSelectFork(
        //     "https://arb-mainnet.g.alchemy.com/v2/0t_u76Gb-cAqqafU1sP8RPwLNoH4eqpi"
        // );
    }

    function testBlockTimestamp() public {
        console2.log("block.timestamp", block.timestamp);
        console2.log("block.number", block.number);
        console2.log("block.coinbase", block.coinbase);
        console2.log("block.gaslimit", block.gaslimit);
        console2.log("block.basefee", block.basefee);
        console2.log("block.chainid", block.chainid);
    }

    function testWrap() public {
        console2.log("block.timestamp", block.timestamp);
        vm.warp(block.timestamp + 1 days);
        console2.log("block.timestamp", block.timestamp);
        vm.warp(1 weeks);
        console2.log("block.timestamp", block.timestamp);
        skip(3000);
        console2.log("block.timestamp", block.timestamp);
    }

    function testRollSkip() public {
        console2.log("block.timestamp", block.timestamp);
        console2.log("block.number", block.number);
        vm.roll(123242121);
        console2.log("block.timestamp", block.timestamp);
        console2.log("block.number", block.number);
    }

    function testPrank() public {
        address bob = makeAddr("Bob");
        vm.startPrank(bob);

        console2.log("bob balance", bob.balance);
        deal(bob, 1 ether);
        console2.log("Bob address ", bob);
        console2.log("bob balance", bob.balance / 1e18);
        vm.stopPrank();

        address alice = makeAddr("Alice");
        vm.prank(alice);
        console2.log("alice.balance", alice.balance);
        console2.log("Alice address ", alice);
    }

    function testAddr() public {
        address user_Alice = vm.addr(1);
        console2.log("Alice address ", user_Alice);

        address user_Bob = vm.addr(2);
        console2.log("Bob address ", user_Bob);

        address user_Carol = vm.addr(3);
        console2.log("Carol address ", user_Carol);

        address user_Dave = vm.addr(4);
        console2.log("Dave address ", user_Dave);

        address user_Eve = vm.addr(5);
        console2.log("Eve address ", user_Eve);
    }

    MockCallExample public mockCallExample;

    function testMockCall() public {
        mockCallExample = new MockCallExample();
        assertEq(mockCallExample.number(), 10);

        vm.mockCall(
            address(mockCallExample),
            abi.encodeWithSelector(bytes4(keccak256("number()"))),
            abi.encode(5)
        );
        assertEq(mockCallExample.number(), 5);
    }

    function testLabel() public {
        address user1;
        address user2;
        user1 = address(111);
        user2 = address(222);
        vm.label(user1, "user1");
        vm.label(user2, "user2");
        console2.log(user1);
        console2.log(user2);
    }

    function testExpectRevert() public {
        uint256 testNumber = 42;
        // vm.expectRevert(stdError.arithmeticError);
        vm.expectRevert();
        testNumber -= 43;
    }

    event Transfer(address indexed from, address indexed to, uint256 amount);

    function test_ExpectEmit() public{
        ExpectEmit emitter = new ExpectEmit();
        // Check topic 1 and topic 2, but do not check data
        vm.expectEmit(true, true, false, false);
        // The event we expect
        emit Transfer(address(this), address(1337), 1338);
        // The event we get
        emitter.t();
    }

}

contract MockCallExample {
    uint256 public number = 10;
}

contract ExpectEmit {
    event Transfer(address indexed from, address indexed to, uint256 amount);

    function t() public {
        emit Transfer(msg.sender, address(1337), 1337);
    }
}
