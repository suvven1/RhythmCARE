import React from "react";
import styled from "styled-components";

const ManagerData = () => {
  return (
    <UserDataBox>
      <table>
        <tbody>
          <tr>
            <th>이름</th>
            <th>최진수</th>
          </tr>
          <tr>
            <th>닉네임</th>
            <th>우산동멍멍이</th>
          </tr>
          <tr>
            <th>휴대폰번호</th>
            <th>010-2534-9160</th>
          </tr>
          <tr>
            <th>생년월일</th>
            <th>1996-10-07</th>
          </tr>
          <tr>
            <th>아이디</th>
            <th>suvven1</th>
          </tr>
          <tr>
            <th>비밀번호</th>
            <th>********</th>
          </tr>
        </tbody>
      </table>
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
`;
