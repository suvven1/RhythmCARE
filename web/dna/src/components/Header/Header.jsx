import React, { useContext, useEffect, useReducer, useState } from "react";
import { Link, useLocation } from "react-router-dom";
import styled from "styled-components";
import { BiMenu } from "react-icons/bi";
import SideBar from "./SideBar";
import SideBarContents from "./SideBarContents";
import { UserContext } from "../../context/UserContext";
import isEqual from "lodash/isEqual";
import axios from "../../axios";
const Header = () => {
  const userData = useContext(UserContext);
  const locationData = useLocation().pathname;
  const [headerWidth, setHeaderWidth] = useState(window.innerWidth);

  const handelResize = () => {
    setHeaderWidth(window.innerWidth);
  };

  useEffect(() => {
    window.addEventListener("resize", handelResize);
    return () => {
      window.removeEventListener("resize", handelResize);
    };
  }, []);

  const [close, setClose] = useState(false);
  const closeMenu = (e) => {
    setClose(e);
  };

  const logout = () => {
    localStorage.clear();
    alert("로그아웃이 완료되었습니다.");
    window.location.replace("/");
  };

  // 새로고침시 유저 정보 받아오기
  const [update, setUpdate] = useState(false);
  useEffect(() => {
    console.log("update user data");
    axios
      .post("/user/login", {
        id: userData?.data.manager_id,
        pw: userData?.data.password,
      })
      .then((res) => {
        if (res.data.loginResult) {
          const user = {
            data: res.data.loginResult.data,
            name: userData.name,
            nick: res.data.loginResult.nick,
            badge: res.data.loginResult.badgeData,
          };
          localStorage.setItem("userData", JSON.stringify(user));
          if (!isEqual(user, userData)) window.location.replace(locationData);
        }
      });
  }, []);

  return (
    <div>
      <BlankBox></BlankBox>
      <HeaderContainer>
        <HeaderBox>
          <Logo>
            <Link to="/">
              <img
                src={`${process.env.PUBLIC_URL}/images/WebLogo.png`}
                alt="헤더 로고"
              />
            </Link>
          </Logo>
          {headerWidth > 1040 ? (
            <>
              <ContentBox>
                <div>
                  <Link to="/">서비스소개</Link>
                </div>
                <div>
                  <Link to="/rhythm">측정데이터확인</Link>
                </div>
                <div>
                  <Link to="/calender">캘린더</Link>
                </div>
                <div>
                  <Link to="/hospital">주변병원정보</Link>
                </div>
                <div>
                  <Link to="/community">커뮤니티</Link>
                </div>
              </ContentBox>
              {userData == null ? (
                <UserContainer>
                  로그인이 필요합니다.
                  <UserBox>
                    <div>
                      <Link to="/login">로그인</Link>
                    </div>
                    <div>
                      <Link to="/join/logindata">회원가입</Link>
                    </div>
                  </UserBox>
                </UserContainer>
              ) : (
                <UserContainer>
                  {userData.name}({userData.nick})
                  <UserBox>
                    <div>
                      <Link onClick={logout}>로그아웃</Link>
                    </div>
                    <div>
                      <Link to="/mypage">마이페이지</Link>
                    </div>
                  </UserBox>
                </UserContainer>
              )}
            </>
          ) : (
            <div className="SideBar">
              <SideBar width={350} close={close} closeSet={closeMenu}>
                <SideBarContents close={closeMenu} />
              </SideBar>
            </div>
          )}
        </HeaderBox>
      </HeaderContainer>
    </div>
  );
};

export default Header;

const BlankBox = styled.div`
  height: 90px;
  background-color: whitesmoke;
`;

const HeaderContainer = styled.div`
  width: 100%;
  position: fixed;
  top: 0;
  background-color: white;
  z-index: 99;
`;
const HeaderBox = styled.div`
  width: 100%;
  height: 90px;
  display: flex;
  justify-content: center;
  align-items: center;
  border-bottom: 1px solid #bdbdbd;
  & a {
    text-decoration: none;
  }

  @media screen and (max-width: 1040px) {
    justify-content: left;
    & .SideBar {
      display: flex;
      justify-content: right;
      width: 100%;
      margin-right: 30px;
    }
  }
`;

const Logo = styled.div`
  & img {
    width: 250px;
  }
  @media screen and (max-width: 1040px) {
    margin-left: 10px;
  }
`;

const ContentBox = styled.div`
  display: flex;
  margin-left: 30px;
  & div {
    width: 155px;
    text-align: center;
    margin-left: -30px;
  }
  & a {
    font-size: 15px;
    color: black;
    &:hover {
      color: #40a3f9;
      font-size: 16px;
    }
  }
`;

const UserContainer = styled.div`
  display: flex;
  flex-direction: column;
  justify-content: center;
  font-size: 11px;
`;

const UserBox = styled.div`
  display: flex;
  margin-top: 5px;
  & div {
    width: 70px;
    margin-right: -10px;
  }
  & a {
    font-size: 11px;
    color: gray;
  }
`;
