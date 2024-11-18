pragma solidity ^0.8.0;

interface IwKoKAIA {
    function getWrappedAmount(uint256) external view returns (uint256);
    function getUnwrappedAmount(uint256) external view returns (uint256);
}
