import React, { useState } from "react";
import styled from "styled-components";
import CheckDelete from "./CheckDelete";

const Delete = () => {
  // 모달창
  const [deleteOpen, setDeleteOpen] = useState(false);
  const showDelete = () => {
    setDeleteOpen(true);
  };

  return (
    <DeleteBox>
      <table>
        <tbody>
          <tr>
            <th>계정 탈퇴</th>
            <th>
              <button onClick={showDelete}>탈퇴하기</button>
            </th>
          </tr>
        </tbody>
      </table>
      {deleteOpen && <CheckDelete setDeleteOpen={setDeleteOpen} />}
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
    width: 80%;
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
      padding-left: 40px;
      text-align: left;
      @media only screen and (max-width: 380px) {
        padding-left: 25px;
      }
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
    &:hover {
      color: white;
      background-color: red;
    }
  }
`;
