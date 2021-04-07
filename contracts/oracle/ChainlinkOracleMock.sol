// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

contract ChainlinkOracleMock {

    uint256 public price;

    constructor(uint256 _mockedPrice) public {
        price = _mockedPrice;
    }

    function setActualTestPrice(uint256 _mockedPrice) public {
        price = _mockedPrice;
    }

    function latestRoundData() external view returns (
      uint80 roundId,
      uint256 answer,
      uint256 startedAt,
      uint256 updatedAt,
      uint80 answeredInRound
    ) {
       roundId = answeredInRound = 1;
       startedAt = updatedAt = block.timestamp;
       answer = price;
    }
}
