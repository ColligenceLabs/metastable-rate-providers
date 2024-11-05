// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

interface IwGcKAIA {
    //Wrap
    function getWGCKLAYByGCKLAY(uint256) external view returns (uint256);
    // Unwrap
    function getGCKLAYByWGCKLAY(uint256) external view returns (uint256);
}
