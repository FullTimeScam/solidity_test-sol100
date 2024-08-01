// SPDX-License-Identifier: GPL-3.0

pragma solidity >= 0.8.2 < 0.9.0;

contract Q71 {
/*
숫자형 변수 a를 선언하고 a를 바꿀 수 있는 함수를 구현하세요.
한번 바꾸면 그로부터 10분동안은 못 바꾸게 하는 함수도 같이 구현하세요.
*/
    uint private a;
    uint public lastUpdated;

    uint interval = 10 * 60; // 10분

    function updateValue(uint newValue) public {
        uint currentTime = block.timestamp;
        require(currentTime >= lastUpdated + interval, "Can change this once every 10 minutes");

        a = newValue;
        lastUpdated = currentTime;
    }

    function isUpdateAllowed() public view returns (bool) {
        return block.timestamp >= lastUpdated + interval;
    }
}
contract Q72 {
/*
contract에 돈을 넣을 수 있는 deposit 함수를 구현하세요. 
해당 contract의 돈을 인출하는 함수도 구현하되 오직 owner만 할 수 있게 구현하세요. 
owner는 배포와 동시에 배포자로 설정하십시오. 한번에 가장 많은 금액을 예치하면 owner는 바뀝니다.

예) A (배포 직후 owner), B가 20 deposit(B가 owner), C가 10 deposit(B가 여전히 owner),
D가 50 deposit(D가 owner), E가 20 deposit(D), E가 45 depoist(D), E가 65 deposit(E가 owner)
*/

    address owner;
    uint whaleBomb = 0;

    constructor() {
        owner = address(0); // 처음 컨트랙트 배포 시에 owner를 0주소로 설정(No Scam!)
    }
    
    function deposit() public payable {
        if(msg.value > whaleBomb){
            owner = msg.sender;
            whaleBomb = msg.value;
        }
    }

    function withdraw() public {
        require(msg.sender == owner, "only owner can withdraw funds");
        uint wdrAmount = address(this).balance / 4; // 1등은 전체 모인 금액의 25%를 출금할 수 있음
        require(wdrAmount > 0, "insufficient funds in contract");

        payable(owner).transfer(wdrAmount);
        
        owner = address(0); // 인출하고 나면 오너를 0주소로 초기화
    }

}
contract Q73 {
/*
위의 문제의 다른 버전입니다. 누적으로 가장 많이 예치하면 owner가 바뀌게 구현하세요.
    
예) A (배포 직후 owner), B가 20 deposit(B가 owner), C가 10 deposit(B가 여전히 owner), 
D가 50 deposit(D가 owner), E가 20 deposit(D), E가 45 depoist(E가 owner, E 누적 65), E가 65 deposit(E)
*/

    address public owner;
    uint public whaleBomb = 0;
    mapping(address => uint) public deposits; // 총 입금량 관리

    constructor() {
        owner = address(0); // 처음 컨트랙트 배포 시에 owner를 0주소로 설정(No Scam!)
    }
    
    function deposit() public payable {
        deposits[msg.sender] += msg.value;
        if (deposits[msg.sender] > whaleBomb) {
            whaleBomb = deposits[msg.sender];
            owner = msg.sender;
        }
    }

    function withdraw() public {
        require(msg.sender == owner, "only owner can withdraw funds");
        uint wdrAmount = address(this).balance / 4; // 1등은 전체 모인 금액의 25%를 출금할 수 있음
        require(wdrAmount > 0, "insufficient funds in contract");

        deposits[owner] = 0; // 인출 할 시에 해당 계정의 총 입금량 초기화

        payable(owner).transfer(wdrAmount);
        owner = address(0); // 인출하고 나면 오너를 0주소로 초기화
        
    }

}

contract Q74 {
/*
어느 숫자를 넣으면 항상 10%를 추가로 더한 값을 반환하는 함수를 구현하세요.
    
예) 20 -> 22(20 + 2, 2는 20의 10%), 0 // 50 -> 55(50+5, 5는 50의 10%), 
0 // 42 -> 46(42+4), 4 (42의 10%는 4.2 -> 46.2, 46과 2를 분리해서 반환) 
// 27 => 29(27+2), 7 (27의 10%는 2.7 -> 29.7, 29와 7을 분리해서 반환)
*/


    function addTenPercent(uint num) public pure returns (uint, uint) {
        // num에 10%를 더한 값
        uint addedValue = num + (num / 10);
        // num의 소수 부분
        uint decimalPart = (num * 10) % 10;

        return (addedValue, decimalPart);
    }

}

contract Q75 {
/*
문자열을 넣으면 n번 반복하여 쓴 후에 반환하는 함수를 구현하세요.
    
예) abc,3 -> abcabcabc // ab,5 -> ababababab
*/

    function repeatString(string memory str, uint n) public pure returns (string memory) {
        bytes memory repeated;
        for (uint i = 0; i < n; i++) {
            repeated = abi.encodePacked(repeated, str); // 이어쓰기
        }
        return string(repeated);
    }

}

