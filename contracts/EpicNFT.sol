pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

import { Base64 } from "./libraries/Base64.sol";

contract EpicNFT is ERC721URIStorage {
  using Counters for Counters.Counter;
  Counters.Counter private _tokenIds;

  uint8 numEpicNFTs;

  string baseSvg = "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><style>.base { fill: white; font-family: serif; font-size: 24px; }</style><rect width='100%' height='100%' fill='black' /><text x='50%' y='50%' class='base' dominant-baseline='middle' text-anchor='middle'>";

  string[] books = [
    "Awaken the Giant Within",
    "The 4 Hour Work Week",
    "Can't Hurt Me",
    "Atomic Habits",
    "12 Rules for life",
    "How to Win Friends and Influence People",
    "The Power of Myth",
    "The 5am Club",
    "Rich Dad, Poor Dad"
  ];

  string[] exercises = [
    "Bodybuilding",
    "Calisthenics",
    "Running",
    "Brazillian jui-jitsu",
    "Karate",
    "Capoeira",
    "Rock Climbing",
    "Powerlifting",
    "Krav Maga",
    "Muay Thai"
  ];

  string[] jobs = [
    "Twitter anon",
    "Day trader",
    "Programmer",
    "Sales VP",
    "Personal Trainer",
    "Ebay flipper",
    "Podcaster",
    "Homeless"
  ];

  event NewEpicNFTMinted(address sender, uint256 tokenId, string svg);

  constructor() ERC721 ("SquareNFT", "SQUARE") {
    console.log("lfg");
    numEpicNFTs = 0;
  }

  function pickRandomBook(uint256 tokenId) public view returns (string memory) {
    uint256 rand = random(string(abi.encodePacked("FIRST_WORD", Strings.toString(tokenId))));
    rand = rand % books.length;
    return books[rand];
  }

  function pickRandomExercise(uint256 tokenId) public view returns (string memory) {
    uint256 rand = random(string(abi.encodePacked("SECOND_WORD", Strings.toString(tokenId))));
    rand = rand % exercises.length;
    return exercises[rand];
  }

  function pickRandomJob(uint256 tokenId) public view returns (string memory) {
    uint256 rand = random(string(abi.encodePacked("THIRD_WORD", Strings.toString(tokenId))));
    rand = rand % jobs.length;
    return jobs[rand];
  }

  function random(string memory input) internal pure returns (uint256) {
    return uint256(keccak256(abi.encodePacked(input)));
  }

  function uintToString(uint _i) internal pure returns (string memory _uintAsString) {
    if (_i == 0) {
        return "0";
    }
    uint j = _i;
    uint len;
    while (j != 0) {
        len++;
        j /= 10;
    }
    bytes memory bstr = new bytes(len);
    uint k = len;
    while (_i != 0) {
      k = k-1;
      uint8 temp = (48 + uint8(_i - _i / 10 * 10));
      bytes1 b1 = bytes1(temp);
      bstr[k] = b1;
      _i /= 10;
    }
    return string(bstr);
  }

  function getNumNFTsMinted() public view returns (uint8 num) {
    num = numEpicNFTs;
  }

  function makeEpicNFT() public {
    require(numEpicNFTs < 100, "all self improovers have been minted");

    uint256 newItemId = _tokenIds.current();

    string[8] memory parts;

    parts[0] = '<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 350 350"><style>.base { font-family: serif; font-size: 14px; }</style><rect width="100%" height="100%" fill="white" />';

    parts[1] = '<text x="10" y="20" class="base">';

    parts[2] = pickRandomBook(newItemId);

    parts[3] = '</text><text x="10" y="40" class="base">';

    parts[4] = pickRandomJob(newItemId);

    parts[5] = '</text><text x="10" y="60" class="base">';

    parts[6] = pickRandomExercise(newItemId);

    parts[7] = '</text></svg>';

    string memory finalSvg = string(abi.encodePacked(parts[0], parts[1], parts[2], parts[3], parts[4], parts[5], parts[6], parts[7]));

    string memory name = string(abi.encodePacked("self improover #", uintToString(newItemId)));

    string memory json = Base64.encode(
      bytes(
        string(
          abi.encodePacked(
            '{"name": "',
            // We set the title of our NFT as the generated word.
            name,
            '", "description": "A highly acclaimed collection of squares.", "image": "data:image/svg+xml;base64,',
            // We add data:image/svg+xml;base64 and then append our base64 encode our svg.
            Base64.encode(bytes(finalSvg)),
            '"}'
          )
        )
      )
    );

    string memory finalTokenUri = string(
        abi.encodePacked("data:application/json;base64,", json)
    );

    _safeMint(msg.sender, newItemId);
  
    _setTokenURI(newItemId, finalTokenUri);

    _tokenIds.increment();

    console.log("An NFT w/ ID %s has been minted to %s", newItemId, msg.sender);

    numEpicNFTs += 1;

    emit NewEpicNFTMinted(msg.sender, newItemId, Base64.encode(bytes(finalSvg)));
  }
}