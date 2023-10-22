// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test, console2} from "forge-std/Test.sol";
import {NoUseful, HW_Token, NFTReceiver} from "../src/ERC721_receiver.sol";

contract NFTReceiverTest is Test {
    NFTReceiver nftReceiver;
    HW_Token hwToken;
    NoUseful noUseful;

    address alice = makeAddr("Alice");

    function setUp() public {
        noUseful = new NoUseful();
        hwToken = new HW_Token();
        nftReceiver = new NFTReceiver(address(noUseful), address(hwToken));
    }

    function test_NFTReceiver_onERC721Received_when_transfer_hwToken() public {
        vm.startPrank(alice);

        // mint hwToken to alice
        hwToken.mint(1, alice);

        assertEq(hwToken.balanceOf(alice), 1);

        // transfer hwToken to NFTReceiver
        hwToken.safeTransferFrom(alice, address(nftReceiver), 1);

        // alice got a new hwToken
        assertEq(hwToken.balanceOf(alice), 0);

        vm.stopPrank();
    }

    function test_NFTReceiver_onERC721Received_when_transfer_NoUseful() public {
        vm.startPrank(alice);

        // mint NoUseful to alice
        noUseful.mint(1, alice);

        assertEq(noUseful.balanceOf(alice), 1);
        assertEq(hwToken.balanceOf(alice), 0);

        // transfer NoUseful to NFTReceiver
        noUseful.safeTransferFrom(alice, address(nftReceiver), 1);

        // alice noUseful didn't change
        assertEq(noUseful.balanceOf(alice), 1);
        // alice got a new hwToken
        assertEq(hwToken.balanceOf(alice), 1);

        vm.stopPrank();
    }
}
