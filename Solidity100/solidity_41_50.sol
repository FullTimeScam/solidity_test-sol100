// SPDX-License-Identifier: GPL-3.0

pragma solidity >= 0.8.2 < 0.9.0;

contract Q41 {
    // 숫자만 들어갈 수 있으며 길이가 4인 배열을 (상태변수로)선언하고
    // 그 배열에 숫자를 넣는 함수를 구현하세요.
    // 배열을 초기화하는 함수도 구현하세요.
    // (길이가 4가 되면 자동으로 초기화하는 기능은 굳이 구현하지 않아도 됩니다.)


    // 숫자만 들어갈 수 있으며 길이가 4인 배열을 (상태변수로)선언하고
    uint[4] public numbers;

    // 그 배열에 숫자를 넣는 함수를 구현하세요.
    function addNumbers(uint[4] memory _nums) public {
        numbers = _nums;
    }

    // 배열을 초기화하는 함수도 구현하세요.
    function reset() public {
        for (uint i = 0; i < numbers.length; i++) {
            numbers[i] = 0;            
        }
    }

}


contract Q42 {
    // 이름과 번호 그리고 지갑주소를 가진 '고객'이라는 구조체를 선언하세요.
    // 새로운 고객 정보를 만들 수 있는 함수도 구현하되 이름의 글자가 최소 5글자가 되게 설정하세요.


    // 이름과 번호 그리고 지갑주소를 가진 '고객'이라는 구조체를 선언하세요.
    struct Gogaek {
        string name;
        uint number;
        address wallet;
    }


    Gogaek[] public customers;

    // 새로운 고객 정보를 만들 수 있는 함수도 구현하되 이름의 글자가 최소 5글자가 되게 설정하세요.
    function addCustomer(string memory _name, uint _number, address _wallet) public {
        require(bytes(_name).length >= 5, "Name must be at least 5");
        
        Gogaek memory newCustomer = Gogaek({
            name: _name,
            number: _number,
            wallet: _wallet
        });

        customers.push(newCustomer);
    }


}

contract Q43 {
    // 은행의 역할을 하는 contract를 만드려고 합니다.
    // 별도의 고객 등록 과정은 없습니다.
    // 해당 contract에 ether를 예치할 수 있는 기능을 만드세요. (payable, msg.value)
    // 또한, 자신이 현재 얼마를 예치했는지도 볼 수 있는 함수 (balance)
    // 그리고 자신이 예치한만큼의 ether를 인출할 수 있는 기능을 구현하세요.


    // 예치금
    mapping(address => uint) private balance;

    // ether를 예치할 수 있는 기능을 만드세요. (payable)
    function deposit() public payable {
        balance[msg.sender] += msg.value;
    }

    // 또한, 자신이 현재 얼마를 예치했는지 볼 수 있는 함수
    function balances() public view returns (uint) {
        return balance[msg.sender];
    }

    // 자신이 예치한 만큼의 ether를 인출할 수 있는 기능
    function withdraw(uint _amount) public {
        require(balance[msg.sender] >= _amount, "Insufficient balance");

        // 금액 차감
        balance[msg.sender] -= _amount;

        // 그 만큼 출금
        payable(msg.sender).transfer(_amount);
    }




}

contract Q44 {
    // string만 들어가는 array를 만들되,
    // 4글자 이상인 문자열만 들어갈 수 있게 구현하세요.


    // string만 들어가는 array를 만들되,
    string[] public stringArray;

    // 4글자 이상인 문자열만 들어갈 수 있게 구현하세요.
    function addString(string memory _str) public {
        require(bytes(_str).length >= 4, "under 4");
        stringArray.push(_str);
    }

    function getStrings() public view returns (string[] memory) {
        return stringArray;
    }




}

contract Q45 {
    // 숫자만 들어가는 array를 만들되,
    // 100이하의 숫자만 들어갈 수 있게 구현하세요.


    // 숫자만 들어가는 array를 만들되,
    uint[] public numbersArray;

    // 100이하의 숫자만 들어갈 수 있게 구현하세요.
    function addNumber(uint _num) public {
        require(_num <= 100, "under 100");
        numbersArray.push(_num);
    }

    function getNumbers() public view returns (uint[] memory) {
        return numbersArray;
    }
}

contract Q46 {
    // 3의 배수이거나 10의 배수이면서 50보다 작은 수만 들어갈 수 있는 array를 구현하세요. (나머지 또는 몫 이용하기)
    // (예 : 15 -> 가능, 3의 배수 // 40 -> 가능, 10의 배수이면서 50보다 작음 // 66 -> 가능, 3의 배수 // 70 -> 불가능 10의 배수이지만 50보다 큼)


    uint[] public specialNumbers;

    function addNumber(uint _num) public {
        require(
            (_num % 3 == 0) || (_num % 10 == 0 && _num < 50), // 괄호 없어도 분기가 ||라서 괜찮음.
            "nope"
        );
        specialNumbers.push(_num);
    }

    function getNumbers() public view returns (uint[] memory) {
        return specialNumbers;
    }
}

