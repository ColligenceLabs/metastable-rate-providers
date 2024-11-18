// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

interface IStKaia {
    function getRatioStakingTokenByNativeToken(uint256) external view returns (uint256);
    function getRatioNativeTokenByStakingToken(uint256) external view returns (uint256);
}
