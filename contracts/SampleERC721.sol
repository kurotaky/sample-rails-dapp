// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "contracts/openzeppelin-contracts/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "contracts/openzeppelin-contracts/contracts/utils/Counters.sol";
import "contracts/openzeppelin-contracts/contracts/access/Ownable.sol";

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

    function allNfts() public view returns (string memory) {
        uint256 _token_id = _current_token_id.current();
        if (_token_id < 1) {
            return "[]";
        }

        string memory ret = "[";
        for (uint256 i = 0; i < _token_id; i++) {
            if (bytes(ret).length > 1) {
                ret = string.concat(ret, ",");
            }
            ret = string.concat(ret, nftToJson(i));
        }
        ret = string.concat(ret, "]");

        return ret;
    }

    function nftToJson(uint256 tokenId) private view returns (string memory) {
        string memory ret = "";
        ret = string.concat(ret, '{');

        ret = string.concat(ret, '"contract_address":');
        ret = string.concat(ret, '"');
        ret = string.concat(ret, addressToString(address(this)));
        ret = string.concat(ret, '"');

        ret = string.concat(ret, ',');

        ret = string.concat(ret, '"token_id":');
        ret = string.concat(ret, Strings.toString(tokenId));

        ret = string.concat(ret, ',');

        ret = string.concat(ret, '"token_uri":');
        ret = string.concat(ret, '"');
        ret = string.concat(ret, tokenURI(tokenId));
        ret = string.concat(ret, '"');

        ret = string.concat(ret, ',');

        ret = string.concat(ret, '"owner":');
        ret = string.concat(ret, '"');
        ret = string.concat(ret, addressToString(ownerOf(tokenId)));
        ret = string.concat(ret, '"');

        ret = string.concat(ret, '}');

        return ret;
    }

    function addressToString(address a) private pure returns (string memory) {
        return Strings.toHexString(uint256(uint160(a)), 20);
    }
}
