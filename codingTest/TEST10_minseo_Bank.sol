// SPDX-License-Identifier: GPL-3.0

pragma solidity >= 0.8.2 < 0.9.0;

    // 은행은 여러개가 있고 IRS는 1개가 있다.
    // 은행에 관련된 어플리케이션을 만드세요.
    // 은행(CA)은 여러가지가 있고, 유저(EOA)는 원하는 은행에 넣을 수 있다. 
    // 국세청은 은행들을 관리하고 있고, 세금을 징수할 수 있다. 
    // 세금은 간단하게 전체 보유자산의 1%를 징수한다. 세금을 자발적으로 납부하지 않으면 강제징수한다. 

    // * 회원 가입 기능 - 사용자가 은행에서 회원가입하는 기능 - 이름, 주소, 금액 / 지갑주소별로 매핑
    // * 입금 기능 - 사용자가 자신이 원하는 은행에 가서 입금하는 기능
    // * 출금 기능 - 사용자가 자신이 원하는 은행에 가서 출금하는 기능
    // * 은행간 송금 기능 1 - 사용자의 A 은행에서 B 은행으로 자금 이동 (자금의 주인만 가능하게)
    // * 은행간 송금 기능 2 - 사용자 1의 A 은행에서 사용자 2의 B 은행으로 자금 이동
    // * 세금 징수 - 국세청은 주기적으로 사용자들의 자금을 파악하고 전체 보유량의 1%를 징수함. 세금 납부는 유저가 자율적으로 실행. (납부 후에는 납부 해야할 잔여 금액 0으로)
    // -------------------------------------------------------------------------------------------------
    // * 은행간 송금 기능 수수료 - 사용자 1의 A 은행에서 사용자 2의 B 은행으로 자금 이동할 때 A 은행은 그 대가로 사용자 1로부터 1 finney 만큼 수수료 징수.
    // * 세금 강제 징수 - 국세청에게 사용자가 자발적으로 세금을 납부하지 않으면 강제 징수. 은행에 있는 사용자의 자금이 국세청으로 강제 이동


contract IRS {
    address[] BankList;

    function pushList(address _addr) public {
        BankList.push(_addr);
    }

    function getList() public view returns(address[] memory) {
        return BankList;
    }

    function predict() public view returns(uint) {

        uint sum;

        for(uint i = 0 ; i < BankList.length; i++) {
            sum += Bank(payable(BankList[i])).getUser(msg.sender).balance;
        }

        return sum / 100;
    }

    function payTaxes() public payable  {
        require(msg.value == predict(),"error");
        
        for(uint i=0; i<BankList.length; i++) {
            Bank(payable(BankList[i])).users(msg.sender).paid;
        }
    }
}


contract Bank {
    struct User {
        address _addr;
        uint balance;
        uint paid; // 시간이라서 uint
    }

    receive() external payable { }

    mapping(address => User) public users;

    function getUser(address _addr) public view returns(User memory) {
        return users[_addr];
    }

    function signUp() public {
        users[msg.sender] = User(msg.sender, 0);
    }

    function deposit() public payable {
        users[msg.sender].balance += msg.value;
    }

    function _deposit(address _addr, uint _n) public {
        users[_addr].balance += _n;
    }

    function withDraw(uint _n) public {
        require(users[msg.sender].balance >= _n, "Not enough funds");
        users[msg.sender].balance -= _n;
        payable(msg.sender).transfer(_n);
    }

    // 은행간 송금 기능 1 - 사용자의 A 은행에서 B 은행으로 자금 이동 (자금의 주인만 가능하게)
    function transfer1(address payable _to, uint _n) public {
        // 조건
        require(Bank(_to).getUser(msg.sender)._addr != address(0));
        users[msg.sender].balance -= _n;
        _to.transfer(_n);
        // 잔액 변화
        Bank(_to)._deposit(msg.sender, _n);
    }

    function transfer2(address payable _bank, address _user, uint _n) public {
        require(Bank(_bank).getUser(_user)._addr != address(0));
        users[msg.sender].balance -= _n;
        _bank.transfer(_n);
        Bank(_bank)._deposit(_user, _n);
    }
}