// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./interfaces/IRateProvider.sol";

contract LstStaticRateProvider is Ownable, IRateProvider {
    uint256 public rate;

    constructor(uint256 _rate){
        rate = _rate;
    }

    function setRate(uint256 _rate) public onlyOwner() {
        rate = _rate;
    }

    function getRate() external view override returns (uint256) {
        return rate;
    }
}
