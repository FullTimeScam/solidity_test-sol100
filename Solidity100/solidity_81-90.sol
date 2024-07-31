// SPDX-License-Identifier: GPL-3.0

pragma solidity >= 0.8.2 < 0.9.0;

contract Q81 {
/*
Contract에 예치, 인출할 수 있는 기능을 구현하세요.
지갑 주소를 입력했을 때 현재 예치액을 반환받는 기능도 구현하세요.
*/

//예치금 추적
    mapping(address => uint) private balances;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint _amount) public {
        require(balances[msg.sender] >= _amount);
        balances[msg.sender] -= _amount;
        payable(msg.sender).transfer(_amount);
    }

    function getBalance(address _addr) public view returns(uint) {
        return balances[_addr];
    }


}


contract Q82 {
/*
특정 숫자를 입력했을 때 그 숫자까지의 3,5,8의 배수의 개수를 알려주는 함수를 구현하세요.
*/

    function countMultiples(uint number) public pure returns (uint) {
        uint256 count = 0;
        
        for (uint i = 1; i <= number; i++) {
            if (i % 3 == 0 || i % 5 == 0 || i % 8 == 0) {
                count++;
            }
        }
        
        return count;
    }

}


contract Q83 {
/*
이름, 번호, 지갑주소 그리고 숫자와 문자를 연결하는 mapping을 가진 구조체 사람을 구현하세요.
사람이 들어가는 array를 구현하고 array안에 push 하는 함수를 구현하세요.
*/

    struct HUMAN {
        string name;
        uint id;
        address wallet;
        mapping(uint => string) numstr;
    }

    HUMAN[] public humans;
    uint public nextId = 0;

    function addHuman(string memory _name, address _wallet) public {
        HUMAN storage human = humans.push();
        human.name = _name;
        human.id = nextId;
        human.wallet = _wallet;
        nextId++;
    }

    function setHumanData(uint _index, uint _key, string memory _value) public {
        require(_index < humans.length, "Index out of bounds");
        HUMAN storage human = humans[_index];
        human.numstr[_key] = _value;
    }

    function getHumanData(uint _index, uint _key) public view returns (string memory) {
        require(_index < humans.length, "Index out of bounds");
        HUMAN storage human = humans[_index];
        return human.numstr[_key];
    }
}


contract Q84 {
/*
2개의 숫자를 더하고, 빼고, 곱하는 함수들을 구현하세요.
단, 이 모든 함수들은 blacklist에 든 지갑은 실행할 수 없게 제한을 걸어주세요.
*/

    mapping(address => bool) public blacklist;

    // 함수마다 블랙리스트 정보 주기
    modifier notBlacklisted() {
        require(!blacklist[msg.sender], "Sender address is blacklisted");
        _;
    }

    function addNumbers(uint a, uint b) public view notBlacklisted returns (uint) {
        return a + b;
    }

    function subtractNumbers(uint a, uint b) public view notBlacklisted returns (uint) {
        return a - b;
    }

    function multiplyNumbers(uint a, uint b) public view notBlacklisted returns (uint) {
        return a * b;
    }

    function addToBlacklist(address _address) public {
        blacklist[_address] = true;
    }

    function removeFromBlacklist(address _address) public {
        blacklist[_address] = false;
    }
}


contract Q85 {
/*
숫자 변수 2개를 구현하세요.
한개는 찬성표 나머지 하나는 반대표의 숫자를 나타내는 변수입니다.
찬성, 반대 투표는 배포된 후 20개 블록동안만 진행할 수 있게 해주세요.
*/

    uint public forVotes;
    uint public agaVotes;
    uint public startBlock;
    uint public endBlock;

    constructor() {
        startBlock = block.number;
        endBlock = startBlock + 20; // 배포 된 후라서 컨스트럭터
    }

    modifier onVotingPeriod() {
        require(block.number <= endBlock, "Voting has ended");
        _;
    }

    function voteYes() public onVotingPeriod {
        forVotes++;
    }

    function voteNo() public onVotingPeriod {
        agaVotes++;
    }

}


