// // SPDX-License-Identifier: GPL-3.0

pragma solidity >= 0.8.2 < 0.9.0;

contract TEST9 {

    // 흔히들 비밀번호 만들 때 대소문자 숫자가 각각 1개씩은 포함되어 있어야 한다 
    // 등의 조건이 붙는 경우가 있습니다. 그러한 조건을 구현하세요.

    // 입력값을 받으면 그 입력값 안에 대문자, 
    // 소문자 그리고 숫자가 최소한 1개씩은 포함되어 있는지 여부를 
    // 알려주는 함수를 구현하세요.


    // 1. for문으로 문자열 전체를 싹 돈다.
    // 2. abi.encondepacked(_p)해가지고
    // 3. byte1(a) ~ byte1(z) 사이에 있는지
    // 4. byte1(A) ~ byte1(Z) 사이에 있는지
    // 5. byte1(uint8(0)) ~ byte1(uint8(9)) 사이에 있는지
    // 6. 위 세 조건 다 만족하면 통과

    function pwCheck(string memory _pw) public pure returns(uint) {
    uint sign;

        for (uint i = 0; bytes(_pw).length > i; i++) {
            bytes1 pw = bytes(_pw)[i];

            if(pw >= bytes1(uint8(0) + 48) && pw <= bytes1(uint8(9) + 48)) {
                sign |= 1;  // 숫자
            } else if (pw >= bytes1("A") && pw <= bytes1("Z")) {
                sign |= 2;  // 대문자
            } else if (pw >= bytes1("a") && pw <= bytes1("z")) {
                sign |= 4;  // 소문자
            }
        }
        //이렇게 하면 빵꾸난 곳을 찾을 수 있다.
        return sign;
    }




}