// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test, console2} from "forge-std/Test.sol";
import {NoUseful, HW_Token} from "../src/ERC721_receiver.sol";

contract checkNum is Test {
    NoUseful public NoUsefulContract;
    HW_Token public HW_TokenContract;

    function checkHWNoNFT(address _hwToken, address owner) public {
        //hwTokenContract = HW_TokenContract(_hwToken);
        assertEq(HW_TokenContract.balanceOf(owner), 1);
    }

    function checkNoNFT(address _noUseful, address owner) public {
        //noUsefulContract = NoUsefulContract(_noUseful);
        assertEq(NoUsefulContract.balanceOf(owner), 2);
    }
}
