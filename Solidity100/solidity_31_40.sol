// SPDX-License-Identifier: GPL-3.0

pragma solidity >= 0.8.2 < 0.9.0;

contract Q31 {
    // 1. string을 input으로 받는 함수를 구현하세요.
    // "Alice"나 "Bob"일 때에만 true를 반환하세요.

    function inputName(string memory _s) public pure returns(bool){
        bytes32 hashAli = keccak256(abi.encodePacked("Alice"));
        bytes32 hashBob = keccak256(abi.encodePacked("Bob"));
        bytes32 hash_s = keccak256(abi.encodePacked(_s));

        if (hash_s == hashAli || hash_s == hashBob) return true;
        else return false;
    }
}


contract Q32 {
    // 3의 배수만 들어갈 수 있는 array를 구현하되,
    // 3의 배수이자 동시에 10의 배수이면 들어갈 수 없는 추가 조건도 구현하세요.
    // 예) 3 → o , 9 → o , 15 → o , 30 → x

    uint[] public three;

    function arrayA(uint _n) public returns(uint[] memory){
        if(_n % 3 == 0 && _n % 30 != 0)
        three.push(_n);
        
        return three;
    }



}

contract Q33 {
    // 이름, 번호, 지갑주소 그리고 생일을 담은 고객 구조체를 구현하세요.
    // 고객의 정보를 넣는 함수와 고객의 이름으로 검색하면 해당 고객의 전체 정보를 반환하는 함수를 구현하세요.

    struct Customer{
        string name;
        uint index;
        address wallet;
        uint birth;
    }

    mapping (string => Customer) public customers;

    function setInfo(string memory _name, uint _index, address _wallet, uint _birth) public {

        customers[_name] = Customer(_name, _index, _wallet, _birth);
    }

    function getInfo(string memory _name) public view returns(string memory, uint, address, uint){
        Customer memory customer = customers[_name];

        return (customer.name, customer.index, customer.wallet, customer.birth);
    }


}

contract Q34 {
    // 이름, 번호, 점수가 들어간 학생 구조체를 선언하세요.
    // 학생들을 관리하는 자료구조도 따로 선언하고
    // 학생들의 전체 평균을 계산하는 함수도 구현하세요.

    struct Student {
        string name;
        uint index;
        uint score;
    }

    Student[] public students;

    function addStudent(string memory _name, uint _index, uint _score) public {
        students.push(Student(_name, _index, _score));
    }

    function avg() public view returns(uint){
        uint totalScore = 0;
        uint studentCount = students.length;

        for (uint i = 0; i < studentCount; i++) {
            totalScore += students[i].score;
        }

        if (studentCount > 0) {
            return totalScore / studentCount;
        } else {
            return 0;
    }
    }

}

contract Q35 {
// 숫자만 들어갈 수 있는 array를 선언하고
// 해당 array의 짝수번째 요소만 모아서 반환하는 함수를 구현하세요.
// 예) [1,2,3,4,5,6] -> [2,4,6] // [3,5,7,9,11,13] -> [5,9,13]

    // 숫자만 들어갈 수 있는 array를 선언하고
    uint[] public numbers;

    function addNumber(uint _number) public {
        numbers.push(_number);
    }

    // 짝수번째 요소만 모아서 반환하는 함수를 구현하세요.
    function getEven() public view returns (uint[] memory) {
        uint count = 0;

        // 짝수번째가 몇 갠지 세어보기(count)
        for (uint i = 1; i < numbers.length; i += 2) {
            count++;
        }

        // count 길이의 배열을 만들고
        uint[] memory even = new uint[](count);
        uint j = 0;

        for (uint i = 1; i < numbers.length; i += 2) {
            even[j] = numbers[i]; // 함수 이식하기
            j++;
        }

        return even;
    }
}

contract Q36 {
    // high, neutral, low 상태를 구현하세요.
    // a라는 변수의 값이 7이상이면 high, 4이상이면 neutral
    // 그 이후면 low로 상태를 변경시켜주는 함수를 구현하세요.

    // 열거형 enum을 사용하면 값이 Status의 0, 1, 2에 매핑 된다.
    enum Status { High, Neutral, Low }
    
    // 열거형의 변수 선언
    Status public nowSatus;

    function setStatus(uint a) public {
        if (a >= 7) {
            nowSatus = Status.High; // 매핑되어 있어서 이렇게 사용하면 된다.
        } else if (a >= 4) {
            nowSatus = Status.Neutral;
        } else {
            nowSatus = Status.Low;
        }
    }

    function getStatus() public view returns (string memory) {
        if (nowSatus == Status.High) {
            return "High";
        } else if (nowSatus == Status.Neutral) {
            return "Neutral";
        } else {
            return "Low";
        }
    }
}

