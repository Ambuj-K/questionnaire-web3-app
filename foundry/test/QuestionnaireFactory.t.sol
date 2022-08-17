// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "../src/QuestionnaireFactory.sol";

contract QuestionnaireFactoryTest is DSTest {
    QuestionnaireFactory public factory;

    function setUp() public {
        factory = new QuestionnaireFactory();
    }

    function testCreateQuestionnaire() public {
        string memory question = "What is the final destination of ours at the job?";
        string memory answer = "new guy";
        bytes32 salt = bytes32("190190190"); 
        bytes32 hashedAnswer = keccak256(abi.encodePacked(salt, answer));
        factory.createQuestionnaire(question, hashedAnswer);
        Questionnaire question_s = factory.questions(0);
        assertEq(keccak256(abi.encodePacked(question_s.question())), keccak256(abi.encodePacked(question)));
    }


    function testGetQuestions() public {
        string memory question = "What is the final destination of ours at the job?";
        string memory answer = "new guy";
        bytes32 salt = bytes32("190190190"); 
        bytes32 hashedAnswer = keccak256(abi.encodePacked(salt, answer));
        factory.createQuestionnaire(question, hashedAnswer);
        factory.createQuestionnaire(question, hashedAnswer);
        Questionnaire[] memory questions = factory.getQuestions();
        assertEq(questions.length, 2);
    }

}