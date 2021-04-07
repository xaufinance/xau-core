// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

import "./TestableRebaser.sol";

contract TestableUsdRebaser is TestableRebaser {

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
    ) TestableRebaser(
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

}
