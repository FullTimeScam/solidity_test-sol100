// // SPDX-License-Identifier: GPL-3.0

pragma solidity >= 0.8.2 < 0.9.0;

contract TEST8 {

// 안건을 올리고 이에 대한 찬성과 반대를 할 수 있는 기능을 구현하세요. 




// * 제안한 안건 확인 기능 - 자신이 제안한 안건에 대한 현재 진행 상황 확인기능 - (번호, 제목, 내용, 찬반 반환 // 밑의 심화 문제 풀었다면 상태도 반환)
// * 전체 안건 확인 기능 - 제목으로 안건을 검색하면 번호, 제목, 내용, 제안자, 찬반 수 모두를 반환하는 기능
// -------------------------------------------------------------------------------------------------
// * 안건 진행 과정 - 투표 진행중, 통과, 기각 상태를 구별하여 알려주고 15개 블록 후에 전체의 70%가 투표에 참여하고 투표자의 66% 이상이 찬성해야 통과로 변경, 둘 중 하나라도 만족못하면 기각



    // 안건은 번호, 제목, 내용, 제안자(address) 그리고 찬성자 수와 반대자 수로 이루어져 있습니다.(구조체)
    struct Agenda {
        uint index;
        string title;
        string content;
        address proposer;
        uint forvote;
        uint agavote;
    }

    uint public agendaIndexCount = 0;

    // 사용자는 자신의 이름과 주소, 자신이 만든 안건 그리고 자신이 투표한 안건과 어떻게 투표했는지(찬/반)에 대한 정보[string => bool]로 이루어져 있습니다.(구조체)
    struct User {
        string myName;
        address myAddress;
        string myAgenda;
        mapping(string => bool) myVote;
    }

    // 안건들을 모아놓은 자료구조도 구현하세요. 
    Agenda[] public agendas;

    mapping(address => User) public users;


    // * 사용자 등록 기능 - 사용자를 등록하는 기능
    function addUser(string memory _myname) public {
        require((users[msg.sender].myAddress) == address(0), "already joined");
        users[msg.sender].myName = _myname;
        users[msg.sender].myAddress = msg.sender;
    }


    // * 안건 제안 기능 - 자신이 원하는 안건을 제안하는 기능
    function agendaStart(string memory _title, string memory _content) public {
        
        agendaIndexCount++; // 1번부터 시작
        
        agendas.push(Agenda({
            index : agendaIndexCount,
            title : _title,
            content : _content,
            proposer : msg.sender,
            forvote : 0, // 초기화
            agavote : 0 // 초기화
        }));
        
    }

    // 안건 찾기 함수
        function findAgendaIndexByTitle(string memory _title) internal view returns (uint) {
        for (uint i = 0; i < agendas.length; i++) {
            if (keccak256(bytes(agendas[i].title)) == keccak256(bytes(_title))) {
                return agendas[i].index;
            }
        }
        return 0; // 못 찾은 경우 0
    }

    // * 투표하는 기능 - 특정 안건에 대하여 투표하는 기능, 안건은 제목으로 검색, 이미 투표한 건에 대해서는 재투표 불가능
    function voting(string memory _agendaTitle, bool upDown) public {
        uint index = findAgendaIndexByTitle(_agendaTitle);
        require(index != 0, "Agenda no exist");
        // (이미 투표한 사람은 못 하는 조건)
        require(!users[msg.sender].myVote[_agendaTitle], "Already voted");


        if (upDown) {
            agendas[index - 1].forvote++;
        } else {
            agendas[index - 1].agavote++;
        }

        // "투표 인증마크"
        users[msg.sender].myVote[_agendaTitle] = true;

    }

    // 전체 아젠다 찾기
        function getAgendaByTitle(string memory _title) public view returns (uint, string memory, string memory, address, uint, uint) {
        uint index = findAgendaIndexByTitle(_title);

        Agenda memory agenda = agendas[index - 1];
        return (agenda.index, agenda.title, agenda.content, agenda.proposer, agenda.forvote, agenda.agavote);
    }



}