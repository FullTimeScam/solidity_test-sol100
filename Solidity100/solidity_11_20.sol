// SPDX-License-Identifier: GPL-3.0

pragma solidity >= 0.8.2 < 0.9.0;

contract Q11_ONLYEVEN {
    // uint 형이 들어가는 array를 선언하고, 짝수만 들어갈 수 있게 걸러주는 함수를 구현하세요.
    uint[] numbers;

    function onlyEven(uint _num) public {
        if (_num % 2 == 0) {
            numbers.push(_num);
        }
    }

}


contract Q12_CHIKEN_TRIPLE {
    // 숫자 3개를 더해주는 함수, 곱해주는 함수 그리고 순서에 따라서 a*b+c를 반환해주는 함수 3개를 각각 구현하세요.

    function add(uint _a, uint _b, uint _c) public pure returns(uint) {
        return _a + _b + _c;
    }

    function mul(uint _a, uint _b, uint _c) public pure returns(uint) {
        return _a * _b * _c;
    }

    function calc(uint _a, uint _b, uint _c) public pure returns(uint) {
        return _a * _b + _c;
    }
}


contract Q13_A3B1C2 {
    // 3의 배수라면 “A”를, 나머지가 1이 있다면 “B”를, 나머지가 2가 있다면 “C”를 반환하는 함수를 구현하세요.
    function a3b1c2(uint _num) public pure returns(string memory) {
        if(_num %3 == 0) {
            return "A";
        } else if (_num %3 == 1) {
            return "B";
        } else if (_num %3 == 2) {
            return "C";
        } else return "error";
    }


}


contract Q14_STUDENT_ID_NAME {
    // 학번, 이름, 듣는 수험 목록을 포함한 학생 구조체를 선언하고 학생들을 관리할 수 있는 array를 구현하세요.
    // array에 학생을 넣는 함수도 구현하는데
    // 학생들의 학번은 1번부터 순서대로 2,3,4,5 자동 순차적으로 증가하는 기능도 같이 구현하세요.

    struct Student{
        uint id;
        string name;
        string[] classes;
    }

    Student[] students;

    
    function addStudent(string memory _name, string[] memory _classes) public {
        uint nextId = students.length + 1;
        students.push(Student(nextId, _name, _classes));
        
    }

    function getStudent(uint _id) public view returns (Student memory) {
        for (uint256 i = 0; i <= students.length-1; i++) {
            if (students[i].id == _id) {
                return students[i];
            }
        }
        revert("Student not found");
    }

    function getStudentCount() public view returns (uint256) {
        return students.length;
    }

    function getAllStudents() public view returns (Student[] memory) {
        return students;
    }
}


contract Q15_ArrayZero2N {
    // 배열 A를 선언하고 해당 배열에 0부터 n까지 자동으로 넣는 함수를 구현하세요. 

    uint[] A;

    function addA(uint _n) public {
        for (uint i=0; i<=_n; i++) 
        {
            A.push(i);
        }
    }

    function getA() public view returns(uint[] memory) {
        return A;
    }

}


contract Q16_ArraySum {
    // 숫자들만 들어갈 수 있는 array를 선언하고 해당 array에 숫자를 넣는 함수도 구현하세요.
    // 또 array안의 모든 숫자의 합을 더하는 함수를 구현하세요.

    uint[] onlyNum;

    function addNum(uint _num) public {
        onlyNum.push(_num);
    }

    function addAll() public view returns(uint) {
        uint sum = 0;
        for (uint i=0; i < onlyNum.length ; i++) 
        {
            sum += onlyNum[i];
        }
        return sum;
    }

}


contract Q17_IsHeBOb {
    // string을 input으로 받는 함수를 구현하세요. 이 함수는 true 혹은 false를 반환하는데 Bob이라는 이름이 들어왔을 때에만 true를 반환합니다. 

    function inputString(string memory _s) public pure returns(bool) {
        if (keccak256(abi.encodePacked(_s)) == keccak256(abi.encodePacked("Bob")))
        return true;
        else return false;
    }

}


contract Q18_NAME_BIRTH {
    // 이름을 검색하면 생일이 나올 수 있는 자료구조를 구현하세요.
    // (매핑) 해당 자료구조에 정보를 넣는 함수, 정보를 볼 수 있는 함수도 구현하세요.

    // struct NameBirth {
    //     string name;
    //     uint birthDate;
    // }

    mapping(string => uint) name2BirthDate;

    function addNameBirth(string memory _name, uint _birthDate) public {
        name2BirthDate[_name] = _birthDate;
    }

    function getArrayNB(string memory _name) public view returns(uint _birthDate) {
        return name2BirthDate[_name];
    }

    
}


contract Q19_TURNDOUBLE {
    // 숫자를 넣으면 2배를 반환해주는 함수를 구현하세요.
    // 단 숫자는 1000이상 넘으면 함수를 실행시키지 못하게 합니다.
    
    uint a = 0;

    function turnDouble(uint _num) public {
        require(_num <= 1000, "You Are So Greedy!");
        a = _num*2;
    }

    function geDouble() public view returns(uint) {
        return a;
    }



}


contract Q20_NUMBERS_POP {
    // 숫자만 들어가는 배열을 선언하고 숫자를 넣는 함수를 구현하세요.
    // 15개의 숫자가 들어가면 3의 배수 위치에 있는 숫자들을 초기화 시키는(3번째, 6번째, 9번째 등등) 함수를 구현하세요. (for 문 응용 → 약간 까다로움)
    
    uint[] Numbers = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15];

    function addNumbersAndPop3(uint _num) public returns(uint[] memory) {
        Numbers.push(_num);

        if(Numbers.length > 15) {
            for (uint i=2; i < Numbers.length; i += 2) 
            {
                remove(i);
                
            }
        }

        return Numbers;
                        
    }

    function remove(uint index) public {

        require(index < Numbers.length, "Index out of bounds!! (limit : 15)"); // 삭제하고 돌리면 더 긴 애들도 줄일 수 있음.

        for (uint i = index; i < Numbers.length - 1; i++) {
            Numbers[i] = Numbers[i + 1];
        }
        Numbers.pop();

    }



}



