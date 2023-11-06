import React, { useContext, useState } from "react";
import { Link } from "react-router-dom";
import styled from "styled-components";
import Image from "./Image";
import ManagerData from "./ManagerData";
import UserData from "./UserData";
import Delete from "./Delete";
import Badge from "./Badge";
import { UserContext } from "../../context/UserContext";
const MyPage = () => {
  const userData = useContext(UserContext);

  return (
    <MyPageBox>
      <MypageContent>
        {/* 유저 사진 정보 표시 */}
        <Image />

        {/* 유저 닉네임 표시 */}
        <div style={{ fontWeight: "bold" }}>{userData.nick}</div>

        {/* 보호자 정보 */}
        <TitleBox>
          <div className="mainTitle">보호자 정보</div>
          <div className="subTitle">
            프로필 사진과 닉네임은 다른 사람이 볼 수 있습니다.
          </div>
        </TitleBox>
        <ManagerData />

        {/* 기기 사용자 정보 */}
        <TitleBox>
          <div className="mainTitle">기기 사용자 정보</div>
        </TitleBox>
        <UserData />

        {/* 뱃지 정보 */}
        <TitleBox>
          <div className="mainTitle">내 뱃지</div>
          <hr width="100%" />
        </TitleBox>
        <Badge />

        {/* 계정 탈퇴 */}
        <TitleBox>
          <div className="mainTitle">계정 탈퇴</div>
          <div className="subTitle">
            탈퇴 후 복구할 수 없습니다. 신중하게 결정해주세요.
          </div>
        </TitleBox>
        <Delete />
      </MypageContent>
    </MyPageBox>
  );
};

export default MyPage;

const MyPageBox = styled.div`
  display: flex;
  justify-content: center;
  align-items: center;
  background-color: whitesmoke;
  margin-top: -9px;
  height: fit-content;
`;

const MypageContent = styled.div`
  display: flex;
  flex-direction: column;
  align-items: center;
  background-color: white;
  border-radius: 20px;
  height: fit-content;
  width: 1000px;
  margin: 40px 0 40px 0;
  @media screen and (max-width: 1040px) {
    width: 90%;
  }
`;

const TitleBox = styled.div`
  display: flex;
  flex-direction: column;
  width: 85%;
  margin: 50px 0 20px 0;

  & .mainTitle {
    font-size: 17px;
    font-weight: bold;
  }

  & .subTitle {
    font-size: 12px;
  }
`;
