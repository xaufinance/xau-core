// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import "./ChainlinkOracleMock.sol";

contract EthUsdChainlinkOracleMock is ChainlinkOracleMock {

    constructor(uint256 _mockedPrice) ChainlinkOracleMock (_mockedPrice) public {
    }

}
