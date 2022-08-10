// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./Questionnaire.sol";

contract QuestionnaireFactory {
    Questionnaire[] public questions;
    event QuestionCreated(Questionnaire indexed question);

    constructor() {}

    function createQuestionnaire(string memory _question, bytes32 _answer) public {
        Questionnaire question = new Questionnaire(_question, _answer);
        questions.push(question);
        emit QuestionCreated(question);
    }

    function getQuestions() public view returns (Questionnaire[] memory) {
        return questions;
    }
}