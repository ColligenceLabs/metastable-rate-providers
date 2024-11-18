// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/security/PausableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "./interfaces/IRateProvider.sol";
import "./interfaces/IStKaia.sol";

contract StKaiaRateProvider is
    OwnableUpgradeable,
    IRateProvider,
    PausableUpgradeable
{
    IStKaia public StKaia;

    modifier validAddress(address value) {
        require(value != address(0), "StKaiaRateProvider:: address is zero");
        _;
    }

    event  SetStKaia(address);

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize(address _StKaia)
        external
        initializer
        validAddress(_StKaia)
    {
        __Pausable_init_unchained();
        __Ownable_init_unchained();

        StKaia = IStKaia(_StKaia);
        emit SetStKaia(_StKaia);
    }

    function getRate() external view override returns (uint256) {
        return StKaia.getRatioNativeTokenByStakingToken(1e18);
    }

    function setStKaia(address _StKaia) public onlyOwner() {
        StKaia = IStKaia(_StKaia);
        emit SetStKaia(_StKaia);
    }
}
