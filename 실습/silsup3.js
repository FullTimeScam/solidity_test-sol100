var { Web3 } = require("web3");
var web3 = new Web3(
  "https://sepolia.infura.io/v3/642c09f951a744d0b2ff3fcf830ffcd6"
);

var privateKey =
  "0xd06d78ab2a2e511edbf0f7a4d0f7aaae7625ca623afbda6b8e5bec96e8d30d2e"; // 앞에 0x 꼭 붙이기
var account = web3.eth.accounts.privateKeyToAccount(privateKey);
web3.eth.accounts.wallet.add(account);

var contractAddress = "0xd92C99ECA10A7c4Eb2553C45CE5D7fe8f97F3f46";
var contractAddress2 = "0x77ec301541b9c2ad99cc5e32a939ee424da59641";
var contractAddress3 = "0xC17760323E064b8563711a78C8DD10Cbf77ba936";

const myAddress = account.address; // 0xE4366c2F4Eca6B42f9C0d1d608E7dCdb94F43731
const myInitial = "SSJ";
const myNumber = 327;
console.log(`my addr = ${myAddress}`);

var start1 = await web3.eth.abi.encodeFunctionSignature("start1()");
var hex1 = await web3.eth.call({
  from: account.address,
  to: contractAddress,
  data: start1,
});
web3.utils.hexToUtf8(hex1);
// STAGE 0-1 : check your status with Stage(). now call start2.

var start2 = await web3.eth.abi.encodeFunctionSignature("start2()");
var hex2 = await web3.eth.call({
  from: account.address,
  to: contractAddress,
  data: start2,
});
web3.utils.hexToUtf8(hex2);
// STAGE 0-2 : the name of next function you have to call is : setData

var setData = await web3.eth.abi.encodeFunctionSignature("setData()");
var hex3 = await web3.eth.call({
  from: account.address,
  to: contractAddress,
  data: setData,
});
web3.utils.hexToUtf8(hex3);
// SSTAGE 0-3 : call this function again with address, initial and number you submitted

var Stage = await web3.eth.abi.encodeFunctionSignature("Stage()");
var StageHex = await web3.eth.call({
  from: account.address,
  to: contractAddress,
  data: Stage,
});
StageHex;
// ''

var data = web3.eth.abi.encodeFunctionCall(
  {
    name: "setData",
    type: "function",
    inputs: [
      { type: "address", name: "address" },
      { type: "string", name: "myInitial" },
      { type: "uint256", name: "myNumber" },
    ],
  },
  [account.address, myInitial, myNumber]
);

var hex4 = await web3.eth.call({
  from: account.address,
  to: contractAddress,
  data: data,
});
web3.utils.hexToUtf8(hex4);
// STAGE 1-1 : better check the personal_id or get_personal_id()

var get_personal_id = await web3.eth.abi.encodeFunctionSignature(
  "get_personal_id()"
);
var hex5 = await web3.eth.call({
  from: account.address,
  to: contractAddress,
  data: get_personal_id,
});
web3.utils.hexToUtf8(hex5);
// STAGE 1-2 : call this function with address again.

var data = web3.eth.abi.encodeFunctionCall(
  {
    name: "get_personal_id",
    type: "function",
    inputs: [{ type: "address", name: "address" }],
  },
  [contractAddress]
);

var hex6 = await web3.eth.call({
  from: account.address,
  to: contractAddress,
  data: data,
});
web3.utils.hexToUtf8(hex6);
// this is your personal methodId call it. If it fails solve problem() first.

var problem = await web3.eth.abi.encodeFunctionSignature("problem()");
var hex7 = await web3.eth.call({
  from: account.address,
  to: contractAddress,
  data: problem,
});
web3.utils.hexToUtf8(hex7);
// get TEST_TOKEN and call it to help_me().

var getPersonalId2 = await web3.eth.abi.encodeFunctionSignature(
  "get_personal_id(address)"
);
var encode = await web3.eth.abi.encodeParameters(
  ["address"],
  [account.address]
);

var data = getPersonalId2 + encode.slice(2);

var estimatedGas = await web3.eth.estimateGas({
  from: account.address,
  to: contractAddress,
  data: data,
});
await web3.eth.sendTransaction({
  from: account.address,
  to: contractAddress,
  data: data,
  gas: estimatedGas,
});

var data2 = web3.eth.abi.encodeFunctionCall(
  {
    name: "get_personal_id",
    type: "function",
    inputs: [{ type: "address", name: "personal_id" }],
  },
  [account.address]
);

var hex9 = await web3.eth.call({
  from: account.address,
  to: contractAddress,
  data: data2,
});
web3.utils.hexToUtf8(hex9);

// this is your personal methodId call it. If it fails solve problem() first.

web3.utils.hexToUtf8(hex7);
// get TEST_TOKEN and call it to help_me().

var TEST_TOKEN = await web3.eth.abi.encodeFunctionSignature("TEST_TOKEN()");
var hex10 = await web3.eth.call({
  from: account.address,
  to: contractAddress,
  data: TEST_TOKEN,
});
hex10;
// ''

var help_me = await web3.eth.abi.encodeFunctionSignature("help_me()");
var hex8 = await web3.eth.sendTransaction({
  from: account.address,
  to: contractAddress2,
  data: help_me,
  gas: 5000000,
});
hex8;
// 'TT토큰 민팅 받음'

/*Token minting 받은 사람들은 아래의 정보들을 이용하여 문제를 마무리하면 됩니다. 

CA : 0xC17760323E064b8563711a78C8DD10Cbf77ba936
getData(address)
// 신세종 : f2b05087
*/

var getDataHash = "0x38266b22";
var data3 = web3.eth.abi.encodeParameter("address", account.address);
var encodeData3 = getDataHash + data3.slice(2);
var hex11 = await web3.eth.call({
  from: account.address,
  to: contractAddress3,
  data: encodeData3,
});

hex11;
//0x32d1322600000000000000000000000000000000000000000000000000000000

var problem = await web3.eth.abi.encodeFunctionSignature("problem()");
var hex12 = await web3.eth.sendTransaction({
  from: account.address,
  to: contractAddress,
  data: problem,
  gas: 5000000,
});
hex12;
// 스테이지2로 넘어옴

// 로그 2개 나옴

web3.utils.hexToUtf8(
  "0x0000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000004772656d656d62657220686f77206d75636820746f6b656e20796f7520676f742e2074686174277320746865206b65792068696e7420666f72206e657874207175657374696f6e2e00000000000000000000000000000000000000000000000000"
);
// remember how much token you got. that's the key hint for next question.
// 0.0000000000004 TT
// 로그1 Hex => decimal 결과 : 100000
// 즉, 10만 wei는 0.0000000000001 ether입니다.

var Sejong = "0xf2b05087";

var mamuri = "0xf2b05087";
var hex13 = await web3.eth.sendTransaction({
  from: account.address,
  to: contractAddress,
  data: mamuri,
  gas: 5000000,
  value: 100000,
});
hex13;
// 벨류 10만 웨이만큼 보냄

var StageHex = await web3.eth.call({
  from: account.address,
  to: contractAddress,
  data: Stage,
});
// 스테이지 확인 => 3
