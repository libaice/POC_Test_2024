// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";

contract POCTest is Test {
    function setUp() public {
        vm.createSelectFork(
            "https://arb-mainnet.g.alchemy.com/v2/0t_u76Gb-cAqqafU1sP8RPwLNoH4eqpi"
        );
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
        console2.log("bob balance", bob.balance);
        vm.stopPrank();

        address alice = makeAddr("Alice");
        vm.prank(alice);
        console2.log("alice.balance", alice.balance);
        console2.log("Alice address ", alice);
    }




}
