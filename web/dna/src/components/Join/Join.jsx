import React from "react";
import { Outlet } from "react-router-dom";
import styled from "styled-components";

const Join = () => {
  return (
    <JoinBox>
      <div>회원가입</div>
      <div>로고자리</div>
      <Outlet />
    </JoinBox>
  );
};

export default Join;

const JoinBox = styled.div`
  display: flex;
  flex-direction: column;
  align-items: center;
`;
