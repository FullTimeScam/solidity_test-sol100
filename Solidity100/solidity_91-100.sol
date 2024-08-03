// SPDX-License-Identifier: GPL-3.0

pragma solidity >= 0.8.2 < 0.9.0;


contract Q91 {
    /*
    배열에서 특정 요소를 없애는 함수를 구현하세요. 
    예) [4,3,2,1,8] 3번째를 없애고 싶음 → [4,3,1,8]
    */

    // 아이디어
    // 원래 배열을 검색하는데
    // 빼고 싶은 요소만 빼고 검색함. (0q부터 시작)

    // 그리고 검색한 결과물들을 새 배열에 복사함


    function removeTarget(uint[] memory _data, uint _n) public pure returns (uint[] memory) {
        
        require(_data.length > 0,"Too short");
        require(_n < _data.length, "Input too long.");

        // 새 배열 생성(길이 1만큼 짧은 거)
        uint[] memory newArray = new uint[](_data.length - 1);

        // 원래 배열에서 하나 삭제
        for (uint i = 0; i < _data.length; i++) {
            if (i < _n) { // 작으면 그대로 복사해서 넣고
                newArray[i] = _data[i];
            } else if (i > _n) { // 크면 길이 1 빼서 넣고 (이 사이에 하나가 빠졌기 때문)
                newArray[i - 1] = _data[i];
            }
        }

        return newArray;
    }

}

contract Q92 {
    /*
    특정 주소를 받았을 때, 그 주소가 EOA인지 CA인지 감지하는 함수를 구현하세요.
    */

    // 아이디어
    // 코드가 있으면 CA다.
    // 메소드 아이디가 있어도 CA다.

        function isItCA(address _addr) public view returns(bool){
        if(_addr.code.length>0){
            return true;
        }
        return false;
    }
}

contract Q93 {
    /*
    다른 컨트랙트의 함수를 사용해보려고 하는데, 그 함수의 이름은 모르고 methodId로 추정되는 값은 있다. 
    input 값도 uint256 1개, address 1개로 추정될 때 해당 함수를 활용하는 함수를 구현하세요.
    */

    // 아이디어
    // 메소드 아이디를 알고 있으면 함수를 사용할 수 있음
    // 퍼블릭이나 익스터널 함수라면
    // call이나 send로 요청을 보내보면 됨

    function callFunction(address _targetContract, bytes4 _methodId, uint _number, address _addr) public returns(bool) {

        // 콜 보내기
        (bool okay,) = _targetContract.call(abi.encodeWithSelector(_methodId, _number, _addr));
        // encodeWithSelector 사용법 : 첫 번째 인자 - 메소드 아이디 / 이후 인자들 - input값들
        
        require(okay, "Function call failed");

        return(okay);
    }
}

   contract Q93_Test_Target{
    uint public number;
    address public sender;

    // 21bc22f8 메소드아이디
    // 컨트랙트주소,0x21bc22f8,1,0x6160D0Ca6ad8AA9Cc68d143D01591d8050b7dD9f
    // 이렇게 넣고 테스트 고
    function setValues(uint _number, address _sender) public {
        number = _number;
        sender = _sender;
    }
}

contract Q94 {
/*
inline - 더하기, 빼기, 곱하기, 나누기하는 함수를 구현하세요.
*/

    function add(uint _a, uint _b) public pure returns (uint result) {
        assembly {
            result := add(_a, _b)
        }
    }

    function sub(uint a, uint b) public pure returns (uint result) {
        assembly {
            result := sub(a, b)
        }
    }


    function mul(uint a, uint b) public pure returns (uint result) {
        assembly {
            result := mul(a, b)
        }
    }


    function div(uint a, uint b) public pure returns (uint result) {
        require(b > 0, "under zero");
        assembly {
            result := div(a, b)
        }
    }
}

