// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/Script.sol";
import "../src/SimpleLiquidityRebalancer.sol";

contract DeploySimpleLiquidityRebalancer is Script {
    function run () external {
        vm.startBroadcast();

        SimpleLiquidityRebalancer rebalancer = new SimpleLiquidityRebalancer(2000,500);

        console.log("Deployed SimpleLiquidityRebalancer at: ", address(rebalancer));

        vm.stopBroadcast();
    }
}
