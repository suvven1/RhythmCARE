import React, { useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import styled from "styled-components";

const LoginData = () => {
  const nav = useNavigate();
  const [id, setId] = useState("");
  const [pw, setPw] = useState("");
  const [nick, setNick] = useState("");
  const loginData = {
    id: id,
    pw: pw,
    nick: nick,
  };

  const nextToUserData = () => {
    console.log(loginData);
    nav("/join/userdata", { state: { loginData: loginData } });
  };

  return (
    <LoginDataBox>
      <Title>보호자와 기기 사용자가 같이 사용할 아이디 / 비밀번호입니다.</Title>
      <LoginDataInput>
        <div>
          <input
            type="text"
            placeholder="     닉네임"
            onChange={(e) => {
              setNick(e.target.value);
            }}
          />
        </div>
        <div>
          <input
            type="text"
            placeholder="     아이디"
            onChange={(e) => {
              setId(e.target.value);
            }}
          />
        </div>
        <div>
          <input
            type="text"
            placeholder="     비밀번호"
            onChange={(e) => {
              setPw(e.target.value);
            }}
          />
        </div>
        <div>
          <input
            type="text"
            placeholder="     비밀번호 확인"
            // onChange={(e) => {
            //   setNick(e.target.value);
            // }}
          />
        </div>
      </LoginDataInput>
      <div className="locationCircle">
        <div className="circle Left"></div>
        <div className="circle Right"></div>
      </div>
      <button onClick={nextToUserData}>다음 페이지</button>
    </LoginDataBox>
  );
};

export default LoginData;

const LoginDataBox = styled.div`
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  margin-top: 10px;
  border-radius: 20px;
  & input {
    border-radius: 10px;
    height: 55px;
    width: 380px;
    margin: 5px;
    border: none;
  }

  & input::placeholder {
    color: #bdbdbd;
    font-size: 14px;
  }

  & button {
    color: white;
    font-size: 15px;
    border-radius: 10px;
    box-shadow: none;
    height: 55px;
    width: 390px;
    margin: 8px;
    background-color: #2e2288;
    border: none;
  }

  & .locationCircle {
    display: flex;
    flex-direction: row;
    & .circle {
      width: 10px;
      height: 10px;
      border-radius: 50%;
      margin: 0 10px 10px 10px;
    }
    & .Left {
      background-color: #2e2288;
    }
    & .Right {
      background-color: #bdbdbd;
    }
  }
`;

const Title = styled.div`
  font-size: 13px;
`;

const LoginDataInput = styled.div`
  height: 600px;
`;
