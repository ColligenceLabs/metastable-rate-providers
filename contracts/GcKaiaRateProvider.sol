pragma solidity ^0.8.0;

import "./interfaces/IRateProvider.sol";
import "./interfaces/IwGcKAIA.sol";

contract GcKaiaRateProvider is IRateProvider {
    IwGcKAIA public immutable wGcKAIA;

    constructor(IwGcKAIA _wGcKAIA) {
        wGcKAIA = _wGcKAIA;
    }

    function getRate() external view override returns (uint256) {
        return wGcKAIA.getGCKLAYByWGCKLAY(1e18);
    }
}
