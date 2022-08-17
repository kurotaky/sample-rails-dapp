// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SampleERC721 is ERC721URIStorage , Ownable {
    using Strings for uint256;
    using Counters for Counters.Counter;
    Counters.Counter private _current_token_id;
    string base_uri = "";
    constructor () ERC721 ("SampleERC721", "SMP721") {}
    function mint () public returns (uint256) { 
        uint256 _token_id = _current_token_id.current();
        _mint(msg.sender, _token_id);
        _setTokenURI(_token_id, string(abi.encodePacked(_token_id.toString(), ".json")));
        _current_token_id.increment();
        return _token_id;
    }

    function _baseURI() internal view virtual override returns (string memory)  {
        return base_uri;
    }

    function setBaseURI(string calldata _base_uri) public {
        require(msg.sender == owner());
        base_uri = _base_uri;
    }
}