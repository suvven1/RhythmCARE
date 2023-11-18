import React, { useContext, useEffect, useState } from "react";
import styled from "styled-components";
import { UserContext } from "../../context/UserContext";
import ChangePW from "./Change/ChangePW";
const ManagerData = () => {
  const userData = useContext(UserContext);

  // 모달 띄우기
  const [changePwOpen, setChangePwOpen] = useState(false);

  // 모달창 노출
  const showChangePw = () => {
    setChangePwOpen(true);
  };
  // 모달 끝

  return (
    <UserDataBox>
      <TitleBox>
        <div className="mainTitle">보호자 정보</div>
        <div className="subTitle">
          <div>프로필 사진과 닉네임은 다른 사람이&nbsp;</div>
          <div>볼 수 있습니다.</div>
        </div>
      </TitleBox>
      <table>
        <tbody>
          <tr>
            <th>이름</th>
            <th>{userData?.mem_name}</th>
          </tr>
          <tr>
            <th>휴대폰번호</th>
            <th>{userData?.mem_phone}</th>
          </tr>
          <tr>
            <th>생년월일</th>
            <th>{userData?.mem_birthdate}</th>
          </tr>
          <tr>
            <th>아이디</th>
            <th>{userData?.mem_id}</th>
          </tr>
          <tr>
            <th>비밀번호</th>
            <th className="changePW">
              <div>********</div>
              <div className="btnBox">
                <button onClick={showChangePw}>변경하기</button>
              </div>
            </th>
          </tr>
        </tbody>
      </table>
      {changePwOpen && <ChangePW setChangePwOpen={setChangePwOpen} />}
    </UserDataBox>
  );
};

export default ManagerData;

const UserDataBox = styled.div`
  display: flex;
  flex-direction: column;
  align-items: center;
  width: 100%;

  & .changePW {
    display: flex;
    align-items: center;

    & .btnBox {
      display: flex;
      width: 100%;
      align-items: end;
      justify-content: end;
    }
  }

  & button {
    background-color: white;
    color: #2e2288;
    border-style: none;
    border: 1px solid #2e2288;
    border-radius: 5px;
    height: 30px;
    width: 80px;
    margin-right: 10px;
    &:hover {
      background-color: #2e2288;
      color: white;
    }
    cursor: pointer;
  }

  & table {
    border-spacing: 0;
    width: 80%;
    border-bottom: 1px solid gray;
    font-size: 15px;
    font-weight: bolder;

    @media only screen and (max-width: 380px) {
      font-size: 14px;
    }

    & th {
      height: 40px;
      border-top: 1px solid gray;
    }

    & th:first-child {
      width: 30%;
      border-right: 1px solid gray;
    }

    & th:nth-child(2) {
      padding-left: 40px;
      text-align: left;
      @media only screen and (max-width: 380px) {
        padding-left: 25px;
      }
    }
  }

  & input {
    font-size: 15px;
    padding-left: 3px;
    margin-left: -3px;
  }
`;

const TitleBox = styled.div`
  display: flex;
  flex-direction: column;
  width: 80%;
  margin: 50px 0 20px 0;

  & .mainTitle {
    font-size: 22px;
    font-weight: bold;
  }

  & .subTitle {
    display: flex;
    font-size: 15px;
    @media only screen and (max-width: 380px) {
      flex-direction: column;
    }
  }
`;
