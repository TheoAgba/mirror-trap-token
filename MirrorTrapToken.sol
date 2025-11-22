// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract MirrorTrapToken {
    string public name = "MirrorTrap";
    string public symbol = "MTR";
    uint8 public decimals = 18;
    uint256 public totalSupply;

    mapping(address => uint256) public balanceOf;
    mapping(address => bool) public flagged;

    address public owner;
    uint256 public burnRate = 20; // 20 percent burn when trap triggers

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    constructor() {
        owner = msg.sender;
        totalSupply = 1_000_000 * 10**18;
        balanceOf[msg.sender] = totalSupply;
    }

    function transfer(address to, uint256 amount) public returns (bool) {
        _checkTrap(msg.sender);
        require(balanceOf[msg.sender] >= amount, "Insufficient balance");

        balanceOf[msg.sender] -= amount;
        balanceOf[to] += amount;
        return true;
    }

    function attemptDrain() public {
        if (!flagged[msg.sender]) {
            flagged[msg.sender] = true;
        } else {
            _mirrorAttack(msg.sender);
        }
    }

    function _mirrorAttack(address user) internal {
        uint256 amount = balanceOf[user];
        if (amount > 0) {
            uint256 burnAmount = (amount * burnRate) / 100;
            balanceOf[user] -= burnAmount;
            totalSupply -= burnAmount;
        }
        flagged[user] = false;
    }

    function _checkTrap(address user) internal {
        if (flagged[user]) {
            _mirrorAttack(user);
        }
    }

    function setBurnRate(uint256 newRate) public onlyOwner {
        burnRate = newRate;
    }
}
