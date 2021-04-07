// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import "./lib/SafeMath.sol";
import "./lib/Context.sol";
import "./lib/Ownable.sol";
import "./lib/Address.sol";
import "./lib/IXAUToken.sol";
import "./lib/IFeeApprover.sol";
import "./lib/IUniswapV2Factory.sol";
import "./lib/IUniswapV2Router02.sol";
import "./lib/IUniswapV2Pair.sol";
import "./lib/IWETH.sol";

contract LiquidityMigrator is Context, Ownable {
    using SafeMath for uint256;
    using Address for address;

    IXAUToken public xauToken;

    IUniswapV2Router02 public uniswapRouterV2;
    IUniswapV2Factory public uniswapFactory;

    address public tokenUniswapPair;

    address public migrator;

    modifier onlyMigrator() {
        require(msg.sender == migrator);
        _;
    }

    constructor (IXAUToken _xauToken) public {
        xauToken = _xauToken;
        migrator = msg.sender;
        uniswapRouterV2 = IUniswapV2Router02(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D);
        uniswapFactory = IUniswapV2Factory(0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f);
        createUniswapPairMainnet(_xauToken);
    }

    function emergencyTokenWithdraw() public onlyMigrator {
        xauToken.transfer(address(migrator), xauToken.balanceOf(address(this)));
    }

    function emergencyETHWithdraw() public onlyMigrator {
        (bool success, ) = msg.sender.call.value(address(this).balance)("");
        require(success, "Transfer failed.");
        totalETHBalance = 0;
    }

    function tokenBalance() public view returns (uint256) {
        return xauToken.balanceOf(address(this));
    }

    function ethBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function createUniswapPairMainnet(IXAUToken _xauToken) public returns (address) {
        require(tokenUniswapPair == address(0), "Token: pool already created");
        tokenUniswapPair = uniswapFactory.createPair(
            address(uniswapRouterV2.WETH()),
            address(_xauToken)
        );
        return tokenUniswapPair;
    }

    uint256 public totalLPTokensMinted;
    uint256 public totalETHBalance;

    function addLiquidityToUniswapXAUxWETHPair() public onlyMigrator {
        totalETHBalance = address(this).balance;
        IUniswapV2Pair pair = IUniswapV2Pair(tokenUniswapPair);
        address WETH = uniswapRouterV2.WETH();
        IWETH(WETH).deposit{value : totalETHBalance}();
        IWETH(WETH).transfer(address(pair), totalETHBalance);
        xauToken.transfer(address(pair), xauToken.balanceOf(address(this)));
        pair.mint(address(this));
        totalLPTokensMinted = pair.balanceOf(address(this));
    }


    function addLiquidity() public payable onlyMigrator {
        totalETHBalance = totalETHBalance.add(msg.value); 
    }
    
    //NOTE: Possible to send LP tokens directly in liquidity addition function
    function withdrawLPTokens() public onlyMigrator {
        IUniswapV2Pair pair = IUniswapV2Pair(tokenUniswapPair);
        require(pair.balanceOf(address(this)) > 0, "No LP Tokens on contract");
        pair.transfer(msg.sender, pair.balanceOf(address(this))); 
    }
}
