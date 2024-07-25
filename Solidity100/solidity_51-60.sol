// SPDX-License-Identifier: GPL-3.0

pragma solidity >= 0.8.2 < 0.9.0;

contract Q51 {
    // 숫자들이 들어가는 배열을 선언하고 그 중에서 3번째로 큰 수를 반환하세요.

    /* ==아이디어==*/
    // 내림차순으로 저장
    // [2] 반환하면 될 듯

    // 예시값 : [123, 456, 789, 1, 2, 3, 4, 5, 6, 7, 8, 9]


    function thirdOne(uint[] memory _numbers) public pure returns(uint) {
        
        // 내림차순으로 정렬
        for (uint i = 0; i < _numbers.length ; i++) { // 각 자리마다 포문 실행
            for (uint j = i + 1 ; j < _numbers.length ; j++) { // 모든 배열의 요소를 한바퀴 다 돈다.
                if (_numbers[i] < _numbers[j]) {
                    uint temp = _numbers[i];
                    _numbers[i] = _numbers[j];
                    _numbers[j] = temp;
                }
            }
        }
        return _numbers[2];
    }


}

contract Q52 {
    // 자동으로 아이디를 만들어주는 함수를 구현하세요.
    // 이름, 생일, 지갑주소를 기반으로 만든 해시값의 첫 10바이트를 추출하여 아이디로 만드시오.

    /* ==아이디어==*/
    // 이름, 생일, 지갑주소 받고 keccak256에 넣고 돌린 다음
    // 바이트 배열에 넣고
    // [0]~[9]까지 반환 (for) < = 틀린 아이디어!
    
    function genID(string memory _name, uint _birth, address _addr) public pure returns(bytes10 id){
      return  bytes10(keccak256(abi.encodePacked(_name, _birth, _addr)));
    }
}


contract Q53 {
    // 1. 시중에는 A,B,C,D,E 5개의 은행이 있습니다.
    // 각 은행에 고객들은 마음대로 입금하고 인출할 수 있습니다.
    // 각 은행에 예치된 금액 확인, 입금과 인출할 수 있는 기능을 구현하세요.
    
    // 힌트 : 이중 mapping을 꼭 이용하세요.

    /* ==아이디어==*/
    // 바깥 매핑은 은행 고르기(시작점)
    // 안쪽 매핑은 고객 지갑 => 예치 금액(목적지)

    mapping(string => mapping(address => uint)) balance;

    string[] public bank$ = ["A", "B", "C", "D", "E"];

    // 은행이름을 입력하면 금액을 알 수 있는 함수
    function getBalance(string memory _bank, address _customer) public view returns (uint) {
        return balance[_bank][_customer];
    }

    // 은행을 골라서 입금
    function deposit(string memory _bank) public payable {
        balance[_bank][msg.sender] += msg.value;
    }

    // 은행을 골라서 출금 (0.001eth부터 출금 가능 - 그거 아니면 수수료도 안 나옴! 땅팧서 장사하는 거 아니다.)
    function withdraw(string memory _bank, uint _amount) public {
        require(balance[_bank][msg.sender] >= _amount && 10 ** 15 <= _amount, "Insufficient balance / im not digging ground for money");
        balance[_bank][msg.sender] -= _amount;
        payable(msg.sender).transfer(_amount);
    }


}

