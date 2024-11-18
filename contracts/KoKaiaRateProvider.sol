// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/security/PausableUpgradeable.sol";
import "./interfaces/IRateProvider.sol";
import "./interfaces/IwKoKAIA.sol";

contract KoKaiaRateProvider is IRateProvider, PausableUpgradeable {
    IwKoKAIA public wKoKAIA;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    modifier validAddress(address value) {
        require(value != address(0), "KoKaiaRateProvider:: address is zero");
        _;
    }

    function initialize(address _wKoKAIA)
        external
        initializer
        validAddress(_wKoKAIA)
    {
        __Pausable_init_unchained();

        wKoKAIA = IwKoKAIA(_wKoKAIA);
    }

    function getRate() external view override returns (uint256) {
        return wKoKAIA.getUnwrappedAmount(1e18);
    }
}
