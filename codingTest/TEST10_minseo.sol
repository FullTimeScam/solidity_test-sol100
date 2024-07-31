// // SPDX-License-Identifier: GPL-3.0

pragma solidity >= 0.8.2 < 0.9.0;



// 은행 컨트랙트부터 연결
import "./TEST10_1_Bank.sol";


contract TEST10 {

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


    struct User{
        string name;
        address account;
        uint balance;
        address bankAddress;
    }

    mapping(address => User) public users;

    function signUp(string memory _name, address _bankAddr) public {
        users[msg.sender] = User({
            name : _name,
            account : msg.sender,
            balance : 0,
            bankAddress : _bankAddr
        });
    }

    function deposit() public payable {
        Bank bank = Bank(users[msg.sender].bankAddress); // Bank컨트랙트 인스턴스화
        bank.deposit{value : msg.value}();
        
        
        users[msg.sender].balance += msg.value;
    }

    function withraw(uint _amount) public {
        require(users[msg.sender].account != address(0), "please sign up");
        require(users[msg.sender].balance != 0);

        // users[msg.sender].balance -= _amount; // 잔액 변경 먼저 하고
        // payable(msg.sender).transfer(_amount); // 돈 꺼내주기       
        Bank bank = Bank(users[msg.sender].bankAddress);
        users[msg.sender].balance -= _amount; // 잔액 변경
        bank.withdraw(_amount); // withdraw 호출
    
    }


    function bank2bank(address _bankA, address _bankB, uint _amount) public {
        require(users[msg.sender].account != address(0), "please sign up");
        require(users[msg.sender].balance != 0);

    }






}