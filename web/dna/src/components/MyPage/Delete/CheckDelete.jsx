import axios from "../../../axios";
import React, { useContext, useEffect, useRef, useState } from "react";
import styled from "styled-components";
import { UserContext } from "../../../context/UserContext";

const CheckDelete = ({ setDeleteOpen }) => {
  const loginData = JSON.parse(localStorage.getItem("loginData"));
  const [id, setId] = useState("");
  const [pw, setPw] = useState("");

  const lastCheck = (e) => {
    e.preventDefault();
    if (
      window.confirm("탈퇴시 복구가 불가능 합니다.\n정말 탈퇴 하시겠습니까?")
    ) {
      deleteUser();
    } else {
      alert("취소 되었습니다.");
    }
  };
  const deleteUser = () => {
    if (loginData.id == id) {
      axios.post("/user/delete", { id: id, pw: pw }).then((res) => {
        if (res.data.deleteResult) {
          alert("탈퇴가 완료되었습니다.");
          localStorage.clear();
          window.location.replace("/");
        } else {
          alert("아이디 비밀번호가 일치하지 않습니다.");
        }
      });
    } else {
      alert("현재 로그인한 계정의 아이디 비밀번호를 입력해주세요.");
    }
  };

  // 모달 코드 시작------------------------------------------------------------------------------------
  // 모달 끄기
  const closeDelete = () => {
    setDeleteOpen(false);
    alert("회원탈퇴가 취소 되었습니다.");
  };

  // 모달 외부 클릭 시 끄기
  const deleteRef = useRef(null);

  useEffect(() => {
    // 이벤트 핸들러 함수
    const handler = (event) => {
      // mousedown 이벤트가 발생한 영역이 모달창이 아닐 때, 모달창 제거 처리
      if (deleteRef.current && !deleteRef.current.contains(event.target)) {
        setDeleteOpen(false);
      }
    };

    // 이벤트 핸들러 등록
    document.addEventListener("mousedown", handler);
    // document.addEventListener('touchstart', handler); // 모바일 대응

    return () => {
      // 이벤트 핸들러 해제
      document.removeEventListener("mousedown", handler);
      // document.removeEventListener('touchstart', handler); // 모바일 대응
    };
  });
  // 모달 코드 끝-------------------------------------------------------------------------------------

  return (
    <LoginBox ref={deleteRef}>
      <Logo>
        <img src={"/images/AppLogo.png"} alt="리듬케어 로고" />
      </Logo>
      <LoginForm onSubmit={lastCheck}>
        <input
          type="text"
          className="userInput"
          placeholder="아이디"
          onChange={(e) => {
            setId(e.target.value);
          }}
        />
        <input
          type="password"
          className="userInput"
          placeholder="비밀번호"
          onChange={(e) => {
            setPw(e.target.value);
          }}
        />
        <div className="btnDelete">
          <input type="submit" value="탈퇴하기" />
          <input type="button" value="취소" onClick={closeDelete} />
        </div>
      </LoginForm>
    </LoginBox>
  );
};

export default CheckDelete;

const LoginBox = styled.div`
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  width: 400px;
  height: 450px;
  z-index: 99999999;
  position: fixed;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  background-color: whitesmoke;
  border: 1px solid rgba(0, 0, 0, 0.253);
  border-radius: 10px;
  box-shadow: 0 0 2cqi rgba(41, 41, 41, 0.3);
  padding-bottom: 15px;

  @media only screen and (max-width: 430px) {
    width: 90%;
  }
`;

const Logo = styled.div`
  display: flex;
  align-items: center;
  justify-content: center;
  & img {
    width: 80%;
  }
`;

const LoginForm = styled.form`
  display: flex;
  flex-direction: column;
  align-items: center;
  width: 100%;
  & input {
    border-radius: 10px;
  }

  & input::placeholder {
    color: #bdbdbd;
    font-size: 15px;
  }

  & .userInput {
    margin: 8px;
    border: none;
    padding-left: 12px;
    width: 80%;
    height: 60px;
  }

  & .btnDelete {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    width: 100%;
    margin-top: 20px;
    & input {
      margin-top: 10px;
      background-color: #2e2288;
      border: none;
      color: white;
      font-size: 15px;
      width: 85%;
      height: 40px;
      cursor: pointer;
    }
  }
`;
