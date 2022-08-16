// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "../src/Questionnaire.sol";

interface CheatCodes {
    function deal(address, uint256) external;
}

contract QuestionnaireTest is DSTest {
    Questionnaire public game;
    CheatCodes constant cheats = CheatCodes(HEVM_ADDRESS);

    function setUp() public {
        string memory question = "What is the final destination of ours at the job?";
        string memory answer = "new guy";
        bytes32 salt = bytes32("190190190"); 
        bytes32 hashedAnswer = keccak256(abi.encodePacked(salt, answer));
        emit log_bytes32(hashedAnswer);
        game = new Questionnaire(question, hashedAnswer);
        emit log(game.question());

    }

    function testQuestionFail() public {
        try game.guess("1"){
            assertTrue(false);
        }
        catch{
            assertTrue(true);
        }
    }

    function testQuestionPass() public {
        uint256 beginBalance = address(this).balance;
        cheats.deal(address(game), 100000);
        game.guess("new guy");
        assertEq(address(this).balance, beginBalance + 100000);
    }

    fallback() external payable {}

    receive() external payable {}

}
