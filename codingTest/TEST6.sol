// // SPDX-License-Identifier: GPL-3.0

pragma solidity >= 0.8.2 < 0.9.0;

contract TEST6 {

/*
숫자를 넣었을 때 그 숫자의 자릿수와 각 자릿수의 숫자를 나열한 결과를 반환하세요.
예) 2 -> 1,   2 // 45 -> 2,   4,5 // 539 -> 3,   5,3,9 // 28712 -> 5,   2,8,7,1,2
--------------------------------------------------------------------------------------------
문자열을 넣었을 때 그 문자열의 자릿수와 문자열을 한 글자씩 분리한 결과를 반환하세요.
예) abde -> 4,   a,b,d,e // fkeadf -> 6,   f,k,e,a,d,f
*/


    function getNumInfo(uint num) public pure returns(uint, uint[] memory) {
        uint length = 0;
        uint i = num; // for문 밖에서 초기화 해야지 다음 for문에서도 쓸 수 있음

        for (; i % 10 != i; i /= 10) {
            length++;
        }
        length++;

        uint[] memory digits = new uint[](length);
        i = num;

        for (uint j = length; j > 0; j--) {
            digits[j-1] = i % 10;
            i /= 10;
        }

        return (length, digits);
    }

    function getStrInfo(string memory srt) public pure returns(uint, string[] memory){
        //코드
    }
}
