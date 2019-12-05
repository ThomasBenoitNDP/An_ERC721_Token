pragma solidity ^0.5.1;

contract ERC721Simple {
 event Transfer(address indexed _from, address indexed _to, uint256 _tokenId);

 function balanceOf(address _owner) public view returns (uint256 balance);
 function ownerOf(uint256 _tokenId) public view returns (address _owner);
 function exists(uint256 _tokenId) public view returns (bool exists);

 function transferFrom(address _from, address _to, uint256 _tokenId) external;
}
