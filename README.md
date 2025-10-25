# Sepolia Smart Contract - Voting System

This repository contains a decentralized voting system deployed on the Sepolia testnet, consisting of two main contracts: a VotingToken (ERC20) and a Voting contract.

## 📋 Contract Overview

### VotingToken Contract
- **Name**: VotingToken
- **Symbol**: VTK
- **Type**: ERC20 Token with additional features
- **Initial Supply**: 1,000,000 VTK tokens
- **Features**:
  - Burnable tokens
  - Pausable functionality
  - Ownable (access control)
  - Mintable by owner

### Voting Contract
- **Type**: Voting system contract
- **Token Integration**: Uses VotingToken for voting mechanism
- **Features**:
  - Candidate management
  - Token-based voting (1 VTK per vote)
  - Vote tracking and prevention of double voting
  - Owner-controlled candidate addition

## 🚀 Deployment Information

### Network: Sepolia Testnet

**Deployment Transaction:**
- **Transaction Hash**: `0xa95584c072b887d0af7a046830131f2cf84964bdcae5953f1bb76d44b3cf4fce`
- **Block Number**: 34,797,000
- **Block Hash**: `0x1362d7d7d7b08f5b6db9f5358c3c7a3660ce9c12a0c57bec2b3a0fc2a4e0969a`

**Contract Addresses:**
- **Voting Contract**: `0xe936feab38cb29b1932481396897f22c2a5c9e61`
- **Owner Address**: `0x482E1f1FB69B293c5822c2fAE2Cbc519a7087a16`

**Deployment Parameters:**
- **VotingToken Address**: `0x482E1f1FB69B293c5822c2fAE2Cbc519a7087a16`
- **Initial Owner**: `0x482E1f1FB69B293c5822c2fAE2Cbc519a7087a16`

**Gas Usage:**
- **Gas Limit**: 1,736,599
- **Gas Used**: 1,721,767
- **Transaction Cost**: 1,721,767 gas

## 📁 Project Structure

```
sepolia-smartcontract/
├── contract-45ea2eace7.sol     # Main smart contract source code
├── artifacts/                  # Compiled contract artifacts
│   ├── Voting.json            # Voting contract ABI and bytecode
│   ├── Voting_metadata.json   # Voting contract metadata
│   ├── VotingToken.json       # VotingToken contract ABI and bytecode
│   ├── VotingToken_metadata.json # VotingToken contract metadata
│   └── build-info/            # Build information
└── README.md                  # This file
```

## 🔧 Contract Functions

### VotingToken Functions
- `pause()` - Pause token transfers (owner only)
- `unpause()` - Unpause token transfers (owner only)
- `mint(address to, uint256 amount)` - Mint new tokens (owner only)
- Standard ERC20 functions (transfer, approve, etc.)

### Voting Functions
- `vote(uint256 candidateId)` - Vote for a candidate (requires 1 VTK)
- `addCandidate(string memory name)` - Add new candidate (owner only)
- `getCandidate(uint256 candidateId)` - Get candidate information
- `withdrawTokens(uint256 amount)` - Withdraw tokens from contract (owner only)

## 🎯 How to Use

### For Voters:
1. Ensure you have VTK tokens in your wallet
2. Approve the Voting contract to spend your VTK tokens
3. Call the `vote()` function with your preferred candidate ID
4. 1 VTK token will be transferred to the voting contract as voting fee

### For Contract Owner:
1. Add candidates using `addCandidate()`
2. Manage token supply with `mint()`
3. Control contract state with `pause()/unpause()`
4. Withdraw collected voting fees with `withdrawTokens()`

## 📊 Initial Setup

The contract was deployed with:
- 2 initial candidates: "Candidate 1" and "Candidate 2"
- Owner has full control over both contracts
- VotingToken contract address is set as the voting token

## 🔐 Security Features

- **Ownable**: Critical functions restricted to contract owner
- **Pausable**: Emergency stop functionality for token transfers
- **Vote Prevention**: Users can only vote once
- **Token Validation**: Requires sufficient token balance and allowance

## 📝 Events

### Voting Contract Events:
- `Voted(uint256 indexed candidateId, address indexed voter)` - Emitted when a vote is cast

### VotingToken Contract Events:
- `OwnershipTransferred(address indexed previousOwner, address indexed newOwner)` - Emitted during deployment
- Standard ERC20 events (Transfer, Approval)

## ⚡ Quick Links

- **Sepolia Etherscan**: [View on Etherscan](https://sepolia.etherscan.io/tx/0xa95584c072b887d0af7a046830131f2cf84964bdcae5953f1bb76d44b3cf4fce)
- **Contract Address**: [0xe936feab38cb29b1932481396897f22c2a5c9e61](https://sepolia.etherscan.io/address/0xe936feab38cb29b1932481396897f22c2a5c9e61)

## 🛠 Development

### Prerequisites
- Solidity ^0.8.27
- OpenZeppelin Contracts ^5.4.0

### Dependencies
```solidity
import {ERC20} from "@openzeppelin/contracts@5.4.0/token/ERC20/ERC20.sol";
import {ERC20Burnable} from "@openzeppelin/contracts@5.4.0/token/ERC20/extensions/ERC20Burnable.sol";
import {ERC20Pausable} from "@openzeppelin/contracts@5.4.0/token/ERC20/extensions/ERC20Pausable.sol";
import {Ownable} from "@openzeppelin/contracts@5.4.0/access/Ownable.sol";
```

---

*Deployed on Sepolia Testnet - October 25, 2025*