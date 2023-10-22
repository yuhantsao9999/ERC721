// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract NFTHW2 is ERC721Enumerable {
    using Strings for uint256;

    uint256 public constant MAX_SUPPLY = 500;

    address public owner;
    bool public blindBoxOpened = false;

    constructor() ERC721("NFT Random Blind Box", "NFTHW2") {
        owner = msg.sender;
    }

    function mint(address receiver) public {
        require(totalSupply() < MAX_SUPPLY, "Max supply reached");
        _mint(receiver, totalSupply());
    }

    function openBlindBox() public {
        require(msg.sender == owner, "Only owner can open blind box");
        blindBoxOpened = true;
    }

    function tokenURI(
        uint256 tokenId
    ) public view virtual override returns (string memory) {
        string memory uri;

        if (blindBoxOpened) {
            uri = string(
                abi.encodePacked(_baseURI(), "/", tokenId.toString(), ".json")
            );
        } else {
            uri = string(abi.encodePacked(_baseURI(), ".json"));
        }
        return uri;
    }

    function _baseURI() internal pure override returns (string memory) {
        return "https://base-uri";
    }
}
