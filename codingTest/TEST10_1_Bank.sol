// // SPDX-License-Identifier: GPL-3.0

pragma solidity >= 0.8.2 < 0.9.0;



// 은행 컨트랙트부터 만들기
contract Bank {
    mapping(address => uint) public balances; // 주소 별로 잔액 검색

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint _amount) public {
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        balances[msg.sender] -= _amount; // 돈 부터 깎고
        payable(msg.sender).transfer(_amount); // 출금 해주기
    }

    function getBalance(address _user) public view returns (uint) {
        return balances[_user];
    }
}
