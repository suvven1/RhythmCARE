import React from "react";
import styled from "styled-components";

const UserData = () => {
  return (
    <UserDataBox>
      <table>
        <tbody>
          <tr>
            <th>이름</th>
            <th>유정숙</th>
          </tr>
          <tr>
            <th>휴대폰번호</th>
            <th>010-9899-9160</th>
          </tr>
          <tr>
            <th>생년월일</th>
            <th>1957-10-13</th>
          </tr>
        </tbody>
      </table>
    </UserDataBox>
  );
};

export default UserData;

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
