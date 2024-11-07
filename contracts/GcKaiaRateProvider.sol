pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/security/PausableUpgradeable.sol";
import "./interfaces/IRateProvider.sol";
import "./interfaces/IwGcKAIA.sol";

contract GcKaiaRateProvider is IRateProvider, PausableUpgradeable {
    IwGcKAIA public wGcKAIA;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    modifier validAddress(address value) {
        require(value != address(0), "KoKaiaRateProvider:: address is zero");
        _;
    }

    function initialize(address _wGcKAIA)
        external
        initializer
        validAddress(_wGcKAIA)
    {
        __Pausable_init_unchained();

        wGcKAIA = IwGcKAIA(_wGcKAIA);
    }

    function getRate() external view override returns (uint256) {
        return wGcKAIA.getGCKLAYByWGCKLAY(1e18);
    }
}
