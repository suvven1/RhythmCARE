import React from "react";
import styled from "styled-components";

const Delete = () => {
  const lastCheck = () => {
    if (
      window.confirm("탈퇴시 복구가 불가능 합니다.\n정말 탈퇴 하시겠습니까?")
    ) {
      alert("탈퇴가 완료되었습니다.");
    } else {
      alert("취소 되었습니다.");
    }
  };

  const deleteUser = () => {};
  return (
    <DeleteBox>
      <table>
        <tbody>
          <tr>
            <th>계정 탈퇴</th>
            <th>
              <button onClick={lastCheck}>탈퇴하기</button>
            </th>
          </tr>
        </tbody>
      </table>
    </DeleteBox>
  );
};

export default Delete;

const DeleteBox = styled.div`
  display: flex;
  flex-direction: column;
  align-items: center;
  width: 100%;
  margin-bottom: 40px;

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

  & button {
    color: red;
    font-size: 15px;
    height: 30px;
    width: 100px;
    border-radius: 5px;
    background-color: white;
    border: 1px solid red;
    cursor: pointer;
  }
`;