contract Q76 {
    /*
    숫자 123을 넣으면 문자 123으로 반환하는 함수를 직접 구현하세요. 
    (패키지없이)
    */

    function uintToString(uint _num) public pure returns (string memory) {
        if (_num == 0) {
            return "0";
        }
        
        uint length = 0;
        uint _numTemp = _num;
        
        // 자릿수를 계산
        while (_numTemp != 0) {
            length++;
            _numTemp /= 10;
        }
        
        uint arrIndex = length - 1;
        bytes memory bString = new bytes(length);
        
        // 숫자를 문자열로 변환
        while (_num != 0) {
            bString[arrIndex] = bytes1(uint8(48 + _num % 10)); // 아스키 코드 '0'은 10진수 48
            _num /= 10;
            if (arrIndex == 0) break;
            arrIndex--;
        }
        
        return string(bString);
    }
}
import "@openzeppelin/contracts/utils/Strings.sol"; // 라이브러리 임포트
contract Q77 {
/*
위의 문제와 비슷합니다. 이번에는 openzeppelin의 패키지를 import 하세요.
    
힌트 : import "@openzeppelin/contracts/utils/Strings.sol";
*/

    using Strings for uint;

    /*
    숫자 123을 넣으면 문자 123으로 반환하는 함수를 구현하세요.
    */
    function uintToString(uint _num) public pure returns (string memory) {
        return _num.toString();
    }
}
contract Q78 {
/*
숫자만 들어갈 수 있는 array를 선언하세요. array 안 요소들 중 최소 하나는 10~25 사이에 있는지를 알려주는 함수를 구현하세요.
    
예) [1,2,6,9,11,19] -> true (19는 10~25 사이) // [1,9,3,6,2,8,9,39] -> false (어느 숫자도 10~25 사이에 없음)
*/

    function containsInRange(uint[] memory _numbers) public pure returns (bool) {
        for (uint i = 0; i < _numbers.length; i++) {
            if (_numbers[i] >= 10 && _numbers[i] <= 25) {
                return true;
            }
        }
        return false;
    }
}
contract Q79 {
/*
3개의 숫자를 넣으면 그 중에서 가장 큰 수를 찾아내주는 함수를 Contract A에 구현하세요. 
Contract B에서는 이름, 번호, 점수를 가진 구조체 학생을 구현하세요. 
학생의 정보를 3명 넣되 그 중에서 가장 높은 점수를 가진 학생을 반환하는 함수를 구현하세요. 
구현할 때는 Contract A를 import 하여 구현하세요.
*/
}

// contract Q79_1 {
//     function findMax(uint a, uint b, uint c) public pure returns (uint) {
//         if (a >= b && a >= c) {
//             return a;
//         } else if (b >= a && b >= c) {
//             return b;
//         } else {
//             return c;
//         }
//     }
// }

import "./Q79_1.sol"; // 같은 폴더의 다른 파일로 저장되어 있습니다.
contract Q79_2 {
    struct Student {
        string name;
        uint id;
        uint score;
    }

    Student[] public students;

    // Q79_1의 인스턴스
    Q79_1 private q79_1;

    constructor() {
        q79_1 = new Q79_1();
    }


    function addStudent(string memory name, uint id, uint score) public {
        students.push(Student(name, id, score));
    }

    // 가장 높은 점수를 가진 학생 찾는 함수
    function getTopScoringStudent() public view returns (Student memory) {
        require(students.length > 0, "No students available");

        Student memory topStudent = students[0];

        for (uint i = 1; i < students.length; i++) {
            uint currentTopScore = topStudent.score;
            uint currentStudentScore = students[i].score;

            uint maxScore = q79_1.findMax(currentTopScore, currentStudentScore, 0);

            if (maxScore == currentStudentScore) {
                topStudent = students[i];
            }
        }

        return topStudent;
    }
}

contract Q80 {
    /*
    1. 지금은 동적 array에 값을 넣으면(push) 가장 앞부터 채워집니다. 
    1,2,3,4 순으로 넣으면 [1,2,3,4] 이렇게 표현됩니다. 그리고 값을 빼려고 하면(pop) 끝의 숫자부터 빠집니다. 
    가장 먼저 들어온 것이 가장 마지막에 나갑니다. 이런 것들을FILO(First In Last Out)이라고도 합니다. 
    가장 먼저 들어온 것을 가장 먼저 나가는 방식을 FIFO(First In First Out)이라고 합니다. 
    push와 pop을 이용하되 FIFO 방식으로 바꾸어 보세요.
    */
    uint256[] private data;

    // 배열에 추가 (FIFO)
    function add(uint256 value) public {
        data.push(value);
    }

    // 값 제거 (FIFO)
    function remove() public returns (uint256) {
        require(data.length > 0, "Data array is empty");

        uint256 value = data[0];

        for (uint256 i = 0; i < data.length - 1; i++) {
            data[i] = data[i + 1];
        }
        data.pop();

        return value;
    }

    // 배열의 길이
    function getDataLength() public view returns (uint256) {
        return data.length;
    }

    // 배열의 전체 값
    function getData() public view returns (uint256[] memory) {
        return data;
    }
}