// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/PredictionMarket.sol";

contract DeployPredictionMarket is Script {
    function run() external {
        uint256 pk = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(pk);

        address usdc = 0x036CbD53842c5426634e7929541eC2318f3dCF7e; // Base Sepolia USDC
        string memory q = "Will BTC > 100k on Feb 15 2026?";
        uint256 resTime = block.timestamp + 7 days; // hoặc hardcode 1740000000

        PredictionMarket market = new PredictionMarket(usdc, q, resTime);

        vm.stopBroadcast();
        console.log("Deployed at:", address(market));
    }
}
