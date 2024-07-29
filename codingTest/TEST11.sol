// // SPDX-License-Identifier: GPL-3.0

pragma solidity >= 0.8.2 < 0.9.0;



contract TEST10 {

    // 로또 프로그램을 만드려고 합니다. 
    // 숫자4개 / 문자 2개를 뽑습니다.
    
    // ===
    // 당첨금 :
    // 6개가 맞으면 1이더,
    // 5개의 맞으면 0.75이더, 
    // 4개가 맞으면 0.25이더,
    // 3개가 맞으면 0.1이더

    // 2개 이하는 상금이 없습니다. 
    // ===
    
    // 참가 금액은 0.05이더이다.

    // 예시 1 : 8,2,4,7,D,A
    // 예시 2 : 9,1,4,2,F,B


    /* 아이디어
    1. 6칸짜리 bytes[](6)배열을 만든다.
    2. uint 4개, string 2개를 순서대로 입력 받는다.
    3. 타임스탬프랑 난이도로 켁칵을 돌린다.
    4. 블록 100개 만들어지면 당첨번호 만든다.
    5. =비교해서 확인한다.
    
     */



    // 개인이 고른 번호 저장
    struct LottoEntry {
        uint8[4] numbers;
        bytes2 characters;
    }

    // 당첨 번호 저장
    struct WinningNumbers {
        uint8[4] numbers;
        bytes2 characters;
    }

    WinningNumbers public winningNumbers;
    mapping(address => LottoEntry) public gammers; // 참가자 별로 번호 저장
    address[] public joinedAddr; // 참가자 목록
    uint256 public prizePool; // 상금풀
    uint256 public initialBlockNumber; // 배포 시 초기 블록 번호


    constructor() {
        initialBlockNumber = block.number; // 계약 배포 시점의 블록 번호 저장
    }

    // 번호 받고 주소별로 저장 / 상금 저장
    function participate(uint num1, uint num2, uint num3, uint num4, string memory char1, string memory char2) public payable {
        require(msg.value == 0.05 ether, "need 0.05 ETH to join.");
        require(bytes(char1).length == 1 && bytes(char2).length == 1);
        require(isUpperAlphabet(bytes(char1)[0]) && isUpperAlphabet(bytes(char2)[0]), "need uppercase (A-Z).");
        require(block.number >= initialBlockNumber + 100, "Wait for 100 blocks.");

        uint8[4] memory numbers = [uint8(num1), uint8(num2), uint8(num3), uint8(num4)];
        bytes2 characters = bytes2(abi.encodePacked(bytes(char1)[0], bytes(char2)[0]));
        gammers[msg.sender] = LottoEntry(numbers, characters);
        joinedAddr.push(msg.sender);
        prizePool += msg.value;

            // 블록 번호가 100 이상 증가한 경우 당첨 번호 생성
        // if ();
        }
    }


    // 대문자 A~Z인지 검사
    function isUpperAlphabet(bytes1 char) internal pure returns (bool) {
        return char >= 0x41 && char <= 0x5A; // ASCII codes for 'A' to 'Z'
    }

    function WinNumbersGen() internal view returns (WinningNumbers memory) {
        // 타임스탬프랑 난이도를 켁칼 돌려서 난수 생성
        uint256 randomHash = uint256(keccak256(abi.encodePacked(block.timestamp, block.prevrandao)));
        WinningNumbers memory newWinningNumbers;
        for (uint8 i = 0; i < 4; i++) {
            newWinningNumbers.numbers[i] = uint8(randomHash % 10); // 0-9 사이의 숫자 생성
            randomHash /= 10;
        }
        newWinningNumbers.characters = bytes2(uint16(randomHash % 65536)); // 2바이트 문자 생성
        return newWinningNumbers;
    }

    //당첨자 뽑기
}