const express = require("express");
const router = express.Router();
const conn = require("../config/database");
const webSocket = require("ws");
const AppSocket = new webSocket.Server({ port: 90 });
const WebSocket = new webSocket.Server({ port: 100 });

let steps;
let heart;
let id;
let num = 1;
let appWebconnected = false;
let onChange = false;
AppSocket.on("connection", (socket) => {
  //   console.log("[APP] 연결완료");

  // 클라이언트로부터 데이터 받기
  socket.on("message", (getData) => {
    const data = JSON.parse(getData);
    appWebconnected = true;
    if (data.channel == "RhythmCare") {
      if (heart != data.heartRate) {
        id = data.ID;
        heart = data.heartRate;
        steps = data.step;
      }
    }
  });

  // 클라이언트 연결 종료 처리
  socket.on("close", () => {
    console.log("[APP] 연결종료");
    appWebconnected = false;
  });
});

WebSocket.on("connection", (socket) => {
  if (num == 1) {
    console.log("[WEB] 연결완료");
  } else if (num == 10) {
    num = 2;
  }
  num++;

  // 클라이언트로 실시간 데이터 보내기
  setInterval(() => {
    if (appWebconnected) {
      socket.send(JSON.stringify({ heartRate: heart, steps: steps, id: id }));
    }
  }, 3000);

  // 클라이언트 연결 종료 처리
  socket.on("close", () => {
    num = 1;
  });
});

module.exports = router;
