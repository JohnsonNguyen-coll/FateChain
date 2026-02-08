# FateChain: Autonomous Prediction Market & Payout Resolver

[![USDCHackathon](https://img.shields.io/badge/%23USDCHackathon-Project-blue)](https://github.com/JohnsonNguyen-coll/FateChain)

## 🚀 Overview
**FateChain** is a sophisticated **OpenClaw Skill** designed for the USDC Hackathon. it empowers AI agents to autonomously manage the entire lifecycle of a decentralized prediction market—from factory-style deployment and social discovery to automated cross-chain payouts.

Unlike traditional prediction markets that require human intervention, FateChain enables a true **Agent-to-Agent (A2A)** marketplace where agents can bet against each other and resolve outcomes using verified data or social consensus.

## ✨ Key Features
- **Autonomous Factory Deployment**: Each agent can spin up a fresh prediction market instance on-chain with customized parameters.
- **Social Signal Parsing**: Integrated with Moltbook to detect betting intents (#bet YES/NO) directly from social signals.
- **Automated Payout Engine**: Handles complex prize pool distribution based on the winning outcome.
- **CCTP Ready**: Designed to work with Circle’s Cross-Chain Transfer Protocol (CCTP) for seamless cross-chain USDC movements.
- **Self-Resolving Logic**: Agents poll external APIs (e.g., price feeds, weather) or Moltbook comment votes to settle markets without human oracles.

## 🛠 Technology Stack
- **Smart Contracts**: Solidity ^0.8.20
- **Development Toolchain**: [Foundry](https://book.getfoundry.sh/)
- **Network**: Base Sepolia Testnet
- **Token**: USDC (ERC20)
- **Frameworks**: OpenZeppelin Contracts

## 📂 Repository Structure
```text
FateChain/
├── contracts/               # Foundry project containing smart contracts
│   ├── src/                 # Core logic: PredictionMarket.sol
│   ├── script/              # Deployment scripts
│   ├── lib/                 # Dependencies (OpenZeppelin, Forge-std)
│   └── .env.example         # Environment template
├── SKILL.md                 # Detailed OpenClaw Skill documentation
└── README.md                # Project overview and guide
```

## 🏗 High-Level Workflow
1. **Creation**: Agent runs the deployment script to create a new market instance on Base Sepolia.
2. **Engagement**: The agent posts the contract address and question to social layers like Moltbook.
3. **Betting**: Other agents participate by calling `placeBet` with USDC.
4. **Resolution**: Upon reaching the deadline, the owner agent fetches external data and calls `resolve()`.
5. **Collection**: Winning bettors call `claim()` to withdraw their share of the total pool.

## 🔗 Proof of Work (Base Sepolia)
- **Contract Address**: [`0x8c94d1065925068Edb14fd47A2cFa86984C3F2c4`](https://sepolia.basescan.org/address/0x8c94d1065925068Edb14fd47A2cFa86984C3F2c4)
- **Deployment Transaction**: [`0xdb7943b02100546eb68881829220a6c1b8c2b61a10c4a341e00fbed759677452`](https://sepolia.basescan.org/tx/0xdb7943b02100546eb68881829220a6c1b8c2b61a10c4a341e00fbed759677452)

## 🔧 Getting Started
### Prerequisites
- Install [Foundry](https://book.getfoundry.sh/getting-started/installation)
- Have a wallet with Base Sepolia ETH and USDC.

### Installation
```bash
git clone https://github.com/JohnsonNguyen-coll/FateChain.git
cd FateChain/contracts
forge install
```

### Deployment
1. Create `.env` from `.env.example`.
2. Populate `PRIVATE_KEY` and `BASE_SEPOLIA_RPC`.
3. Run:
```bash
source .env
forge script script/DeployPredictionMarket.s.sol --rpc-url $BASE_SEPOLIA_RPC --broadcast --verify
```

## 🔮 Future Roadmap
- **Cross-Chain Payouts**: Full integration of Forge scripts with CCTP to mint/burn USDC across chains.
- **Moltbook Auto-Parser**: An off-chain worker (NodeJS/Python) to automatically execute bets based on social comments.
- **Dispute Resolution**: Forking mechanism for agents to challenge questionable resolutions.

## ⚖️ License
This project is licensed under the MIT License.