contract Q54 {
    // 1. 기부받는 플랫폼을 만드세요.
    // 가장 많이 기부하는 사람을 나타내는 변수와 그 변수를 지속적으로 바꿔주는 함수를 만드세요.
    // 힌트 : 굳이 mapping을 만들 필요는 없습니다.

    /* ==아이디어==*/
    // payable로 기부하는 기능.
        // 기부할 때 주소와 금액 저장
    // 기부 조회 기능
        // 가장 많이 기부한 사람을 저장(교체)
    // 이벤트 만들어서 로그 남기기(수업시간에 이렇게 하면 좋다 들었음)


    address public topDonor; // 사람
    uint public topDonation; // 금액

    // 이벤트 : 기부자, 금액 (없어도 됨)
    event DonationLog(address indexed donor, uint amount);

    // 기부 - 이 함수 작동할 때마다 이벤트로 로그 남기고
            // 가장 많이 기부한 사람 없데이트 함
    function donate() public payable {
        require(msg.value > 0, "Donation must be positive");

        // 기부 이벤트
        emit DonationLog(msg.sender, msg.value);

        // 가장 많이 기부한 사람 업데이트
        if (msg.value > topDonation) {
            topDonation = msg.value;
            topDonor = msg.sender;
        }
    }

    // 가장 많이 기부한 사람과 금액을 조회하는 함수
    function getTopDonor() public view returns (address, uint) {
        return (topDonor, topDonation);
    }

}

contract Q55 {
    // 배포와 함께 owner를 설정하고
    // owner를 다른 주소로 바꾸는 것은 오직 owner 스스로만 할 수 있게 하십시오.

    address public owner;


    // 배포와 함께 owner를 설정하고
        constructor() {
        owner = msg.sender;
    }

    function changeOwner(address newOwner) public {
        require(newOwner != address(0), "Invalid address");
        require(msg.sender == owner, "You are not the owner");
        owner = newOwner;
    }

}

contract Q56 {
    // 위 문제의 확장버전입니다.
    // owner와 sub_owner를 설정하고
    // owner를 바꾸기 위해서는 둘의 동의가 모두 필요하게 구현하세요.

    /* ==아이디어==*/
    // 오너, 부오너의 동의를 각각 받고
    // 동의 상태를 저장한다.
    // 둘 다 동의가 되어 있다면 새로운 오너 지정 가능 (오너, 부오너 누구든 가능)
    // 주인 바뀌고 나면 동의 상태 둘 다 초기화

    address public owner; // 오너 주소
    address public subOwner; // 부오너 주소
    bool public ownerApproval; // owner의 동의 상태
    bool public subOwnerApproval; // subOwner의 동의 상태


    constructor(address _subOwner) {
        owner = msg.sender;
        subOwner = _subOwner; // subOwner는 입력받음
    }

    // owner와 subOwner 동의 상태 받기
    function approveChangeOwner() public {
        require(msg.sender == owner || msg.sender == subOwner, "You are not auth"); // owner / subOwner인지 확인
        if (msg.sender == owner) {
            ownerApproval = true; // owner 동의!
        } else if (msg.sender == subOwner) {
            subOwnerApproval = true; // subOwner 동의!
        }
    }

    // 주인 바꾸기
    function changeOwner(address newOwner) public {
        require(newOwner != address(0), "Invalid address");
        require(ownerApproval && subOwnerApproval, "Both approvals required"); // 둘 다 동의 했는지 확인

        owner = newOwner; // 새로운 owner
        ownerApproval = false; // 초기화
        subOwnerApproval = false; // 초기화
    }
}

contract Q57 {
    // 위 문제의 또다른 버전입니다.
    // owner가 변경할 때는 바로 변경가능하게
    // sub-owner가 변경하려고 한다면 owner의 동의가 필요하게 구현하세요.


    address public owner; // 오너 주소
    address public subOwner; // 부오너 주소
    bool public ownerApproval; // owner의 동의 상태
    // 서브오너 동의는 필요 없음

    constructor(address _subOwner) {
        owner = msg.sender;
        subOwner = _subOwner; // subOwner는 입력 받음
    }

    // owner는 바로 변경 가능
    function changeOwner(address newOwner) public {
        require(newOwner != address(0), "Invalid address");
        require(msg.sender == owner, "You are not the owner");
        owner = newOwner; // 새 owner
    }

    // sub-owner는 owner 허락 필요
    function changeSubOwner(address newSubOwner) public {
        require(newSubOwner != address(0), "Invalid address");
        require(msg.sender == subOwner, "You are not the sub-owner");
        require(ownerApproval, "need approval"); // owner 동의 확인

        subOwner = newSubOwner;
        ownerApproval = false; // 초기화
    }

    // owner 승인 함수
    function approveSubOwnerChange() public {
        require(msg.sender == owner, "You are not the owner");
        ownerApproval = true;
    }

    // owner 승인 취소 함수
    function revokeSubOwnerChangeApproval() public {
        require(msg.sender == owner, "You are not the owner");
        ownerApproval = false;
    }
}



