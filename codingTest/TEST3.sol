// // SPDX-License-Identifier: GPL-3.0

pragma solidity >= 0.8.2 < 0.9.0;

contract TEST3 {
/*
학생 점수관리 프로그램입니다.
여러분은 한 학급을 맡았습니다.
학생은 번호, 이름, 점수로 구성되어 있고(구조체)
가장 점수가 낮은 사람을 집중관리하려고 합니다.

가장 점수가 낮은 사람의 정보를 보여주는 기능,
총 점수 합계, 총 점수 평균을 보여주는 기능,
특정 학생을 반환하는 기능, -> 점수로 반환
가능하다면 학생 전체를 반환하는 기능을 구현하세요. ([] <- array)
*/


    struct Student {
        uint id;
        string name;
        uint score;
    }

    Student[] students;
    uint nextNumber = 1;

    constructor() { // 학생 - 점수 샘플
        addStudent("Alice", 100);
        addStudent("Bob", 80);
        addStudent("Charlie", 60);
        addStudent("Dwayne", 40);
        addStudent("Ellen", 20);
    }
    
    function addStudent( string memory _name, uint _score) public {
        students.push(Student(nextNumber, _name, _score));
        nextNumber++;
    }

    function lowestScoreStudent() public view returns (Student memory) {
        Student memory lowest = students[0]; // 1qjs번 학생
        for (uint i = 1; i < students.length; i++) {
            if (students[i].score < lowest.score) { // 이전 학생보다 점수가 낮으면
                lowest = students[i]; // lowest에 저장(교체)
            }
        }
        return lowest;
    }

    function TotalScore() public view returns (uint) {
        uint total;
        for (uint i = 0; i < students.length; i++) {
            total += students[i].score;
        }
        return total;
    }

    

    function AverageScore() public view returns (uint) {
        return TotalScore() / students.length;
    }

    function getStudentById(uint _id) public view returns (Student memory) {
        return students[_id-1];
    }

    function getAllStudents() public view returns (Student[] memory) {
        return students;
    }
}