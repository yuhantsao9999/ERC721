// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NoUseful is ERC721 {
    constructor() ERC721("appworksSchool", "APS") {}
}

contract HW_Token is ERC721 {
    constructor() ERC721("Do not send NFT to me", "NONFT") {}

    function mint(uint256 tokenId) public {
        _safeMint(msg.sender, tokenId);
    }

    function tokenURI() public view virtual returns (string memory) {
        return
            "https://ipfs.io/ipfs/QmQ3WWDvsYw2xM68G7sHffsMCmhcb7AKsxe2mMZkt5uD9w/0";
    }
}

contract NFTReceiver is IERC721Receiver {
    NoUseful public noUsefulContract; // The contract for "nouseful" NFTs
    HW_Token public hwTokenContract; // The contract for HW_Tokens

    constructor(address _noUseful, address _hwToken) {
        noUsefulContract = NoUseful(_noUseful);
        hwTokenContract = HW_Token(_hwToken);
    }

    function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes memory data
    ) public override returns (bytes4) {
        // 1. Check the sender to make sure it's the "NoUseful" contract
        if (msg.sender != address(noUsefulContract)) {
            // 2. If not, transfer the "nouseful" token back to the original owner
            noUsefulContract.safeTransferFrom(address(this), from, tokenId);
            // 3. Mint HW_Token for the original owner
            hwTokenContract.mint(tokenId);
        }

        return this.onERC721Received.selector;
    }
}
