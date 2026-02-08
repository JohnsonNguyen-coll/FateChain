// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract PredictionMarket {
    IERC20 public immutable usdc;
    address public immutable owner;
    uint256 public immutable resolutionTime;
    string public question;
    bool public resolved;
    bool public winningOutcome;

    mapping(address => uint256) public betsYes;
    mapping(address => uint256) public betsNo;
    uint256 public totalYes;
    uint256 public totalNo;

    event BetPlaced(address bettor, bool outcome, uint256 amount);
    event Resolved(bool winningOutcome);
    event Claimed(address claimer, uint256 amount);

    constructor(address _usdc, string memory _question, uint256 _resolutionTime) {
        usdc = IERC20(_usdc);
        owner = msg.sender;
        question = _question;
        resolutionTime = _resolutionTime;
    }

    function placeBet(bool _outcome, uint256 _amount) external {
        require(!resolved, "Already resolved");
        require(block.timestamp < resolutionTime, "Time over");
        usdc.transferFrom(msg.sender, address(this), _amount);
        if (_outcome) { betsYes[msg.sender] += _amount; totalYes += _amount; }
        else { betsNo[msg.sender] += _amount; totalNo += _amount; }
        emit BetPlaced(msg.sender, _outcome, _amount);
    }

    function resolve(bool _winningOutcome) external {
        require(msg.sender == owner, "Only owner");
        require(!resolved, "Already resolved");
        require(block.timestamp >= resolutionTime, "Too early");
        resolved = true;
        winningOutcome = _winningOutcome;
        emit Resolved(_winningOutcome);
    }

    function claim() external {
        require(resolved, "Not resolved");
        uint256 amount = winningOutcome 
            ? (totalYes + totalNo) * betsYes[msg.sender] / totalYes 
            : (totalYes + totalNo) * betsNo[msg.sender] / totalNo;
        if (amount > 0) {
            betsYes[msg.sender] = betsNo[msg.sender] = 0;
            usdc.transfer(msg.sender, amount);
            emit Claimed(msg.sender, amount);
        }
    }
}
