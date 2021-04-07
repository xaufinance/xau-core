pragma solidity ^0.6.0;

import "./UniswapPairMock.sol";

contract UniswapPairMock1 is UniswapPairMock {

    constructor (
        uint112 _reserve0mock,
        uint112 _reserve1mock,
        uint32 _blockTimestampLastmock,
        uint _price0Cumulative,
        uint _price1Cumulative,
        uint256 _mockedTotalSupply
    ) public UniswapPairMock(
        _reserve0mock,
        _reserve1mock,
        _blockTimestampLastmock,
        _price0Cumulative,
        _price1Cumulative,
        _mockedTotalSupply
    ) {
    }

}
