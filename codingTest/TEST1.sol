// SPDX-License-Identifier: GPL-3.0

pragma solidity >= 0.8.2 < 0.9.0;

contract TEST1 {
  /*
  시간 : 30분
학생이라는 구조체를 만드세요. 학생은 이름, 번호, 점수, 학점(A,B,C,F)으로 구성되어 있습니다.
학점은 90점 이상이면 A, 80점 이상이면 B, 70점 이상이면 C, 나머지는 F입니다.  
학생들이 들어가는 array를 구현하고, 학생 정보를 넣는 함수, 정보를 받는 함수를 구현하세요.

필수 구현 기능 
* 학생 추가 기능 - 특정 학생의 정보를 추가
* 학생 정보 조회 기능 - 특정 학생의 정보를 조회
  */

  struct Student {
    string name;
    uint id;
    uint score;
    string grade; // A B C F
  }

  Student[] students;

  mapping(uint => uint) studentId;




  function addStudent(string memory _name, uint _id, uint _score) public {
    string memory grade = calculateGrade(_score); // 학점계산
    Student memory newStudent = Student(_name, _id, _score, grade);

    students.push(newStudent);
    studentId[_id] = students.length - 1; // ID만들기
  }

  function getStudent(uint _id) public view returns (string memory name, uint id, uint score, string memory grade) {
      uint ID = studentId[_id];
      Student memory student = students[ID];
      return (student.name, student.id, student.score, student.grade);
  }

  function calculateGrade(uint _score) public pure returns (string memory) {
    require(_score<=100, "exceeded!!"); // 100 넘기면 에러 반환
      if (_score >= 90) {
          return "A";
      } else if (_score >= 80) {
          return "B";
      } else if (_score >= 70) {
          return "C";
      } else {
          return "F";
      }
  }
  
}