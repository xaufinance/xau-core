// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

interface AggregatorInterface {
  function currentAnswer() external view returns (int256);
  function updatedHeight() external view returns (uint256);
}
