import React, { useEffect, useState } from "react";
import styled from "styled-components";
import useNotification from "../Notification/useNotification";
const HeartBeat = () => {
  // ----------------------------------------------------------------------------
  const loginData = JSON.parse(localStorage.getItem("loginData"));
  const [heartbeat, setHeartbeat] = useState("--");

  const socket = new WebSocket("ws://115.95.222.206:100");
  const triggerNotif = useNotification("[경고] 심박수 이상", {
    body: `기기 사용자의 심박에서 이상을 감지했습니다! \n현재 심박수 : ${heartbeat}`,
    icon: `${process.env.PUBLIC_URL}/images/ic_launcher.png`,
    badge: `${process.env.PUBLIC_URL}/images/ic_launcher.png`,
    tag: "Rhythm Care",
    requireInteraction: true,
  });

  // 심박수 받아오기
  if (loginData != null) {
    socket.addEventListener("message", (e) => {
      e.preventDefault();
      const data = JSON.parse(e.data);
      if (data.id == loginData.id) {
        setHeartbeat(data.heartRate);
        if (parseInt(data.heartRate) < 60 || parseInt(data.heartRate) > 100) {
          triggerNotif();
        }
      }
    });
  }

  // ----------------------------------------------------------------------------

  return (
    <HeartBeatBox>
      <img
        src={`${process.env.PUBLIC_URL}/images/rhythm/heartbeat.gif`}
        alt=""
      />
      <p id="hb">{heartbeat}</p>
      <p>bpm</p>
    </HeartBeatBox>
  );
};

export default HeartBeat;

// 심박수 ------------------------
const HeartBeatBox = styled.div`
  margin-top: 50px;
  width: 100%;
  height: 460px;
  /* background-image: url("${process.env
    .PUBLIC_URL}/images/rhythm/heartbeat.gif"); */
  background-size: cover;
  display: flex;
  flex-direction: column;
  align-items: center;

  & img {
    position: absolute;
    z-index: -1;
    width: 500px;
  }

  & #hb {
    margin-top: 150px;
    font-size: 80px;
    font-weight: bold;
  }

  & p {
    margin-top: -70px;
    font-size: 40px;
    font-weight: bold;
  }

  @media only screen and (max-width: 1040px) {
    & img {
      width: 400px;
    }

    & #hb {
      margin-top: 120px;
    }
  }
`;
