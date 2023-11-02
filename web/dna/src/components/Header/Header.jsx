import React, { useEffect, useState } from "react";
import { Link } from "react-router-dom";
import styled from "styled-components";
import { BiMenu } from "react-icons/bi";
import SideBar from "./SideBar";
import SideBarContents from "./SideBarContents";
const Header = () => {
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
  return (
    <div>
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
            <UserBox>
              <div>
                <Link to="/login">로그인</Link>
              </div>
              <div>
                <Link to="/join/logindata">회원가입</Link>
              </div>
            </UserBox>
          </>
        ) : (
          <div className="SideBar">
            <SideBar width={350} close={close} closeSet={closeMenu}>
              <SideBarContents close={closeMenu} />
            </SideBar>
          </div>
        )}
      </HeaderBox>
      <hr />
    </div>
  );
};

export default Header;

const HeaderBox = styled.div`
  width: 100%;
  display: flex;
  justify-content: center;
  align-items: center;

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

const UserBox = styled.div`
  display: flex;
  margin-left: 30px;
  & div {
    width: 60px;
    margin-left: -10px;
  }
  & a {
    margin-left: 15px;
    font-size: 11px;
    color: gray;
  }
`;
