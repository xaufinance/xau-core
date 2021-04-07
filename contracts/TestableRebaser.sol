// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

import "./Rebaser.sol";

// Testable descendant exposing internal members
contract TestableRebaser is Rebaser {

    using SafeMath for uint256;

    uint256 public _getTWAPResult;

    constructor(
        address xauToken_,
        address reserveToken_,
        address uniswapPair_,
        address targetRateOracle1Address_,
        address targetRateOracle2Address_,
        uint8 targetRateOracleDecimals_,
        uint256 _minRebaseTimeIntervalSec,
        uint256 _rebaseWindowOffsetSec,
        uint256 _rebaseWindowLengthSec,
        uint256 _rebaseDelay
    ) Rebaser(
        xauToken_,
        reserveToken_,
        uniswapPair_,
        targetRateOracle1Address_,
        targetRateOracle2Address_,
        targetRateOracleDecimals_,
        _minRebaseTimeIntervalSec,
        _rebaseWindowOffsetSec,
        _rebaseWindowLengthSec,
        _rebaseDelay
    )
        public
    {
    }

    function _obeyMaxRebaseRatio(uint256 indexDelta, bool positive)
        public
        view
        returns (uint256)
    {
        return obeyMaxRebaseRatio(indexDelta, positive);
    }

    function _getTWAP()
        public
        returns (uint256)
    {
        return (_getTWAPResult = getTWAP());
    }

}
