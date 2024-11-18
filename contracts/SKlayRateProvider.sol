// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/security/PausableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "./interfaces/IRateProvider.sol";
import "./interfaces/ISKlay.sol";

contract SKlayRateProvider is
    OwnableUpgradeable,
    IRateProvider,
    PausableUpgradeable
{
    ISKlay public SKlay;

    modifier validAddress(address value) {
        require(value != address(0), "SKlayRateProvider:: address is zero");
        _;
    }

    event SetSKlay(address);

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize(address _SKlay)
        external
        initializer
        validAddress(_SKlay)
    {
        __Pausable_init_unchained();
        __Ownable_init_unchained();

        SKlay = ISKlay(_SKlay);
        emit SetSKlay(_SKlay);
    }

    function getRate() external view override returns (uint256) {
        (uint256 x, uint256 y) = SKlay.getPoolStat();
        return  SafeMath.div(y*1e18, x);
    }

    function setSKlay(address _SKlay) public onlyOwner() {
        SKlay = ISKlay(_SKlay);
        emit SetSKlay(_SKlay);
    }
}
