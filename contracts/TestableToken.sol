// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import "./Token.sol";

// Testable descendant exposing internal members
contract TestableToken is XAUToken {

    using SafeMath for uint256;

    uint256 public _getTWAPResult;

    constructor(
      string memory __name,
      string memory __symbol,
      uint256 __initialSupply
    ) XAUToken(
      __name,
      __symbol,
      __initialSupply
    )
        public
    {
    }

    function _setScalingFactor(uint256 newScalingFactor)
        public
    {
        xauScalingFactor = newScalingFactor;
        _totalSupply = _fromUnderlying(initialSupplyUnderlying);
    }

}
