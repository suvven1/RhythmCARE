import axios from "../../axios";
import React, { useContext, useEffect, useState } from "react";
import styled from "styled-components";
import { UserContext } from "../../context/UserContext";

const ScheduleModal = ({ onClose, handleAddSchedule, events }) => {
  const [title, setTitle] = useState("");
  const [start, setStart] = useState("");
  const [end, setEnd] = useState("");
  const [color, setColor] = useState("");
  const [defaultColor, setDefaultColor] = useState("#eb6867");
  // 서버에 일정 추가
  const loginData = JSON.parse(localStorage.getItem("loginData"));
  const updateSchedule = (id, title, start, end, color) => {
    axios
      .post("/calender/updateSchedule", {
        id,
        title,
        start,
        end,
        color,
      })
      .then((res) => {
        if (res.data.updateScheduleResult) {
          alert("일정 추가가 완료되었습니다.");
          window.location.replace("/calender");
        } else {
          alert("일정 추가 실패! 일정을 다시 입력해주세요.");
        }
      });
  };

  const handleAdd = () => {
    if (title && start && end && color) {
      updateSchedule(loginData.id, title, start, end, color);
    } else {
      alert("모든 필드를 입력하세요.");
    }
  };

  useEffect(() => {
    setColor(defaultColor);
  }, [defaultColor]);

  return (
    <ModalOverlay>
      <ModalContainer>
        <ModalTitle>새로운 일정 추가</ModalTitle>
        <ColorPicker>
          <InputLabel>일정 색상</InputLabel>
          <div className="blank" />
          <ColorButton
            color="#eb6867"
            onClick={() => {
              setColor("#eb6867");
              setDefaultColor("#eb6867");
            }}
            isSelected={color === "#eb6867"}
          />
          <ColorButton
            color="#f39a47"
            onClick={() => setColor("#f39a47")}
            isSelected={color === "#f39a47"}
          />
          <ColorButton
            color="#47b794"
            onClick={() => setColor("#47b794")}
            isSelected={color === "#47b794"}
          />
          <ColorButton
            color="#1eb2d4"
            onClick={() => setColor("#1eb2d4")}
            isSelected={color === "#1eb2d4"}
          />
          <ColorButton
            color="#762fc1"
            onClick={() => setColor("#762fc1")}
            isSelected={color === "#762fc1"}
          />
        </ColorPicker>
        <FormContainer>
          <InputLabel>일정 제목</InputLabel>
          <InputField
            type="text"
            placeholder="일정 제목을 입력하세요"
            value={title}
            onChange={(e) => setTitle(e.target.value)}
          />
        </FormContainer>
        <FormContainer>
          <InputLabel>시작 일자</InputLabel>
          <InputField
            type="date"
            value={start}
            onChange={(e) => setStart(e.target.value)}
          />
        </FormContainer>
        <FormContainer>
          <InputLabel>종료 일자</InputLabel>
          <InputField
            type="date"
            value={end}
            onChange={(e) => setEnd(e.target.value)}
          />
        </FormContainer>
        <ButtonContainer>
          <AddButton onClick={handleAdd}>일정 추가</AddButton>
          <div className="blank" />
          <CloseButton onClick={onClose}>닫기</CloseButton>
        </ButtonContainer>
      </ModalContainer>
    </ModalOverlay>
  );
};

export default ScheduleModal;

// 모달 뒷배경
const ModalOverlay = styled.div`
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(0, 0, 0, 0.5);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 9999;
`;

// 모달창 css
const ModalContainer = styled.div`
  background: white;
  width: 500px;
  height: 450px;
  padding: 20px;
  border-radius: 20px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
  text-align: center;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;

  & .blank {
    width: 5px;
  }

  @media only screen and (max-width: 1040px) {
    width: 380px;
  }
`;

// 일정제목
const ModalTitle = styled.h2`
  margin-top: -20px;
  font-size: 30px;
`;

// 일정색상-------------------------
const ColorPicker = styled.div`
  display: flex;
  align-items: center;
  justify-content: start;
  margin-top: 20px;
  width: 90%;
  height: 300;
  padding-left: 7px;

  & .blank {
    width: 13px;
  }
  @media only screen and (max-width: 1040px) {
    padding: 5px;
  }
`;

const ColorButton = styled.div`
  width: 20px;
  height: 20px;
  background-color: ${(props) => props.color};
  border-radius: 10%;
  margin: 0 10px;
  cursor: pointer;
  border: 2px solid transparent;

  ${
    (props) =>
      props.isSelected &&
      `border: 2px solid #000000;` /* 선택된 상태일 때는 검은색 테두리 추가 */
  };
`;

// form 관련 --------------------
const FormContainer = styled.div`
  display: flex;
  align-items: center;
  justify-content: center;
  width: 90%;
  margin-top: 20px;
`;

const InputLabel = styled.label`
  font-size: 20px;
  text-align: left;

  @media only screen and (max-width: 1040px) {
    font-size: 18px;
    width: 100px;
  }
`;

const InputField = styled.input`
  width: 70%;
  padding: 10px;
  font-size: 16px;
  margin-top: 5px;
  margin-left: 20px;
  border: 1px solid #ccc;
  border-radius: 5px;

  @media only screen and (max-width: 1040px) {
    margin-left: 30px;
  }
`;

// 버튼 --------------------------
const ButtonContainer = styled.div`
  display: flex;
  margin-top: 20px;
`;

const AddButton = styled.button`
  background: #2e2288;
  color: white;
  padding: 10px 20px;
  font-size: 18px;
  border: none;
  border-radius: 5px;
  margin-top: 20px;
  cursor: pointer;
`;

const CloseButton = styled.button`
  background: #bbbbbb;
  color: white;
  padding: 10px 20px;
  font-size: 18px;
  border: none;
  border-radius: 5px;
  margin-top: 20px;
  cursor: pointer;
`;
