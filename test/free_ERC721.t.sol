// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {NFTHW2} from "../src/NFTHW2.sol";

contract NFTHW2Test is Test {
    NFTHW2 public nft;

    function setUp() public {
        nft = new NFTHW2();
    }

    function test_Mint() public {
        nft.mint(address(this));
        assertEq(nft.balanceOf(address(this)), 1);
    }

    function test_mint_maxSupply() public {
        assertEq(nft.MAX_SUPPLY(), 500);

        for (uint256 i = 0; i < nft.MAX_SUPPLY(); i++) {
            nft.mint(address(this));
        }

        vm.expectRevert(bytes("Max supply reached"));
        nft.mint(address(this));
    }

    function test_OpenBlindBox() public {
        nft.mint(address(this));

        assertEq(nft.blindBoxOpened(), false);
        assertEq(nft.tokenURI(0), "https://base-uri.json");

        nft.openBlindBox();
        assertEq(nft.blindBoxOpened(), true);
        assertEq(nft.tokenURI(0), "https://base-uri/0.json");
    }
}
