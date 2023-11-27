const express = require("express");
const router = express.Router();
const pool = require("../config/database");
const cluster = require("cluster");
const webSocket = require("ws");

if (cluster.isMaster) {
  cluster.fork({ WS_PORT_APP: 90, WS_PORT_WEB: 100 });
  cluster.fork({ WS_PORT_APP: 91, WS_PORT_WEB: 101 });
  cluster.fork({ WS_PORT_APP: 92, WS_PORT_WEB: 102 });
  cluster.fork({ WS_PORT_APP: 93, WS_PORT_WEB: 103 });
} else {
  const wsPortApp = process.env.WS_PORT_APP || 90;
  const wsPortWeb = process.env.WS_PORT_WEB || 100;

  const AppSocket = new webSocket.Server({ port: wsPortApp });
  const WebSocket = new webSocket.Server({ port: wsPortWeb });

  let steps;
  let heart;
  let id;
  let num = 1;
  let appWebconnected = false;
  let onChange = false;
  AppSocket.on("connection", (socket, request) => {
    console.log("[APP] 연결완료");

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

  WebSocket.on("connection", (socket, request) => {
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
}

module.exports = router;
