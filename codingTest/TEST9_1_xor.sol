// // SPDX-License-Identifier: GPL-3.0

pragma solidity >= 0.8.2 < 0.9.0;

contract TEST9 {

    function op5(uint a, uint b, uint c, uint d) public pure returns(uint) {
        return (a^b^c^d);
    }


}