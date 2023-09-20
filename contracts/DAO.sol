// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DAO {

	struct Proposal {
        string description;
        uint voteCount;
        bool executed;
    }

    struct Member {
		address memberAddress;
        uint memberSince;
        uint tokenBalance;
    }

    address[] public members;
    mapping(address => Member) public memberInfo;
    mapping(address => mapping(uint => bool)) public votes;
    Proposal[] public proposals;

    uint public totalSupply;
    mapping(address => uint) public balances;

    event ProposalCreated(uint indexed proposalId, string description);
    event VoteCast(address indexed voter, uint indexed proposalId, uint tokenAmount);
    event ProposalAccepted(string message);
    event ProposalRejected(string rejected);

    function addMember(address _member) public {
      require(memberInfo[_member].memberAddress == address(0), "Member already exists");
      memberInfo[_member] = Member({
          memberAddress: _member,
          memberSince: block.timestamp,
          tokenBalance: 100
      });
      members.push(_member);
      balances[_member] = 100;
      totalSupply += 100;
    }

}


