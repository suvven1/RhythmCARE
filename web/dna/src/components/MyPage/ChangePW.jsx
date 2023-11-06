import React, { useContext, useEffect, useRef, useState } from "react";
import { UserContext } from "../../context/UserContext";
import { AiOutlineCheckCircle, AiOutlineCloseCircle } from "react-icons/ai";
import { RiCheckboxBlankCircleLine } from "react-icons/ri";
import styled from "styled-components";

const ChangePW = ({ setChangePwOpen }) => {
  const userData = useContext(UserContext);

  // 기존 비밀번호 관련 변수
  const [pw, setPw] = useState("");
  const [passPW, setPassPW] = useState();
  const [checkPWText, setCheckPWText] = useState("");
  const checkPW = () => {
    if (pw == userData.data.password) {
      setPassPW(true);
      setCheckPWText("* 비밀번호가 일치합니다.  변경할 비밀번호를 입력하세요.");
    } else if (pw == "") {
      setPassPW();
      setCheckPWText();
    } else {
      setPassPW(false);
      setCheckPWText("* 비밀번호가 일치하지않습니다.");
    }
  };
  useEffect(() => {
    checkPW();
  }, [pw]);

  // 변경할 비밀번호 관련 변수
  const [changePw, setChangePw] = useState("");
  const [passChangePW, setPassChangePW] = useState();
  const [checkChangePWText, setCheckChangePWText] = useState("");
  const checkChangePW = () => {
    if (changePw.length >= 8) {
      setPassChangePW(true);
      setCheckChangePWText();
    } else if (changePw == "") {
      setPassChangePW();
      setCheckChangePWText();
    } else {
      setPassChangePW(false);
      setCheckChangePWText("* 올바른 비밀번호를 입력해주세요.");
    }
  };
  useEffect(() => {
    checkChangePW();
  }, [changePw]);

  // 비밀번호 확인 관련 변수
  const [rePw, setRePw] = useState("");
  const [passRePW, setPassRePW] = useState();
  const [checkRePWText, setCheckRePWText] = useState("");
  const checkRePW = () => {
    if (rePw == "") {
      setPassRePW();
      setCheckRePWText();
    } else if (changePw == rePw && rePw.length >= 8) {
      setPassRePW(true);
      setCheckRePWText();
    } else {
      setPassRePW(false);
      setCheckRePWText("* 비밀번호가 일치하는지 확인해주세요.");
    }
  };
  useEffect(() => {
    checkRePW();
  }, [rePw]);

  // 모달 끄기
  const closeReview = () => {
    setChangePwOpen(false);
  };

  // 모달 외부 클릭 시 끄기
  const changePwRef = useRef(null);

  useEffect(() => {
    // 이벤트 핸들러 함수
    const handler = (event) => {
      // mousedown 이벤트가 발생한 영역이 모달창이 아닐 때, 모달창 제거 처리
      if (changePwRef.current && !changePwRef.current.contains(event.target)) {
        setChangePwOpen(false);
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
  return (
    <ChangePWBox ref={changePwRef}>
      <ChangePwInput>
        <Title>기존 비밀번호를 입력 후 변경할 비밀번호를 입력해주세요.</Title>

        <Input>
          <CheckBox>
            {passPW == null ? (
              <RiCheckboxBlankCircleLine className="init" />
            ) : (
              <>
                {passPW ? (
                  <AiOutlineCheckCircle className="pass" />
                ) : (
                  <AiOutlineCloseCircle className="warn" />
                )}
              </>
            )}
          </CheckBox>
          <input
            className="pwInput"
            type="password"
            placeholder="기존 비밀번호"
            value={pw}
            onChange={(e) => {
              setPw(e.target.value);
            }}
          />
        </Input>
        {passPW ? (
          <Passed>{checkPWText}</Passed>
        ) : (
          <Warning>{checkPWText}</Warning>
        )}

        <Input>
          <CheckBox>
            {passChangePW == null ? (
              <RiCheckboxBlankCircleLine className="init" />
            ) : (
              <>
                {passChangePW ? (
                  <AiOutlineCheckCircle className="pass" />
                ) : (
                  <AiOutlineCloseCircle className="warn" />
                )}
              </>
            )}
          </CheckBox>
          <input
            className="pwInput"
            type="password"
            placeholder="변경할 비밀번호 (8자리 이상) "
            value={changePw}
            onChange={(e) => {
              setChangePw(e.target.value);
            }}
          />
        </Input>

        <Warning>{checkChangePWText}</Warning>

        <Input>
          <CheckBox>
            {passRePW == null ? (
              <RiCheckboxBlankCircleLine className="init" />
            ) : (
              <>
                {passRePW ? (
                  <AiOutlineCheckCircle className="pass" />
                ) : (
                  <AiOutlineCloseCircle className="warn" />
                )}
              </>
            )}
          </CheckBox>
          <input
            className="pwInput"
            type="password"
            placeholder="비밀번호 확인"
            value={rePw}
            onChange={(e) => {
              setRePw(e.target.value);
            }}
          />
        </Input>

        <Warning>{checkRePWText}</Warning>
      </ChangePwInput>
      <button>변경</button>
      <button onClick={closeReview}>취소</button>
    </ChangePWBox>
  );
};

export default ChangePW;

const ChangePWBox = styled.div`
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  width: 400px;
  height: 550px;
  z-index: 99999999;
  position: fixed;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  background-color: whitesmoke;
  border: 1px solid rgba(0, 0, 0, 0.253);
  border-radius: 10px;
  box-shadow: 0 0 2cqi rgba(41, 41, 41, 0.3);
  & input {
    height: 50px;

    margin: 5px;
    border: none;
    background-image: url("/images/User");
    background-repeat: no-repeat;
    background-size: 32px;
    background-position: 10px center;
  }

  & .pwInput {
    border-radius: 0 10px 10px 0;
    width: 80%;
  }

  & input::placeholder {
    color: #bdbdbd;
    font-size: 14px;
  }

  & input:focus {
    outline: none;
  }

  & button {
    color: white;
    font-size: 15px;
    border-radius: 10px;
    box-shadow: none;
    height: 50px;
    width: 85%;
    margin: 8px 8px 20px 8px;
    background-color: #2e2288;
    border: none;
    cursor: pointer;
  }
`;

const Title = styled.div`
  font-size: 13px;
  margin-left: 10px;
  margin-top: 20px;
  margin-bottom: 10px;
`;

const ChangePwInput = styled.div`
  height: 600px;
`;

const Input = styled.div`
  display: flex;
  flex-direction: row;
  align-items: center;
`;

const Warning = styled.div`
  padding-left: 15px;
  margin-bottom: 10px;
  height: 15px;
  color: red;
  font-size: 12px;
`;

const Passed = styled.div`
  padding-left: 15px;
  margin-bottom: 10px;
  height: 15px;
  color: green;
  font-size: 12px;
`;

const CheckBox = styled.div`
  display: flex;
  align-items: center;
  justify-content: center;
  border-top-left-radius: 10px;
  border-bottom-left-radius: 10px;
  margin-right: -5px;
  height: 52px;
  width: 40px;
  font-size: 25px;
  background-color: white;
  & .init {
    color: #bdbdbd;
  }
  & .pass {
    color: green;
  }
  & .warn {
    color: red;
  }
`;
