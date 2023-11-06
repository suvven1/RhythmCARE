import styled from "styled-components";
import React, { useState } from "react";
import { Link, useLocation, useNavigate } from "react-router-dom";
import axios from "../../axios";
const UserData = () => {
  const nav = useNavigate();
  const loginData = useLocation().state.loginData;
  // 데이터 베이스 순서대로 정렬
  const id = useLocation().state.loginData.id;
  const pw = useLocation().state.loginData.pw;
  const [mName, setMName] = useState("");
  const nick = useLocation().state.loginData.nick;
  const [mBirth, setMBirth] = useState("");
  const [mGender, setMGender] = useState("");
  const [mPhone, setMPhone] = useState("");
  const [uName, setUName] = useState("");
  const [uBirth, setUBirth] = useState("");
  const [uGender, setUGender] = useState("");
  const [uPhone, setUPhone] = useState("");
  const joinData = {
    id: id,
    pw: pw,
    mName: mName,
    nick: nick,
    mBirth: mBirth,
    mGender: mGender,
    mPhone: mPhone,
    uName: uName,
    uBirth: uBirth,
    uGender: uGender,
    uPhone: uPhone,
  };

  const doJoin = () => {
    if (
      mName != "" &&
      mBirth != "" &&
      mGender != "" &&
      mPhone != "" &&
      uName != "" &&
      uBirth != "" &&
      uGender != "" &&
      uPhone
    ) {
      axios.post("/user/join", { joinData: joinData }).then((res) => {
        if (res.data.joinResult) {
          endJoin();
        } else {
          alert("알수없는 이유로 회원가입에 실패하였습니다.");
        }
      });
    } else {
      alert("빈칸 없이 입력해주세요.");
    }
  };

  const endJoin = () => {
    alert("Rhythm Care에 오신걸 환영합니다.");
    nav("/login");
  };

  const backToPage = () => {
    nav("/join/logindata", { state: { loginData: loginData } });
  };

  return (
    <LoginDataBox>
      <LoginDataInput>
        <Title>보호자 정보를 입력해주세요.</Title>
        <div>
          <input
            type="text"
            placeholder="보호자 성명"
            onChange={(e) => {
              setMName(e.target.value);
            }}
          />
        </div>
        <BirthBox>
          <input
            type="date"
            data-placeholder="보호자 생년월일 8자리"
            required
            aria-required="true"
            onChange={(e) => {
              setMBirth(e.target.value);
            }}
          />
        </BirthBox>
        <div>
          <input
            type="text"
            placeholder="사용자 휴대폰번호"
            onChange={(e) => {
              setMPhone(e.target.value);
            }}
          />
        </div>
        <GenderBox>
          <div className="form_radio_btn">
            <input
              id="manager-man"
              type="radio"
              name="manager-Gender"
              value="man"
              onChange={(e) => {
                setMGender(e.target.value);
              }}
            />
            <label htmlFor="manager-man">남자</label>
          </div>

          <div className="form_radio_btn">
            <input
              id="manager-woman"
              type="radio"
              name="manager-Gender"
              value="woman"
              onChange={(e) => {
                setMGender(e.target.value);
              }}
            />
            <label htmlFor="manager-woman">여자</label>
          </div>
        </GenderBox>
        <Title>기기를 사용할 사용자의 정보를 입력해주세요.</Title>
        <div>
          <input
            type="text"
            placeholder="사용자 성명"
            onChange={(e) => {
              setUName(e.target.value);
            }}
          />
        </div>
        <BirthBox>
          <input
            type="date"
            data-placeholder="사용자 생년월일 8자리"
            required
            aria-required="true"
            onChange={(e) => {
              setUBirth(e.target.value);
            }}
          />
        </BirthBox>
        <div>
          <input
            type="text"
            placeholder="사용자 휴대폰번호"
            onChange={(e) => {
              setUPhone(e.target.value);
            }}
          />
        </div>
        <GenderBox>
          <div className="form_radio_btn">
            <input
              id="user-man"
              type="radio"
              name="user-Gender"
              value="man"
              onChange={(e) => {
                setUGender(e.target.value);
              }}
            />
            <label htmlFor="user-man">남자</label>
          </div>

          <div className="form_radio_btn">
            <input
              id="user-woman"
              type="radio"
              name="user-Gender"
              value="woman"
              onChange={(e) => {
                setUGender(e.target.value);
              }}
            />
            <label htmlFor="user-woman">여자</label>
          </div>
        </GenderBox>
      </LoginDataInput>

      <div className="locationCircle">
        <div className="circle Left"></div>
        <div className="circle Right"></div>
      </div>
      <button className="btnJoin" onClick={doJoin}>
        회원가입
      </button>
      <button className="btnBack" onClick={backToPage}>
        이전
      </button>
    </LoginDataBox>
  );
};

export default UserData;
const LoginDataBox = styled.div`
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  border-radius: 20px;

  & input {
    border-radius: 10px;
    height: 50px;
    width: 380px;
    margin: 5px;
    border: none;
    padding-left: 12px;
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
    height: 50px;
    width: 390px;
    margin: 8px;
    border: none;
  }
  & .btnJoin {
    background-color: #2e2288;
  }

  & .btnBack {
    background-color: #bdbdbd;
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
      background-color: #bdbdbd;
    }
    & .Right {
      background-color: #2e2288;
    }
  }
`;

const Title = styled.div`
  font-size: 13px;
  margin-left: 10px;
  margin-top: 20px;
`;

const LoginDataInput = styled.div`
  height: 600px;
`;

const BirthBox = styled.div`
  & input[type="date"] {
    position: relative;
    background-color: white;
  }
  & input[type="date"]::-webkit-calendar-picker-indicator {
    position: absolute;
    left: 0;
    top: 0;
    width: 380px;
    height: 50px;
    background: transparent; // 배경은 투명하게,
    color: transparent; // 글자도 투명하게! 이 두 설정을 통해 캘린더 아이콘을 사라지게 만든다.
    cursor: pointer;
  }
  & input[type="date"]::before {
    content: attr(data-placeholder);
    width: 100%;
    color: #bdbdbd;
  }

  & input[type="date"]:focus::before,
  & input[type="date"]:valid::before {
    display: none;
  }
`;

const GenderBox = styled.div`
  display: flex;
  flex-direction: row;
  justify-content: center;
  margin-top: 5px;
  .form_radio_btn {
    width: 190px;
    height: 50px;
    border: 1px solid #eae7e7;
    border-radius: 10px;
    margin: 0 5px 0 5px;
  }
  .form_radio_btn input[type="radio"] {
    display: none;
  }
  .form_radio_btn label {
    display: block;
    border-radius: 10px;
    margin: 0 auto;
    text-align: center;
    height: -webkit-fill-available;
    line-height: 50px;
  }

  /* Checked */
  .form_radio_btn input[type="radio"]:checked + label {
    background: #2e2288;
    color: #fff;
  }

  /* Disabled */
  .form_radio_btn input[type="radio"] + label {
    background: #f9fafc;
    color: #666;
  }
`;
