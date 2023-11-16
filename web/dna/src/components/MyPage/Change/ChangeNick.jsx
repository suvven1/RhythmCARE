import React, { useContext, useEffect, useRef, useState } from "react";
import axios from "../../../axios";
import { AiOutlineCheckCircle, AiOutlineCloseCircle } from "react-icons/ai";
import { RiCheckboxBlankCircleLine } from "react-icons/ri";
import styled from "styled-components";
import { UserContext } from "../../../context/UserContext";

const ChangeNick = ({ setChangeNickOpen }) => {
  const userData = useContext(UserContext);
  // 닉네임 관련 변수
  const [nick, setNick] = useState("");
  const [passNick, setPassNick] = useState();
  const [passDupNick, setPassDupNick] = useState(false);
  const [checkNickText, setCheckNickText] = useState("");
  const checkNick = () => {
    setPassDupNick(false);
    if (nick.length > 1 && nick.length < 7) {
      setPassNick(true);
      setCheckNickText("* 닉네임 중복 확인을 해주세요.");
    } else if (nick == "") {
      setPassNick();
      setCheckNickText();
    } else {
      setPassNick(false);
      setCheckNickText("* 올바른 닉네임을 입력해주세요.");
    }
  };
  useEffect(() => {
    checkNick();
  }, [nick]);

  const checkDupNick = () => {
    axios.post("/user/join/nickDupCheck", { nick: nick }).then((res) => {
      if (res.data.nickDupResult) {
        setPassNick(true);
        setCheckNickText("* 사용가능한 닉네임 입니다.");
        setPassDupNick(true);
      } else {
        setPassNick(false);
        setCheckNickText("* 중복된 닉네임 입니다.");
      }
    });
  };

  // 닉네임 변경 함수 시작---------------------------------------------------------------------------
  const changeNick = () => {
    if (passDupNick) {
      axios
        .post("/user/changeNick", {
          id: userData.data.manager_id,
          nick: nick,
        })
        .then((res) => {
          if (res.data.changeNickResult) {
            setChangeNickOpen(false);
            alert("닉네임 변경이 완료 되었습니다.");
            window.location.replace("/mypage");
          }
        });
    } else {
      alert("닉네임 중복체크를 진행해주세요.");
    }
  };
  // 닉네임 변경 함수 끝-----------------------------------------------------------------------------

  // 모달 코드 시작------------------------------------------------------------------------------------
  // 모달 끄기
  const closeChangeNick = () => {
    setChangeNickOpen(false);
    alert("닉네임 변경이 취소 되었습니다.");
  };

  // 모달 외부 클릭 시 끄기
  const changeNickRef = useRef(null);

  useEffect(() => {
    // 이벤트 핸들러 함수
    const handler = (event) => {
      // mousedown 이벤트가 발생한 영역이 모달창이 아닐 때, 모달창 제거 처리
      if (
        changeNickRef.current &&
        !changeNickRef.current.contains(event.target)
      ) {
        setChangeNickOpen(false);
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
    <ChangeNickBox ref={changeNickRef}>
      <img src={"/images/WebLogo.png"} alt="리듬케어 로고" />
      <ChangeNickInput>
        <Title>변경할 닉네임을 입력해주세요.</Title>

        <Input>
          <CheckBox>
            {passNick == null ? (
              <RiCheckboxBlankCircleLine className="init" />
            ) : (
              <>
                {passNick ? (
                  <AiOutlineCheckCircle className="pass" />
                ) : (
                  <AiOutlineCloseCircle className="warn" />
                )}
              </>
            )}
          </CheckBox>
          <input
            className="nickInput"
            type="text"
            placeholder="닉네임 (2~6글자)"
            value={nick}
            onChange={(e) => {
              setNick(e.target.value);
            }}
          />
          <DupCheckBox onClick={checkDupNick}>중복확인</DupCheckBox>
        </Input>
        {passNick ? (
          <Passed>{checkNickText}</Passed>
        ) : (
          <Warning>{checkNickText}</Warning>
        )}
      </ChangeNickInput>
      <button onClick={changeNick}>변경</button>
      <button onClick={closeChangeNick}>취소</button>
    </ChangeNickBox>
  );
};

export default ChangeNick;

const ChangeNickBox = styled.div`
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  width: 400px;
  height: 350px;
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

  & img {
    width: 80%;
    margin: 10px 0 -10px 0;
  }

  & input {
    height: 50px;
    width: 80%;
    margin: 5px;
    border: none;
    border-radius: 0 10px 10px 0;
    background-image: url("/images/User");
    background-repeat: no-repeat;
    background-size: 32px;
    background-position: 10px center;
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
    height: 60px;
    width: 75%;
    margin-bottom: 10px;
    background-color: #2e2288;
    border: none;
    cursor: pointer;
    @media only screen and (max-width: 430px) {
      width: 85%;
    }
  }
`;

const Title = styled.div`
  font-size: 12px;
  margin-bottom: 20px;
`;

const ChangeNickInput = styled.div`
  height: 600px;
  margin-bottom: -200px;
`;

const Input = styled.div`
  display: flex;
  flex-direction: row;
  width: 300px;
  align-items: center;
  justify-content: center;
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
const DupCheckBox = styled.div`
  display: flex;
  align-items: center;
  justify-content: center;
  border-top-right-radius: 10px;
  border-bottom-right-radius: 10px;
  margin-left: -5px;
  height: 52px;
  width: 50px;
  font-size: 10px;
  color: white;
  background-color: #2e2288;
  cursor: pointer;
`;
