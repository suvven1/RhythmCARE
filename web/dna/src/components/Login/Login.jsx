import React, { useState } from "react";
import styled from "styled-components";
import { Link, useNavigate } from "react-router-dom";
import axios from "../../axios";

const Login = () => {
  const nav = useNavigate();
  const [user, setUser] = useState("manager");
  const [id, setId] = useState("");
  const [pw, setPw] = useState("");
  const [name, setName] = useState("");
  const [nick, setNick] = useState("");
  const login = (e) => {
    e.preventDefault();
    console.log(user);
    doLogin();
  };

  const doLogin = () => {
    axios.post("/user/login", { user: user, id: id, pw: pw }).then((res) => {
      if (res.data.loginResult) {
        endLogin(res.data.loginResult.name, res.data.loginResult.nick);
      } else {
        alert("아이디 또는 비밀번호를 확인해주세요!");
      }
    });
  };

  const endLogin = async (name, nick) => {
    await setName(name);
    await setNick(nick);
    alert(`${name}(${nick})님 환영합니다!`);
    sessionStorage.setItem("name", `${name}`);
    sessionStorage.setItem("nick", `${nick}`);
    window.location.replace("/");
  };

  return (
    <LoginBack>
      <LoginBox>
        <Logo>
          <Link to="/">
            <img src={"/images/AppLogo.png"} alt="리듬케어 로고" />
          </Link>
        </Logo>
        <SelectUser>
          <Input
            type="radio"
            id="toggle-switch"
            name="switch"
            value="manager"
            defaultChecked
            onChange={(e) => {
              setUser(e.target.value);
            }}
          />
          <Label htmlFor="toggle-switch">
            <Span /> 보호자로 로그인
          </Label>
          <Input
            type="radio"
            id="toggle-switch2"
            name="switch"
            value="user"
            onChange={(e) => {
              setUser(e.target.value);
            }}
          />
          <Label htmlFor="toggle-switch2">기기 사용자로 로그인</Label>
        </SelectUser>
        <LoginForm onSubmit={login}>
          <div>
            <input
              type="text"
              className="userInput"
              placeholder="아이디"
              onChange={(e) => {
                setId(e.target.value);
              }}
            />
          </div>
          <div>
            <input
              type="text"
              className="userInput"
              placeholder="비밀번호"
              onChange={(e) => {
                setPw(e.target.value);
              }}
            />
          </div>
          <input type="submit" className="btnLogin" value="로그인" />
        </LoginForm>
        <Find>
          <Link to="/findidpw" className="findUserData">
            아이디 또는 비밀번호 찾기
          </Link>
        </Find>
        <Join>
          <span>아직 계정이 없으신가요?</span>
          <Link to="/join/logindata" className="goToJoin">
            회원가입
          </Link>
        </Join>
      </LoginBox>
    </LoginBack>
  );
};

export default Login;

const LoginBack = styled.div`
  background-color: whitesmoke;
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  z-index: 99999999999;
`;

const LoginBox = styled.div`
  width: 100wh;
  display: flex;
  flex-direction: column;
  align-items: center;
  margin-top: 120px;
`;

const Logo = styled.div`
  & img {
    width: 400px;
    margin: 20px 0 0 0;
  }
`;

const SelectUser = styled.div`
  display: inline-block;
  position: relative;
  width: 376px;
  height: 55px;
  margin-top: 20px;
  margin-bottom: 40px;
  border-radius: 1000px;
  background-color: white;
`;

const Label = styled.label`
  display: inline-block;
  position: relative;
  width: 188px;
  height: 40px;
  border-radius: 1000px;
  color: #bdbdbd;
  line-height: 55px;
  font-weight: 700;
  font-size: 15px;
  text-align: center;
  cursor: pointer;
  transition: 0.5s ease;
  z-index: 2; //span보다 위쪽에 위치
`;

//하얀색 원
const Span = styled.span`
  background-color: #2e2288;
  position: absolute;
  left: 0px;
  width: 190px;
  height: 55px;
  border-radius: 1000px;
  transition: all 0.2s ease-in-out;
  transform: translateX(188px); //원 이동시키기
  z-index: -10; //label 보다 아래쪽에 위치
`;

const Input = styled.input`
  position: absolute;
  clip: rect(0, 0, 0, 0); // input태그 숨기기
  width: 10px;
  height: 10px;
  border: 0;

  &:checked + ${Label} {
    color: white; //체크가 되면 글자색 바뀜
  }
  &:checked + ${Label} ${Span} {
    transform: translateX(0px); //체크가 되어 있으면 왼쪽으로 이동
  }
`;

const LoginForm = styled.form`
  display: flex;
  flex-direction: column;
  align-items: center;

  & input {
    border-radius: 10px;
    height: 60px;
  }

  & input::placeholder {
    color: #bdbdbd;
    font-size: 15px;
  }

  & .userInput {
    width: 365px;
    margin: 8px;
    border: none;
    padding-left: 12px;
  }

  & .btnLogin {
    width: 380px;
    margin-top: 40px;
    background-color: #2e2288;
    border: none;
    color: white;
    font-size: 15px;
  }
`;

const Find = styled.div`
  margin-top: 30px;
  & .findUserData {
    margin: 10px;
    text-decoration: none;
    font-size: 12px;
    color: #bdbdbd;
  }
`;

const Join = styled.div`
  font-size: 12px;
  color: #bdbdbd;
  margin-top: 40px;
  & .goToJoin {
    margin-left: 20px;
    text-decoration: none;
    color: #2e2288;
  }
`;
