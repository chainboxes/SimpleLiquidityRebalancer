// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/Test.sol";
import "../src/SimpleLiquidityRebalancer.sol";


contract SimpleLiquidityRebalancerTest is Test {
    SimpleLiquidityRebalancer rebalancer;

    function setUp() public {
        rebalancer = new SimpleLiquidityRebalancer(2000,500);
    }

    function testInitialState() public  {
        assertEq(rebalancer.owner(), address(this), "Owner Mismatch");
        assertEq(rebalancer.liquidity(), 1000, "Liquidity should be 1000");
        assertEq(rebalancer.lowerPrice(),1500, "Lower Price should be 1500");
        assertEq(rebalancer.upperPrice(), 2500, "Upper Price should be 2500");
    }


   function testNoRebalanceWithinRange() public {
    uint256 price = 1800;
    vm.warp(price);
    rebalancer.checkAndRebalance();
    assertEq(rebalancer.liquidity(), 1000, "Liquidity should Not Change");
   }

   function testRebalanceWhenOutOfRange() public {
    uint256 price = 2700;
    vm.warp(price);
    rebalancer.checkAndRebalance();

    assertEq(rebalancer.liquidity(), 1000, "Liquidity should be ReAdded");
    assertEq(rebalancer.lowerPrice(), 2200, "Lower price should be updated");
    assertEq(rebalancer.upperPrice(), 3200, "Upper price should be updated");
   }

   function testRebalanceWhenPriceDrops() public {
    uint256 price = 1200; 
    vm.warp(price); 
    rebalancer.checkAndRebalance();

    assertEq(rebalancer.liquidity(), 1000, "Liquidity should be re-added");
    assertEq(rebalancer.lowerPrice(), 700, "Lower price should be updated");
    assertEq(rebalancer.upperPrice(), 1700, "Upper price should be updated");
}
 
}
