pragma solidity ^0.8.0;

interface ISKlay {
    function getPoolStat() external view returns (uint256, uint256);
}
