// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "./Base64.sol";

contract TestNFT is ERC721("TestNFT", "TNFT") {
    uint256 public nextTokenId = 0;

    function mint() external {
        uint256 tokenId = nextTokenId;
        nextTokenId++;
        _safeMint(_msgSender(), tokenId);
    }

       function tokenURI(uint256 tokenId) public view override returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");

        string memory svg = getSVG();
        bytes memory json = abi.encodePacked(
            '{"name": "TestNFT #',
            Strings.toString(tokenId),
            '", "description": "TestNFT is a full on-chain text NFT.", "image": "data:image/svg+xml;base64,',
            Base64.encode(bytes(svg)),
            '"}'
        );
        return string(abi.encodePacked("data:application/json;base64,", Base64.encode(json)));
       }

        function getSVG() public pure returns (string memory) {
            return string(abi.encodePacked(
                '<svg width="300" height="300" viewBox="0, 0, 300, 300" xmlns="http://www.w3.org/2000/svg">',
                '<rect width="100%" height="100%" fill="#f2eecb" />',
                '<foreignObject x="10" y="10" width="280" height="280">',
                '<div xmlns="http://www.w3.org/1999/xhtml" style="font-size:x-small;text-indent:1em">',
                '<p>A. D. 10,000. more than six hundred years of age, was walking with a boy through a great museum. The people who were moving around them had beautiful forms, and faces which were indescribably refined and spiritual.</p>',
                '<p>"Father," said the boy, "you promised to tell me to-day about the Dark Ages. I like to hear how men lived and thought long ago."</p>',
                '<p>"It is no easy task to make you understand the past," was the reply. "It is hard to realize that man could have been so ignorant as he was eight thousand years ago, but come with me; I will show you something."</p>',
                '<p>He led the boy to a cabinet containing a few time-worn books bound in solid gold.</p>',
                '</div></foreignObject></svg>'
            ));
        }
    }