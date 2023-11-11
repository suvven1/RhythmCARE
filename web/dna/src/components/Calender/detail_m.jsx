import React from 'react';
import styled from 'styled-components';

const DetailModal = ({ onClose, event, onDeleteSchedule }) => {
    if (!event) return null;

    const { title, start, end, backgroundColor } = event;

    // 종료 일자에서 하루를 빼서 표시
    const endDate = new Date(end);
    if (isNaN(endDate.getTime())) {
        console.error("Invalid end date:", end);
        return null;
    }

    // 종료 일자에서 하루를 빼서 표시
    endDate.setDate(endDate.getDate() - 1);

    return (
        <ModalOverlay>
            <ModalContainer>
                <ModalTitle>일정 상세 정보</ModalTitle>
                <EventDetails backgroundColor={backgroundColor}>
                    <div className='colorBox' />
                    <div>
                        <p className='detail_title'>제목</p>
                        <p>{title}</p>
                    </div>
                    <div>
                        <p className='detail_title'>시작 일자</p>
                        <p>{start}</p>
                    </div>
                    <div>
                        <p className='detail_title'>종료 일자</p>
                        <p>{endDate.toISOString().split('T')[0]}</p>
                    </div>
                </EventDetails>
                <ButtonContainer>
                    <DeleteButton onClick={() => { onDeleteSchedule(); onClose(); }}>일정삭제하기</DeleteButton>
                    <div className="blank" />
                    <CloseButton onClick={onClose}>닫기</CloseButton>
                </ButtonContainer>
            </ModalContainer>
        </ModalOverlay>
    );
};

export default DetailModal;

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

  @media only screen and (max-width: 1040px){
        width: 380px;
    }
`;

// 일정제목
const ModalTitle = styled.h2`
  margin-top: -20px;
  font-size: 30px;
`;

const EventDetails = styled.div`
  text-align: left;
  margin-bottom: 20px;
  align-items: center;
  justify-content: center;
  display: flex;
  flex-direction: column;
  
  & .colorBox {
    background-color: ${({ backgroundColor }) => backgroundColor};
    width: 5px;
    height: 5px;
    padding: 10px;
    border-radius: 5px;
  }

  & div {
    display: flex;
    gap: 20px;

    & .detail_title{
        font-size: 20px;
        text-align: center;
        width: 200px;
        font-weight: bold;
    }
  }
  p {
    width: 200px;
    font-size: 20px;
    margin-bottom: 10px;
  }
`;

const ButtonContainer = styled.div`
  display: flex;
  margin-top: 20px;

  & .blank{
        width: 13px ;
    }
`;

const DeleteButton = styled.button`
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
