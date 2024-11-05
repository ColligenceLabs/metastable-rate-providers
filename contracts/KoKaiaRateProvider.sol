pragma solidity ^0.8.0;

import "./interfaces/IRateProvider.sol";
import "./interfaces/IwKoKAIA.sol";

contract KoKaiaRateProvider is IRateProvider {
    IwKoKAIA public immutable wKoKAIA;

    constructor(IwKoKAIA _wKoKAIA) {
        wKoKAIA = _wKoKAIA;
    }

    function getRate() external view override returns (uint256) {
        return wKoKAIA.getUnwrappedAmount(1e18);
    }
}