contract Q95 {
/*
inline - 3개의 값을 받아서, 더하기, 곱하기한 결과를 반환하는 함수를 구현하세요.
*/

    function add(uint _a, uint _b, uint _c) public pure returns (uint result) {
        assembly {
            result := add(_c, add(_a, _b))
        }
    }

    function mul(uint _a, uint _b, uint _c) public pure returns (uint result) {
        assembly {
            result := mul(_c, mul(_a, _b))
        }
    }

}

contract Q96 {
    /*
    inline - 4개의 숫자를 받아서 가장 큰수와 작은 수를 반환하는 함수를 구현하세요.
    */

    // 아이디어
    // 지역변수 min이랑 max를 미리 선언해줘서
    // lt로 숫자를 계속 비교해고
    // min이랑 max 값을 계속 바꿔주기

    // 더 짧은 방법이 있을 것 같은데..
    
    function minMax(uint _a, uint _b, uint _c, uint _d) public pure returns (uint, uint) {
        uint min = _a; // 어셈블리 안에 선언하고 싶은데 그러면 리턴을 어떻게 하는지 모르겠음.
        uint max = _a;

        assembly {
            // Initialize min and max with the first value

            // a : b
            if lt(_b, min) {
                min := _b
            }
            if gt(_b, max) {
                max := _b
            }

            // min : c
            if lt(_c, min) {
                min := _c
            }
            if gt(_c, max) {
                max := _c
            }

            // min : d
            if lt(_d, min) {
                min := _d
            }
            if gt(_d, max) {
                max := _d
            }
        }
        return(min, max);
    }

}

contract Q97 {
    /*
    inline - 상태변수 숫자만 들어가는 동적 array numbers에 push하고 pop하는 함수 그리고 전체를 반환하는 구현하세요.
    */

    // 아이디어
    // uint[] numbers; 상태변수 숫자만 들어가는 동적 array numbers
    // numbers.push
        // 동적 배열의 길이 슬롯을 불러와서 길이를 구하고 늘려주기
        // 받은 숫자를 마지막 슬롯에 추가하기
        // 상태변수니까 sstore / sload 쓰기

    // numbers.pop
        // 동적 배열의 길이 슬롯을 불러와서 길이를 구하고 줄여주기
        // 마지막 슬롯 0으로 변경

    // function getnNnmbers() public view returns(uint[]) {reuturn numbers;}
        // 이 건 어셈블리로 어떻게 하는지 모르겠습.

    uint[] private numbers;

    function pushNumber(uint _number) public {
        assembly {
            // 배열의 길이를 불러온다.
            let length := sload(numbers.slot)
            
            // numbers 배열의 길이(시작 위치)를 계산한다.
            let dataLocation := add(keccak256(add(numbers.slot, 0x20), 0x20), length)

            // 그 위치에 숫자를 저장한다.
            sstore(dataLocation, _number)

            // 길이를 1 증가시킨다.
            sstore(numbers.slot, add(length, 1))
        }
    }

    function popNumber() public {
        require(numbers.length > 0, "Array is empty");
        assembly {
            // 배열의 길이를 불러온다.
            let length := sload(numbers.slot)

            // 배열의 마지막 인덱스 위치를 계산한다.
            let dataLocation := add(keccak256(add(numbers.slot, 0x20), 0x20), sub(length, 1))

            // 마지막 숫자를 제거 (0으로 설정하면 0x000000... 되어서 비게 됨)
            sstore(dataLocation, 0)

            // 배열의 길이를 1 감소시킨다.
            sstore(numbers.slot, sub(length, 1))
        }
    }

    function getAllNumbers() public view returns (uint[] memory) {
        return numbers;
    }
}

contract Q98 {
/*
inline - 상태변수 문자형 letter에 값을 넣는 함수 setLetter를 구현하세요.
*/

}

contract Q99 {
/*
inline - 4개의 숫자를 받아서 가장 큰수와 작은 수를 반환하는 함수를 구현하세요.
*/

}

contract Q100 {
/*
inline - bytes형 변수 b의 값을 정하는 함수 setB를 구현하세요.
변수 b가 상태변수고 sebB 함수로 바꾸는 것임.
*/

}