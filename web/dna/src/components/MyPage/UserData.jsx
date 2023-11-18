import React, { useContext } from "react";
import styled from "styled-components";
import { UserContext } from "../../context/UserContext";

const UserData = () => {
  const userData = useContext(UserContext);
  return (
    <UserDataBox>
      <table>
        <tbody>
          <tr>
            <th>이름</th>
            <th>{userData?.user_name}</th>
          </tr>
          <tr>
            <th>휴대폰번호</th>
            <th>{userData?.user_phone}</th>
          </tr>
          <tr>
            <th>생년월일</th>
            <th>{userData?.user_birthdate}</th>
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
`;
