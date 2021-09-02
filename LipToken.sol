// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract LipToken is ERC721, Ownable {
    constructor(string memory _name, string memory _symbol)
        ERC721(_name, _symbol)
    {}

    uint256 COUNTER;

    struct Lip {
        string name;
        uint256 id;
        uint256 dna;
        uint8 level;
        uint8 rarity;
    }

    Lip[] public lips;

    event NewLip(address indexed owner, uint256 id, uint256 dna);

    function _genRandomDna(string memory _str) internal pure returns (uint256) {
        uint256 randomNum = uint256(keccak256(abi.encodePacked(_str)));
        return randomNum % 10**16;
    }

    function _createLip(string memory _name, uint256 _dna) internal {
        Lip memory newlip = Lip(_name, COUNTER, _dna, 1, 50);
        lips.push(newlip);
        _safeMint(msg.sender, COUNTER);
        emit NewLip(msg.sender, COUNTER, _dna);
        COUNTER++;
    }

    function createRandomLip(string memory _name) public {
        uint256 randDna = _genRandomDna(_name);
        _createLip(_name, randDna);
    }

    function getLips() public view returns (Lip[] memory) {
        return lips;
    }
}