contract Q86 {
/*
숫자 변수 2개를 구현하세요.
한개는 찬성표 나머지 하나는 반대표의 숫자를 나타내는 변수입니다.
찬성, 반대 투표는 1이더 이상 deposit한 사람만 할 수 있게 제한을 걸어주세요.
*/

    uint public forVotes;
    uint public againstVotes;
    mapping(address => uint) public deposits;

    function deposit() public payable {
        require(msg.value >= 1 ether, "Minimum deposit is 1 ether");
        deposits[msg.sender] += msg.value;
    }


    function vote(bool support) public {
        require(deposits[msg.sender] >= 1 ether, "Deposit at least 1 ether to vote");
        if (support) {
            forVotes++;
        } else {
            againstVotes++;
        }
    }

    function getDeposit() public view returns (uint) {
        return deposits[msg.sender];
    }

    function withdraw() public {
        uint amount = deposits[msg.sender];
        require(amount > 0, "No deposit to withdraw");
        deposits[msg.sender] = 0;
        payable(msg.sender).transfer(amount);
    }
}


contract Q87 {
/*
visibility에 신경써서 구현하세요. 
숫자 변수 a를 선언하세요.
해당 변수는 컨트랙트 외부에서는 볼 수 없게 구현하세요.
변화시키는 것도 오직 내부에서만 할 수 있게 해주세요.
*/

    uint private a;

    function setA(uint _a) internal {
        a = _a;
    }

    function getA() internal view returns (uint) {
        return a;
    }
}


contract Q88 {
/*
1. 아래의 코드를 보고 owner를 변경시키는 방법을 생각하여 구현하세요.
    
    ```solidity
    contract OWNER {
    	address private owner;
    
    	constructor() {
    		owner = msg.sender;
    	}
    
        function setInternal(address _a) internal {
            owner = _a;
        }
    
        function getOwner() public view returns(address) {
            return owner;
        }
    }
    ```
    
    힌트 : 상속
*/

}


// Q88_ChangeOwner의 오너는 변경할 수 있는데
// Q88_OWNER의 오너를 변경시키는 방법은 잘 모르겠습니다.

contract Q88_OWNER {
    address private owner;

    constructor() {
        owner = msg.sender;
    }

    function setInternal(address _a) internal {
        owner = _a;
    }

    function getOwner() public view returns(address) {
        return owner;
    }
}

contract Q88_ChangeOwner is Q88_OWNER {

    function changeOwner(address newOwner) public {
        setInternal(newOwner);
    }
}


contract Q89 {
/*
이름과 자기 소개를 담은 고객이라는 구조체를 만드세요.
이름은 5자에서 10자이내 자기 소개는 20자에서 50자 이내로 설정하세요.
(띄어쓰기 포함 여부는 신경쓰지 않아도 됩니다. 더 쉬운 쪽으로 구현하세요.)
*/
    struct Customer {
        string name;
        string introduction;
    }

    Customer[] public customers;

    function addCustomer(string memory _name, string memory _introduction) public {
        require(bytes(_name).length >= 5 && bytes(_name).length <= 10, "5<= Name.length <=10");
        require(bytes(_introduction).length >= 20 && bytes(_introduction).length <= 50, "2-<=Introduction.length<=50");

        Customer memory newCustomer = Customer({name: _name, introduction: _introduction});

        customers.push(newCustomer);
    }

    function getCustomer(uint index) public view returns (string memory, string memory) {
        require(index < customers.length, "Index out of bounds");
        Customer memory customer = customers[index];
        return (customer.name, customer.introduction);
    }
}


contract Q90 {
/*
당신 지갑의 이름을 알려주세요. 아스키 코드를 이용하여 byte를 string으로 바꿔주세요.
*/

    mapping(address => bytes) private walletNames;

    // 이름 설정
    function setWalletName(string memory name) public {
        require(bytes(name).length > 0, "Name cannot be empty");
        walletNames[msg.sender] = abi.encodePacked(name);
    }

    // 지갑 주소에 대한 이름 반환
    function getWalletName(address wallet) public view returns (string memory) {
        bytes memory nameBytes = walletNames[wallet];
        require(nameBytes.length > 0, "No name set for this wallet");
        return bytesToString(nameBytes);
    }

    function bytesToString(bytes memory _bytes) internal pure returns (string memory) {
        bytes memory strBytes = new bytes(_bytes.length);
        for (uint i = 0; i < _bytes.length; i++) {
            strBytes[i] = _bytes[i];
        }
        return string(strBytes);
    }

}

