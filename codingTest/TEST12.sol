// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract TEST12 {

    // 주차정산 프로그램을 만드세요. 주차시간 첫 2시간은 무료, 그 이후는 1분마다 200원(wei)씩 부과합니다. - payable
    // 주차료는 차량번호인식을 기반으로 실행됩니다. array(X) or struct(O) - 검색, mapping
    // 주차료는 주차장 이용을 종료할 때 부과됩니다. - 조건 붙은 요금 다 계산해주고 마지막에 payable
    // ----------------------------------------------------------------------
    // 차량번호가 숫자로만 이루어진 차량은 20% 할인해주세요. - 모든 자리가 아스키코드 0x30 ~ 0x30 + 0x09
    // 차량번호가 문자(알파벳)로만 이루어진 차량은 50% 할인해주세요. - 모든 자리가 아스키코드 0x41 ~ 0x48 + 0x5A

    // 지갑 하나가 여러 차량을 가지고 있을 수 있음.


    struct Fee {
        string numPlate; // 차량번호
        uint timePassed; // 주차 시간
    }

    mapping(address => Fee[]) public userFees;
    mapping(string => uint) public startTime;

    constructor() {
        // 샘플 차량 3대
        enterParking("1234");
        enterParking("ABcd");
        enterParking("12Aa");
    }

    function enterParking(string memory numPlate) public {
        require(startTime[numPlate] == 0, "this car already parked");
        startTime[numPlate] = block.timestamp; // 입장시각 기록
    }

    function exitParking(string memory numPlate) public payable { // 나갈 때 돈 내기
        require(startTime[numPlate] != 0, "no car here");

        uint timeSpent = block.timestamp - startTime[numPlate]; // 주차시간 계산하기
        
        uint fee = calculateFee(numPlate, timeSpent);
        userFees[msg.sender].push(Fee(numPlate, timeSpent));
        
        require(msg.value >= fee, "Not enough Ether sent.");
        payable(msg.sender).transfer(msg.value - fee);
        
        startTime[numPlate] = 0; // 돈 다 받고 마지막에 시간 초기화
    }
    
    function calculateFee(string memory numPlate, uint timeSpent) internal pure returns (uint) {
        if (timeSpent <= 2 * 60 * 60) { // 2시간 이하일 경우
            return 0;
        }
        
        uint payableTime = timeSpent - 2 * 60 * 60; // 2시간을 초 단위로 표현
        uint fee = payableTime / 60 * 200; // 1분당 200 wei
        
        if (isNumeric(numPlate)) {
            return fee * 80 / 100; // 20% 할인
        } else if (isAlphabetic(numPlate)) {
            return fee * 50 / 100; // 50% 할인
        } else {
            return fee;
        }
    }
    
    function isNumeric(string memory s) internal pure returns (bool) {
        bytes memory b = bytes(s);
        for (uint i; i < b.length; i++) {
            if (b[i] < 0x30 || b[i] > 0x39) { // 1~9
                return false;
            }
        }
        return true;
    }
    
    function isAlphabetic(string memory s) internal pure returns (bool) {
        bytes memory b = bytes(s);
        for (uint i; i < b.length; i++) {
            if ((b[i] < 0x41 || b[i] > 0x5A) && (b[i] < 0x61 || b[i] > 0x7A)) { // A~Z , a~z
                return false;
            }
        }
        return true;
    }
    
    // 유저 별로 Fee 확인하는 함수(없어도 됨)
    function getFees(address user) public view returns (Fee[] memory) {
        return userFees[user];
    }

}
