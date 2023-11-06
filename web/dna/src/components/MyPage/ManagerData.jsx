import React, { useContext, useState } from "react";
import styled from "styled-components";
import { UserContext } from "../../context/UserContext";
import ChangePW from "./ChangePW";
const ManagerData = () => {
  const userData = useContext(UserContext);
  const [changeNick, setChangeNick] = useState(userData.nick);

  // 비밀번호 변경 모달 띄우기
  const [changePwOpen, setChangePwOpen] = useState(false);

  // 모달창 노출
  const showChangePw = () => {
    setChangePwOpen(true);
  };
  // 비밀번호 변경 모달 끝

  return (
    <UserDataBox>
      <table>
        <tbody>
          <tr>
            <th>이름</th>
            <th>{userData.name}</th>
          </tr>
          <tr>
            <th>닉네임</th>
            <th>
              <input
                type="text"
                value={changeNick}
                onChange={(e) => {
                  setChangeNick(e.target.value);
                }}
              />
            </th>
          </tr>
          <tr>
            <th>휴대폰번호</th>
            <th>{userData.data.manager_hp}</th>
          </tr>
          <tr>
            <th>생년월일</th>
            <th>{userData.data.manager_bd}</th>
          </tr>
          <tr>
            <th>아이디</th>
            <th>{userData.data.manager_id}</th>
          </tr>
          <tr>
            <th>비밀번호</th>
            <th>
              ******** <button onClick={showChangePw}>변경하기</button>
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

  & table {
    border-spacing: 0;
    width: 85%;
    border-bottom: 1px solid gray;
    font-size: 15px;
    font-weight: bolder;
    & th {
      height: 40px;
      border-top: 1px solid gray;
    }

    & th:first-child {
      width: 30%;
      border-right: 1px solid gray;
    }

    & th:nth-child(2) {
      padding-left: 50px;
      text-align: left;
    }
  }

  & input {
    font-size: 15px;
    padding-left: 3px;
    margin-left: -3px;
  }
`;
