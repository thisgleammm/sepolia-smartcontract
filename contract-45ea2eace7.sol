// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.4.0
pragma solidity ^0.8.27;

import {ERC20} from "@openzeppelin/contracts@5.4.0/token/ERC20/ERC20.sol";
import {ERC20Burnable} from "@openzeppelin/contracts@5.4.0/token/ERC20/extensions/ERC20Burnable.sol";
import {ERC20Pausable} from "@openzeppelin/contracts@5.4.0/token/ERC20/extensions/ERC20Pausable.sol";
import {Ownable} from "@openzeppelin/contracts@5.4.0/access/Ownable.sol";

contract VotingToken is ERC20, ERC20Burnable, ERC20Pausable, Ownable {
    constructor(address recipient, address initialOwner)
        ERC20("VotingToken", "VTK")
        Ownable(initialOwner)
    {
        _mint(recipient, 1_000_000 * 10 ** decimals());
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    // The following function is required by Solidity for multiple inheritance.
    function _update(address from, address to, uint256 value)
        internal
        override(ERC20, ERC20Pausable)
    {
        super._update(from, to, value);
    }
}

contract Voting is Ownable {
    struct Candidate {
        uint256 id;
        string name;
        uint256 voteCount;
    }

    VotingToken public votingToken;
    mapping(uint256 => Candidate) public candidates;
    mapping(address => bool) public voters;
    uint256 public candidatesCount;

    event Voted(uint256 indexed candidateId, address indexed voter);

    constructor(address _votingToken, address initialOwner) Ownable(initialOwner) {
        votingToken = VotingToken(_votingToken);
        _addCandidate("Candidate 1");
        _addCandidate("Candidate 2");
    }

    function addCandidate(string memory _name) public onlyOwner {
        _addCandidate(_name);
    }

    function _addCandidate(string memory _name) internal {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    function vote(uint256 _candidateId) public {
        require(!voters[msg.sender], "You have already voted");
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate");

        uint256 votingCost = 1 * 10 ** votingToken.decimals();
        require(votingToken.balanceOf(msg.sender) >= votingCost, "Not enough tokens to vote");
        require(
            votingToken.allowance(msg.sender, address(this)) >= votingCost,
            "Approve tokens first"
        );

        bool ok = votingToken.transferFrom(msg.sender, address(this), votingCost);
        require(ok, "Transfer failed");

        voters[msg.sender] = true;
        candidates[_candidateId].voteCount += 1;

        emit Voted(_candidateId, msg.sender);
    }

    function getCandidate(uint256 _candidateId)
        public
        view
        returns (uint256 id, string memory name, uint256 voteCount)
    {
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate");
        Candidate memory candidate = candidates[_candidateId];
        return (candidate.id, candidate.name, candidate.voteCount);
    }

    function withdrawTokens(uint256 amount) public onlyOwner {
        require(votingToken.balanceOf(address(this)) >= amount, "Not enough tokens in contract");
        bool ok = votingToken.transfer(msg.sender, amount);
        require(ok, "Transfer failed");
    }
}
