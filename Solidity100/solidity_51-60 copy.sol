// SPDX-License-Identifier: GPL-3.0

pragma solidity >= 0.8.2 < 0.9.0;

contract Q61 {
    // a의 b승을 반환하는 함수를 구현하세요.

    function sqr(uint _a, uint _b) public pure returns(uint) {
        return _a**_b;
    }
}

contract Q62 {
    // 2개의 숫자를 더하는 함수,
    // 곱하는 함수
    // a의 b승을 반환하는 함수를 구현하는데
    // 3개의 함수 모두 2개의 input값이 10을 넘지 않아야 하는 조건을
    // 최대한 효율적으로 구현하세요.

    modifier underTen(uint _a, uint _b) {
        require(_a <= 10 && _b <= 10, "exceeded 10");
        _;
    }

    function plus(uint _a, uint _b) public pure underTen(_a, _b) returns(uint) {
        return _a+_b;
    }
    
    function mult(uint _a, uint _b) public pure underTen(_a, _b) returns(uint) {
        return _a*_b;
    }

    function sqr(uint _a, uint _b) public pure underTen(_a, _b) returns(uint) {
        return _a**_b;
    }


}

contract Q63 {
    // 2개 숫자의 차를 나타내는 함수를 구현하세요.

    function diff(uint _a, uint _b) public pure returns(uint) {
        return _a >= _b ? _a - _b : _b - _a;
    }
    
}

contract Q64 {
    // 지갑 주소를 넣으면 5개의 4bytes로 분할하여 반환해주는 함수를 구현하세요.

    function addrDivider(address _addr) public pure returns (bytes4[5] memory)  {
        bytes20 addr = bytes20(_addr);
        bytes4[5] memory result;

        // 4바이트씩 5개로 쪼개기
        // bytes4 part1 = bytes4(abi.encodePacked(addr[0], addr[1], addr[2], addr[3]));
        // bytes4 part2 = bytes4(abi.encodePacked(addr[4], addr[5], addr[6], addr[7]));
        // bytes4 part3 = bytes4(abi.encodePacked(addr[8], addr[9], addr[10], addr[11]));
        // bytes4 part4 = bytes4(abi.encodePacked(addr[12], addr[13], addr[14], addr[15]));
        // bytes4 part5 = bytes4(abi.encodePacked(addr[16], addr[17], addr[18], addr[19]));


        for (uint i=0; i<5; i++) 
        {
            bytes4 temp = bytes4(abi.encodePacked(addr[i*4+0], addr[i*4+1], addr[i*4+2], addr[i*4+3]));
            result[i] = temp;
        }

        return result;
    }

    

    // 모르겠습니다 ㅜㅜ
    // 현용님 힌트 : abi.encodePacked로 4개씩 합친거 만든 다음에 bytes4[] 에 하나씩 넣어줬습니다
}

contract Q644{
    /*
    지갑 주소를 넣으면 5개의 4bytes로 분할하여 반환해주는 함수를 구현하세요.
    현용님이 푼 것
    */
     function split(address _addr) public pure returns (bytes4[5] memory) {
        bytes20 addr = bytes20(_addr);
        bytes4[5] memory result;
        bytes4 temp;
        
        for(uint i=0;i<5;i++){
            temp=bytes4(abi.encodePacked(addr[i*4],addr[i*4+1],addr[i*4+2],addr[i*4+3]));
            result[i]=temp;
        }

        return result;
    }
}


contract Q65 {
    // 숫자 3개를 입력하면 그 제곱을 반환하는 함수를 구현하세요.
    // 그 3개 중에서 가운데 출력값만 반환하는 함수를 구현하세요.
    // 예) func A : input → 1,2,3 // output → 1,4,9 | func B : output 4 (1,4,9중 가운데 숫자)

    function sqr3(uint _a, uint _b, uint _c) public pure returns(uint, uint, uint){
        return (_a**2, _b**2, _c**2);
    }

    function middle(uint _a, uint _b, uint _c) public  pure returns(uint) {
        (uint a, uint b, uint c) = sqr3(_a, _b, _c);

        return b;

        
    }
}

contract Q66 {
    // 특정 숫자를 입력했을 때 자릿수를 알려주는 함수를 구현하세요.
    // 추가로 그 숫자를 5진수로 표현했을 때는 몇자리 숫자가 될 지 알려주는 함수도 구현하세요.

    uint public n;

    function setn(uint _n) public {
        n = _n;
    }

    function jinsu10() public view returns(uint) {
        uint len = 0;

        for (uint _n = n ; _n > 0; _n /= 10) 
        {
            len++;
        }
        return len;
    }

    function jinsu5() public view returns(uint) {
        uint len5 = 0;
        
        for (uint _n = n; _n > 0; _n /= 5)
        {
            len5++;
        }
        return len5;

    }
}

contract Q67 {
    // 자신의 현재 잔고를 반환하는 함수를 보유한 Contract A와
    // 다른 주소로 돈을 보낼 수 있는 Contract B를 구현하세요.
    // B의 함수를 이용하여 A에게 전송하고 A의 잔고 변화를 확인하세요.
}

contract Q67_A{
    function getBal() public view returns(uint){
        return address(this).balance;
    }

    receive() external payable {}
}

contract Q67_B{
    function send(address payable _sendTo) public payable {
        (bool success, ) = _sendTo.call{value : msg.value}("");
        require(success, "Transfer Failed");

    }
}


contract Q68 {
    // 계승(팩토리얼)을 구하는 함수를 구현하세요.
    // 계승은 그 숫자와 같거나 작은 모든 수들을 곱한 값이다. 
    // 예) 5 → 1*2*3*4*5 = 120, 11 → 1*2*3*4*5*6*7*8*9*10*11 = 39916800
    // while을 사용해보세요

    function facto(uint _n) public pure returns(uint) {
        uint n = _n;
        uint result = 1;

        while (n > 1) 
        {
            result *= n;
            n--;
        }
        return result;
    }
}

contract Q69 {
    // 숫자 1,2,3을 넣으면 1 and 2 or 3 라고 반환해주는 함수를 구현하세요.
    // 힌트 : 7번 문제(시,분,초로 변환하기)

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

    function numAndOr(uint _num1, uint _num2, uint _num3) public pure returns(string memory) {
        return string(abi.encodePacked(
            uintString(_num1), " and ", uintString(_num2), " or ", uintString(_num3)
        ));
    }
}

contract Q70 {
    // 번호와 이름 그리고 bytes로 구성된 고객이라는 구조체를 만드세요.
    // bytes는 번호와 이름을 keccak 함수의 input 값으로 넣어 나온 output값입니다.
    // 고객의 정보를 넣고 변화시키는 함수를 구현하세요. 

    struct Gogaek {
        uint number;
        string name;
        bytes cryptData;
    }

    mapping(uint => Gogaek) public  Gogaeks;

    // 암호화 함수
    function encrypt(uint _number, string memory _name) public pure returns(bytes memory) {
        bytes memory data = abi.encodePacked(keccak256(abi.encodePacked(_number, _name))); // keccak256이 32바이트라서 encodePaced 한 번 더 해줬음
        return data;
    }

    function updateCustomer(uint _number, string memory _name) public returns(uint, string memory, bytes memory) {

        bytes memory data = encrypt(_number, _name);

        Gogaeks[_number] =
        Gogaek({
            number : _number,
            name : _name,
            cryptData : data
        });

        return(_number, _name, data);

    }








}
