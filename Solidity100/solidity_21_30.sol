// SPDX-License-Identifier: GPL-3.0

pragma solidity >= 0.8.2 < 0.9.0;

contract Q21 {
    // 3의 배수만 들어갈 수 있는 array를 구현하세요.

    uint[] numbers;

    function addNum(uint _n) public {
        if(_n%3 == 0) {
            numbers.push(_n);
        }
    }

}

contract Q22 {
    // 뺄셈 함수를 구현하세요. 임의의 두 숫자를 넣으면 자동으로 둘 중 큰수로부터 작은 수를 빼는 함수를 구현하세요.
    
    function sub(uint _a, uint _b) public pure returns(uint) {
        if(_a <= _b) {
            return _b - _a;
        } else if (_b < _a) {
            return _a - _b;
        } else {return 0;}
    }

}

contract Q23 {
    // 3의 배수라면 “A”를, 나머지가 1이 있다면 “B”를, 나머지가 2가 있다면 “C”를 반환하는 함수를 구현하세요.

    function compare3(uint _n) public pure returns(string memory) {
        if (_n % 3 == 0) {
            return "A";
        } else if (_n % 3 == 1) {
            return "B";
        } else { return "c";}
    }

}

contract Q24 {
    // string을 input으로 받는 함수를 구현하세요. “Alice”가 들어왔을 때에만 true를 반환하세요.

    function alice(string memory _a) public pure returns(bool) {
        // require((keccak256(abi.encodePacked(_a)) == keccak256(abi.encodePacked("Alice"))), "That's not my Alice");
        // return true;

        if ((keccak256(abi.encodePacked(_a)) == keccak256(abi.encodePacked("Alice")))) {
            return true; }
                else {return false;}
            }

}

contract Q25 {
    // 배열 A를 선언하고 해당 배열에 n부터 0까지 자동으로 넣는 함수를 구현하세요. 

    uint[] A;

    function fill09(uint n) public returns(uint[] memory) {
        delete A;
        require(n<=9, "Input can't be bigger than 9");
        for (uint i=n; i<=9; i++) 
        {
            A.push(i);
        }

        return A;
    }

}

contract Q26 {
    // 홀수만 들어가는 array, 짝수만 들어가는 array를 구현하고 숫자를 넣었을 때 자동으로 홀,짝을 나누어 입력시키는 함수를 구현하세요.

    uint[] odd;
    uint[] even;

    function oddEven(uint _n) public returns(uint[] memory, string memory) {
        if (_n %2 != 0) {
            odd.push(_n);
            return (odd, "odd added");
        } else if (_n % 2 == 0) {
            even.push(_n);
            return (even, "even added");
        } else revert("error");
    }

    function clear() public {
        delete odd;
        delete even;
    }

}

contract Q27 {
    // string 과 bytes32를 key-value 쌍으로 묶어주는 mapping을 구현하세요. 해당 mapping에 정보를 넣고, 지우고 불러오는 함수도 같이 구현하세요.

    mapping (string => bytes32) public data;

    constructor() {
        string memory a = "sample";
        bytes32 b = 0x68656c6c6f20776f726c64000000000000000000000000000000000000000000;
        data[a] = b;
    }

    function setData(string memory a, bytes32 b) public {
        data[a] = b;        
    }
    function deleteData(string memory a) public {
        delete data[a];
    }
    function getData(string memory a) public view returns(bytes32){
        return data[a];
    }

}

contract Q28 {
    // ID와 PW를 넣으면 해시함수(keccak256)에 둘을 같이 해시값을 반환해주는 함수를 구현하세요.

    function IDPW(string memory ID, string memory PW) public pure returns(bytes32){
        return keccak256(abi.encodePacked(ID, PW));
    }

}

contract Q29 {
    // 숫자형 변수 a와 문자형 변수 b를 각각 10 그리고 “A”의 값으로 배포 직후 설정하는 contract를 구현하세요.

    uint public a;
    string public b;

    constructor () {
        uint _a = 10;
        string memory _b = "A";

        a = _a;
        b = _b;
    }

}

contract Q30 {
    // 10. 임의대로 숫자를 넣으면 알아서 내림차순으로 정렬해주는 함수를 구현하세요
    // (sorting 코드 응용 → 약간 까다로움)
    // 예 : [2,6,7,4,5,1,9] → [9,7,6,5,4,2,1]

    
    function sorting(uint[] memory _array) public pure returns(uint[] memory) {
        for (uint i=0; i<_array.length; i++) {
            for (uint j=i+1; j<_array.length; j++){
                if(_array[i] < _array[j]) {
                    (_array[i], _array[j]) = (_array[j], _array[i]);
                }
            }
        }
        return _array;
    }



}