contract Q58 {
    // A contract에 a,b,c라는 상태변수가 있습니다.
    // a는 A 외부에서는 변화할 수 없게 하고 싶습니다. - private
    // b는 상속받은 contract들만 변경시킬 수 있습니다. - internal
    // c는 제한이 없습니다. - public
    // 각 변수들의 visibility를 설정하세요.

    /* ==아이디어==*/
    // virtual이 뭐였지 : 컨트랙트 간 상속 관계에서 함수가 재정의될 수 있음을 나타내는 키워드

    uint private a;
    uint internal b;
    uint public c;
}

contract Q59 {
    // 현재시간을 받고
    // 2일 후의 시간을 설정하는 함수를 같이 구현하세요.


    uint public currentTime;
    uint public futureTime;

    function setCurrentTime() public {
        currentTime = block.timestamp; 
        // futureTime = currentTime + (2 * 24 * 60 * 60);
        futureTime = currentTime + 2 days; // days가 예약어에 있음
    }

    function timeCheck() public view returns (uint, uint) {
        return (currentTime, futureTime);
    }



}

contract Q60 {
    // 방이 2개 밖에 없는 펜션을 여러분이 운영합니다.
    // 각 방마다 한번에 3명 이상 투숙객이 있을 수는 없습니다.
    // 특정 날짜에 특정 방에 누가 투숙했는지 알려주는 자료구조와
    // 그 자료구조로부터 값을 얻어오는 함수를 구현하세요.
    
    // 예약시스템은 운영하지 않아도 됩니다. 과거의 일만 기록한다고 생각하세요.
    
    // 힌트 : 날짜는 그냥 숫자로 기입하세요. 예) 2023년 5월 27일 → 230527

    // 방마다 투숙객 정보 저장
    struct Room {
        address[3] people; // 방의 최대 투숙객 수는 3명
        bool taken; // 방이 이미 사용되었는지 여부를 확인하는 플래그
    }


    // 특정 날짜에 특정 방에 누가 투숙했는지 알려주는 자료구조와
    // 날짜 => 방 번호 => 방 투숙객 정보
    mapping(uint => mapping(uint => Room)) public logs;

    // 날짜 => 방 번호 => 방 투숙객 정보 저장
    function addLog(uint date, uint roomNum, address[3] memory guests) public {
        require(roomNum == 1 || roomNum == 2, "Invalid room number"); // 방 번호는 1 또는 2 (단 두 칸!)
        Room storage room = logs[date][roomNum]; // 상태변수라서 storage
        require(!room.taken, "already booked");

        for (uint i = 0; i < 3; i++) {
            // 빈 주소가 있는지 봐서 방이 찼는지 확인
            // 예약 시스템이 아니라서 초기화할 필요 없음
            require(room.people[i] == address(0), "Room is already full");
            room.people[i] = guests[i];
        }
        room.taken = true; // 방의 예약 상태를 변경
    }

    // 날짜 => 방 번호 => 방 투숙객 정보 반환
    function getLog(uint date, uint roomNum) public view returns (address[3] memory) {
        require(roomNum == 1 || roomNum == 2, "Invalid room number"); // 방 번호는 1 또는 2만 가능
        Room storage room = logs[date][roomNum];
        require(room.taken, "No booking found");

        return room.people;
    }

}