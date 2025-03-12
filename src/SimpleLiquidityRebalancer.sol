// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract SimpleLiquidityRebalancer {
    address public owner;
    uint256 public lowerPrice;
    uint256 public upperPrice;
    uint256 public liquidity;

    event LiquidityAdded(uint256 amount, uint256 newLower, uint256 newUpper );
    event LiquidityRemoved(uint256 amount); 

    constructor(uint256 _initialPrice, uint256 _range) {
        owner = msg.sender;
        lowerPrice = _initialPrice - _range;
        upperPrice = _initialPrice + _range;
        liquidity = 1000; 
    }

    modifier onlyOwner () {
        require (msg.sender == owner, "Not The Owner");
        _;
    }

    function getCurrentPrice() public view returns (uint256) {
        return block.timestamp % 3000;
    }

    function checkAndRebalance () public onlyOwner {
        uint256 currentPrice = getCurrentPrice();

        if (currentPrice < lowerPrice || currentPrice > upperPrice) {
            _rebalanceLiquidity(currentPrice);
        }
    }
    
    function _rebalanceLiquidity (uint256 newPrice) internal {
       emit LiquidityRemoved(liquidity);
       liquidity = 0;

       lowerPrice = newPrice - 500;
       upperPrice = newPrice + 500;

       liquidity = 1000;
       emit LiquidityAdded(liquidity, lowerPrice, upperPrice);

    }
}
