// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract TEST13 {

// 가능한 모든 것을 inline assembly로 진행하시면 됩니다.
// 1. 숫자들이 들어가는 동적 array number를 만들고 1~n까지 들어가는 함수를 만드세요.
// 2. 숫자들이 들어가는 길이 4의 array number2를 만들고 여기에 4개의 숫자를 넣어주는 함수를 만드세요.
// 3. number의 모든 요소들의 합을 반환하는 함수를 구현하세요. 
// 4. number2의 모든 요소들의 합을 반환하는 함수를 구현하세요. 
// 5. number의 k번째 요소를 반환하는 함수를 구현하세요.
// 6. number2의 k번째 요소를 반환하는 함수를 구현하세요.

    uint[] public number;
    uint[4] public numbers2;


    // 1. 숫자들이 들어가는 동적 array number를 만들고 1~n까지 들어가는 함수를 만드세요.
    function one2N(uint _n) public {
        assembly {
            let length := sload(number.slot) // 배열 길이
            let slot := keccak256(add(number.slot, 0x20), 0x20) // 시작 위치 켁칵(배열의 저장위치, 길이)
            // 첫 슬롯에는 길이가 저장 됨
            
            for {let i := 1} lt(i, add(_n, 1)) { i := add(i, 1)} {
                sstore(add(slot, length), i)
                length := add(length, 1)
            }
            sstore(number.slot, length)
        }
    }

    // 2. 숫자들이 들어가는 길이 4의 array number2를 만들고 여기에 4개의 숫자를 넣어주는 함수를 만드세요.
    function add4(uint a, uint b, uint c, uint d) public {
        assembly {
            sstore(numbers2.slot, a) // 첫 슬롯에 값이 저장 됨
            sstore(add(numbers2.slot, 1), b)
            sstore(add(numbers2.slot, 2), c)
            sstore(add(numbers2.slot, 3), d)
            }
    }

    // 3. number의 모든 요소들의 합을 반환하는 함수를 구현하세요. 
    function sumNumber() public view returns (uint sum) {
        assembly {
            let length := sload(number.slot) // 첫 번째 슬롯 = 길이
            let slot := keccak256(0x0, number.slot) // 시작 위치
            for {let i := 0} lt(i, length) { i := add(i, 1) } {
                sum := add(sum, sload(add(slot, i)))
            }
        }
    }

    // 4. number2의 모든 요소들의 합을 반환하는 함수를 구현하세요. 
    function sumNumbers2() public view returns (uint sum) {
        assembly {
            for {let i := 0} lt(i, 4) { i := add(i, 1) } { // for( i=0 ; i<4; i++)
                sum := add(sum, sload(add(numbers2.slot, i))) // sum += number2[i];
            }
        }
    }

    // 5. number의 k번째 요소를 반환하는 함수를 구현하세요.
    function getNumberAt(uint k) public view returns (uint result) {
        assembly {
            let slot := keccak256(0x0, number.slot)
            result := sload(add(slot, k))
        }
    }


    // 6. number2의 k번째 요소를 반환하는 함수를 구현하세요.
    function getNumbers2At(uint k) public view returns (uint result) {
        assembly {
            result := sload(add(numbers2.slot, k))
        }
    }
}
