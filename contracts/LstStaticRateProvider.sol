// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/security/PausableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "./interfaces/IRateProvider.sol";

contract LstStaticRateProvider is OwnableUpgradeable, IRateProvider, PausableUpgradeable {
    uint256 public rate;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize(uint256 _rate)
        external
        initializer
    {
        __Pausable_init_unchained();
        __Ownable_init_unchained();

        require(_rate > 0, "LstStaticRateProvider:: rate should be bigger than zero");
        rate = _rate;
    }

    function setRate(uint256 _rate) public onlyOwner() {
        rate = _rate;
    }

    function getRate() external view override returns (uint256) {
        return rate;
    }
}
