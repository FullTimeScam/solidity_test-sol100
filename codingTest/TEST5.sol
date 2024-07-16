// // SPDX-License-Identifier: GPL-3.0

pragma solidity >= 0.8.2 < 0.9.0;

contract TEST5 {
    /*숫자를 시분초로 변환하세요.
    예) 100 -> 1 min 40 sec
    600 -> 10 min 
    1000 -> 1 6min 40 sec
    5250 -> 1 hour 27 min 30 sec*/

    function convertTime(uint _second) public pure returns(string memory) {
        uint hour = _second / 3600; // 시 계산
        uint minute = (_second % 3600) / 60; // 분 계산
        uint second = _second % 60; // 초 계산
        
        string memory timeString = "";
        
        if (hour > 0) { // 시
            timeString = string(abi.encodePacked(uint2str(hour), " hour", hour > 1 ? "s " : " "));
        }
        
        if (minute > 0) { // 분
            timeString = string(abi.encodePacked(timeString, uint2str(minute), " min", minute > 1 ? "s " : " "));
        }
        
        if (second > 0 || _second == 0) { // 초
            timeString = string(abi.encodePacked(timeString, uint2str(second), " sec", second != 1 ? "s" : ""));
        }
        
        return timeString;
    }
    
    function uint2str(uint _i) public pure returns (string memory) {
        if (_i == 0) {
            return "0";
        }

        uint j = _i;
        uint len;
        
        // 자릿수 계산
        for (len = 0; j != 0; len++) {
            j /= 10;
        }

        bytes memory byteString = new bytes(len);
        uint k = len;
        
        // 숫자 -> 문자열로 변환
        for (; _i != 0; k--) {
            uint8 temp = (48 + uint8(_i - _i / 10 * 10));
            bytes1 b1 = bytes1(temp);
            byteString[k - 1] = b1;
            _i /= 10;
        }

        return string(byteString);
    }
}
