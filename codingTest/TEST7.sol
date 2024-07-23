// // SPDX-License-Identifier: GPL-3.0

pragma solidity >= 0.8.2 < 0.9.0;

contract TEST7 {

// * 악셀 기능 - 속도를 10 올리는 기능, 악셀 기능을 이용할 때마다 연료가 20씩 줄어 듦, 연료가 30이하면 더 이상 악셀을 이용할 수 없음, 속도가 70이상이면 악셀 기능은 더이상 못씀
// * 주유 기능 - 주유하는 기능, 주유를 하면 1eth를 지불해야하고 연료는 100이 됨
// * 브레이크 기능 - 속도를 10 줄이는 기능, 브레이크 기능을 이용할 때마다 연료가 10씩 줄어듬, 속도가 0이면 브레이크는 더이상 못씀
// * 시동 끄기 기능 - 시동을 끄는 기능, 속도가 0이 아니면 시동은 꺼질 수 없음
// * 시동 켜기 기능 - 시동을 켜는 기능, 시동을 키면 정지 상태로 설정됨
// --------------------------------------------------------
// * 충전식 기능 - 지불을 미리 해놓고 추후에 주유시 충전금액 차감 

    uint public speed;
    uint public fuel;
    bool public isRunning; // 시동 여부
    uint public balance;


    constructor() {
        speed = 0;
        fuel = 100;
        isRunning = false;
        balance = 0; // 충전 잔액
    }

    // * 악셀 기능
    function accel() public {
        require(isRunning == true, "need to start up first.");
        require(fuel > 30, "low fuel. accel not working"); // 연료가 30이하면 더 이상 악셀을 이용할 수 없음
        require(speed < 70, "too fast. accel not working"); // 속도가 70이상이면 악셀 기능은 더이상 못씀
        
        speed += 10; // 속도를 10 올리는 기능
        fuel -= 20; // 악셀 기능을 이용할 때마다 연료가 20씩 줄어 듦
    }

    // * 주유 기능
    function refuel() public payable{
        require(msg.value == 1 ether || balance >= 1 ether, "insufficient balance");
        // 조건 추가 : 시동 꺼야 주유할 수 있음
        require(isRunning == false, "FBI WARNING!!! NOT ALLOW FILLING GAS!! STOP YOUR ENGINE!!");
        
        // 주유를 하면 1eth를 지불해야하고 연료는 100이 됨
        if (msg.value < 1 ether && balance >= 1 ether) {
            // 추후에 주유시 충전금액 차감 
            balance -= 1 ether;
        }

        fuel = 100;
        
    }

    // * 브레이크 기능
    // 속도를 10 줄이는 기능, 브레이크 기능을 이용할 때마다 연료가 10씩 줄어 듦, 속도가 0이면 브레이크는 더이상 못씀
    function breaking() public {
        require(speed>0, "car sttoped.");

        speed -= 10; // 속도를 10 줄이는 기능,
        fuel -= 10; // 브레이크 기능을 이용할 때마다 연료가 10씩 줄어 듦,
    }

    // * 시동 끄기 기능 - 시동을 끄는 기능,
    function turnOff() public view {
        // 속도가 0이 아니면 시동은 꺼질 수 없음
        require(speed == 0, "Car must be sttoped ro turn off");
         // 시동 끄는 기능
        isRunning == false;
    }

    // * 시동 켜기 기능 - 시동을 켜는 기능, 시동을 키면 정지 상태로 설정됨
    function startUp() public {
        require(isRunning == false, "Car is already running.");
        isRunning = true;
        speed = 0;
    }

    // * 충전식 기능 - 지불을 미리 해놓고 추후에 주유시 충전금액 차감 
    function recharge() public payable {
        // 지불을 미리 해놓고
        balance += msg.value;
    }


    function getStatus() public view returns (uint, uint, bool, uint) {
        return (speed, fuel, isRunning, balance);
    }

}