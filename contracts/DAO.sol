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
        memberInfo[_member] = Member({memberAddress: _member, memberSince: block.timestamp, tokenBalance: 100});
        members.push(_member);
        balances[_member] = 100;
        totalSupply += 100;
    }

    function removeMember(address _member) public {
        require(memberInfo[_member].memberAddress != address(0), "Member does not exist");
        memberInfo[_member] = Member({memberAddress: address(0), memberSince: 0, tokenBalance: 0});
        for (uint i = 0; i < members.length; i++) {
            if (members[i] == _member) {
                members[i] = members[members.length - 1];
                members.pop();
                break;
            }
        }
        balances[_member] = 0;
        totalSupply -= 100;
    }

    function createProposal(string memory _description) public {
        proposals.push(Proposal({description: _description, voteCount: 0, executed: false}));
        emit ProposalCreated(proposals.length - 1, _description);
    }
}
