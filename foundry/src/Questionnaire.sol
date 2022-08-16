// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Questionnaire{
    bytes32 public hashedAnswer;
    bytes32 public salt = bytes32("190190190"); 
    string public question;
    event QuestionnaireFunded(uint256 amount);
    event AnswerGuessed();

    constructor(string memory _question, bytes32 _hashedanswer) payable{
        question = _question;
        hashedAnswer = _hashedanswer;
    }

    function guess(string calldata answer) public {
        require(keccak256(abi.encodePacked(salt, answer)) == hashedAnswer);
        if (address(this).balance > 0) {
            emit AnswerGuessed();
            payable(msg.sender).transfer(address(this).balance);            
        }
    }

    fallback() external payable {
        emit QuestionnaireFunded(address(this).balance);
    }

    receive() external payable {
        emit QuestionnaireFunded(address(this).balance);
    }
}