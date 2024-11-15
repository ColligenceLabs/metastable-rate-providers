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
    uint256 public rate;
    ISKlay public SKlay;
    bool public isSet;

    modifier validAddress(address value) {
        require(value != address(0), "SKlayRateProvider:: address is zero");
        _;
    }

    modifier isNotSet() {
        require(isSet != true, "SKlayRateProvider:: SKLAY is already set");
        _;
    }

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

    function getRate() external view override returns (uint256) {
        (uint256 x, uint256 y) = SKlay.getPoolStat();
        return  SafeMath.div(y*1e18, x);
    }

    function setSKlay(address _SKlay) public onlyOwner() {
        SKlay = ISKlay(_SKlay);
        isSet = true;
    }
}
