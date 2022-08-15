// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Questionnaire{
    bytes32 public hashedAnswer;
    bytes32 salt = bytes32("190190190"); 
    string public question;

    constructor(string memory _question, bytes32 _hashedanswer){
        question = _question;
        hashedAnswer = _hashedanswer;
    }
}