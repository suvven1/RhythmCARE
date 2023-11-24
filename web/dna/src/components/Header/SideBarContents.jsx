import React, { useContext, useEffect, useState } from "react";
import { Link } from "react-router-dom";
import { UserContext } from "../../context/UserContext";
import styled from "styled-components";

const SideBarContents = ({ close }) => {
  const userData = useContext(UserContext);
  const loginData = JSON.parse(localStorage.getItem("loginData"));

  const closeMenu = () => {
    close(true);
  };

  const logout = () => {
    localStorage.clear();
    alert("로그아웃이 완료되었습니다.");
    window.location.replace("/");
  };

  // 로컬 스토리지에서 불러온 이미지 데이터 변환
  const conImg = btoa(
    String.fromCharCode(...new Uint8Array(userData?.mem_profile_img?.data))
  );

  return (
    <SideBarContentBox>
      <UserDataBox>
        {userData == null ? (
          <>
            <ImgBox>
              <Link to="/login" onClick={closeMenu}>
                <img
                  src={`${process.env.PUBLIC_URL}/images/User.png`}
                  alt="유저사진"
                />
              </Link>
            </ImgBox>
            <Link to="/login" className="goTOLogin" onClick={closeMenu}>
              로그인이 필요합니다.
            </Link>
          </>
        ) : (
          <>
            <ImgBox>
              <div className="innerImgBox" style={{ backgroundColor: "white" }}>
                <Link to="/mypage" onClick={closeMenu}>
                  {userData.mem_profile_img != null ? (
                    <img
                      src={`data:image/png;base64,${conImg}`}
                      alt="유저사진"
                    />
                  ) : (
                    <img
                      src={`${process.env.PUBLIC_URL}/images/User.png`}
                      alt="기본 유저사진"
                    />
                  )}
                </Link>
              </div>
            </ImgBox>
            <LoginedUserBox>
              <Link to="/mypage" className="goTOmypage" onClick={closeMenu}>
                {loginData.name}({loginData.nick})
              </Link>
              <Link to="/" onClick={logout}>
                로그아웃
              </Link>
            </LoginedUserBox>
          </>
        )}
      </UserDataBox>
      <MenuBox>
        <Link to="/" onClick={closeMenu}>
          서비스소개
        </Link>
        <Link to="/rhythm" onClick={closeMenu}>
          측정데이터확인
        </Link>
        <Link to="/calender" onClick={closeMenu}>
          캘린더
        </Link>
        <Link to="/hospital" onClick={closeMenu}>
          주변병원정보
        </Link>
        <Link to="/community" onClick={closeMenu}>
          커뮤니티
        </Link>
      </MenuBox>
    </SideBarContentBox>
  );
};

export default SideBarContents;

const SideBarContentBox = styled.div`
  display: flex;
  flex-direction: column;
`;

const UserDataBox = styled.div`
  display: flex;
  flex-direction: column;
  background-color: #6ebcff;
  height: 220px;
  border-radius: 30px 0 0 0;
  border-top: 1px solid gray;

  & .goTOLogin {
    margin: 15px 0 0 40px;
    color: black;
    &:hover {
      color: white;
      font-size: 17px;
    }
  }
`;

const LoginedUserBox = styled.div`
  margin-top: 15px;
  & a {
    color: black;
  }
  & .goTOmypage {
    margin: 0 70px 0 40px;
    &:hover {
      color: white;
    }
  }
`;

const ImgBox = styled.div`
  display: flex;
  align-items: center;
  justify-content: center;
  width: 90px;
  height: 90px;
  margin: 40px 0 0 40px;
  border-radius: 50%;
  border: 1px solid #bdbdbd;
  overflow: hidden;

  & img {
    max-width: 110px;
    max-height: 110px;
    cursor: pointer;
  }
`;
const MenuBox = styled.div`
  margin: 40px 0 0 20px;
  display: flex;
  flex-direction: column;

  & a {
    color: black;
    font-size: 20px;
    height: 70px;
    &:hover {
      color: #40a3f9;
      font-size: 21px;
    }
  }
`;
