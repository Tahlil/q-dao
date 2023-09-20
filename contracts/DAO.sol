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

}

