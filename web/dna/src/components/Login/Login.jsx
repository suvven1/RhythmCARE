import React from "react";
import { Link, useNavigate } from "react-router-dom";
import styled from "styled-components";

const Login = () => {
  const nav = useNavigate();
  const login = (e) => {
    e.preventDefault();
    console.log("login");
    // nav("/");
  };

  return (
    <LoginBox>
      <Logo>
        <Link to="/">
          <img src={"/images/AppLogo.png"} alt="리듬케어 로고" />
        </Link>
      </Logo>
      <LoginForm onSubmit={login}>
        <div>
          <input type="text" className="userInput" placeholder="아이디" />
        </div>
        <div>
          <input type="text" className="userInput" placeholder="비밀번호" />
        </div>
        <input type="submit" className="btnLogin" value="로그인" />
      </LoginForm>
      <Find>
        <Link to="/findid" className="findUserData">
          아이디 찾기
        </Link>
        <Link to="/findpw" className="findUserData">
          비밀번호 찾기
        </Link>
      </Find>
      <Join>
        <span>아직 계정이 없으신가요?</span>
        <Link to="/join/logindata" className="goToJoin">
          회원가입
        </Link>
      </Join>
    </LoginBox>
  );
};

export default Login;

const LoginBox = styled.div`
  width: 100wh;
  display: flex;
  flex-direction: column;
  align-items: center;
  margin-top: 120px;
`;

const Logo = styled.div`
  & img {
    width: 300px;
    margin: 20px;
  }
`;

const LoginForm = styled.form`
  display: flex;
  flex-direction: column;
  align-items: center;

  & input {
    border-radius: 10px;
    height: 40px;
  }

  & .userInput {
    width: 300px;
    margin: 8px;
    border-color: whitesmoke;
  }

  & .btnLogin {
    width: 310px;
    margin-top: 20px;
    background-color: #40a3f9;
    border-color: whitesmoke;
    color: white;
  }
`;

const Find = styled.div`
  margin-top: 20px;
  & .findUserData {
    margin: 10px;
    text-decoration: none;
    font-size: 12px;
    color: gray;
  }
`;

const Join = styled.div`
  font-size: 12px;
  color: gray;
  margin-top: 30px;
  & .goToJoin {
    margin-left: 20px;
    text-decoration: none;
    color: #40a3f9;
  }
`;
