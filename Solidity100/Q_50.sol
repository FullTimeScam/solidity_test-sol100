// SPDX-License-Identifier: GPL-3.0

pragma solidity >= 0.8.2 < 0.9.0;

import "@openzeppelin/contracts/utils/Strings.sol";

contract TOSTRING {
    function A(uint _a) public pure returns(string memory) {
        return Strings.toString(_a);
    }

    // string.concat(a,b);
    function getNumbers(uint[] memory _numbers) public pure returns(string memory) {
        string memory _res;
        for(uint i=0; i<_numbers.length; i++) {
            _res = string.concat(_res, Strings.toString(_numbers[i]));
        }
        return _res;
    }

    function getDigits(uint _num) public pure returns(uint) {
        uint idx = 1;
        while(_num >= 10) {
            _num = _num/10;
            idx ++;
        }

        return idx;
    }

    function uintToBytes(uint8 _num) public pure returns(bytes1) {
        return bytes1(_num);
    }

    function uintToString(uint _num) public pure returns(string memory) {
        uint digits = getDigits(_num);
        bytes memory _b = new bytes(digits);

        while(_num != 0) {
            digits--;
            _b[digits] = bytes1(uint8(48+_num%10));
            _num /= 10;
        }

        return string(_b);
    }

    function FINAL(uint[] memory _num) public pure returns(string memory) {
        bytes memory _b = new bytes(_num.length);
        for(uint i=0; i<_num.length; i++) {
            _b = abi.encodePacked(_b, uintToString(_num[i]));
        }

        return string(abi.encodePacked(_b));
    }
}