contract Q47 {
    //배포와 함께 배포자가 owner로 설정되게 하세요.
    // owner를 바꿀 수 있는 함수도 구현하되
    // 그 함수는 owner만 실행할 수 있게 해주세요.

     address public owner;

    //배포와 함께 배포자가 owner로 설정되게 하세요.
        constructor() {
        owner = msg.sender;
    }

    // owner를 바꿀 수 있는 함수도 구현하되
    function changeOwner(address newOwner) public {
        // 그 함수는 owner만 실행할 수 있게 해주세요.
        require(msg.sender == owner, "Only owner");
        owner = newOwner;
    }

}

contract Q48_1 { // 라이브러리
    // A라는 contract에는 2개의 숫자를 더해주는 함수를 구현하세요.
    // B라고 하는 contract를 따로 만든 후에 A의 더하기 함수를 사용하는 코드를 구현하세요.
    function add(uint num1, uint num2) public pure returns (uint) {
        return num1 + num2;
    }
}

contract Q48_2 {
    Q48_1 public contQ48_1;

    // 2 contract의 생성자에서 1 주소를 받아서 저장
    constructor(address conAddr) {
        contQ48_1 = Q48_1(conAddr);
    }

    // 1의 더하기 함수를 사용하는 함수
    function addFrom1(uint num1, uint num2) public view returns (uint) {
        return contQ48_1.add(num1, num2);
    }
}

contract Q49 {
    // 9. 긴 숫자를 넣었을 때, 마지막 3개의 숫자만 반환하는 함수를 구현하세요.
    // 예) 459273 → 273 // 492871 → 871 // 92218 → 218
    function lastThree(uint number) public pure returns (uint) {
        return number % 1000;
    }


}

contract Q50 {
    // 숫자 3개가 부여되면 그 3개의 숫자를 이어붙여서 반환하는 함수를 구현하세요.
    // 예) 3,1,6 → 316 // 1,9,3 → 193 // 0,1,5 → 15
    // 응용 문제 : 3개 아닌 n개의 숫자 이어붙이기
    // 역시 박연하! 박연하! 박연하!

    //@openzeppelin/contracts/utils/Strings.sol 써도 됨.

    function uintString(uint _num) public pure returns(string memory) {
        if (_num > 0) {
            uint length = 0; // _num의 자릿수 나옴 => 배열의 번호로 쓸 것임(arrIndex)
            uint _numTemp = _num; // _num값이 바뀌어서 임시num 만듦
            
            for ( ; _numTemp != 0 ; _numTemp /= 10){
                length++;
            }

            uint arrIndex = length-1; // 배열의 번호

            bytes memory bString = new bytes(length); // 배열에 각각 숫자들을 저장할 것

            for ( ; _num != 0; _num /= 10) {
                // 10으로 나눈 나머지를 하나씩 배열에 저장
                bString[arrIndex] = bytes1(uint8(48 + _num % 10)); // 뒤에서 부터 // 아스키코드 문자"0"은 10진수 48
                if (arrIndex == 0) break; // 연하님이 에러 해결해주심! arrIndex가 음수로 가서 에러가 났었음
                arrIndex--;
            }

            return string(bString); // string은 특별한 형태의 배열임! 그러니까 이게 된다.

        } else{
            return "0";
        }
    }


    // 숫자 3개가 들어오면 이어 붙이기

    function concatThree(uint _a, uint _b, uint _c) public pure returns(string memory) {
        bytes memory result;

        result = abi.encodePacked(uintString(_a), uintString(_b), uintString(_c));

        return string(result);
    }

    // 숫자 n개가 들어오면 이어 붙이기
    function concatArr(uint[] memory _nums) public pure returns(string memory) {

        bytes memory result;

        for (uint i = 0; i< _nums.length; i++) 
        {
            result = abi.encodePacked(result, uintString(_nums[i]));
        }

        return string(result);
    }




    //아래 코드는 한 자리 숫자에서만 작동함

    
    // // 숫자 3개가 부여되면 그 3개의 숫자를 이어붙여서 반환하는 함수를 구현하세요.
    // function concatThree(uint num1, uint num2, uint num3) public pure returns (uint) {
    //     return num1 * 100 + num2 * 10 + num3;
    // }

    // // 응용 문제 : 3개 아닌 n개의 숫자 이어붙이기
    // function concat(uint[] memory numbers) public pure returns (uint) {
    //     uint result = 0;
    //     for (uint i = 0; i < numbers.length; i++) {
    //         result = result * 10 + numbers[i];
    //     }
    //     return result;
    // }    
}