contract Q37 {
    // 1 wei를 기부하는 기능, 1finney를 기부하는 기능 그리고 1 ether를 기부하는 기능을 구현하세요.
    // 최초의 배포자만이 해당 smart contract에서 자금을 회수할 수 있고 다른 이들은 못하게 막는 함수도 구현하세요.
    // (힌트 : 기부는 EOA가 해당 Smart Contract에게 돈을 보내는 행위, contract가 돈을 받는 상황)
    
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function donateWei() public payable {
        require(msg.value == 1 wei, "you can donate only exactly 1 wei");
    }

    function donateFinney() public payable {
        // require(msg.value == 1 finney, "you can donate only exactly 1 finney"); // finney 지원 안 됨
        require(msg.value == 10**15 wei, "you can donate only exactly 1 finney");
    }

    function donateEther() public payable {
        require(msg.value == 1 ether, "you can donate only exactly 1 ether");
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    function withdraw() public {
        require(msg.sender == owner, "pls bring Owner's wallet");
        payable(owner).transfer(address(this).balance);
    }
}

contract Q38 {
    // 상태변수 a를 "A"로 설정하여 선언하세요.
    // 이 함수를 "B" 그리고 "C"로 변경시킬 수 있는 함수를 각각 구현하세요.
    // 단 해당 함수들은 오직 owner만이 실행할 수 있습니다.
    // owner는 해당 컨트랙트의 최초 배포자입니다.
    // (힌트 : 동일한 조건이 서로 다른 두 함수에 적용되니 더욱 효율성 있게 적용시킬 수 있는 방법을 생각해볼 수 있음)

    string public a = "A";
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner");
        _;
    }

    function setToB() public onlyOwner { // onlyOwner은 모디파이어
        a = "B";
    }

    function setToC() public onlyOwner {
        a = "C";
    }


}

contract Q39 {
    // 특정 숫자의 자릿수까지의 2의 배수, 3의 배수, 5의 배수 7의 배수의 개수를 반환해주는 함수를 구현하세요.
    // 예) 15 : 7,5,3,2  (2의 배수 7개, 3의 배수 5개, 5의 배수 3개, 7의 배수 2개) // 100 : 50,33,20,14  (2의 배수 50개, 3의 배수 33개, 5의 배수 20개, 7의 배수 14개)

    function countMultiples(uint num) public pure returns (uint, uint, uint, uint) {
        uint count2 = num/2;
        uint count3 = num/3;
        uint count5 = num/5;
        uint count7 = num/7;

        return (count2, count3, count5, count7);
    }


}

contract Q40 {
    // 숫자를 임의로 넣었을 때 내림차순으로 정렬하고
    // 가장 가운데 있는 숫자를 반환하는 함수를 구현하세요.
    // 가장 가운데가 없다면 가운데 2개 숫자를 반환하세요.
    // 예) [5,2,4,7,1] -> [1,2,4,5,7], 4 // [1,5,4,9,6,3,2,11] -> [1,2,3,4,5,6,9,11], 4,5 // [6,3,1,4,9,7,8] -> [1,3,4,6,7,8,9], 6

    function sort(uint[] memory data) public pure returns (uint[] memory) {
        
        uint n = data.length;

        // 내림차순으로 정렬
        for (uint i = 0; i < n; i++) { // 각 자리마다 포문 실행
            for (uint j = i + 1; j < n; j++) { // 모든 배열의 요소를 한바퀴 다 돈다.
                if (data[i] < data[j]) {
                    uint temp = data[i];
                    data[i] = data[j];
                    data[j] = temp;
                }
            }
        }
        return data;
    }

    // 가운데 값 찾는 함수

    function findMiddle(uint[] memory data) public pure returns (uint[] memory) {
        uint[] memory sortedData = sort(data);
        uint n = sortedData.length; // 길이
        if(n % 2 == 1) { // 홀수면
            uint[] memory result = new uint[](1); // 한 칸짜리 만들고
            result[0] = sortedData[n / 2]; // 절반 나눈 값(나머지 때문에 절반에서 한 칸 넘은 값이 나옴
            return result;
        } else { // 짝수면
            uint[] memory result = new uint[](2); // 두 칸 짜리 만들고
            result[0] = sortedData[(n / 2) -1]; // 절반 나눈 값에서 1 뺌(시작점)
            result[1] = sortedData[n / 2]; // 그 다음 수까지 출력
            return result;
        }
    }

}