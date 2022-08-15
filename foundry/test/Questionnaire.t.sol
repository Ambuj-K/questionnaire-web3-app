// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "../src/Questionnaire.sol";

contract QuestionnaireTest is Test {
    Questionnaire public game;
    function setUp() public {
        string memory question = "What is the final destination of ours at the job?";
        string memory answer = "new guy";
        bytes32 salt = bytes32("190190190"); 
        bytes32 hashedAnswer = keccak256(abi.encodePacked(salt, answer));
        emit log_bytes32(hashedAnswer);
        game = new Questionnaire(question, hashedAnswer);
        emit log(game.question());

    }

    function testExample() public {
        assertTrue(true);
    }
}
